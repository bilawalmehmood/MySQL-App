
class UserModel {
  int id=-1;
  String name = '';
  String email = '';

  UserModel.empty();

  UserModel({
    required this.id,
    required this.name,
    required this.email,
  });


  UserModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
  }
  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    return data;
  }
}
