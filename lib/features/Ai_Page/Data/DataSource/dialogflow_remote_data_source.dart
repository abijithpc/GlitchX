import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:googleapis_auth/auth_io.dart';
// import 'package:http/http.dart' as http;

class DialogflowRemoteDataSource {
  final String projectId;
  // AccessCredentials? _credentials;
  AuthClient? _client;

  DialogflowRemoteDataSource(this.projectId);

  Future<AuthClient> _getAuthClient() async {
    if (_client != null) return _client!;

    final jsonString = await rootBundle.loadString('Assets/credentials.json');
    final serviceAccountCredentials = ServiceAccountCredentials.fromJson(
      jsonString,
    );

    const scopes = ['https://www.googleapis.com/auth/cloud-platform'];

    _client = await clientViaServiceAccount(serviceAccountCredentials, scopes);
    return _client!;
  }

  Future<String> detectIntent(String sessionId, String text) async {
    final client = await _getAuthClient();

    final url = Uri.parse(
      'https://dialogflow.googleapis.com/v2/projects/$projectId/agent/sessions/$sessionId:detectIntent',
    );

    final body = json.encode({
      'queryInput': {
        'text': {'text': text, 'languageCode': 'en-US'},
      },
    });

    final response = await client.post(
      url,
      headers: {'Content-Type': 'application/json; charset=utf-8'},
      body: body,
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['queryResult']['fulfillmentText'] ?? '';
    } else {
      throw Exception('Dialogflow API error: ${response.body}');
    }
  }

  void dispose() {
    _client?.close();
  }
}
