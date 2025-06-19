import 'dart:convert';

import 'package:http/http.dart' as http;

class TwitchAuthService {
  final String clientId;
  final String clientSecret;

  TwitchAuthService({required this.clientId, required this.clientSecret});
  final url =
      'https://id.twitch.tv/oauth2/token?client_id=y9u368dpjt2xfqrublireqhsr9vh0i&client_secret=l6ltmivs9z7us5tbwh69lwhlrgka66&grant_type=client_credentials';
  Future<String?> getAccessToken() async {
    final response = await http.post(
      Uri.parse(url),
      body: {
        "client_id": clientId,
        "client_secret": clientSecret,
        "grant_type": "client_credentials",
      },
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['access_token'];
    } else {
      return null;
    }
  }
}
