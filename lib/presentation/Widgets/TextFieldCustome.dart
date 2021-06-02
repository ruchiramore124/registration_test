import 'package:flutter/material.dart';

class TextFieldCustome extends StatelessWidget {
  final TextEditingController controller;
  final bool readOnly;
  final String hintText;
  final TextInputType keyboardType;
  final String Function(String) validator;
  final FocusNode focusNode;
  final void Function() onTap;
  final Widget suffixIcon;

  const TextFieldCustome(
      {Key key,
      this.controller,
      this.readOnly,
      this.hintText,
      this.keyboardType,
      this.validator,
      this.focusNode,
      this.onTap,
      this.suffixIcon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: TextFormField(
        decoration: InputDecoration(
            suffixIcon: suffixIcon,
            hintText: hintText,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blueAccent))),
        controller: controller,
        readOnly: readOnly ?? false,
        keyboardType: keyboardType,
        validator: validator,
        focusNode: focusNode,
        onTap: onTap,
      ),
    ));
  }
}
