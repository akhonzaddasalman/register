
import 'dart:convert';

SignUpResponseModel signUpResponseJson(String str) => SignUpResponseModel.fromJson(json.decode(str));

class SignUpResponseModel {
  String? msg;
  Response? response;
  bool? status;

  SignUpResponseModel({this.msg, this.response, this.status});

  SignUpResponseModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    response = json['response'] != null
        ?  Response.fromJson(json['response'])
        : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    final response = this.response;
    if (response != null) {
      data['response'] = response.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Response {
  String? sId;
  String? username;
  String? email;
  String? token;

  Response({this.sId, this.username, this.email, this.token});

  Response.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
    email = json['email'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['username'] = this.username;
    data['email'] = this.email;
    data['token'] = this.token;
    return data;
  }
}
