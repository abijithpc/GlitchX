class GameTrailerModel {
  final String name;
  final String? videoId;

  GameTrailerModel({required this.name, this.videoId});

  factory GameTrailerModel.fromJson(Map<String, dynamic> json) {
    final videoList = json['videos'] as List?;
    final videoId =
        videoList != null && videoList.isNotEmpty
            ? videoList[0]['video_id']
            : null;
    return GameTrailerModel(name: json['name'], videoId: videoId);
  }
}
