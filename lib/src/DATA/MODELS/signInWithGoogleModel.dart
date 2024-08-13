class SignInWithGoogleModel {
  String? number;
  String? password;

  SignInWithGoogleModel({this.password, this.number});

  SignInWithGoogleModel.fromJson(Map<dynamic, dynamic> json) {
    number = json['OLoginId'];
    password = json['OUserPassword'];
  }
}
