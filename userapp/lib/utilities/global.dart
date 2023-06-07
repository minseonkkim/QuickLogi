import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

Future<void> sendNotificationToDevice(
    {required String deviceToken,
    required String title,
    required String content,
    required Map<String, dynamic> data}) async {
  final url = Uri.parse('https://fcm.googleapis.com/fcm/send');
  final headers = {
    'Content-Type': 'application/json',
    'Authorization':
        'key=BISn4b7FwYrg-GUS530K7TOfObF-UFdaNkgL-1K2_XOsgItFszHjE8aFGtlNqHFXy-HlwTNsTJ4mhkka7bjkdH4'
  };

  final body = {
    'notification': {'title': title, 'body': content, 'data': data},
    'to': deviceToken,
  };

  final response =
      await http.post(url, headers: headers, body: json.encode(body));

  if (response.statusCode == 200) {
    print("성공적으로 전송되었습니다.");
    print("$title $content");
  } else {
    print("전송에 실패하였습니다.");
  }
}
