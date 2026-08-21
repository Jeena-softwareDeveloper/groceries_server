import twilio from 'twilio';
import dotenv from 'dotenv';
import path from 'path';

// Load .env file
dotenv.config({ path: path.resolve(process.cwd(), '.env') });

async function testTwilio() {
  const { TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN, TWILIO_PHONE_NUMBER } = process.env;

  if (!TWILIO_ACCOUNT_SID || !TWILIO_AUTH_TOKEN || !TWILIO_PHONE_NUMBER) {
    console.error('❌ Missing Twilio credentials in .env file!');
    console.error('Please ensure the following are set:');
    console.error('- TWILIO_ACCOUNT_SID');
    console.error('- TWILIO_AUTH_TOKEN');
    console.error('- TWILIO_PHONE_NUMBER');
    process.exit(1);
  }

  console.log('✅ Found Twilio credentials. Initializing client...');

  try {
    const client = twilio(TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN);

    const testNumber = process.argv[2];
    if (!testNumber) {
      console.warn('⚠️ No test phone number provided. To actually send an SMS, run:');
      console.warn('npx tsx test-twilio.ts <your-mobile-number>');
      console.warn('\nFetching Twilio account details instead to verify connection...');
      
      const account = await client.api.v2010.accounts(TWILIO_ACCOUNT_SID).fetch();
      console.log(`✅ Successfully connected to Twilio Account: ${account.friendlyName} (${account.status})`);
      process.exit(0);
    }

    console.log(`Sending test SMS to ${testNumber} from ${TWILIO_PHONE_NUMBER}...`);
    
    const message = await client.messages.create({
      body: 'Hello',
      from: TWILIO_PHONE_NUMBER,
      to: testNumber.startsWith('+') ? testNumber : `+91${testNumber.replace(/\D/g, '').slice(-10)}`, // assuming India by default
    });

    console.log('✅ SMS Sent Successfully!');
    console.log(`Message SID: ${message.sid}`);
    
  } catch (error) {
    console.error('❌ Failed to connect/send SMS via Twilio:');
    console.error(error);
  }
}

testTwilio();
