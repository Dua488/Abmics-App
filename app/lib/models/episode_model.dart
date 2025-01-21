class EpisodeModel{
  String episode_id;
  String episode_title;
  String thumbnail;
  String type;
  String points;

  EpisodeModel({
    required this.episode_id,
    required this.episode_title,
    required this.thumbnail,
    required this.type,
    required this.points,
  });

  static EpisodeModel empty() => EpisodeModel(episode_id: '', episode_title: '', thumbnail: '', type: '', points: '');

  factory EpisodeModel.fromJson(Map<String, dynamic>? document){
    if (document != null){
      return EpisodeModel(
          episode_id: document['episode_id'].toString(),
          episode_title: document['episode_title'].toString(),
          thumbnail: document['thumbnail'].toString(),
          type: document['type'].toString(),
          points: document['points'].toString()
      );
    }
    else{
      return empty();
    }
  }
}