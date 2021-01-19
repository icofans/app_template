import 'package:app_template/base/util/util.dart';
import 'package:app_template/base/widget/exit_scope.dart';
import 'package:app_template/pages/home/home_page.dart';
import 'package:app_template/pages/profile/profile_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController _pageController = PageController();

  int _tabIndex = 0;

  final List _pages = [
    HomePage(),
    ProfilePage(),
  ];

  void _pageChanged(int index) {
    setState(() {
      if (_tabIndex != index) _tabIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExitScope(
      child: Scaffold(
        body: PageView.builder(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: _pageChanged,
          itemCount: _pages.length,
          itemBuilder: (context, index) => _pages[index],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "首页",
              // activeIcon: Image(image: Util.imageNamed("ico_working_selected")),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "我的",
            ),
          ],
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Color(0xFF9DA4BA),
          selectedItemColor: Theme.of(context).primaryColor,
          selectedFontSize: 13.spx,
          unselectedFontSize: 13.spx,
          currentIndex: _tabIndex,
          onTap: (index) {
            _pageController.jumpToPage(index);
          },
        ),
      ),
    );
  }
}
