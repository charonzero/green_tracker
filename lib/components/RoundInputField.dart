// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:greentracker/components/TextContainer.dart';
import 'package:greentracker/constants.dart';
import 'package:flutter/services.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final ValueChanged<String> onChanged;
  final String validatorText;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;

  const RoundedInputField(
      {Key? key,
      required this.hintText,
      this.icon = Icons.person,
      required this.onChanged,
      this.obscureText = false,
      this.validatorText = 'Please enter some text',
      this.keyboardType = TextInputType.name,
      this.inputFormatters = const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextContainer(
      child: TextFormField(
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        obscureText: obscureText,
        onChanged: onChanged,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validatorText;
          }
          return null;
        },
        decoration: InputDecoration(
          errorStyle: const TextStyle(
            fontSize: 11.0,
            height: .1,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Icon(
              icon,
              color: kPrimaryColor,
            ),
          ),
          hintText: hintText,
          fillColor: kBackgroundColor,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black45, width: 1),
              borderRadius: BorderRadius.circular(10.0)),
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }
}
