class GenreModel {
  String name;
  String slug;
  GenreModel({
    required this.name,
    required this.slug
  });

  static GenreModel empty() => GenreModel(name: '', slug: '');

  factory GenreModel.fromJson(Map<String, dynamic>? document){

    if (document != null){
      return GenreModel(
        name: document['name'].toString(),
        slug: document['slug'].toString(),
      );
    }
    else{
      return empty();
    }
  }
}