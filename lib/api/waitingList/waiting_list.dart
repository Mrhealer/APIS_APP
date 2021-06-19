import 'package:apis_app/api/base/base_service.dart';
import 'package:apis_app/api/config/api.dart';
import 'package:apis_app/models/waitingList/waiting_list_detail_model.dart';
import 'package:apis_app/models/waitingList/waiting_list_model.dart';

class WaitingListService extends BaseServices {
  static WaitingListService _instance = new WaitingListService.internal();

  WaitingListService.internal();

  factory WaitingListService() => _instance;

  Future<WaitingListModel> getList(String strDate) async {
    var resp = await apiGet(Api.instance.getWaitingList + strDate);
    WaitingListModel waitingListModel = WaitingListModel.fromJson(resp);
    return waitingListModel;
  }

  Future<WaitingListDetailModel> getListDetail(
      String strDate, String strTuyenDuong, String strType) async {
    var resp = await apiGet(Api.instance.getWaitingDetail +
        strDate +
        "/" +
        strTuyenDuong +
        "/" +
        strType);
    WaitingListDetailModel waitingListModel =
        WaitingListDetailModel.fromJson(resp);
    return waitingListModel;
  }
}
