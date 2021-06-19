import 'package:apis_app/models/waitingList/waiting_list_model.dart';
import 'package:apis_app/ui/waitingList/components/header.dart';
import 'package:flutter/material.dart';

import 'calendar.dart';
import 'customer_card.dart';

class Body extends StatelessWidget {
  final List<WaitingListData> listWaitingList;

  Body({this.listWaitingList});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        TableBasicsExample(),
        Container(
          padding: EdgeInsets.all(21),
          child: WaitingListHeader(
              title: "Số chuyến", count: listWaitingList.length, press: () {}),
        ),
        Container(
            child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: listWaitingList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return CustomerCard(
              tenTuyenDuong: listWaitingList[index].tenTuyenDuong,
              thoiGianDi: listWaitingList[index].thoiGianDi,
              thoiGianDen: listWaitingList[index].thoiGianDen,
              loaiKhach: listWaitingList[index].loaiKhach,
            );
          },
        ))
      ],
    ));
  }
}
