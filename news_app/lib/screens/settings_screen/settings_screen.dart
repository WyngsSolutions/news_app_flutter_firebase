// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures
import 'dart:io';
import 'package:flutter/material.dart';
//import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/constants.dart';
import '../../utils/size_config.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({ Key? key }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  //BannerAd? _bannerAd;
  bool _bannerAdIsLoaded = false;

  @override
  void initState() {
    super.initState();
    //Constants.showInterstitialAd();
    //loadAd();
  }

  @override
  void dispose() {
    super.dispose();
    //_bannerAd?.dispose();
  }

  // Future<void> loadAd() async {
  //   _bannerAd = BannerAd(
  //   size: AdSize.banner,
  //   adUnitId: Platform.isAndroid
  //       ? 'ca-app-pub-3940256099942544/6300978111'
  //       : 'ca-app-pub-3940256099942544/2934735716',
  //   listener: BannerAdListener(
  //     onAdLoaded: (Ad ad) {
  //       print('$BannerAd loaded.');
  //       setState(() {
  //         _bannerAdIsLoaded = true;
  //       });
  //     },
  //     onAdFailedToLoad: (Ad ad, LoadAdError error) {
  //       print('$BannerAd failedToLoad: $error');
  //       ad.dispose();
  //     },
  //     onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
  //     onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
  //   ),
  //   request: AdRequest())
  //   ..load();
  // }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Constants.appThemeColor,
        titleSpacing: 5,
        title: Row(
          children: [
            Container(
              height: kToolbarHeight-20,
              width: kToolbarHeight-10,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image:  AssetImage('assets/logo.png'),
                  fit: BoxFit.contain
                )
              ),
            ),
            Text('Settings', style: TextStyle(color: Colors.white, fontSize: SizeConfig.fontSize*2.3),),
          ],
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal*5, vertical: SizeConfig.blockSizeVertical*2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Text(
            //   'About KV News',
            //   style: TextStyle(
            //     color: Colors.black,
            //     fontSize: SizeConfig.fontSize*2.2,
            //     fontWeight: FontWeight.bold
            //   ),
            // ),
            // Container(
            //   height: SizeConfig.blockSizeVertical*2,
            // ),
            //listCell('Contact Us', Icons.call, 1),
            //listCell('About Us', Icons.info, 2),
            listCell('Privacy Policy', Icons.policy_rounded, 3),
            listCell('Share app', Icons.share, 4),
          ],
        ),
      ),
      // bottomNavigationBar: (!_bannerAdIsLoaded) ? Container(height: 0,) : Container(
      //   height: _bannerAd!.size.height.toDouble(),
      //   width: _bannerAd!.size.width.toDouble(),
      //   child: AdWidget(ad: _bannerAd!)
      // ),
    );
  }

  Widget listCell(String title, IconData icon, int listId){
    return GestureDetector(
      onTap: (){
        // if(listId == 1)
        //   //launchUrl(Uri.parse('https://KV Newsapp.com/'));
        // if(listId == 2)
        //   //launchUrl(Uri.parse('https://www.linkedin.com/in/tristansw'));
        if(listId == 3)
          launchUrl(Uri.parse('http://wyngslogistics.com/#/policy'));
        if(listId == 4)
          Share.share('Get the latest news app on appstore/nKV News');
      },
      child: Container(
        height: SizeConfig.blockSizeVertical*8,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black,
              width: 0.2
            )
          )
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: SizeConfig.blockSizeVertical*3,
              color: Constants.appThemeColor
            ),
            Container(
              margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*4),
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: SizeConfig.fontSize*1.8,
                  fontWeight: FontWeight.w500
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}