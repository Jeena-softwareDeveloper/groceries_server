import { env } from '../config/env.js';

export interface Fast2SmsResponse {
  return: boolean;
  request_id?: string;
  message?: string[] | string;
  status_code?: number;
}

/**
 * Send an OTP via Fast2SMS.
 * If FAST2SMS_OTP_ID is configured, it uses Fast2SMS Smart OTP (25 paisa with ATMRKT header).
 * Otherwise, it falls back to the guaranteed Quick SMS route ('q') to ensure 100% instant delivery to the user's mobile.
 */
export async function sendFast2SmsOtp(
  phone: string,
  otp: string
): Promise<{ success: boolean; message?: string; requestId?: string }> {
  const apiKey = env.FAST2SMS_API_KEY;
  if (!apiKey) {
    console.warn('[Fast2SMS] FAST2SMS_API_KEY is not configured in .env');
    return { success: false, message: 'Fast2SMS API key not configured' };
  }

  const normalizedPhone = phone.replace(/\D/g, '').slice(-10);
  if (!/^[6-9]\d{9}$/.test(normalizedPhone)) {
    return { success: false, message: 'Invalid 10-digit Indian mobile number' };
  }

  try {
    // 1. If Smart OTP ID is configured, try Smart OTP route (25 paisa, approved ATMRKT header)
    if (env.FAST2SMS_OTP_ID) {
      try {
        console.log(`[Fast2SMS] Sending via Smart OTP (ID: ${env.FAST2SMS_OTP_ID}) to ${normalizedPhone}...`);
        const response = await fetch('https://www.fast2sms.com/dev/otp/send', {
          method: 'POST',
          headers: {
            authorization: apiKey,
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({
            mobile: normalizedPhone,
            otp_id: env.FAST2SMS_OTP_ID,
            otp: String(otp),
            variables_values: String(otp),
          }),
        });

        const data = (await response.json()) as Fast2SmsResponse;
        if (data.return) {
          console.log(`[Fast2SMS] Smart OTP sent successfully to ${normalizedPhone}. Request ID: ${data.request_id}`);
          return { success: true, requestId: data.request_id };
        }
        console.warn(`[Fast2SMS] Smart OTP failed: ${JSON.stringify(data)}. Falling back to guaranteed Quick route...`);
      } catch (err: any) {
        console.warn(`[Fast2SMS] Smart OTP exception: ${err.message}. Falling back to Quick route...`);
      }
    }

    // 2. Guaranteed Instant Route ('q')
    // This route bypasses DLT template mismatch and delivers directly to the handset in ~3 seconds.
    console.log(`[Fast2SMS] Sending OTP to ${normalizedPhone} via guaranteed instant route ('q')...`);
    const response = await fetch('https://www.fast2sms.com/dev/bulkV2', {
      method: 'POST',
      headers: {
        authorization: apiKey,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        route: 'q',
        message: `${otp} is your OTP to login to your account. - All Time Market`,
        language: 'english',
        flash: 0,
        numbers: normalizedPhone,
      }),
    });

    const data = (await response.json()) as Fast2SmsResponse;

    if (data.return) {
      console.log(`[Fast2SMS] OTP sent successfully to ${normalizedPhone} via route 'q'. Request ID: ${data.request_id}`);
      return { success: true, requestId: data.request_id };
    }

    const errorMsg = Array.isArray(data.message)
      ? data.message.join(', ')
      : typeof data.message === 'string'
      ? data.message
      : 'Failed to send OTP SMS';

    console.error(`[Fast2SMS] Error sending OTP to ${normalizedPhone}:`, errorMsg);
    return { success: false, message: errorMsg };
  } catch (error: any) {
    console.error(`[Fast2SMS] Network exception sending OTP to ${normalizedPhone}:`, error);
    return { success: false, message: error.message || 'SMS service network error' };
  }
}

/**
 * Send a custom SMS via Fast2SMS Quick Route ('q').
 */
export async function sendFast2SmsQuick(
  phone: string,
  message: string
): Promise<{ success: boolean; message?: string }> {
  const apiKey = env.FAST2SMS_API_KEY;
  if (!apiKey) {
    return { success: false, message: 'Fast2SMS API key not configured' };
  }

  const normalizedPhone = phone.replace(/\D/g, '').slice(-10);

  try {
    const response = await fetch('https://www.fast2sms.com/dev/bulkV2', {
      method: 'POST',
      headers: {
        authorization: apiKey,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        route: 'q',
        message,
        language: 'english',
        numbers: normalizedPhone,
      }),
    });

    const data = (await response.json()) as Fast2SmsResponse;
    if (data.return) {
      return { success: true };
    }
    return {
      success: false,
      message: Array.isArray(data.message) ? data.message.join(', ') : data.message,
    };
  } catch (error: any) {
    return { success: false, message: error.message };
  }
}
