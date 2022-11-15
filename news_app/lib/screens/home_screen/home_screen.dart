import 'dart:io';
import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../utils/size_config.dart';
import '../my_favorites/my_favorites.dart';
import '../news_screen/news_screen.dart';
import '../search_screen/search_screen.dart';
import '../settings_screen/settings_screen.dart';

class HomeScreen extends StatefulWidget {

  final int defaultPage;
  const HomeScreen({required this.defaultPage});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 
  int _pageIndex = 0;
  late PageController _pageController;
  bool isUserSignedIn = false;
  List<Widget> tabPages =[];

  @override
  void initState() {
    super.initState();
    _pageIndex = widget.defaultPage;
    tabPages = [
      const NewsApp(),
      const SearchScreen(),
      const MyFavorites(),
      const SettingsScreen(),
    ];
    _pageController = PageController(initialPage: _pageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _pageIndex = page;
    });
  }

  void onTabTapped(int index) {
    setState(() {
      _pageIndex = index;
    });

    _pageController.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: tabPages[_pageIndex],
      bottomNavigationBar: Container(
        height: (Platform.isIOS) ? SizeConfig.blockSizeVertical * 12:  SizeConfig.blockSizeVertical * 8,
        color: Colors.white,
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: _pageIndex,
          selectedItemColor: Constants.appThemeColor,
          unselectedItemColor: Colors.grey[300],
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          unselectedFontSize: SizeConfig.blockSizeVertical*1.7,
          selectedFontSize: SizeConfig.blockSizeVertical*1.7,
          onTap: onTabTapped,
          items: [
            BottomNavigationBarItem(
              icon: Container(
                margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 0.7),
                // child: ImageIcon(
                //   AssetImage("assets/home.png"),
                //   size: SizeConfig.blockSizeVertical*2.7,
                // ),
                child: Icon(Icons.home, size: SizeConfig.blockSizeVertical*2.7),
              ),
              label: 'Home'
            ),
            BottomNavigationBarItem(
              icon: Container(
                margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 0.7),
                child: Icon(Icons.search, size: SizeConfig.blockSizeVertical*2.7),
              ),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Container(
                margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 0.7),
                child: Icon(Icons.favorite, size: SizeConfig.blockSizeVertical*2.7),
              ),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Container(
                margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 0.7),
                // child: ImageIcon(
                //   AssetImage("assets/settings.png"),
                //   size: SizeConfig.blockSizeVertical*2.7,
                // ),
                child: Icon(Icons.settings, size: SizeConfig.blockSizeVertical*2.7),
              ),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}