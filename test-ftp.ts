import * as ftp from 'basic-ftp';

async function testFTP(user: string, pass: string) {
  const client = new ftp.Client();
  client.ftp.verbose = true;
  try {
    await client.access({
      host: "ftp.jeenora.cloud",
      user: user,
      password: pass,
      secure: false
    });
    console.log(`✅ Success with user: ${user}`);
    const list = await client.list();
    console.log("Directory listing:", list.map(item => item.name));
  }
  catch(err: any) {
    console.log(`❌ Failed with user: ${user}`);
    console.log(err.message);
  }
  client.close();
}

async function run() {
  await testFTP("ponnilamfincorp", "ponnilamfincorp");
  await testFTP("atm", "alltimmarket");
}

run();
