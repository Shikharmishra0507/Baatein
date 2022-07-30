class Users{
  final String? userName;
  final String? imageUrl;
  final String ?uid;
  final String ?email;
  Users({this.userName ,this.imageUrl,this.uid,this.email});
  factory Users.fromJson(Map<String, dynamic> json){
    return Users(
      userName: json['username'],
      imageUrl:json['imageUrl'],
      email: json['email'],
      uid: json['uid']
    );
  }


  Map<String, dynamic> toJson(Users user){
    return {
      'userName':user.userName,
      'email':user.email,
      'uid':user.uid,
      'imageUrl':user.imageUrl
    };
  }
}