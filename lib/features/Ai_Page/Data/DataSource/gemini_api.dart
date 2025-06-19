import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiRemoteDataSource {
  final http.Client client;
  final String apiKey;

  GeminiRemoteDataSource({required this.client, required this.apiKey});

  Future<String> sendPrompt(String prompt) async {
    final url = Uri.parse('https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=$apiKey');

    final response = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {"text": prompt}
            ]
          }
        ]
      }),
    );

    final decoded = json.decode(response.body);
    if (response.statusCode == 200) {
      return decoded['candidates'][0]['content']['parts'][0]['text'];
    } else {
      throw Exception(decoded['error']['message']);
    }
  }
}
