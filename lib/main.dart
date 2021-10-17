import 'dart:html';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web_app_for_crawler/html_parser.dart';
import 'package:web_app_for_crawler/model/movie_model.dart';
import 'package:web_app_for_crawler/not_found_page.dart';

import 'card_view.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IMDB Crawled Releases',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      onGenerateRoute: (page) {
        // print(page.name);
        return MaterialPageRoute(builder: (context) {
          return RouteController(pageName: page.name!);
        });
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) {
            return NotFoundPage();
          },
        );
      },
    );
  }
}

class RouteController extends StatelessWidget {
  final String pageName;
  const RouteController({
    Key? key,
    required this.pageName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (pageName == '/') {
      return MyHomePage(title: 'IMDB Crawled Releases');
    } else {
      return NotFoundPage();
    }
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget buildMovieList(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    double width = MediaQuery.of(context).size.width;
    int widthCard = (250);
    int countRow = width ~/ widthCard;

    if (snapshot.hasData) {
      return GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: countRow),
        itemCount: snapshot.data!.docs.length,
        itemBuilder: (context, index) {
          DocumentSnapshot movie = snapshot.data!.docs[index];

          var df =
              DateFormat('MM-dd-yyyy').format(movie['releaseDate'].toDate());

          Movie m = Movie(movie['title'], movie['url'], df, movie['htmlPage']);

          return GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HelpScreen(m)));
            },
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(40), bottom: Radius.circular(40)),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: CardView(m.releaseDate.toString(), m.title, m.url),
              ),
            ),
          );
        },
      );
    } else if (snapshot.connectionState == ConnectionState.done &&
        !snapshot.hasData) {
      // Handle no data
      return const Center(
        child: Text("No movies found."),
      );
    } else {
      // Still loading
      return const Center(child: CircularProgressIndicator());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),centerTitle: true,
        ),
        body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('movies')
              .orderBy('releaseDate', descending: false)
              .get(),
          builder: buildMovieList,
        ));
  }
}
