import 'package:flutter/material.dart';
import 'utils/db.dart';
import 'widgets/adminDrawer.dart';

class FeedbackPage extends StatefulWidget {
  FeedbackPage();
  _FeedbackPage createState() => new _FeedbackPage();
}

class _FeedbackPage extends State<FeedbackPage> {
  List<Map> fb;

  void fetchFB() async {
    List futurelist = await DbHelper().fetchAllFeedbacks();

    setState(() {
      fb = futurelist;
    });
  }

  void reviewFB(int id) async {
    await DbHelper().reviewFeedbacks(id);
  }

  initState() {
    super.initState();
    fetchFB();
  }

  _deleteOnpressed(int index) {
    reviewFB(index);
    fetchFB();
  }

  @override
  Widget build(BuildContext context) {
    if (fb != null && fb.length > 0) {
      return new WillPopScope(
        onWillPop: () async => false,
        child: new Scaffold(
            endDrawer: AdminDrawer(),
            appBar: new AppBar(
              title: new Text("Feedbacks"),
              automaticallyImplyLeading: false,
              centerTitle: true,
              backgroundColor: Colors.blueAccent,
            ),
            body: new Padding(
                padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                child: getHomePageBody(context))),
      );
    } else {
      return new WillPopScope(
        onWillPop: () async => false,
        child: new Scaffold(
          endDrawer: AdminDrawer(),
          appBar: new AppBar(
            title: new Text("Feedbacks"),
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
                  new Padding(padding: new EdgeInsets.all(45.0)),
                  Container(
                      height: 60.0,
                      padding: EdgeInsets.all(0.0),
                      child: Text(
                        'No new feedbacks',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                        ),
                      )),
                  Divider(
                    height: 90.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  getHomePageBody(BuildContext context) {
    return ListView.builder(
      itemCount: fb.length,
      itemBuilder: _myLayoutWidget,
      padding: EdgeInsets.all(0.0),
    );
  }

  Widget _myLayoutWidget(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.all(16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(),
        borderRadius: BorderRadius.all(Radius.circular(3.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.chat,
                  color: Colors.green,
                ),
              ),
              Text(
                fb[index]['feedbackN'],
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 0,
            ),
            child: Text(
              fb[index]['feedbackD'],
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              RaisedButton(
                child: Text('Done'),
                onPressed: () {
                  _deleteOnpressed(fb[index]['feedbackID']);
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
