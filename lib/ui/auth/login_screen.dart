import 'package:apis_app/ui/routers/fluro_navigator.dart';
import 'package:apis_app/ui/routers/router_generator.dart';
import 'package:apis_app/ui/widget/bizier_container.dart';
import 'package:apis_app/utils/dialog_common.dart';
import 'package:apis_app/utils/network_utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:tip_dialog/tip_dialog.dart';

import 'login_presenter.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin, DialogCommon
    implements AuthScreenContract {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  AuthScreenPresenter _presenter;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  String _token = "";

  _LoginScreenState() {
    _presenter = AuthScreenPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      _token = token;
      Logger().d("_token " + _token);
    });
  }

  Widget _entryField(String title, TextEditingController textEditingController,
      {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: textEditingController,
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () {
        _login();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xfffbb448), Color(0xfff7892b)])),
        child: Text(
          'Đăng nhập',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        NavigatorUtils.push(context, RouterGenerator.routeSignUpScreen);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Don\'t have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Register',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Vi',
          style: GoogleFonts.openSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10),
          ),
          children: [
            TextSpan(
              text: 'Vi',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'An',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
            ),
          ]),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Tên đăng nhập", emailController),
        _entryField("Mật khẩu", passwordController, isPassword: true),
      ],
    );
  }

  _login() {
    String email = emailController.text.toString();
    String password = passwordController.text.toString();
    if (email.isEmpty || password.isEmpty) {
      showDialogError("Nhập user và mật khẩu !!!");
      return;
    }
    showDialogLogin(context);
    NetworkUtil().isNetworkConnection().then((internet) {
      if (internet != null && internet) {
        _presenter.doLogin(email, password, _token);
      } else {
        hideDialog();
        showToast("Network Not Connection!", Toast.LENGTH_SHORT,
            ToastGravity.BOTTOM, Colors.grey);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return new Scaffold(
        body: Container(
      height: height,
      key: _scaffoldKey,
      child: Stack(
        children: <Widget>[
          Positioned(
              top: -height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer()),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * .2),
                  _title(),
                  SizedBox(height: 50),
                  _emailPasswordWidget(),
                  SizedBox(height: 20),
                  _submitButton(),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        // NavigatorUtils.push(
                        //     context, RouterGenerator.routeForgotPassword);
                      },
                      child: Text('Forgot Password ?',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500)),
                    ),
                  ),
                  _divider(),
                  // _facebookButton(),
                  SizedBox(height: height * .055),
                  _createAccountLabel(),
                ],
              ),
            ),
          ),
          TipDialogContainer(duration: const Duration(seconds: 2))
        ],
      ),
    ));
  }

  @override
  void onChangePasswordError() {
    // TODO: implement onChangePasswordError
  }

  @override
  void onChangePasswordSuccess() {
    // TODO: implement onChangePasswordSuccess
  }

  @override
  void onLoginError() {
    hideDialogLogin(context);
    showDialogError("Đăng nhập thất bại !");
  }

  @override
  void onLoginSuccess() {
    hideDialogLogin(context);
    showToastSuccess("Đăng nhập thành công");
    Navigator.of(context).pushNamedAndRemoveUntil(
        RouterGenerator.routeHome, (Route<dynamic> route) => false);
  }

  @override
  void onForgotPasswordError() {
    // TODO: implement onForgotPasswordError
  }

  @override
  void onForgotPasswordSuccess() {
    // TODO: implement onForgotPasswordSuccess
  }

  @override
  void onRegisterError() {
    // TODO: implement onRegisterError
  }

  @override
  void onRegisterSuccess() {
    // TODO: implement onRegisterSuccess
  }

  @override
  void onEmailExists() {
    // TODO: implement onEmailExists
  }
}
