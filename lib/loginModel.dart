class LoginModel {
  int? status;
  bool? success;
  int? code;
  String? message;
  String? token;

  LoginModel({this.status, this.success, this.code, this.message, this.token});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    code = json['code'];
    message = json['message'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['success'] = this.success;
    data['code'] = this.code;
    data['message'] = this.message;
    data['token'] = this.token;
    return data;
  }
}
