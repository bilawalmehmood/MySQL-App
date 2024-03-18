
class UserModel {
  String id='';
  String name = '';
  String email = '';
  String password = '';

  UserModel.empty();

  UserModel({
    required this.name,
    required this.email,
    required this.password,
  });


  UserModel.fromJson(Map<String, dynamic> json){
    id = json['id'].toString();
    name = json['name'];
    email = json['email'];
    password = json['password'];
  }
  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}
