import 'dart:html';
import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:web_app_for_crawler/html_parser.dart';
import 'package:web_app_for_crawler/model/movie_model.dart';
import 'package:web_app_for_crawler/not_found_page.dart';
import 'package:web_app_for_crawler/widgets/home_top_view.dart';

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
      title: 'IMBD CRAWLER',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/home',
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
    if (pageName == '/home') {
      return MyHomePage(title: 'IMBD CRAWLER');
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
    int widthCard = (350);
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

          Movie m = Movie(movie['title'], movie['url'], df, movie['htmlPage'],
              movie['posterUrl']);

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
                  child: CardView(m.releaseDate.toString(), m.title, m.url, m.posterUrl),
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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            snap: false,
            floating: false,
            elevation: 0,
            expandedHeight: 290.0,
            flexibleSpace: Center(
              child: FlexibleSpaceBar(
                title: Center(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          widget.title,
                          textAlign: TextAlign.justify,
                          textStyle: GoogleFonts.robotoCondensed(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w400),
                          speed: const Duration(milliseconds: 100),
                        ),
                      ],
                      totalRepeatCount: 2,
                      pause: const Duration(milliseconds: 1000),
                      displayFullTextOnTap: true,
                      stopPauseOnTap: true,
                    ),
                  ),
                ),
                background: const HomeTopViewWidget(),
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: true,
            child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('movies')
                  .orderBy('releaseDate', descending: false)
                  .get(),
              builder: buildMovieList,
            ),
          ),
        ],
      ),
    );
  }
}
