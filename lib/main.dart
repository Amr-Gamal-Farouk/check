import 'package:check/res/theme.dart';
import 'package:check/view/screen/login_view.dart';
import 'package:check/view_model/user_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  ThemeData myTheme = appTheme;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: UserViewModel(),
        ),
      ],
      child: MaterialApp(
        title: 'Store',
        theme: myTheme,
        debugShowCheckedModeBanner: false,
        home: LoginView(),
        // HomeView(),
      ),
    );
  }
}
