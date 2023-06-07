// import 'dart:convert';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:http/http.dart' as http;

// Future<void> sendFCMNotification(
//     {required String deviceToken,
//     required String title,
//     required String content,
//     required Map<String, dynamic> data}) async {
//   final url = Uri.parse('https://www.googleapis.com/auth/firebase.messaging');
//   final headers = {
//     'Content-Type': 'application/json',
//     'Authorization':
//         'key=BISn4b7FwYrg-GUS530K7TOfObF-UFdaNkgL-1K2_XOsgItFszHjE8aFGtlNqHFXy-HlwTNsTJ4mhkka7bjkdH4'
//   };

//   final body = {
//     'notification': {'title': title, 'body': content, 'data': data},
//     'to': deviceToken,
//   };

//   final response =
//       await http.post(url, headers: headers, body: json.encode(body));

//   if (response.statusCode == 200) {
//     print("성공적으로 전송되었습니다.");
//     print("$title $content");
//   } else {
//     print("전송에 실패하였습니다.");
//   }
// }

// import 'dart:convert';
// import 'package:http/http.dart' as http;

// import 'package:firebase_messaging/firebase_messaging.dart';

// final String serverKey = 'AIzaSyDHcBtR0KquTLR3huXWRRMQNBGx3F0duXw';
// //'56ec9f7e69fd72eddfd83640a0f1e3faae9e0851';

// final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

// void sendNotificationToDevice() async {
//   await firebaseMessaging.requestPermission();

//   String? token = await FirebaseMessaging.instance.getToken();

//   final notification = {
//     'notification': {
//       'title': 'FCM Test',
//       'body': 'This is a test notification'
//     },
//     'to': token,
//   };

//   final response = await http.post(
//     Uri.parse('https://fcm.googleapis.com/v1/projects/quicklogi/messages:send'),
//     headers: {
//       'Content-Type': 'application/json',
//       'Authorization': 'key=$serverKey',
//     },
//     body: jsonEncode(notification),
//   );

//   if (response.statusCode == 200) {
//     print('Notification sent successfully');
//   } else {
//     print('Failed to send notification');
//   }
// }

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis/fcm/v1.dart' as fcm;

FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

String? getToken() {
  firebaseMessaging.getToken().then((token) {
    print('FCM Token: $token');
    return token;
  }).catchError((err) {
    print('Failed to get FCM token: $err');
    return null;
  });
}

void sendNotificationToDevice() async {
  final client = await clientViaServiceAccount(
    ServiceAccountCredentials.fromJson({
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDe/HGHiKqwSfLC\n6GDhYfPmz7e9pcNAk1yxNblDZQPIqaXV+zvgCjVNbLSCz4gbbc/mG1uNGz7wbwYj\n1xfEsZd+e9MDaH4gwah43xSkpkMqDxTnMyc/eLcRHZ+PcAHZu4mWYORvq2fOPGxo\nHIWkN/EFQoYiDYJy2qNVXpwtwg86nrDvytJmfLNKjLHtv+q0JWPDdzhj5UtAPAem\nUa9O1r2Z8pAl2wsI4HDCQafL259Fr65rmGRm1yXlMc/34apXpQKW4WSMQoH4E9/M\nR78AhMcvqIC7ljgMPlb+esPS6ztSg2COW9l8ikn8YxyV+PIbMvimFEt0VvdCMTIv\nxcxJyE/xAgMBAAECggEAHIQSDLAYi/TY+7317by2ETVNHQ6euppdxzfEmm7Hnhi7\n4XKAhLUpfd5B81yQ3lkbtiSXf6MVWHAKS/kMzBWd9wnkwVHSl2PMpLB6llfAzRci\nqDJteXt5hdHQ/unnAq4t+TIo5HL6EnC9uE61dHvG8dJBDwfFP+Tf8GHp/RwNEITP\npQnMHD237czw3cF5f8aM2dyjFPaJZXkbtSN8l5am2kcvedDsRZ5hRH11qbkXaSt2\nfZPOzr+6MoK7jYeFdoDGLjEOnB6w/DCmZE/mEZ/WLzCpCCYlqU05PtBIWASiVLBh\nMcCGfC5BM4K1bIP+gOtkYhijDdD2bzMl7xDVW10BMQKBgQDxcnrNmXy6y7mzBaMS\niS5AfzJZ2eNEb9MtutfJs5+RhsmwREtveFrOr/T6fdhUMB0vnFn/tRmnGvaAogdB\nFml8hgBiwlhPrOeQR6JYhRyxmoYGzzLVgLOApXZatk6owM+XWkq3kVmXq8UIzuCF\ncFjB+zxyF4/Wl8uWUoZ9zb+45QKBgQDsbRwtypePzQYrVCvlO8tY5EATTZIJYS3F\napmE/UInra/kZtkwReFFvLB+iMobwvtOfFWwCFHa9+Yl0PqbKkFWQ3w2sBB3a9ZO\n0ReRI0lM7ga0LddfBMeyhFhIeu+lIXzefUri6avAduyM0mJnkafdnOn1NLOxcf4W\nONwVJR8GHQKBgQDe8Cal6sA5tlysCVtuhQ4Y7ZmvTznC+kIS6n/PNTT0aXGXeSfy\nMD4gtGXOWR7DdX2tdX/AVRbvrjzHv1RVa/1QxmZayjpCr1NNbGdhtt8supJgfTbh\n3qlf8ufakJUGyqmjhfKRlvsTyb3wCR1U+MxrqLBCZLEioxyPm3mldbI+ZQKBgBI3\nziYRKGCiUclg8Qj29JJi9DUIkyo53McLkczXnxNjpNwauL2phNRU19zIOZquCaNg\nnVG1MmmHFKrxUX5HYUV+acHlCz/IhXkJT6GVcH6HEOktZx0hRyoQXKUpI/I7hF24\nld6qVtu7zjqDs6V7ac3/219Tsk0IFaYst3jBpYRZAoGBANH7IekkpA6fSsjhAoX0\nlChaZgs0WDzbsRp1Qf+QUHNWIr7iPVOpzFR6BP5BfUqY27RNanHaGHk6qQnpANfd\ngObRwL3WfnKb8fD8SJUYQ5mh+Rijp7K5avkVTcI50QvxFE5Qi268KS/EEc9vkeYx\npYyQq0oZ3rOkvCDlSxnRLdXV\n-----END PRIVATE KEY-----\n"
              "AIzaSyDHcBtR0KquTLR3huXWRRMQNBGx3F0duXw",
      "client_email":
          "firebase-adminsdk-5xry7@quicklogi.iam.gserviceaccount.com",
    }),
    ['https://www.googleapis.com/auth/firebase.messaging'],
  );

  final fcmClient = fcm.FirebaseCloudMessagingApi(client);

  final message = fcm.SendMessageRequest.fromJson({
    'message': {
      'token': getToken(),
      'notification': {
        'title': 'FCM Test',
        'body': 'This is a test notification'
      },
    },
  });

  try {
    await fcmClient.projects.messages.send(message, 'projects/quicklogi');
    print('Notification sent successfully');
  } catch (e) {
    print('Failed to send notification: $e');
  }
}
