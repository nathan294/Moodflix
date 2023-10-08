import 'package:flutter/material.dart';
import 'package:moodflix/features/auth/validators/validators.dart';

typedef ValidatorFunc = String? Function(String? value);
typedef OnSavedFunc = void Function(String? value);

class MyPasswordFormField extends StatefulWidget {
  final String label;
  final ValidatorFunc validator;
  final OnSavedFunc onSaved;

  const MyPasswordFormField({
    Key? key,
    required this.label,
    this.validator = validatePassword,
    required this.onSaved,
  }) : super(key: key);

  @override
  MyPasswordFormFieldState createState() => MyPasswordFormFieldState();
}

class MyPasswordFormFieldState extends State<MyPasswordFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: widget.label,
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
      obscureText: _obscureText,
      validator: widget.validator,
      onSaved: widget.onSaved,
    );
  }
}
