import twilio from 'twilio';
import dotenv from 'dotenv';
import path from 'path';

dotenv.config({ path: path.resolve(process.cwd(), '.env') });

async function sendOTP() {
  const { TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN, TWILIO_API_KEY, TWILIO_API_SECRET, TWILIO_VERIFY_SERVICE_SID } = process.env;


  const phone = process.argv[2] || '9344193569';
  const toNumber = phone.startsWith('+') ? phone : `+91${phone.replace(/\D/g, '').slice(-10)}`;

  console.log('🔐 Twilio OTP Test');
  console.log(`📱 Sending OTP to: ${toNumber}`);
  console.log(`🔑 Account SID: ${TWILIO_ACCOUNT_SID?.slice(0, 8)}...`);
  console.log(`🔑 Verify SID:  ${TWILIO_VERIFY_SERVICE_SID}`);

  if (!TWILIO_ACCOUNT_SID || !TWILIO_AUTH_TOKEN || !TWILIO_VERIFY_SERVICE_SID) {
    console.error('❌ Missing Twilio credentials in .env!');
    process.exit(1);
  }

  try {
    // Use API Key auth if available (new upgraded account), else fallback to Auth Token
    const client = (TWILIO_API_KEY && TWILIO_API_SECRET)
      ? twilio(TWILIO_API_KEY, TWILIO_API_SECRET, { accountSid: TWILIO_ACCOUNT_SID })
      : twilio(TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN);

    const verification = await client.verify.v2
      .services(TWILIO_VERIFY_SERVICE_SID)
      .verifications.create({ to: toNumber, channel: 'sms' });

    console.log('\n✅ OTP Sent Successfully!');
    console.log(`   Status : ${verification.status}`);
    console.log(`   To     : ${verification.to}`);
    console.log(`   Channel: ${verification.channel}`);
  } catch (error: any) {
    console.error('\n❌ Failed to send OTP:');
    console.error(`   Code   : ${error.code}`);
    console.error(`   Message: ${error.message}`);
    if (error.moreInfo) console.error(`   Info   : ${error.moreInfo}`);
  }
}

sendOTP();
