
import 'dart:convert';

LoginResponseModel loginResponseJson(String str) => LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {
  String? msg;
  Response? response;
  bool? status;

  LoginResponseModel({this.msg, this.response, this.status});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    if (this.response != null) {
      data['response'] = response?.toJson();
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