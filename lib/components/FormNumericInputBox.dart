// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormNumericInputBox extends StatelessWidget {
  const FormNumericInputBox(
      {Key? key,
      required this.size,
      required this.hinttext,
      required this.controller})
      : super(key: key);

  final Size size;
  final String hinttext;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: TextFormField(
            autofocus: true,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            controller: controller,
            decoration: InputDecoration(
              hintText: hinttext,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field can not be empty.';
              }
              return null;
            },
          ),
        ));
  }
}
