const express = require('express');
const { exec } = require('child_process');
const winston = require('winston');
const fs = require('fs');
const path = require('path');

const app = express();
const PORT = 4100;
const sudoPassword = "1234";
// Parse JSON requests
app.use(express.json());

app.get("/webhook", (req, res) => {
  res.send(`Hello World! Connected to webhook handler server: Listening for latest changes...`);
});

app.get("/webhook/bootcamper/:bc(\\d{1,2})", (req, res) => {
  let bc = req.params.bc
  // Check if bc is within the valid range (1-10)
  if (parseInt(bc) < 1 || parseInt(bc) > 10) {
    return res.status(400).send({
      message: 'Invalid bootcamper number. Must be between 1 and 10. Check your assigned number',
    });
  }

  const logFilePath = path.join(__dirname, `logs/deploy${bc}.log`); // Adjust the file path as needed

  // Check if the log file exists
  if (fs.existsSync(logFilePath)) {
    // Read the log file content
    let logContent = fs.readFileSync(logFilePath, 'utf8');

    // Replace newline characters with HTML line breaks
    logContent = logContent.replace(/\n/g, '<br>');

    let content = `
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>CSP2 DEPLOYMENT LOGS</title>
    </head>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
    </style>
    <body>
        <h3 style="font-family: Arial, sans; position: sticky; top: 0; background-color: white; padding: 1em;">AWS CSP2 DEPLOYMENTS LOGS (Bootcamper ${bc})</h3>
        <pre style="background-color: rgb(17, 17, 17); color: white; padding: 1rem;">${logContent}</pre>
    </body>
    </html>
    `
    // Send the log content as HTML response
    res.send(content); // Use <pre> to preserve formatting
  } else {
    // If the log file doesn't exist, send a 404 Not Found response
    res.status(404).send('Log file not found');
  }

});

app.post("/webhook/bootcamper/:bc(\\d{1,2})", (req, res) => {
  let bc = req.params.bc
  // Check if bc is within the valid range (1-10)
  if (parseInt(bc) < 1 || parseInt(bc) > 10) {
    return res.status(400).send({
      message: 'Invalid bootcamper number. Must be between 1 and 10. Check your assigned number',
    });
  }

  // Create a logger instance
  const logger = winston.createLogger({
    format: winston.format.combine(
      winston.format.simple()
    ),
    transports: [
      new winston.transports.File({ filename: `logs/deploy${bc}.log` }),
    ],
  });


  let command = `echo "${sudoPassword}" | sudo -S -u bootcamper${bc} /home/bootcamper${bc}/redeploy.sh`;
  
  console.log("\n++++++++++++++++++++++++++++++++++++++++++++++++++++")
  console.log(`Webhook received from bootcamper${bc}. Deploying changes...`);
  console.log("++++++++++++++++++++++++++++++++++++++++++++++++++++\n")
  let currentDate = new Date();
  logger.info(`\n\n\n****************************************** DEPLOYMENT CREATED [${currentDate.toLocaleString()}] ******************************************\n`)
  logger.info(`Webhook received from bootcamper${bc}. Deploying changes...`);
  exec(command, (err, stdout, stderr) => {
    if (err) {
      console.error(`Error from bootcamper${bc}: ${stderr}`);
      logger.error(`Webhook received from bootcamper${bc}. Deploying changes...`);
      return res.status(500).send({
        message: 'Deployment failed :(',
        error: `${stderr}`
      });
    }
    console.log("Deployment started successfully!");
    console.log(stdout)
    // Log deployment success
    logger.info('Deployment started successfully!');
    logger.info(stdout);
  });
  res.status(200).send({message: 'Deployment successful!'});
});

app.use("*", (req, res) => res.status(400).send({
  message: 'Invalid bootcamper number. Must be between 1 and 10. Check your assigned number',
}))

app.listen(PORT, () => {
  console.log(`Webhook Handler Server is running on port ${PORT}`);
  console.log(`Now listening for changes from Zuitt Git...`);
});
