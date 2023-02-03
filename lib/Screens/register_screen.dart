import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

import '../Models/signup_request_model.dart';
import '../Services/Api_services.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isApiCallProcess = false;
  bool hidePassword = true;
  static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? userName;
  String? password;
  String? email;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Screen'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: globalFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //User name
                TextFormField(
                    validator: (onValidateVal) {
                    if (onValidateVal!.isEmpty) {
                      return 'Username can\'t be empty.';
                    }

                    return null;
                  },
                    onSaved: (onSavedVal) => {
                    userName = onSavedVal,
                  },
                  decoration: InputDecoration(
                    hintText: 'User Name'
                  ),
                ),
                TextFormField(
                  //controller: _emailController,
                  validator: (onValidateVal) {
                    if (onValidateVal!.isEmpty) {
                      return 'Email can\'t be empty.';
                    }

                    return null;
                  },
                  onSaved: (onSavedVal) => {
                    email = onSavedVal,
                  },
                  decoration: InputDecoration(
                    hintText: 'email',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  //controller: _emailController,
                     validator:  (onValidateVal) {
                    if (onValidateVal!.isEmpty) {
                      return 'Password can\'t be empty.';
                    }

                    return null;
                  },
                    onSaved:   (onSavedVal) => {
                    password = onSavedVal,
                  },
                  decoration: InputDecoration(
                    hintText: 'password',
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      if (validateAndSave()) {
                        setState(() {
                          isApiCallProcess = true;
                        });

                        SignUpRequestModel model = SignUpRequestModel(
                          username: userName,
                          password: password,
                          email: email,
                        );

                        APIService.register(model).then(
                          (response) {
                            setState(() {
                              isApiCallProcess = false;
                            });

                            if (response.response != null) {
                              FormHelper.showSimpleAlertDialog(
                                context,
                                'Congrates',
                                "Registration Successful. Please login to the account",
                                "OK",
                                () {
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    '/',
                                    (route) => false,
                                  );
                                },
                              );
                            } else {
                              FormHelper.showSimpleAlertDialog(
                                context,
                                "Config.appName",
                                response.msg.toString(),
                                "OK",
                                () {
                                  Navigator.of(context).pop();
                                },
                              );
                            }
                          },
                        );
                      }
                    },
                    child: Text('Sign Up'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
