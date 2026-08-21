import twilio from 'twilio';

import dotenv from 'dotenv';
import path from 'path';

dotenv.config({ path: path.resolve(process.cwd(), '.env') });

const accountSid = process.env.TWILIO_ACCOUNT_SID;
const authToken = process.env.TWILIO_AUTH_TOKEN;
const verifyServiceSid = 'VAc13bf2a5beaa10a6f77616cd03be9b0d';

const client = twilio(accountSid, authToken);

async function testVerify() {
  const testNumber = process.argv[2] || '+919344193569';
  console.log(`Sending Verify OTP to ${testNumber} via SMS...`);

  try {
    const verification = await client.verify.v2
      .services(verifyServiceSid)
      .verifications.create({
        to: testNumber.startsWith('+') ? testNumber : `+91${testNumber.replace(/\D/g, '').slice(-10)}`,
        channel: 'sms'
      });
      
    console.log(`✅ Success! OTP has been sent.`);
    console.log(`Verification Status: ${verification.status}`);
    console.log(`Verification SID: ${verification.sid}`);
    
  } catch (error) {
    console.error(`❌ Failed to send OTP:`);
    console.error(error);
  }
}

testVerify();
