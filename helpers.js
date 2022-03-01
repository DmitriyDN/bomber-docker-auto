const { exec } = require("child_process");
const config = require("./config");

const warningLog = (str) => {
  console.log("\x1b[33m%s\x1b[0m", str);
  restLog();
};

const successLog = (str) => {
  console.log("\x1b[32m", str);
  restLog();
};

const errorLog = (str) => {
  console.log("\x1b[31m", str);
  restLog();
};

const restLog = () => {
  console.log("\x1b[0m");
};

const renderContainers = () => {
  exec("docker ps ", (error, stdout, stderr) => {
    if (!error && !stderr && stdout) {
      console.log(stdout);
      console.log("\n\n");
      console.log("\n\n");
    }
  });
};

const logStatistics = (args) => {
  const { uniqueUrls, launched, areNotAvailable, proceeded, stopped } = args;
  if (proceeded >= uniqueUrls.length) {
    setRunning();
    const now = new Date().toLocaleTimeString();
    setTimeout(() => console.log("obtaining statistics data..."), 100);
    setTimeout(() => {
      console.log(`${now}: All ${uniqueUrls.length} urls are checked.`);
      console.log(`running: ${config.running}`);
      console.log(`newlyLaunched: ${launched}`);
      console.log(`stopped: ${stopped}`);
      console.log(`areNotAvailable: ${areNotAvailable}`);
      console.log(`Next attempt in ${config.timeout / 1000 / 60} minutes`);
      renderContainers();
    }, 3000);
  }
};

const setRunning = () => {
  exec("docker ps -q | wc -l", (error, stdout, stderr) => {
    if (!error && !stderr && stdout) {
      const num = Number(stdout.toString().trim());
      if (!isNaN(num)) {
        config.running = num;
      }
    }
  });
};

const chunking = (urls) => {
    const chunks = [];
    const tempUrls = [...urls];
    while(tempUrls.length) {
        chunks.push(tempUrls.splice(0, config.chunkSize));
    }

    return chunks;
}

module.exports = {
    warningLog,
    successLog,
    errorLog,
    restLog,
    renderContainers,
    logStatistics,
    setRunning,
    chunking
};