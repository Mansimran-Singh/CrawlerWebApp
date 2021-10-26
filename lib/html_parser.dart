import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'fake_ui.dart' if (dart.library.html) 'real_ui.dart' as ui;
import 'package:flutter/widgets.dart';
import 'model/movie_model.dart';

class HelpScreen extends StatefulWidget {
  final Movie? movie;

  HelpScreen(this.movie,{Key? key}) : super(key: key) {
    ui.platformViewRegistry.registerViewFactory(
         movie!.title,
        (int viewId) => IFrameElement()
          ..id = movie!.title
          ..width = '100%'
          ..height = '100%'
          ..style.width = '100%'
          ..style.height = '100%'
          ..srcdoc = movie!.htmlPage
          ..style.border = 'none');          
    // print("Registered Movie:[${movie.title}]");
  }

  @override
  HelpScreenState createState() {
    return HelpScreenState();
  }
}

class HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    print("Load Registered Movie:[${widget.movie!.title}]");
    return Scaffold(
      appBar: CupertinoNavigationBar(
          automaticallyImplyLeading: true,
          middle: Text(widget.movie!.title)),
      body: HtmlElementView(
        viewType: widget.movie!.title,
      ),
    );
  }
}
