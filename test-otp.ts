import dotenv from 'dotenv';
import path from 'path';

dotenv.config({ path: path.resolve(process.cwd(), '.env') });

import { sendFast2SmsOtp } from './src/lib/sms.js';

async function testOtpDelivery() {
  const phone = process.argv[2] || '9025255639';
  const testOtp = Math.floor(100000 + Math.random() * 900000).toString();

  console.log('🧪 Testing Server OTP Service');
  console.log(`📱 Phone: ${phone}`);
  console.log(`🔢 OTP: ${testOtp}`);

  const result = await sendFast2SmsOtp(phone, testOtp);
  console.log('\nResult from sendFast2SmsOtp:', result);

  if (result.success && result.requestId) {
    console.log('⏳ Checking real telecom DLR in 4 seconds...');
    await new Promise((r) => setTimeout(r, 4000));
    try {
      const apiKey = process.env.FAST2SMS_API_KEY;
      const res = await fetch(`https://www.fast2sms.com/dev/dlr/${result.requestId}`, {
        headers: { authorization: apiKey! },
      });
      const d = await res.json();
      console.log('Telecom Delivery Report:');
      console.dir(d?.data?.[0]?.delivery_status?.[0], { depth: null });
    } catch (e: any) {
      console.log('DLR check skipped:', e.message);
    }
  }
}

testOtpDelivery();
