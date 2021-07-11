import 'package:flutter/material.dart';
import 'package:here4u/ui/home/home_screen.dart';

class NavigationBar extends StatefulWidget {
  static const String id = 'navigation_bar';
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  int selectedPage = 0;
  late PageController pageController;
  //***************************Init State**************************************
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController(initialPage: 0);
  }

  //---------------------------List of Pages------------------------------------
  final List<Widget> _pages = [
    HomeScreen(),
    //SeekedServices(),
    // MyAppointment(),
  ];
  //--------------------------On Tapped item-----------------------------------
  _onTapped(int index) {
    setState(() {
      selectedPage = index;

      pageController.jumpToPage(index);
    });
  }
  //------------------------On Page Changed-------------------------------------

  void onPageChanged(int page) {
    setState(() {
      this.selectedPage = page;
    });
  }
  //----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: _pages,
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      key: _drawerKey,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // to make it unsizable
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "الرئيسية"),
          BottomNavigationBarItem(
              icon: Icon(Icons.car_rental), label: "تبرعات"),
          BottomNavigationBarItem(
              icon: Icon(Icons.date_range), label: "الحقيبة"),
          BottomNavigationBarItem(icon: Icon(Icons.date_range), label: "حسابي"),
          BottomNavigationBarItem(icon: Icon(Icons.date_range), label: "تواصل"),
        ],
        currentIndex: selectedPage,
        showUnselectedLabels: true,
        unselectedItemColor: Color(0xFFB1B1B1),
        selectedItemColor: Colors.purpleAccent,
        selectedFontSize: 10.0,
        unselectedFontSize: 10.0,
        backgroundColor: Colors.white,
        onTap: _onTapped,
      ),
    );
  }
}
