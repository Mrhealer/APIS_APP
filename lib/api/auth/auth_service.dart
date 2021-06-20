import 'package:apis_app/api/base/base_service.dart';
import 'package:apis_app/api/config/api.dart';
import 'package:apis_app/models/auth/login_model.dart';
import 'package:apis_app/models/base/base_data_response.dart';

class AuthService extends BaseServices {
  final String loginNameParamKey = "TenDangNhap";
  final String passwordParamKey = "MatKhau";
  final String phoneParamKey = "DienThoai";
  final String idNhaXeParamKey = "IdNhaXe";
  final String chucvuParamKey = "ChucVu";

  static AuthService _instance = new AuthService.internal();

  AuthService.internal();

  factory AuthService() => _instance;

  /// login account
  Future<LoginApi> login(String email, String password, String token) async {
    var resp = await request(Api.instance.login, RequestType.POST,
        data: {loginNameParamKey: email, passwordParamKey: password},
        useToken: false);
    LoginApi loginApi = LoginApi.fromJson(resp);

    return loginApi;
  }

  /// register account
  Future<BaseDataResponse> register(
      String userName, String password, String phone,
      {int id = 4, int level = 2}) async {
    var resp = await request(Api.instance.register, RequestType.POST,
        data: {
          loginNameParamKey: userName,
          passwordParamKey: password,
          phoneParamKey: phone,
          idNhaXeParamKey: id,
          chucvuParamKey: level
        },
        useToken: false);

    BaseDataResponse registerApi = BaseDataResponse.fromJson(resp);
    return registerApi;
  }
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
