import 'package:alalmiya_g2/views/home/pages/favs/view.dart';
import 'package:alalmiya_g2/views/home/pages/main/view.dart';
import 'package:alalmiya_g2/views/home/pages/my_account/view.dart';
import 'package:alalmiya_g2/views/home/pages/my_orders/view.dart';
import 'package:alalmiya_g2/views/home/pages/notifications/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 0;
  List<Widget> pages = [
    MainPage(),
    MyOrdersPage(),
    NotificationsPage(),
    FavsPage(),
    MyAccountPage(),
  ];

  List<String> titles = [
    "الرئيسية",
    "طلباتي",
    "الإشعارات",
    "المفضلة",
    "حسابي",
  ];

  List<String> icons = [
    "main",
    "my_orders",
    "notifications",
    "favs",
    "my_account",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Color(0xffAED489),
        selectedItemColor: Colors.white,
        currentIndex: currentIndex,
        onTap: (value) {
          currentIndex = value;
          setState(() {});
        },
        items: List.generate(
            icons.length,
            (index) => BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/icons/svg/${icons[index]}.svg",
                  color: currentIndex == index ? Colors.white : Color(0xffAED489),
                ),
                label: titles[index])),
      ),
    );
  }
}
