import 'dart:convert';

import 'package:glitchxscndprjt/features/Home_Page/Domain/Models/gametrailer_model.dart';
import 'package:http/http.dart' as http;

class IgdbRemoteDatasource {
  final String clientId;
  final String accessToken;

  IgdbRemoteDatasource({required this.clientId, required this.accessToken});

  Future<List<GameTrailerModel>> getUpcomingGameTrailer() async {
    final url = Uri.parse('https://api.igdb.com/v4/games');

    final response = await http.post(
      url,
      headers: {"Client-ID": clientId, "Authorization": "Bearer $accessToken"},
      body: '''
        fields name, videos.video_id, first_release_date;
        sort first_release_date desc;
        where videos != null & first_release_date > ${DateTime.now().millisecondsSinceEpoch ~/ 1000};
        limit 5;
      ''',
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => GameTrailerModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch trailer');
    }
  }
}
