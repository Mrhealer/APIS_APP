class Api {
  //* Creating instance constructor;
  static Api instance = Api();

  //* Base API URL
  static const baseURL = "https://apidev.trungchuyenhn.com/api/v1";

  /// login
  String login = "$baseURL/taikhoan/dangnhap";

  /// register
  String register = "$baseURL/taikhoan/dangky";

  // waitingList
  String getWaitingList = "$baseURL/trungchuyen/";

  // waitingList
  String getWaitingDetail = "$baseURL/trungchuyen/";
}
