// ignore_for_file: prefer_const_declarations
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../models/news.dart';

class Constants {
  static final Constants _singleton = Constants._internal();
  static String appName = "KV News";
  static bool isUserSignedIn = false;
  static bool isFirstTimeAppLaunched = true;
  static Color appThemeColor = const Color(0xff140268);
  static List<News> favNews = [];
  //ADS
  static String testDevice = 'YOUR_DEVICE_ID';
  static int maxFailedLoadAttempts = 3;
  // static InterstitialAd? _interstitialAd;
  // static int _numInterstitialLoadAttempts = 0;
  // static final AdRequest request = const AdRequest(
  //   keywords: <String>['foo', 'bar',],
  //   contentUrl: 'http://foo.com/bar.html',
  //   nonPersonalizedAds: true,
  // );

  factory Constants() {
    return _singleton;
  }

  Constants._internal();

  static void showDialog(String message) {
    Get.generalDialog(
      pageBuilder: (context, __, ___) => AlertDialog(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(const Radius.circular(10.0))),
        title: Text(appName, style: const TextStyle(fontWeight: FontWeight.w700),),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('OK')
          )
        ],
      )
    );
  }

//   static void createInterstitialAd() {
//     InterstitialAd.load(
//     adUnitId: Platform.isAndroid
//       ? 'ca-app-pub-3940256099942544/1033173712'
//       : 'ca-app-pub-3940256099942544/4411468910',
//     request: request,
//     adLoadCallback: InterstitialAdLoadCallback(
//       onAdLoaded: (InterstitialAd ad) {
//         print('$ad loaded');
//         _interstitialAd = ad;
//         _numInterstitialLoadAttempts = 0;
//         _interstitialAd!.setImmersiveMode(true);
//       },
//       onAdFailedToLoad: (LoadAdError error) {
//         print('InterstitialAd failed to load: $error.');
//         _numInterstitialLoadAttempts += 1;
//         _interstitialAd = null;
//         if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
//           createInterstitialAd();
//         }
//       },
//     ));
//   }

//   static void showInterstitialAd() {
//     if (_interstitialAd == null) {
//       print('Warning: attempt to show interstitial before loaded.');
//       return;
//     }
//     _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
//       onAdShowedFullScreenContent: (InterstitialAd ad) =>
//           print('ad onAdShowedFullScreenContent.'),
//       onAdDismissedFullScreenContent: (InterstitialAd ad) {
//         print('$ad onAdDismissedFullScreenContent.');
//         ad.dispose();
//         createInterstitialAd();
//       },
//       onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
//         print('$ad onAdFailedToShowFullScreenContent: $error');
//         ad.dispose();
//         createInterstitialAd();
//       },
//     );
//     _interstitialAd!.show();
//     _interstitialAd = null;
//   }
}

//ANDROID


//IOS
