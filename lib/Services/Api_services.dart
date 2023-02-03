
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:login_register/Services/shared_services.dart';
import 'package:login_register/api.dart';

import '../Models/login_response_model.dart';
import '../Models/signin_request_model.dart';
import '../Models/signup_request_model.dart';
import '../Models/signup_response_model.dart';

class APIService {
  static var client = http.Client();

  static Future<bool> login(
      LoginRequestModel model,
      ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.parse(Api.loginUrl);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    if (response.statusCode == 200) {
      await SharedService.setLoginDetails(
        loginResponseJson(
          response.body,
        ),
      );

      return true;
    } else {
      return false;
    }
  }

  static Future<SignUpResponseModel> register(
      SignUpRequestModel model,
      ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.parse(Api.registerUrl);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );

    return signUpResponseJson(
      response.body,
    );
  }

  // static Future<String> getUserProfile() async {
  //   var loginDetails = await SharedService.loginDetails();
  //
  //   Map<String, String> requestHeaders = {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Basic ${loginDetails!.data.token}'
  //   };
  //
  //   var url = Uri.parse(Api.registerUrl);
  //
  //   var response = await client.get(
  //     url,
  //     headers: requestHeaders,
  //   );
  //
  //   if (response.statusCode == 200) {
  //     return response.body;
  //   } else {
  //     return "";
  //   }
  // }
}