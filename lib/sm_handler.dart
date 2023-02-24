import 'package:telephony/telephony.dart';
import 'package:background_sms/background_sms.dart' as bd;

import 'api_service.dart';

@pragma('vm:entry-point')
void backgroundMessageHandler(SmsMessage message) async {
  String data = await getData();
  var result = await bd.BackgroundSms.sendMessage(
    phoneNumber: data,
    message: message.body.toString(),
  );
  if (result == bd.SmsStatus.sent) {
    print("Sent");
  } else {
    print("Failed");
  }
}
