import 'package:flutter/material.dart';
import 'utils/db.dart';
import 'models/feedback.dart' as F;
import 'bloc.dart';
import 'package:flutter/services.dart';
import 'home.dart';
import 'utils/data.dart';
import 'widgets/NavSideDrawer.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUs createState() => new _ContactUs();
}

class _ContactUs extends State<ContactUs> {
  final Bloc bloc = Bloc();

  final TextEditingController name = new TextEditingController();
  final TextEditingController email = new TextEditingController();
  final TextEditingController description = new TextEditingController();

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  void goTraveler() {
    Navigator.push<bool>(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                Home(Data.userLang.toLowerCase())));
  }

  void _handleSubmitted(String name, String email, String msg) async {
    DbHelper reg = DbHelper();
    F.FeedbackModel feedback = F.FeedbackModel(name, email, msg);
    await reg.addFeedback(feedback);
  }

  void feedbackSent() {
    _handleSubmitted(name.text, email.text, description.text);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Feedback Sent'),
          content: const Text('Thanks for sharing your feedback with us!'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                goTraveler();
              },
            ),
          ],
        );
      },
    );
    name.text = '';
    email.text = '';
    description.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        endDrawer: NavSideDrawer(),
        appBar: AppBar(
          title: Text("Contact us"),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        body: new SingleChildScrollView(
          child: new Form(
            key: _formKey,
            autovalidate: true,
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(30.0),
                    child: Center(
                      child: Icon(
                        Icons.chat,
                        color: Colors.teal,
                        size: 45.0,
                      ),
                    ),
                  ),
                  StreamBuilder<String>(
                    stream: bloc.email,
                    builder: (context, snapshot) => TextField(
                      onChanged: bloc.emailChanged,
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Enter email",
                          labelText: "Email",
                          errorText: snapshot.error),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  StreamBuilder<String>(
                    stream: bloc.name,
                    builder: (context, snapshot) => TextField(
                      onChanged: bloc.nameChanged,
                      controller: name,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Enter name",
                          labelText: "Name",
                          errorText: snapshot.error),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  StreamBuilder<String>(
                    stream: bloc.description,
                    builder: (context, snapshot) => TextField(
                      onChanged: bloc.descriptionChanged,
                      controller: description,
                      maxLines: 3,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Enter feedback",
                          labelText: "Feedback",
                          errorText: snapshot.error),
                    ),
                  ),
                  SizedBox(
                    height: 120.0,
                  ),
                  StreamBuilder<bool>(
                    stream: bloc.submitValid,
                    builder: (context, snapshot) => RaisedButton(
                        color: Colors.redAccent,
                        onPressed: (!snapshot.hasData) ? null : feedbackSent,
                        child: Text(
                          "Send feedback",
                          style: new TextStyle(color: Colors.white),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
