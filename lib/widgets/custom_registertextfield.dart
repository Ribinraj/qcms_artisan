import 'package:flutter/material.dart';
import 'package:qcms_artisan/core/colors.dart';


class CustomRegisterTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String hintText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const CustomRegisterTextField({
    super.key,
    required this.controller,
    this.focusNode,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE8E4F3),
        border: Border(
          bottom: BorderSide(color: Appcolors.ksecondaryColor, width: 1.5),
        ),
      ),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: keyboardType,
        validator: validator,
        onChanged: onChanged,
        style: const TextStyle(fontSize: 16, color: Colors.black87),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Color.fromARGB(255, 108, 106, 106),
            fontSize: 15,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
        ),
      ),
    );
  }
}
