import dotenv from 'dotenv';
import path from 'path';

dotenv.config({ path: path.resolve(process.cwd(), '.env') });

const apiKey = process.env.FAST2SMS_API_KEY;
const phone = process.argv[2] || '9025255639';
const normalizedPhone = phone.replace(/\D/g, '').slice(-10);
const testOtp = Math.floor(100000 + Math.random() * 900000).toString();

async function sendDirectOtp() {
  console.log('⚡ Sending Real-Time Instant OTP SMS');
  console.log(`📱 Phone: ${normalizedPhone}`);
  console.log(`🔢 OTP: ${testOtp}`);

  if (!apiKey) {
    console.error('❌ Missing FAST2SMS_API_KEY');
    return;
  }

  // If FAST2SMS_OTP_ID is configured, test Smart OTP route
  if (process.env.FAST2SMS_OTP_ID) {
    console.log(`\n🚀 Testing Smart OTP route with OTP ID: ${process.env.FAST2SMS_OTP_ID}...`);
    try {
      const response = await fetch('https://www.fast2sms.com/dev/otp/send', {
        method: 'POST',
        headers: {
          authorization: apiKey,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          mobile: normalizedPhone,
          otp_id: process.env.FAST2SMS_OTP_ID,
          otp: testOtp,
        }),
      });
      const data = await response.json();
      console.log('Smart OTP Response:', data);
      if (data.return) {
        console.log(`🎉 Smart OTP sent successfully! Request ID: ${data.request_id}`);
        return;
      }
    } catch (e: any) {
      console.error('Smart OTP exception:', e.message);
    }
  }

  // Guaranteed Instant Route ('q')
  console.log('\n📲 Sending via Instant Delivery Route (route: "q")...');
  try {
    const response = await fetch('https://www.fast2sms.com/dev/bulkV2', {
      method: 'POST',
      headers: {
        authorization: apiKey,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        route: 'q',
        message: `${testOtp} is your OTP to login to your account. - All Time Market`,
        language: 'english',
        flash: 0,
        numbers: normalizedPhone,
      }),
    });

    const data = await response.json();
    console.log('\nInstant SMS Response:');
    console.log(JSON.stringify(data, null, 2));

    if (data.return) {
      console.log(`\n🎉 OTP SMS Dispatched Successfully to ${normalizedPhone}!`);
      console.log(`   Request ID: ${data.request_id}`);
      console.log('⏳ Checking real delivery status from telecom network in 3 seconds...');

      await new Promise((resolve) => setTimeout(resolve, 3000));

      const dlrRes = await fetch(`https://www.fast2sms.com/dev/dlr/${data.request_id}`, {
        headers: { authorization: apiKey },
      });
      const dlrData = await dlrRes.json();
      const status = dlrData?.data?.[0]?.delivery_status?.[0];
      if (status) {
        console.log(`\n📡 Live Telecom Status: ${status.status} (${status.status_description})`);
        if (status.status === 'Delivered') {
          console.log(`✅ CONFIRMED DELIVERED to mobile at ${status.delivery_time || 'just now'}!`);
        }
      }
    } else {
      console.error('\n❌ Fast2SMS returned error:', data.message);
    }
  } catch (error: any) {
    console.error('\n❌ Exception:', error.message);
  }
}

sendDirectOtp();
