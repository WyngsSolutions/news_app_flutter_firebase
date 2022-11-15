import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/models/news.dart';
import '../../utils/constants.dart';
import '../home_screen/home_screen.dart';
import '../../utils/size_config.dart';

class SplashScreen extends StatefulWidget {
  
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      checkIfUserLoggedIn();
    });
  }

  void checkIfUserLoggedIn() async {
    //Check User Login
    Constants.favNews = await News.getAllSavedList();
    Get.offAll(const HomeScreen(defaultPage: 0,));
  }
  
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Constants.appThemeColor,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            
            Center(
              child: Container(
                height: SizeConfig.blockSizeHorizontal*90,
                width: SizeConfig.blockSizeHorizontal*90,
                alignment: Alignment.center,
                //color: Colors.red,
                child: Image.asset(
                  "assets/logo.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // Container(
            //   margin: EdgeInsets.only(top: 5),
            //   child: Text(
            //     'Developed by KV',
            //     textAlign: TextAlign.center,
            //     style: TextStyle(
            //       color: Colors.white,
            //       fontSize: SizeConfig.fontSize*1.6,
            //       fontWeight: FontWeight.bold
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}