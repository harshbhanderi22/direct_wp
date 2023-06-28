import 'package:flutter/material.dart';

class CommonField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final TextInputType textInputType;
  const CommonField(
      {Key? key,
      required this.controller,
      required this.hint,
      required this.icon,
      this.textInputType = TextInputType.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black54, width: 1)),
      child: Center(
        child: TextFormField(
          keyboardType: textInputType,
          controller: controller,
          style: const TextStyle(fontSize: 20),
          decoration: InputDecoration(
              prefixIcon: Icon(
                icon,
                color: Colors.black54,
              ),
              hintText: hint,
              border: InputBorder.none),
        ),
      ),
    );
  }
}
