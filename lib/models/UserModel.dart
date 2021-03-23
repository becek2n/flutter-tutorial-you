// class UserModel{
//   final int? id;
//   final String firstName;
//   String lastName;

//   UserModel({this.responsecode, this.responsemessage, this.responsedata});

//   //mapping json data
//   factory UserModel.fromJSON(Map<String, dynamic> jsonMap){
//     var list = jsonMap["responseData"] as dynamic;
//     final data = ResultModel(
//       responsecode: jsonMap["responseCode"].toString(),
//       responsemessage: jsonMap["responseMessage"],
//       responsedata: list
//     );
//     return data;
//   }
// }