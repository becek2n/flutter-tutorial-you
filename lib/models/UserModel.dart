class UserModel{
  final int id;
  final String? firstName;
  final String? lastName;
  final String? image;
  final String? email;

  UserModel({required this.id, this.firstName, this.lastName, this.image, this.email});

  //mapping json data
  factory UserModel.fromJSON(Map<String, dynamic> jsonMap){
    final data = UserModel(
      id: jsonMap["id"],
      firstName: jsonMap["firstName"],
      lastName: jsonMap["lastName"],
      image: jsonMap["image"],
      email: jsonMap["email"]
    );
    return data;
  }
}