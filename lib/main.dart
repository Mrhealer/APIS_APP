import 'package:apis_app/ui/routers/router_generator.dart';
import 'package:apis_app/ui/splash/splash_screen.dart';
import 'package:apis_app/ui/widget/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.white));
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Apis",
      theme: new ThemeData(
        primarySwatch: Colors.lightBlue,
        primaryColor: Colours.color_app,
        backgroundColor: Colours.color_app,
        fontFamily: "OpenSans",
        primaryTextTheme: TextTheme(headline6: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      home: new SplashScreen(),
      onGenerateRoute: RouterGenerator.generateRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}