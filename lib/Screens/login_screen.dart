import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

import '../Models/signin_request_model.dart';
import '../Services/Api_services.dart';

class LoginPageScreen extends StatefulWidget {
  const LoginPageScreen({Key? key}) : super(key: key);

  @override
  State<LoginPageScreen> createState() => _LoginPageScreenState();
}

class _LoginPageScreenState extends State<LoginPageScreen> {
  bool isApiCallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? email;
  String? password;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: globalFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                //controller: _emailController,
                validator: (onValidateVal) {
                  if (onValidateVal!.isEmpty) {
                    return 'Username can\'t be empty.';
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
                validator: (onValidateVal) {
                  if (onValidateVal!.isEmpty) {
                    return 'Password can\'t be empty.';
                  }

                  return null;
                },
                onSaved: (onSavedVal) => {
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

                      LoginRequestModel model = LoginRequestModel(
                        email: email,
                        password: password,
                      );

                      APIService.login(model).then(
                        (response) {
                          setState(() {
                            isApiCallProcess = false;
                          });

                          if (response) {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/home',
                              (route) => false,
                            );
                          } else {
                            FormHelper.showSimpleAlertDialog(
                              context,
                              "Dear User",
                              "Invalid Username/Password !!",
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
              ),
              const SizedBox(
                height: 20,
              ),
              const Center(
                child: Text(
                  "OR",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 25,
                  ),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(color: Colors.black, fontSize: 14.0),
                      children: <TextSpan>[
                        const TextSpan(
                          text: 'Dont have an account? ',
                        ),
                        TextSpan(
                          text: 'Sign up',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(
                                context,
                                '/register',
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
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
