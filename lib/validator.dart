import 'dart:async';

mixin Validators {
  var emailValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (String email, EventSink<String> sink) {
    if (email.contains("@") && email.contains(".") && email.length > 6) {
      sink.add(email);
    } else {
      sink.addError("Please enter a  valid email address.");
    }
  });

  var nameValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (String name, EventSink<String> sink) {
    if (name.length > 2) {
      sink.add(name);
    } else {
      sink.addError("Please enter your full name.");
    }
  });

  var descriptionValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (String description, EventSink<String> sink) {
    if (description.length > 4) {
      sink.add(description);
    } else {
      sink.addError("Feedback length should be greater than 4 letters.");
    }
  });
}
