import 'package:flutter/material.dart';

class AppSearchBar extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;

  const AppSearchBar({
    super.key,
    required this.hint,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(26),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(
          fontFamily: 'Georgia',
          fontSize: 16,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          prefixIcon: const Icon(
            Icons.search,
            size: 20,
            color: Colors.black54,
          ),
          hintText: hint,
          hintStyle: const TextStyle(
            fontFamily: 'Georgia',
            color: Colors.black54,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
          filled: true,
          fillColor: Colors.transparent,
        ),
      ),
    );
  }
}