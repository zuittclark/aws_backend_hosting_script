const express = require("express");
const { exec } = require("child_process");
const session = require("express-session");
const fs = require("fs");
const app = express();
const PORT = 4100;

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(
    session({ secret: "csp2Hosting", resave: true, saveUninitialized: true })
);
app.set("view engine", "ejs");

const path = require("path");
app.use("/static", express.static(path.join(__dirname, "public")));

let userData = JSON.parse(fs.readFileSync("./data/data.json"));

app.get("/", (req, res) => {
    if (req.session.user) {
        res.redirect("/dashboard");
    } else {
        res.render("login", { errorMessage: null, user: null });
    }
});

app.post("/login", (req, res) => {
    const { username, token } = req.body;
    // Check if the username and token match any user in the data
    const user = userData.find(
        (u) => u.username === username && u.token === token
    );

    if (user) {
        // Create a session and store user data
        req.session.user = user;
        res.redirect("/dashboard");
    } else {
        res.render("login", { errorMessage: "Incorrect username or token" });
    }
});

app.get("/dashboard", (req, res) => {
    // Check if the user is authenticated (session exists)
    if (req.session.user) {
        const user = req.session.user;

        res.render("dashboard", { user });
    } else {
        res.redirect("/");
    }
});

app.get("/addRepo", (req, res) => {
  if (req.session.user) {
    const user = req.session.user;

    res.render("addRepo", { user });
  } else {
      res.redirect("/");
  }
});

app.post("/addRepo", (req, res) => {
    const { gitUrl } = req.body;

    // Find the user in the data based on the current session user
    let user = userData.find((u) => u.username === req.session.user.username);

    if (user) {
        // Extract the repo name from the Git URL
        const repoName = extractRepoName(gitUrl);
        // Update the user's repo information
        user.repo = gitUrl;
        user.repoName = repoName;
        user.status = "Ready for deployment";

        // Save the updated data to the JSON file
        fs.writeFileSync("./data/data.json", JSON.stringify(userData, null, 2));

        // Reload the data
        userData = JSON.parse(fs.readFileSync("./data/data.json"));
        user = userData.find(
            (u) =>
                u.username === req.session.user.username &&
                u.token === req.session.user.token
        );
        if (user) {
            req.session.user = user;
        }

        res.redirect("/dashboard");
    } else {
        res.redirect("/");
    }
});

function extractRepoName(gitUrl) {
    const regex = /\/([^\/]+)\.git$/;
    const match = gitUrl.match(regex);
    return match ? match[1] : "";
}

app.get("/deploy", (req, res) => {
  if (req.session.user) {
    const user = req.session.user;

    res.render("deploy", { user });
  } else {
      res.redirect("/");
  }
});

app.post("/deploy", (req, res) => {
    let user = userData.find((u) => u.username === req.session.user.username);

    if (user) {

      // Deploy Script
      let command = `cd ~/ && ./deploy.sh ${user.repo} ${user.portNum}`;
      return exec(command, (err, stdout, stderr) => {
          console.log("\n\n++++++++++++++++++++++++++++++++++++++++++++++++++++");
          console.log(`Deploying ${user.repoName}.`);
          console.log("++++++++++++++++++++++++++++++++++++++++++++++++++++\n");
          if (err) {
              console.error(`Error from ${user.repoName}: ${stderr}`);
              console.log(
                  "++++++++++++++++++++++++++++++++++++++++++++++++++++\n"
              );
              return res.status(500).send("error");
          }

          console.log(stdout);

          // Update Status
          user.status = "Deployed";
          // Save the updated data to the JSON file
          fs.writeFileSync("./data/data.json", JSON.stringify(userData, null, 2));
          // Reload the data
          userData = JSON.parse(fs.readFileSync("./data/data.json"));
          user = userData.find(
              (u) =>
                  u.username === req.session.user.username &&
                  u.token === req.session.user.token
          );
    
          if (user) {
              req.session.user = user;
          }
    
          return res.status(200).send(true)
      });



    } else {
          return res.sendStatus(401);
    }
});

app.get("/logout", (req, res) => {
    // Destroy the session and redirect to the login page
    req.session.destroy((err) => {
        res.redirect("/");
    });
});

// Webhook endpoint
app.post("/webhook/:repoName", (req, res) => {
    let repoName = req.params.repoName;

    let command = `cd ~/${repoName} && git pull`;
    exec(command, (err, stdout, stderr) => {
        console.log("\n++++++++++++++++++++++++++++++++++++++++++++++++++++");
        console.log(`Webhook received from bootcamper${repoName}. Deploying changes...`);
        console.log("++++++++++++++++++++++++++++++++++++++++++++++++++++\n");
        if (err) {
            console.error(`Error from ${repoName}: ${stderr}`);
            console.log(
                "++++++++++++++++++++++++++++++++++++++++++++++++++++\n"
            );
            return res.status(500).send({
                message: "Deployment failed :(",
                error: `${stderr}`,
            });
        }
        console.log(stdout);
        console.log("Changes pulled successfully!");
        console.log("++++++++++++++++++++++++++++++++++++++++++++++++++++\n");
    });
    res.status(200).send({ message: "Deployment successful!" });
});

app.use("*", (req, res) => res.sendStatus(404));

app.listen(PORT, () => {
    console.log(`Webhook Handler Server is running on port ${PORT}`);
    console.log(`Now listening for changes from Zuitt Git...`);
});
