import 'package:flutter/material.dart';

Widget buildRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(value),
      ],
    ),
  );
}
