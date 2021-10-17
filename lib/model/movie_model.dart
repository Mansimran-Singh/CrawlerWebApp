import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';

class Movie {
String title;
String releaseDate; 
String url;
String htmlPage;

Movie(this.title, this.url, this.releaseDate, this.htmlPage);

Movie.fromJson(Map json)
  : title = json['title'],
    releaseDate = json['releaseDate'],
    url = json['url'],
    htmlPage = json['htmlPage'];

Map toJson(){
  return {'title': title, 'releaseDate': releaseDate, 'url': url, 'htmlPage': htmlPage};
}

Object? toLis(){}

}