import 'dart:io';
import 'dart:convert';
import 'package:signalr_netcore/signalr_client.dart';
import 'package:logging/logging.dart';

void main() async {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });

  print('Creating user to test SignalR...');
  final httpClient = HttpClient();
  
  // Register User
  final req = await httpClient.postUrl(Uri.parse('https://rentalplatform.runasp.net/api/Authentication/register'));
  req.headers.contentType = ContentType.json;
  req.write(jsonEncode({
    "firstName": "Test",
    "lastName": "User",
    "email": "test_signalr_${DateTime.now().millisecondsSinceEpoch}@example.com",
    "password": "Password123!",
    "phoneNumber": "010${DateTime.now().millisecondsSinceEpoch.toString().substring(0, 8)}",
    "role": "User"
  }));
  final res = await req.close();
  final body = await res.transform(utf8.decoder).join();
  print('Register response: ${res.statusCode} $body');
  
  if (res.statusCode != 200 && res.statusCode != 201) return;
  final json = jsonDecode(body);
  final token = json['token']; // wait, look at login response in swagger
  // if not 'token', maybe 'data']['token']
  
  String actualToken = token ?? (json['data']?['token']) ?? '';
  if (actualToken.isEmpty) {
    print('Failed to get token');
    return;
  }
  print('Got token: $actualToken');

  final connection = HubConnectionBuilder()
      .withUrl(
        'https://rentalplatform.runasp.net/chatHub',
        options: HttpConnectionOptions(
          accessTokenFactory: () async => actualToken,
          logMessageContent: true,
        ),
      )
      .build();

  await connection.start();
  print('SignalR connected: ${connection.state}');

  try {
    print('Testing CreateOrGetConversation...');
    final result = await connection.invoke('CreateOrGetConversation', args: ['seller123', 1]);
    print('CreateOrGetConversation result: $result');
  } catch(e) {
    print('CreateOrGetConversation failed: $e');
  }

  try {
    print('Testing SendMessage...');
    final result = await connection.invoke('SendMessage', args: [1, 'hello']);
    print('SendMessage result: $result');
  } catch(e) {
    print('SendMessage failed: $e');
  }

  await connection.stop();
  exit(0);
}
