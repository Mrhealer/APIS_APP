import 'package:apis_app/ui/routers/fluro_navigator.dart';
import 'package:apis_app/ui/routers/router_generator.dart';
import 'package:flutter/material.dart';

class CustomerCard extends StatelessWidget {
  final String ngayChay,
      idTuyenDuong,
      tenTuyenDuong,
      idKhungGio,
      thoiGianDi,
      thoiGianDen;
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
      this.soKhach})
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
                  child: Text("Add to cart".toUpperCase(),
                      style: TextStyle(fontSize: 14)),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.all(15)),
                      foregroundColor: colorType(loaiKhach),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.red)))),
                  onPressed: () => {
                        NavigatorUtils.push(
                            context, RouterGenerator.routeDetail)
                      }),
            ),
          ],
        ),
      ),
    );
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
      case 9:
        return "Đã huỷ";
        break;
    }
  }
}
