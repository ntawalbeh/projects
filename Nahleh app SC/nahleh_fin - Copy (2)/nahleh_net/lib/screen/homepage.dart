import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nahleh_net/screen/codes.dart';
import 'package:nahleh_net/screen/dashboard.dart';
import 'package:nahleh_net/screen/info.dart';
import 'package:nahleh_net/widget/constant.dart';

class HomePageNavigator extends StatefulWidget {
  final int? indexpage;
  const HomePageNavigator({Key? key, this.indexpage}) : super(key: key);

  @override
  _HomePageNavigatorState createState() => _HomePageNavigatorState();
}

class _HomePageNavigatorState extends State<HomePageNavigator> {
  int _selectedIndex = 1;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.indexpage == null) {
      _selectedIndex = 1;
    } else {
      _selectedIndex = widget.indexpage!;
    }
  }

  static List<Widget> _widgetOptions = <Widget>[
    DashBoard(),
    Codes(),
    InfoPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.white,
          canvasColor: kPrimaryColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: "Tajawal"),
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: _widgetOptions.elementAt(_selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: firstColor,
            unselectedItemColor: Colors.white,
            selectedLabelStyle:
                TextStyle(color: firstColor, fontFamily: 'Tajawal'),
            unselectedLabelStyle:
                TextStyle(color: Colors.white, fontFamily: 'Tajawal'),
            selectedIconTheme: IconThemeData(color: firstColor, size: 32),
            unselectedIconTheme: IconThemeData(color: secontColor, size: 32),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/images/home.svg',
                    color: _selectedIndex == 0 ? Colors.grey[200] : secontColor,
                    width: 30,
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/images/code.svg',
                    color: _selectedIndex == 1 ? Colors.grey[200] : secontColor,
                    width: 30,
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/images/info.svg',
                    color: _selectedIndex == 2 ? Colors.grey[200] : secontColor,
                    width: 30,
                  ),
                  label: ''),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
