import 'package:apis_app/ui/routers/fluro_navigator.dart';
import 'package:apis_app/ui/routers/router_generator.dart';
import 'package:apis_app/ui/widget/bizier_container.dart';
import 'package:apis_app/utils/dialog_common.dart';
import 'package:apis_app/utils/network_utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tip_dialog/tip_dialog.dart';

import 'login_presenter.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin, DialogCommon
    implements AuthScreenContract {
  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final fullNameController = TextEditingController();

  AuthScreenPresenter _presenter;

  _SignUpScreenState() {
    _presenter = AuthScreenPresenter(this);
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _entryField(String title, TextEditingController textEditingController,
      String textHint,
      {bool isPassword = false, bool isPhone = false, bool isEmail = false}) {
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
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.white)),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: textHint))
        ],
      ),
    );
  }

  Widget _submitButton() {
    return Container(
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
        child: InkWell(
          child: Text(
            'Register Now',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          onTap: () {
            _register();
          },
        ));
  }

  _register() {
    String email = emailController.text.toString().trim();
    String userName = userNameController.text.toString().trim();
    String phone = phoneController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    String fullName = fullNameController.text.toString().trim();
    if (email.isEmpty) {
      showDialogError("Email là thông tin bắt buộc !!!");
      return;
    }

    if (userName.isEmpty) {
      showDialogError("User Name là thông tin bắt buộc !!!");
      return;
    }

    if (password.isEmpty) {
      showDialogError("Password là thông tin bắt buộc !!!");
      return;
    }
    showDialogLoading();
    NetworkUtil().isNetworkConnection().then((internet) {
      if (internet != null && internet) {
        // _presenter.doRegister(email, userName, password, phone, fullName);
      } else {
        hideDialog();
        showToast("Network Not Connection!", Toast.LENGTH_SHORT,
            ToastGravity.BOTTOM, Colors.grey);
      }
    });
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        NavigatorUtils.pushReplacementNamed(
            context, RouterGenerator.routeLoginScreen);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
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
        _entryField("Email*", emailController, "Email"),
        _entryField("UserName*", userNameController, "UserName"),
        _entryField("Password*", passwordController, "Password",
            isPassword: true),
        _entryField("Phone", phoneController, "Phone"),
        _entryField("FullName", fullNameController, "FullName"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    _title(),
                    SizedBox(
                      height: 50,
                    ),
                    _emailPasswordWidget(),
                    SizedBox(
                      height: 20,
                    ),
                    _submitButton(),
                    SizedBox(height: height * .14),
                    _loginAccountLabel(),
                  ],
                ),
              ),
            ),
            Positioned(top: 40, left: 0, child: _backButton()),
            TipDialogContainer(duration: const Duration(seconds: 2))
          ],
        ),
      ),
    );
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
    // TODO: implement onLoginError
  }

  @override
  void onLoginSuccess() {
    // TODO: implement onLoginSuccess
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
    hideDialog();
    showDialogError("Đăng ký thất bại!");
  }

  @override
  void onRegisterSuccess() {
    hideDialog();
    showDialogSuccess("Đăng ký thành công!");
    NavigatorUtils.pushReplacementNamed(
        context, RouterGenerator.routeLoginScreen);
  }

  @override
  void onEmailExists() {
    hideDialog();
    showDialogError("Email đã tồn tại!");
  }
}
