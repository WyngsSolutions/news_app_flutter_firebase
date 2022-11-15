// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, avoid_print, sized_box_for_whitespace, deprecated_member_use, curly_braces_in_flow_control_structures
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
//import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/news.dart';
import '../../utils/constants.dart';
import '../../utils/size_config.dart';
import 'package:timeago/timeago.dart' as timeago;

class MyFavorites extends StatefulWidget {
  const MyFavorites({ Key? key }) : super(key: key);

  @override
  State<MyFavorites> createState() => _MyFavoritesState();
}

class _MyFavoritesState extends State<MyFavorites> {
  List<News> news = [];
  //BannerAd? _bannerAd;
  bool _bannerAdIsLoaded = false;

  @override
  void initState() {
    super.initState();
    //loadAd();
  }

  @override
  void dispose() {
    super.dispose();
    //_bannerAd?.dispose();
  }

  /// Load another ad, disposing of the current ad if there is one.
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
  // ..load();
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
            Text('Favorites', style: TextStyle(color: Colors.white, fontSize: SizeConfig.fontSize*2.3),),
          ],
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: (Constants.favNews.isEmpty) ?  Container(
        child: Center(
          child: Text(
            'No Favourites Added',
            style: TextStyle(
              color: Colors.grey,
              fontSize: SizeConfig.fontSize*2.2
            ),
          ),
        ),
      ): Container(
        padding: EdgeInsets.only(bottom:10),
        child: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: Constants.favNews.length,
            itemBuilder: (context, i){
              return topView(Constants.favNews[i]);
            },
          ),
        ),
      ),
      // bottomNavigationBar: (!_bannerAdIsLoaded) ? Container(height: 0,) : Container(
      //   height: _bannerAd!.size.height.toDouble(),
      //   width: _bannerAd!.size.width.toDouble(),
      //   child: AdWidget(ad: _bannerAd!)
      // ),
    );
  }

  Widget topView(News newsDetail){

    final newsTime = DateFormat('yyyy-MM-dd hh:mm:ss').parse(newsDetail.newsTime);
    String dateText = timeago.format(newsTime); 
    bool isFavorite = false;
    News isFoundInFavs = Constants.favNews.firstWhere((element) => element.newsName == newsDetail.newsName, orElse: (){return News.fromEmpty();});
    if(isFoundInFavs.newsName.isNotEmpty)
      isFavorite = true;

    return GestureDetector(
      onTap :(){
        launch(newsDetail.newsLink);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal*5, vertical: SizeConfig.blockSizeVertical*1),
        height: SizeConfig.blockSizeVertical*35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Constants.appThemeColor,
          image: DecorationImage(
            image: (newsDetail.newsImage.isEmpty) ? AssetImage('assets/placeholder.png') : CachedNetworkImageProvider(newsDetail.newsImage) as ImageProvider,
            fit: (newsDetail.newsImage.isEmpty) ? BoxFit.contain : BoxFit.cover
          )
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [Colors.transparent, Colors.transparent, Colors.black.withOpacity(0.6), Colors.black],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.3, 0.4, 1, 1],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: EdgeInsets.only(top: 20,right: 20),
                  //color: Colors.lightBlue,
                  child: GestureDetector(
                    onTap: () async {
                      if(!isFavorite)
                        await News.saveNewsToList(newsDetail);
                      else
                        await News.deleteSavedTranslationFromFavorite(newsDetail);                              
                      
                      setState(() {});
                    },
                    child: Icon((isFavorite) ?Icons.favorite : Icons.favorite_border, color: Colors.white, size: SizeConfig.blockSizeVertical*3.5,)
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal : SizeConfig.blockSizeHorizontal*5),
                child: Column(
                  children: [
                    Text(
                      newsDetail.newsName,
                      maxLines: 2,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: SizeConfig.fontSize*1.8,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*1, bottom: SizeConfig.blockSizeVertical*1),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Container(
                          //   padding: EdgeInsets.symmetric(horizontal: 10),
                          //   height: SizeConfig.blockSizeVertical*3.4,
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(5),
                          //     color: Colors.orange
                          //   ),
                          //   child: Center(
                          //     child: Text(
                          //       'Breaking news',
                          //       maxLines: 2,
                          //       style: TextStyle(
                          //         color: Colors.white,
                          //         fontSize: SizeConfig.fontSize*1.5,
                          //         fontWeight: FontWeight.bold
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          Row( 
                            children: [
                              Text(
                                newsDetail.newsFrom,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: SizeConfig.fontSize *1.5,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                              Container(
                                height: SizeConfig.blockSizeVertical*0.5,
                                width: SizeConfig.blockSizeVertical*0.5,
                                margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*3, right: SizeConfig.blockSizeHorizontal*1,),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle
                                ),
                              ),
                              Text(
                                dateText,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: SizeConfig.fontSize *1.5,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                )
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget userCell(News newsDetail){
    final newsTime = DateFormat('yyyy-MM-dd hh:mm:ss').parse(newsDetail.newsTime);
    String dateText = timeago.format(newsTime); 
    bool isFavorite = false;
    News isFoundInFavs = Constants.favNews.firstWhere((element) => element.newsName == newsDetail.newsName, orElse: (){return News.fromEmpty();});
    if(isFoundInFavs.newsName.isNotEmpty)
      isFavorite = true;

    return GestureDetector(
      onTap :(){
        launch(newsDetail.newsLink);
      },
      child: Container(
        height: SizeConfig.blockSizeVertical*11,
        margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical*2, left: SizeConfig.blockSizeHorizontal*5, right: SizeConfig.blockSizeHorizontal*5),
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal*3, vertical: SizeConfig.blockSizeVertical*1),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: SizeConfig.blockSizeVertical *9,
              width: SizeConfig.blockSizeHorizontal *20,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
                // image: DecorationImage(
                //   image: (newsDetail['image_url'] == null) ? AssetImage('assets/news.png') : CachedNetworkImageProvider(newsDetail['image_url']) as ImageProvider,
                //   fit: BoxFit.cover
                // )
              ),
              child: CachedNetworkImage(   
              fit: BoxFit.cover,
              imageUrl: (newsDetail.newsImage.isEmpty) ? "" : newsDetail.newsImage,  
              imageBuilder: 
              (context, imageProvider) =>  Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),   
              ),   
              placeholder: (context, url) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Constants.appThemeColor,
                  image: DecorationImage(
                    image: AssetImage('assets/placeholder.png'),
                    fit: BoxFit.contain,
                  ),
                ),   
              ),   
              errorWidget: (context, url, error) =>  Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Constants.appThemeColor,
                  image: DecorationImage(
                    image: AssetImage('assets/placeholder.png'),
                    fit: BoxFit.cover,
                    ),
                  ),   
                ),   
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*4, right: SizeConfig.blockSizeHorizontal*2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            newsDetail.newsName,
                            maxLines: 2,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: SizeConfig.fontSize *1.6,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            if(!isFavorite)
                              await News.saveNewsToList(newsDetail);
                            else
                              await News.deleteSavedTranslationFromFavorite(newsDetail);                              
                            
                            setState(() {});
                          },
                          child: Icon((isFavorite) ?Icons.favorite : Icons.favorite_border, color: Constants.appThemeColor, size: SizeConfig.blockSizeVertical*2.5,)
                        )
                      ],
                    ),
                    SizedBox(height: SizeConfig.blockSizeVertical*0.5,),
                    Row( 
                      children: [
                        Expanded(
                          child: Text(
                            newsDetail.newsFrom,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: SizeConfig.fontSize *1.4,
                            ),
                          ),
                        ),
                        Container(
                          height: SizeConfig.blockSizeVertical*0.5,
                          width: SizeConfig.blockSizeVertical*0.5,
                          margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*3, right: SizeConfig.blockSizeHorizontal*1,),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle
                          ),
                        ),
                        Text(
                          dateText,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: SizeConfig.fontSize *1.2,
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ),
            ),
          ],
        )
      ),
    );
  }
}