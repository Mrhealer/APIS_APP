import 'package:apis_app/api/waitingList/waiting_list.dart';
import 'package:apis_app/models/waitingList/waiting_list_detail_model.dart';
import 'package:apis_app/models/waitingList/waiting_list_model.dart';

class Repository {
  final waitingListService = WaitingListService();

  Future<WaitingListModel> getList(String strDate) =>
      waitingListService.getList(strDate);

  Future<WaitingListDetailModel> getListDetail(
          String strDate, String strTuyenDuong, String strType) =>
      waitingListService.getListDetail(strDate, strTuyenDuong, strType);
}
