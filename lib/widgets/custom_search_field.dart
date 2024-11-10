import 'package:flutter/material.dart';

class CustomSearchField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String>? onChanged;

  const CustomSearchField({
    super.key,
    required this.controller,
    this.hintText = 'Search...',
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon:
            const Icon(Icons.search), // Ikon kaca pembesar di dalam bidang teks
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[200], // Warna latar belakang bidang teks
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      ),
      style: const TextStyle(fontSize: 16.0),
    );
  }
}
