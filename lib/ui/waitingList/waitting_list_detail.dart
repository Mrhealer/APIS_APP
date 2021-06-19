import 'package:apis_app/blocs/waitingListBloc.dart';
import 'package:apis_app/models/waitingList/waiting_list_detail_model.dart';
import 'package:apis_app/models/waitingList/waiting_list_model.dart';
import 'package:apis_app/ui/waitingList/components/detail_body.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class WaitingListDetailScreen extends StatefulWidget {
  final String strDate = "2021-06-07";
  final String strTuyenDuong = "33";
  final String strType = "19";

  const WaitingListDetailScreen(
      {Key key})
      : super(key: key);

  @override
  _WaitingListDetailState createState() => _WaitingListDetailState();
}

class _WaitingListDetailState extends State<WaitingListDetailScreen> {
  WaitingListDetailBloc _waitingListBloc;

  @override
  void initState() {
    _waitingListBloc = WaitingListDetailBloc();
    _waitingListBloc.fetchWaitingDetailList(
        widget.strDate, widget.strTuyenDuong, widget.strType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Danh Sach"), backgroundColor: Colors.lightBlue[900]),
      body: Container(
        child: StreamBuilder(
          stream: _waitingListBloc.waitingDetailList,
          builder: (context, AsyncSnapshot<WaitingListDetailModel> snapshot) {
            if (snapshot.hasData) {
              return BodyDetail(listWaitingList: snapshot.data.data);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Container(
                padding: EdgeInsets.all(20.0),
                child: Center(child: CircularProgressIndicator()));
          },
        ),
      ),
    );
  }
}
