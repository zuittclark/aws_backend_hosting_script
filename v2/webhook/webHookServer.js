const express = require('express');
const { exec } = require('child_process');

// to get positional arguments
const args = process.argv.slice(2);
const bootcamperNo = parseInt(args[0] ? args[0] : 0);

const app = express();
const PORT = 4100 + bootcamperNo;
// Parse JSON requests
app.use(express.json());

app.get(`/b${bootcamperNo}-webhook`, (req, res) => {
  res.send(`Hello Bootcamper #${bootcamperNo}! Connected to webhook server: Listening for latest changes...`);
});

app.post(`/b${bootcamperNo}-webhook`, (req, res) => {
  console.log('Webhook received. Deploying...');
  exec(`./webhook/deploy.sh ${bootcamperNo}`, (err, stdout, stderr) => {
    if (err) {
      console.error(`Error: ${stderr}`);
      return res.status(500).send({
        message: 'Deployment failed :(',
        error: `${stderr}`
      });
    }
    console.log(`Deployment successful: ${stdout}`);
    res.status(200).send({message: 'Deployment successful!'});
  });
});

app.listen(PORT, () => {
  console.log(`Web Hook Server for Bootcamper #${bootcamperNo} is running on port ${PORT}`);
  console.log(`Now listening for changes from Zuitt Git...`);
});
