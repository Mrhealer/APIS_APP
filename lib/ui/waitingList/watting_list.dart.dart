import 'package:apis_app/blocs/waitingListBloc.dart';
import 'package:apis_app/models/waitingList/waiting_list_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'components/body.dart';

class WaitingListScreen extends StatefulWidget {
  const WaitingListScreen({Key key}) : super(key: key);

  @override
  _WaitingListScreenState createState() => _WaitingListScreenState();
}

class _WaitingListScreenState extends State<WaitingListScreen> {
  WaitingListBloc _waitingListBloc;

  @override
  void initState() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    _waitingListBloc = WaitingListBloc();
    _waitingListBloc.fetchWaitingList("2021-06-07");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Danh Sach"), backgroundColor: Colors.lightBlue[900]),
      body: Container(
        child: StreamBuilder(
          stream: _waitingListBloc.waitingList,
          builder: (context, AsyncSnapshot<WaitingListModel> snapshot) {
            if (snapshot.hasData) {
              return Body(listWaitingList: snapshot.data.data);
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
