import 'dart:html';


class Movie {
String title;
String releaseDate; 
String url;
String htmlPage;
String posterUrl;

Movie(this.title, this.url, this.releaseDate, this.htmlPage, this.posterUrl);

Movie.fromJson(Map json)
  : title = json['title'],
    releaseDate = json['releaseDate'],
    url = json['url'],
    htmlPage = json['htmlPage'],
    posterUrl = json['posterUrl'];

Map toJson(){
  return {'title': title, 'releaseDate': releaseDate, 'url': url, 'htmlPage': htmlPage, 'posterUrl': posterUrl};
}

Object? toLis(){}

}