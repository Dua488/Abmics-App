class DetailModel {
  String episode_title;
  String thumbnail;
  String type;
  String points;
  List<String> images;

  DetailModel({
    required this.episode_title,
    required this.thumbnail,
    required this.type,
    required this.points,
    required this.images,
  });

  static DetailModel empty() => DetailModel(episode_title: '', thumbnail: '', type: '', points: '', images: []);

  factory DetailModel.fromJson(Map<String, dynamic> document){
    //final strList = document['images'] as List<String>;
    final strList = (document['images'] as List).map((item) => item as String).toList();
    print('strList count : ${strList.length}');

    if (document.isNotEmpty){
      return DetailModel(
          episode_title: document['episode_title'].toString(),
          thumbnail: document['thumbnail'].toString(),
          type: document['type'].toString(),
          points: document['points'].toString(),
          images: strList);
    }
    else{
      return empty();
    }
  }
}