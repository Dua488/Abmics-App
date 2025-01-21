class UserModel{
  String ID;
  String user_login;
  String user_nicename;
  String user_email;
  String display_name;
  String level;
  String phone;

  UserModel({
    required this.ID,
    required this.user_login,
    required this.user_nicename,
    required this.user_email,
    required this.display_name,
    required this.level,
    required this.phone,
  });

  static UserModel empty() => UserModel(ID: '', user_login: '', user_nicename: '', user_email: '', display_name: '', level: '', phone: '');

  factory UserModel.fromJson(Map<String, dynamic>? document){
    if(document != null){
      return UserModel(
          ID: document['ID'].toString(),
          user_login: document['user_login'].toString(),
          user_nicename: document['user_nicename'].toString(),
          user_email: document['user_email'].toString(),
          display_name: document['display_name'].toString(),
          level: document['level'].toString(),
          phone: document['phone'].toString(),
      );
    }
    else{
      return empty();
    }
  }
}
