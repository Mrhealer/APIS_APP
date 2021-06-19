import 'package:apis_app/ui/map/map_screen.dart';
import 'package:apis_app/ui/profile/profile_screen.dart';
import 'package:apis_app/ui/waitingList/watting_list.dart.dart';
import 'package:apis_app/utils/auth_atils.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  int _selectedTabIndex = 0;

  static const List<Widget> _pages = <Widget>[
    WaitingListScreen(),
    MapScreen(),
    WaitingListScreen(),
    ProfileScreen(),
  ];

  _changeIndex(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    AuthUtils.instance.getToken().then((value) => {
          if (value.toString().isNotEmpty)
            {AuthUtils.instance.setTokenLocal(value.toString())}
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedTabIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTabIndex,
        onTap: _changeIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
          BottomNavigationBarItem(icon: Icon(Icons.map), title: Text("Map")),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), title: Text("Notification")),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), title: Text("Profile")),
        ],
      ),
    );
  }
}
