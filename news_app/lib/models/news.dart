// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:convert';
import 'package:news_app/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class News{

  String newsName = "";
  String newsFrom = "";
  String newsTime = "";
  String newsImage = "";
  String newsLink = "";

  
  News({required this.newsName, required this.newsFrom, required this.newsTime, required this.newsImage, required this.newsLink});

  factory News.fromJson(dynamic json) {
    News savedNews = News(
      newsName: json['newsName'],
      newsFrom : json['newsFrom'],
      newsTime : json['newsTime'],
      newsImage : json['newsImage'],
      newsLink : json['newsLink'],
    );
    return savedNews;
  }

  ///// ***** SavedQuestions SAVING LOADING RELATED  ***** /////
  factory News.fromSavedJson(dynamic parsedJson) {
    return News(
      newsName: parsedJson['newsName'] ?? "",
      newsFrom: parsedJson['newsFrom'] ?? "",
      newsTime: parsedJson['newsTime'] ?? "",
      newsImage: parsedJson['newsImage'] ?? "",
      newsLink: parsedJson['newsLink'] ?? ""
    );
  }

  News.fromEmpty();

  Map<String, dynamic> toJson() {
    return {
      "newsName": newsName,
      'newsFrom' : newsFrom,
      "newsTime": newsTime,
      "newsImage": newsImage,    
      "newsLink": newsLink,   
    };
  }

  static Future<void> saveNewsToList(News news) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> alreadySaved = prefs.getStringList('SavedNewsList') ?? [];  
    String newAddition = jsonEncode(news.toJson());
    alreadySaved.add(newAddition);
    await prefs.setStringList('SavedNewsList', alreadySaved);
    Constants.favNews = await getAllSavedList();
  }

  static Future getAllSavedList() async {
    List<News> newsList = [];
    final prefs = await SharedPreferences.getInstance();
    List<String> alreadySaved = prefs.getStringList('SavedNewsList') ?? [];
    for(int i=0; i < alreadySaved.length; i++)
    {
      Map decodeList = jsonDecode(alreadySaved[i]);
      News news = News.fromSavedJson(decodeList);
      newsList.add(news);
    }
    newsList.sort((b, a) => a.newsName.compareTo(b.newsName));
    return newsList;
  }

  static Future deleteSavedTranslationFromFavorite(News newsDetail) async {
    final prefs = await SharedPreferences.getInstance();
    List<News> news = await getAllSavedList();
    int indexToDelete = -1;
    for(int i=0; i < news.length; i++)
    {
      if(news[i].newsName == newsDetail.newsName && news[i].newsLink == newsDetail.newsLink)
        indexToDelete = i;
    }

    if(indexToDelete != -1)
      news.removeAt(indexToDelete);

    List<String> alreadySaved = [];
    for(int i=0; i < news.length ; i++)
    {
      String newAddition = jsonEncode(news[i].toJson());
      alreadySaved.add(newAddition);
    }
    await prefs.setStringList('SavedNewsList', alreadySaved);
    Constants.favNews = await getAllSavedList();
  }
}