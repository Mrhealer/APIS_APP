import 'package:apis_app/api/auth/auth_service.dart';
import 'package:apis_app/models/auth/login_model.dart';
import 'package:apis_app/models/base/base_data_response.dart';
import 'package:apis_app/utils/auth_atils.dart';
import 'package:logger/logger.dart';

abstract class AuthScreenContract {
  void onLoginSuccess();

  void onLoginError();

  void onChangePasswordSuccess();

  void onChangePasswordError();

  void onForgotPasswordSuccess();

  void onForgotPasswordError();

  void onRegisterSuccess();

  void onRegisterError();

  void onEmailExists();
}

class AuthScreenPresenter {
  AuthScreenContract _view;

  AuthScreenPresenter(this._view);

  /// TODO Handle logic login from api.
  void doLogin(String username, String password, String token) async {
    AuthService.internal().login(username, password, token).then((value) {
      LoginApi loginApi = value;
      if (loginApi != null && loginApi.statusCode == 200) {
        Logger().d("Success");
        AuthUtils.instance.saveTokenPrefs(
            loginApi.data.accessToken, loginApi.data.taiKhoan.id);
        _view.onLoginSuccess();
      } else {
        Logger().d("fails");
        _view.onLoginError();
      }
    });
  }

  /// register account.
  void doRegister(String userName, String password, String phone,
      {int id = 4, int level = 2}) async {
    AuthService.internal()
        .register(userName, password, phone, id: id, level: level)
        .then((value) {
      BaseDataResponse registerApi = value;
      if (registerApi.statusCode == 200) {
        _view.onRegisterSuccess();
      } else {
        _view.onRegisterError();
      }
    });
  }

  void doForgotPassword(String email) async {
    // AuthService.internal().checkEmail(email).then((value) {
    //   CheckEmailData checkEmailData = value;
    //   if (checkEmailData.success) {
    //     AuthService.internal().sendEmail(email).then((value2) {
    //       CheckEmailData forgotPassword = value2;
    //       if (forgotPassword.success) {
    //         _view.onForgotPasswordSuccess();
    //       } else {
    //         _view.onForgotPasswordError();
    //       }
    //     });
    //   } else {
    //     _view.onEmailExists();
    //   }
    // });
  }
}
