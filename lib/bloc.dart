import 'dart:async';
import 'validator.dart';
import 'package:rxdart/rxdart.dart';

class Bloc with Validators {
  final BehaviorSubject _emailController = BehaviorSubject<String>();
  final BehaviorSubject _nameController = BehaviorSubject<String>();
  final BehaviorSubject _descriptionController = BehaviorSubject<String>();

  Function(String) get emailChanged => _emailController.sink.add;
  Function(String) get nameChanged => _nameController.sink.add;
  Function(String) get descriptionChanged => _descriptionController.sink.add;

  Stream<String> get email => _emailController.stream.transform(emailValidator);
  Stream<String> get name => _nameController.stream.transform(nameValidator);
  Stream<String> get description =>
      _descriptionController.stream.transform(descriptionValidator);
  Stream<bool> get submitValid => Observable.combineLatest3(
      email, name, description, (email, name, description) => true);

  submit() {
    final validEmail = _emailController.value;
    final validName = _nameController.value;
    final validFescription = _descriptionController.value;
  }

  void dispose() {
    _emailController.close();
    _nameController.close();
    _descriptionController.close();
  }
}
