import 'dart:html';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:web_app_for_crawler/model/movie_model.dart';

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
      title: 'IMDB Releases',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'IMDB Crawled Releases'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Widget buildUserList(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasData) {
      return GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
        itemCount: snapshot.data!.docs.length,
        itemBuilder: (context, index) {
          DocumentSnapshot movie = snapshot.data!.docs[index];

          var df =
              DateFormat('MM-dd-yyyy').format(movie['releaseDate'].toDate());

          Movie m = Movie(movie['title'], movie['url'], df, movie['htmlPage']);

          return GestureDetector(
            onTap: (){},
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
      return CircularProgressIndicator();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('movies')
              .orderBy('releaseDate', descending: false)
              .get(),
          builder: buildUserList,
        ));
  }
}
