import 'package:flutter/material.dart';
import 'utils/data.dart';
import 'widgets/NavSideDrawer.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'widgets/CircularIndicator.dart';
import 'description.dart';

class Home extends StatefulWidget {
  final String lang;
  Home(this.lang);
  @override
  State<StatefulWidget> createState() {
    return _HomeInstance(this.lang);
  }
}

class _HomeInstance extends State<Home> {
  bool loading = false;
  var img;
  String lang;
  _HomeInstance(this.lang);

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: loading ? loadingIndicator() : icons(),
        ),
        endDrawer: NavSideDrawer(),
      ),
    );
  }

  Widget loadingIndicator() {
    return CircularIndicator();
  }

  _getImage(ImageSource src) async {
    img = await ImagePicker.pickImage(
        source: src, maxHeight: 300.0, maxWidth: 300.0);
    if (img != null) {
      setState(() {
        loading = true;
      });
      _imgToApi(img);
    }
  }

  void _imgToApi(File img) async {
    List<int> imageBytes = img.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    String url = 'http://18.213.123.42/Voyager/GCVAPI.php';
    http.Response response = await http.post(url, body: {
      "imagexcoded": base64Image,
    });
    String landmark = response.body;
    setState(() {
      loading = false;
    });
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Description(landmark, img, lang)),
    );
  }

  Widget drawerSetStatic() {
    NavSideDrawer.username = Data.userName;
    return NavSideDrawer();
  }

  Widget icons() {
    return new WillPopScope(
        onWillPop: () async => false,
        child: new Scaffold(
          endDrawer: drawerSetStatic(),
          appBar: new AppBar(
            title: new Text("Home"),
            automaticallyImplyLeading: false,
            centerTitle: true,
            backgroundColor: Colors.blueAccent,
          ),
          body: new Container(
            child: new Center(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Padding(padding: new EdgeInsets.all(35.0)),
                  SizedBox(height: 120),
                  GestureDetector(
                      child: Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            image: DecorationImage(
                                image: AssetImage("assets/images/aperture.png"),
                                fit: BoxFit.fill),
                          )),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return SimpleDialog(
                                  title: Text("Camera/Gallery"),
                                  children: <Widget>[
                                    SimpleDialogOption(
                                      onPressed: () async {
                                        Navigator.pop(context);
                                        _getImage(ImageSource.gallery);
                                      },
                                      child: const Text('Pick From Gallery'),
                                    ),
                                    SimpleDialogOption(
                                      onPressed: () async {
                                        Navigator.pop(context);
                                        _getImage(ImageSource.camera);
                                      },
                                      child: const Text('Take A New Picture'),
                                    ),
                                  ]);
                            });
                      }),
                  SizedBox(height: 200),
                ],
              ),
            ),
          ),
        ));
  }
}
