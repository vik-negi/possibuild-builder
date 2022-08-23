import 'package:flutter/material.dart';
import 'package:possibuild/utils/validator.dart';

class TextffWidget extends StatelessWidget {
  const TextffWidget({
    Key? key,
    required this.controller,
    required this.focus,
    required this.hintText,
    required this.labelText,
    required this.icon,
    required this.isPassword,
    required this.isUsername,
  }) : super(key: key);

  final TextEditingController controller;
  final FocusNode focus;
  final String hintText;
  final String labelText;
  final IconData icon;
  final bool isPassword;
  final bool isUsername;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focus,
      style: const TextStyle(
        color: Colors.white,
      ),
      validator: (value) => isPassword
          ? Validator.validatePassword(
              password: value!,
            )
          : (isUsername
              ? Validator.validateName(name: value)
              : Validator.validateEmail(email: value!)),
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
        errorBorder: const UnderlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(35)),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        prefixIcon: Icon(
          icon,
          color: Colors.white,
        ),
        labelText: labelText,
        labelStyle: const TextStyle(
          color: Colors.white,
        ),
        filled: true,
        fillColor: const Color.fromARGB(255, 43, 47, 51),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(35)),
            borderSide: BorderSide.none),
      ),
    );
  }
}
