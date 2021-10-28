import 'dart:async';

import 'package:check/view/screen/home_view.dart';
import 'package:check/view_model/user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../validate.dart';

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  TextEditingController phoneNumCont = TextEditingController();

  TextEditingController passCont = TextEditingController();
  bool notShowPassword = true;
  IconData showPasswordIcon = Icons.remove_red_eye_outlined;

  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();
  final _formKey = GlobalKey<FormState>();

  void loginAction(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _btnController.success();
      Timer(Duration(seconds: 1), () {
        _btnController.reset();
        Navigator.pushReplacement(
            context, 
            MaterialPageRoute(
              builder: (context) => HomeView(),
            ));
      });
    } else {
      _btnController.error();
      Timer(Duration(seconds: 1), () {
        _btnController.reset();
      });
    }
  }

  @override
  void initState() {
    phoneNumCont = TextEditingController();
    passCont = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    phoneNumCont.dispose();
    passCont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 100,
            child: Column(
              children: [
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  color: Theme.of(context).primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 40, horizontal: 20),
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              top: 75,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width - 20,
                  height: MediaQuery.of(context).size.height - 125,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.2))),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40),
                          child: Image.asset(
                            "asset/logo.png",
                            fit: BoxFit.contain,
                            height: 100,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            maxLength: 10,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                              hintText: "Phone Number",
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor)),
                              prefixIcon: SizedBox(
                                child: Center(
                                  widthFactor: 0.0,
                                  child: Text(
                                    '+20',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  ),
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Phone can't be empty";
                              } else if (validPhone(value)) {
                                return null;
                              } else {
                                return "Something Wrong Please Check input Data";
                              }
                            },
                            controller: phoneNumCont,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            obscureText: notShowPassword,
                            decoration: InputDecoration(
                              // focusColor: Colors.black,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              hintText: "Password",
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor)),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  showPasswordIcon,
                                  color: Theme.of(context).buttonColor,
                                ),
                                onPressed: () {
                                  if (notShowPassword) {
                                    setState(() {
                                      notShowPassword = false;
                                      showPasswordIcon =
                                          Icons.remove_red_eye_sharp;
                                    });
                                  } else {
                                    setState(() {
                                      notShowPassword = true;
                                      showPasswordIcon =
                                          Icons.remove_red_eye_outlined;
                                    });
                                  }
                                },
                              ),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.black54,
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "password can't be empty";
                              } else if (value.length < 6) {
                                return "password not less than 6 character";
                              } else {
                                return null;
                              }
                            },
                            controller: passCont,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 30,
                          child: RoundedLoadingButton(
                            child: Text(
                              "LOGIN",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Theme.of(context).primaryColor,
                            controller: _btnController,
                            onPressed: () => loginAction(context),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          child: Text(
                            "Don't Have Account?Create Now!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                decoration: TextDecoration.underline),
                          ),
                          onTap: () {
                            Provider.of<UserViewModel>(context, listen: false)
                                .changeTo(false);
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
