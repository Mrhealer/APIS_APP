import 'package:apis_app/api/base/base_service.dart';
import 'package:apis_app/api/config/api.dart';
import 'package:apis_app/models/auth/login_model.dart';
import 'package:logger/logger.dart';

class AuthService extends BaseServices {
  final String loginNameParamKey = "TenDangNhap";
  final String passwordParamKey = "MatKhau";

  static AuthService _instance = new AuthService.internal();

  AuthService.internal();

  factory AuthService() => _instance;

  /// login account
  Future<LoginApi> login(String email, String password, String token) async {
    var resp = await request(Api.instance.login, RequestType.POST,
        data: {
          loginNameParamKey: email,
          passwordParamKey: password},
        useToken: false);
    LoginApi loginApi = LoginApi.fromJson(resp);

    return loginApi;
  }
  //
  // /// register account
  // Future<RegisterApi> register(
  //     String email,
  //     String userName,
  //     String password,
  //     String phone,
  //     String fullName,
  //     String city,
  //     String university,
  //     String userFor,
  //     {int month = -1,
  //     int year = -1}) async {
  //   var resp = await request(Api.instance.register, RequestType.POST,
  //       data: {
  //         emailParamKey: email,
  //         userNameParamKey: userName,
  //         passwordParamKey: password,
  //         phoneParamKey: phone,
  //         fullNameParamKey: fullName,
  //         cityParamKey: city,
  //         universityParamKey: university,
  //         userForParamKey: userFor,
  //         monthParamKey: month,
  //         yearParamKey: year
  //       },
  //       useToken: false);
  //
  //   RegisterApi registerApi = RegisterApi.fromJson(resp);
  //   return registerApi;
  // }
  //
  // Future<CheckEmailData> checkEmail(String email) async {
  //   var resp = await request(
  //       Api.instance.checkEmail.replaceAll("%email%", email), RequestType.GET,
  //       useToken: false);
  //
  //   CheckEmailData checkEmailData = CheckEmailData.fromJson(resp);
  //   return checkEmailData;
  // }
  //
  // Future<CheckEmailData> sendEmail(String email) async {
  //   var resp = await request(
  //       Api.instance.checkEmail.replaceAll("%email%", email), RequestType.GET,
  //       useToken: false);
  //
  //   CheckEmailData checkEmailData = CheckEmailData.fromJson(resp);
  //   return checkEmailData;
  // }
  //
  // Future<VersionApp> getVersion() async {
  //   var resp =
  //       await apiGetNotConvert(Api.instance.getVersion, isHeaders: false);
  //   VersionApp versionApp = new VersionApp();
  //   versionApp.version = resp.toString().replaceAll("\"", "");
  //
  //   return versionApp;
  // }
}
