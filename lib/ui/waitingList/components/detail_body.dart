import 'package:apis_app/models/waitingList/waiting_list_detail_model.dart';
import 'package:apis_app/ui/routers/fluro_navigator.dart';
import 'package:apis_app/ui/routers/router_generator.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BodyDetail extends StatelessWidget {
  final List<WaitingListDetailData> listWaitingList;

  BodyDetail({this.listWaitingList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: listWaitingList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: ExpansionTileCard(
                leading: CircleAvatar(
                    child: Text('C',
                        style: TextStyle(
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.bold))),
                title: Text(listWaitingList[index].tenKhachHang,
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: "OpenSans",
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold)),
                subtitle: Text(listWaitingList[index].diaChiKhachDi,
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: "OpenSans",
                        color: Colors.grey,
                        fontWeight: FontWeight.bold)),
                children: <Widget>[
                  Divider(
                    thickness: 1.0,
                    height: 1.0,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 0,
                          vertical: 8.0,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Tài xế",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: "OpenSans")),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    listWaitingList[index].hoTenTaiXeLimousine,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "OpenSans",
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Sđt tài xế",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "OpenSans",
                                    )),
                                Text(
                                    listWaitingList[index]
                                        .dienThoaiTaiXeLimousine,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "OpenSans",
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Tên xe",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "OpenSans",
                                    )),
                                Text(listWaitingList[index].tenXeLimousine,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "OpenSans",
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Biển số",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "OpenSans",
                                    )),
                                Text(listWaitingList[index].bienSoXeLimousine,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "OpenSans",
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Tên khác Hàng",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "OpenSans",
                                    )),
                                Text(listWaitingList[index].tenKhachHang,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "OpenSans",
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Số điện thoại",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "OpenSans",
                                    )),
                                Text(listWaitingList[index].soDienThoaiKhach,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "OpenSans",
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Địa chỉ đi",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "OpenSans",
                                    )),
                                Text(listWaitingList[index].diaChiKhachDi,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "OpenSans",
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Địa chỉ đến",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "OpenSans",
                                    )),
                                Text(listWaitingList[index].diaChiKhachDen,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "OpenSans",
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                          ],
                        )),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceAround,
                    buttonHeight: 52.0,
                    buttonMinWidth: 90.0,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          _launchPhone(
                              "tel:${listWaitingList[index].dienThoaiTaiXeLimousine}");
                        },
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.call),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Text('Tài xế'),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // cardB.currentState?.collapse();
                        },
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.zoom_in),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Text('Điển đến'),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          NavigatorUtils.push(
                              context, RouterGenerator.routeMap);
                        },
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.map),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Text('Điểm đón'),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          _launchPhone(
                              "tel:${listWaitingList[index].soDienThoaiKhach}");
                        },
                        child: Column(
                          children: <Widget>[
                            Icon(Icons.call_end_sharp),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                            ),
                            Text('Khách hàng'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }

  void _launchPhone(String str) async =>
      await canLaunch(str) ? await launch(str) : throw 'Could not launch $str';
}
