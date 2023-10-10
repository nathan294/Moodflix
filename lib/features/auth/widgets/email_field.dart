import 'package:flutter/material.dart';
import 'package:moodflix/features/auth/validators/validators.dart';

typedef ValidatorFunc = String? Function(String? value);
typedef OnSavedFunc = void Function(String? value);

class MyEmailFormField extends StatelessWidget {
  final String label;
  final ValidatorFunc validator;
  final OnSavedFunc onSaved;

  const MyEmailFormField({
    Key? key,
    required this.label,
    this.validator = validateEmail,
    required this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
      ),
      validator: validator,
      onSaved: onSaved,
    );
  }
}
