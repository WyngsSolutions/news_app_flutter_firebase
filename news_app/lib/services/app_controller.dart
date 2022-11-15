import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:news_app/models/news.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppController {

  //SIGN UP
  Future getNews(Map newsData, int currentPage) async {
    try {
      String url = newsData['url'];
      url = url.replaceFirst('{pageNo}', currentPage.toString());
      Response response = await get(Uri.parse(url));
      if (response.statusCode == 200) {
        print(response.body);
        Map data = jsonDecode(response.body);
        bool isNextPage = false;
        if(data['nextPage'] != null)
        {
          currentPage = currentPage + 1;
          isNextPage = true;
        }

        List<News> newsList = [];
        for(int i=0; i < data['results'].length; i++){
          News news = News.fromEmpty();
          news.newsName =  (data['results'][i]['title'] == null) ? "" : data['results'][i]['title'];
          news.newsFrom =  (data['results'][i]['source_id'] == null) ? "" : data['results'][i]['source_id'];
          news.newsImage =  (data['results'][i]['image_url'] == null) ? "" : data['results'][i]['image_url'];
          news.newsLink =  (data['results'][i]['link'] == null) ? "" : data['results'][i]['link'];
          news.newsTime =  (data['results'][i]['pubDate'] == null) ? "" : data['results'][i]['pubDate'];
          newsList.add(news);
        }

        Map finalResponse = <dynamic, dynamic>{}; //empty map
        finalResponse['Status'] = "Success";
        finalResponse['News'] = newsList;
        finalResponse['isNextPage'] = isNextPage;
        finalResponse['CurrentPage'] = currentPage;
        return finalResponse;
      } 
      else
      {
        Map data = jsonDecode(response.body);
        Map finalResponse = <dynamic, dynamic>{}; //empty map
        finalResponse['Error'] = "Error";
        finalResponse['ErrorMessage'] = data["msg"];
        return finalResponse;
      }
    } catch (e) {
      print(e.toString());
      return setUpFailure();
    }
  }

  Future searchNews(String searchText, int currentPage) async {
    try {
      String url = "https://newsdata.io/api/1/news?apikey=pub_10483b32b6b515b6885e2102671fb3ffd8793&q=$searchText&language=en&page={pageNo}";
      url = url.replaceFirst('{pageNo}', currentPage.toString());
      Response response = await get(Uri.parse(url));
      if (response.statusCode == 200) {
        print(response.body);
        Map data = jsonDecode(response.body);
        bool isNextPage = false;
        if(data['nextPage'] != null)
        {
          currentPage = currentPage + 1;
          isNextPage = true;
        }

        List<News> newsList = [];
        for(int i=0; i < data['results'].length; i++){
          News news = News.fromEmpty();
          news.newsName =  (data['results'][i]['title'] == null) ? "" : data['results'][i]['title'];
          news.newsFrom =  (data['results'][i]['source_id'] == null) ? "" : data['results'][i]['source_id'];
          news.newsImage =  (data['results'][i]['image_url'] == null) ? "" : data['results'][i]['image_url'];
          news.newsLink =  (data['results'][i]['link'] == null) ? "" : data['results'][i]['link'];
          news.newsTime =  (data['results'][i]['pubDate'] == null) ? "" : data['results'][i]['pubDate'];
          newsList.add(news);
        }

        Map finalResponse = <dynamic, dynamic>{}; //empty map
        finalResponse['Status'] = "Success";
        finalResponse['News'] = newsList;
        finalResponse['isNextPage'] = isNextPage;
        finalResponse['CurrentPage'] = currentPage;
        return finalResponse;
      } 
      else
      {
        Map data = jsonDecode(response.body);
        Map finalResponse = <dynamic, dynamic>{}; //empty map
        finalResponse['Error'] = "Error";
        finalResponse['ErrorMessage'] = data["msg"];
        return finalResponse;
      }
    } catch (e) {
      print(e.toString());
      return setUpFailure();
    }
  }

  Future<Map<String, String>> setHeaders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userToken = prefs.getString('token') ?? "";
    Map<String, String> headers = {
      //"Content-type": "application/json",
    };
    return headers;
  }

  Map setUpFailure() {
    Map finalResponse = <dynamic, dynamic>{}; //empty map
    finalResponse['Status'] = "Error";
    finalResponse['ErrorMessage'] = "Cannot connect to server at this time. Please try again later";
    return finalResponse;
  }
}
