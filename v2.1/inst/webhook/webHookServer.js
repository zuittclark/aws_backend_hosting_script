const express = require('express');
const { exec } = require('child_process');

const app = express();
const PORT = 4100;
const sudoPassword = "1234";
// Parse JSON requests
app.use(express.json());

app.get("/webhook", (req, res) => {
  res.send(`Hello World! Connected to webhook handler server: Listening for latest changes...`);
});

app.post("/webhook/bootcamper/:bc(\\d{1,2})", (req, res) => {
  let bc = req.params.bc
  // Check if bc is within the valid range (1-10)
  if (parseInt(bc) < 1 || parseInt(bc) > 10) {
    return res.status(400).send({
      message: 'Invalid bootcamper number. Must be between 1 and 10. Check your assigned number',
    });
  }

  let command = `echo "${sudoPassword}" | sudo -S -u bootcamper${bc} /home/bootcamper${bc}/redeploy.sh`;
  console.log("\n++++++++++++++++++++++++++++++++++++++++++++++++++++")
  console.log(`Webhook received from bootcamper${bc}. Deploying...`);
  console.log("++++++++++++++++++++++++++++++++++++++++++++++++++++\n")
  exec(command, (err, stdout, stderr) => {
    if (err) {
      console.error(`Error from bootcamper${bc}: ${stderr}`);
      return res.status(500).send({
        message: 'Deployment failed :(',
        error: `${stderr}`
      });
    }
    console.log("Deployment successful:");
    console.log(stdout)
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
