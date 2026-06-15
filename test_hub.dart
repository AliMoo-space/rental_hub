import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:signalr_netcore/signalr_client.dart';

void main() async {
  print('Trying to connect without token first...');
  final hubConnection = HubConnectionBuilder()
      .withUrl("https://rentalplatform.runasp.net/chatHub")
      .withAutomaticReconnect()
      .build();

  try {
    await hubConnection.start();
    print('Connected to Hub!');
    
    final methods = [
      'CreateOrGetConversation',
      'CreateConversation',
      'StartConversation',
      'GetOrCreateConversation',
      'SendMessage',
      'Send',
      'SendChatMessage'
    ];
    
    for (final method in methods) {
      try {
        print('Invoking $method...');
        await hubConnection.invoke(method, args: ['123', 1]);
        print('SUCCESS: $method');
      } catch (e) {
        print('Failed $method: $e');
      }
    }
  } catch (e) {
    print('Connection failed: $e');
  } finally {
    hubConnection.stop();
    exit(0);
  }
}
