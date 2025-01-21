
class ComicModel {
  String comic_id;
  String title_en;
  String title_ar;
  String content;
  String thumbnail;
  String badge;
  String type;
  String status;

  ComicModel({
    required this.comic_id,
    required this.title_en,
    required this.title_ar,
    required this.content,
    required this.thumbnail,
    required this.badge,
    required this.type,
    required this.status,
  });

  static ComicModel empty() => ComicModel(comic_id: '', title_en: '', title_ar: '', content: '', thumbnail: '', badge: '', type: '', status: '');

  factory ComicModel.fromJson(Map<String, dynamic>? document){
    if(document != null){
      return ComicModel(
          comic_id: document['comic_id'].toString(),
          title_en: document['en']['title'].toString(),
          title_ar: document['ar']['title'].toString(),
          content: document['content'],
          thumbnail: document['thumbnail'].toString().toLowerCase() == 'false' ? '' : document['thumbnail'].toString(),
          badge: document['badge'].toString(),
          type: document['type'].toString(),
          status: document['status'].toString());
    }
    else{
      return empty();
    }
  }
}