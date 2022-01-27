// Copyright (c) MokiyCodes. Licensed under the MIT License.
// Made for YieldingCoder.
const major = Number(process.version.replace('v', '').split('.')[0]);
if (!major) throw new Error('Cannot find NodeJS Major version...');
if (major < 12) throw new Error('Please upgrade your NodeJS to version >=12');
const AdoptiumURL =
  'https://api.adoptium.net/v3/binary/version/jdk-17.0.1%2B12/linux/x64/jdk/hotspot/normal/eclipse?project=jdk';

const fs = require('fs'),
  path = require('path');
const axios = require('axios').default,
  tarballExt = require('tarball-extract');
const VersionText = `/// Get Java by MokiyCodes | NodeJS ${process.version} ///`;
console.log(`${'/'.repeat(VersionText.length)}
${VersionText}
${'/'.repeat(VersionText.length)}`);

const log = (...a) => console.log('>', ...a);
(async () => {
  const javaDir = path.resolve(process.cwd(), 'Java');
  if (fs.existsSync(javaDir)) {
    log('Removing old Java Install...');
    fs.rmSync(javaDir, {
      recursive: true,
      force: true,
    });
  }
  log(`Downloading Java from ${AdoptiumURL}...`);
  const response = await axios({
    url: AdoptiumURL,
    onDownloadProgress: progressEvent => {
      let percentCompleted = Math.round(
        (progressEvent.loaded * 100) / progressEvent.total,
      );
      console.log('Download Progress:', percentCompleted + '%');
    },
    responseType: 'stream',
  });
  log('Downloaded! Writing to tar.gz file...');
  const tarball = path.resolve(process.cwd(), 'java.tar.gz');
  const writer = fs.createWriteStream(tarball);
  response.data.pipe(writer);
  await new Promise((resolve, reject) => {
    writer.on('finish', resolve);
    writer.on('error', reject);
  });
  log(
    'Wrote tarball (.tar.gz) to ' +
      tarball +
      '! Extracting to ' +
      javaDir +
      '...',
  );
  await new Promise((resolve, reject) =>
    tarballExt.extractTarball(tarball, process.cwd(), err =>
      err ? reject(err) : resolve(void 0),
    ),
  );
  const javaExtractedDirName = fs
    .readdirSync(process.cwd())
    .filter(y => y.startsWith('jdk'))[0];
  if (!javaExtractedDirName)
    throw new Error(
      `Cannot find extracted JDK directory!\nIt likely exists, but hasn\'t been found by GetJava`,
    );
  log('Moving ' + javaExtractedDirName + ' to Java');
  const javaExtractedDir = path.resolve(process.cwd(), javaExtractedDirName);
  fs.renameSync(javaExtractedDir, javaDir);
  log(`Cleaning Up`);
  fs.rmSync(tarball);
  log(`Done installing Java ${javaExtractedDirName}!`);
})();
