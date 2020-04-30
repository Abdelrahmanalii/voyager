import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'widgets/tts.dart';
import 'widgets/CircularIndicator.dart';
import 'widgets/NavSideDrawer.dart';

class Description extends StatefulWidget {
  final String landmark;
  final File img;
  final String lang;
  Description(this.landmark, this.img, this.lang);
  @override
  State<StatefulWidget> createState() {
    return new DescriptionState(this.landmark, this.img, this.lang);
  }
}

class DescriptionState extends State<Description> {
  final String landmark;
  final File img;
  final String lang;
  DescriptionState(this.landmark, this.img, this.lang);
  @override
  void initState() {
    super.initState();
    _fetchAndTranslate(this.landmark, this.lang);
  }

  String translated;
  bool loading = true;

  _fetchAndTranslate(String landmark, String language) async {
    String url = 'http://18.213.123.42/Voyager/WIKIAPI.php';
    http.Response response = await http
        .post(url, body: {"wiwkilandmarkx": landmark, "langx": language});
    translated = response.body;
    setState(() {
      loading = false;
    });
  }

  Widget control() {
    if (loading == true) {
      return CircularIndicator();
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            (Image.file(img)),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                border: Border.all(),
                borderRadius: BorderRadius.all(Radius.circular(3.0)),
              ),
              padding: EdgeInsets.all(24.0),
              margin: EdgeInsets.fromLTRB(24.0, 0, 24.0, 0),
              child: Text(
                translated,
                style: TextStyle(
                    fontSize: 17.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            TextToSpeech(translated, this.lang)
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text('$landmark Description'),
            centerTitle: true,
          ),
          body: control(),
          endDrawer: NavSideDrawer()),
      debugShowCheckedModeBanner: false,
    );
  }
}
