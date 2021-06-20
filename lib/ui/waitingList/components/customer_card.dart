import 'package:apis_app/models/bundle.dart';
import 'package:apis_app/ui/routers/router_generator.dart';
import 'package:flutter/material.dart';

import 'date_callback.dart';

class CustomerCard extends StatelessWidget implements ADateSelected {
  final String ngayChay,
      idTuyenDuong,
      tenTuyenDuong,
      idKhungGio,
      thoiGianDi,
      thoiGianDen,
      strDate;
  int loaiKhach, soKhach;

  CustomerCard(
      {Key key,
      this.ngayChay,
      this.idTuyenDuong,
      this.tenTuyenDuong,
      this.idKhungGio,
      this.thoiGianDi,
      this.thoiGianDen,
      this.loaiKhach,
      this.soKhach,
      this.strDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 9.0, horizontal: 21.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
      ),
      padding: EdgeInsets.all(21),
      child: Container(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    tenTuyenDuong,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: "OpenSans",
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    thoiGianDi + " - " + thoiGianDen,
                    style: Theme.of(context).textTheme.subhead,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  child: Text(statusType(loaiKhach).toUpperCase(),
                      style: TextStyle(fontSize: 14)),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.all(15)),
                      foregroundColor: colorStateType(loaiKhach),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.red)))),
                  onPressed: () {
                    DataBundle dataBundle = new DataBundle(
                        strDate: strDate,
                        strTuyenDuong: idTuyenDuong,
                        strType: loaiKhach);
                    Navigator.pushNamed(context, RouterGenerator.routeDetail,
                        arguments: dataBundle);
                  }),
            ),
          ],
        ),
      ),
    );
  }

  colorStateType(int status) {
    switch (status) {
      case 2:
        return MaterialStateProperty.all<Color>(Colors.grey);
        break;
      case 3:
        return MaterialStateProperty.all<Color>(Colors.yellowAccent);
        break;
      case 4:
        return MaterialStateProperty.all<Color>(Colors.blueAccent);
        break;
      case 9:
        return MaterialStateProperty.all<Color>(Colors.red);
        break;
    }
    return MaterialStateProperty.all<Color>(Colors.blueGrey);
  }

  colorType(int status) {
    switch (status) {
      case 2:
        return Colors.grey;
        break;
      case 3:
        return Colors.yellowAccent;
        break;
      case 4:
        return Colors.blueAccent;
        break;
      case 9:
        return Colors.red;
        break;
    }
  }

  statusType(int status) {
    switch (status) {
      case 2:
        return "Đón khách";
        break;
      case 3:
        return "Đang đón";
        break;
      case 4:
        return "Đã đón";
        break;
      case 10:
        return "Đã nhận khách";
        break;
      case 5:
        return "Trả khách";
        break;
      case 6:
        return "Đã trả";
        break;
      case 7:
        return "Đang trả khách";
        break;
      case 9:
        return "Đã huỷ";
        break;
      default:
        return "unknow";
        break;
    }
  }

  @override
  void onDateSelected(String str) {
    // TODO: implement onDateSelected
  }
}
