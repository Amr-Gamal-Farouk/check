import 'package:check/view/widget/login_widget.dart';
import 'package:check/view/widget/signup_widget.dart';
import 'package:check/view_model/user_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: (Provider.of<UserViewModel>(context).isLogin)
            ? LoginWidget()
            : SignupWidget(),
      ),
    );
  }
}
