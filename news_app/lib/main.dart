import 'dart:io';
//import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'screens/splash_screen/splash_screen.dart';
import 'utils/constants.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  //await Firebase.initializeApp();
  // if(Platform.isIOS)
  // {
  //   final status = await AppTrackingTransparency.requestTrackingAuthorization();
  //   print(status);
  // }
  // await MobileAds.instance.initialize();
  //Constants.createInterstitialAd();
  runApp(MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.white
    ..backgroundColor = Constants.appThemeColor
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..textStyle = const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false
    ..customAnimation = CustomAnimation();
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KV News',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
      ),
      home: const SplashScreen(),
      builder: EasyLoading.init(),
    );
  }
}


class CustomAnimation extends EasyLoadingAnimation {
  CustomAnimation();
  @override
  Widget buildWidget(
    Widget child,
    AnimationController controller,
    AlignmentGeometry alignment,
  ) {
    double opacity = controller.value;
    return Opacity(
      opacity: opacity,
      child: RotationTransition(
        turns: controller,
        child: child,
      ),
    );
  }
}
