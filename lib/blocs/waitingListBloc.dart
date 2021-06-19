import 'package:apis_app/models/waitingList/waiting_list_detail_model.dart';
import 'package:apis_app/models/waitingList/waiting_list_model.dart';

import 'base_bloc.dart';

class WaitingListBloc extends BaseBloc<WaitingListModel> {
  Stream<WaitingListModel> get waitingList => fetcher.stream;

  fetchWaitingList(String strDate) async {
    WaitingListModel data = await repository.getList(strDate);
    fetcher.sink.add(data);
  }
}

class WaitingListDetailBloc extends BaseBloc<WaitingListDetailModel> {
  Stream<WaitingListDetailModel> get waitingDetailList => fetcher.stream;

  fetchWaitingDetailList(
      String strDate, String strTuyenDuong, String strType) async {
    WaitingListDetailModel data =
        await repository.getListDetail(strDate, strTuyenDuong, strType);
    fetcher.sink.add(data);
  }
}
