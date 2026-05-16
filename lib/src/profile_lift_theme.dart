import 'package:flutter/material.dart';

class ProfileLiftTheme {
  final Color backgroundColor;
  final Color cardColor;
  final Color textColor;
  final Color subtitleColor;
  final Color primaryColor;
  final Color logoutColor;

  const ProfileLiftTheme({
    this.backgroundColor = const Color(0xff0f0f0f),
    this.cardColor = const Color(0xff1b1b1b),
    this.textColor = Colors.white,
    this.subtitleColor = Colors.grey,
    this.primaryColor = Colors.blue,
    this.logoutColor = Colors.redAccent,
  });
}