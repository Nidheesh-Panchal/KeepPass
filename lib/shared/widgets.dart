import 'package:flutter/material.dart';

Widget sizedBoxHeight() => const SizedBox(
      height: 20,
    );

Widget sizedBoxWidth() => const SizedBox(
      width: 10,
    );

Widget largeText(String text) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
