import 'dart:io';
import 'dart:convert';

void main() async {
  print('Creating user to test SignalR...');
  final httpClient = HttpClient();
  
  // Register User
  final req = await httpClient.postUrl(Uri.parse('https://rentalplatform.runasp.net/api/User/auth/register'));
  req.headers.contentType = ContentType.json;
  req.write(jsonEncode({
    "firstName": "Test",
    "lastName": "User",
    "email": "test_signalr_${DateTime.now().millisecondsSinceEpoch}@example.com",
    "password": "Password123!",
    "phoneNumber": "010${DateTime.now().millisecondsSinceEpoch.toString().substring(0, 8)}"
  }));
  final res = await req.close();
  final body = await res.transform(utf8.decoder).join();
  print('Register response: ${res.statusCode} $body');
  
  if (res.statusCode != 200 && res.statusCode != 201) return;
  final json = jsonDecode(body);
  final token = json['data']['token'];
  print('Got token: $token');
}
