import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tip_dialog/tip_dialog.dart';

abstract class DialogCommon {
  void showDialogLoading() {
    TipDialogHelper.loading("Loading");
  }

  void showDialogSuccess(String str) {
    TipDialogHelper.show(
        tipDialog: new TipDialog.builder(
      bodyBuilder: (context) {
        return new Container(
          width: 120.0,
          height: 90.0,
          alignment: Alignment.center,
          child: new Text(
            str,
            style: new TextStyle(color: Colors.black),

            /// if TipDialogContainer are outside of MaterialApp,
            /// here is a must to set
            textDirection: TextDirection.ltr,
          ),
        );
      },
      color: Colors.blueAccent.withAlpha(150),
    ));
  }

  void hideDialog() {
    TipDialogHelper.dismiss();
  }

  void showDialogError(String str) {
    Fluttertoast.showToast(
        msg: str,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blueGrey,
        textColor: Colors.orange,
        fontSize: 18.0);
  }

  void showToastSuccess(String str) {
    Fluttertoast.showToast(
        msg: str,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.blue,
        fontSize: 18.0);
  }

  void showToastNotification(String str) {
    Fluttertoast.showToast(
        msg: str,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.orangeAccent,
        textColor: Colors.blue,
        fontSize: 18.0);
  }

  void showToast(String value, Toast toastLength, ToastGravity toastGravity,
      Color backgroundColor) {
    Fluttertoast.showToast(
        msg: value,
        toastLength: Toast.LENGTH_LONG,
        gravity: toastGravity,
        timeInSecForIosWeb: 3,
        backgroundColor: backgroundColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void showToastWaining(String value, Toast toastLength, ToastGravity toastGravity,
      Color backgroundColor) {
    Fluttertoast.showToast(
        msg: value,
        toastLength: Toast.LENGTH_LONG,
        gravity: toastGravity,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blueGrey,
        textColor: Colors.yellowAccent,
        fontSize: 16.0);
  }


  void hideDialogLogin(BuildContext context) {
    Navigator.of(context).pop();
  }

  void showDialogLogin(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder :(_)=> _FullScreenLoader());
  }
}

class _FullScreenLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5)),
        child: Center(child: CircularProgressIndicator()));
  }
}
