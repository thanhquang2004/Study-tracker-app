import 'package:flutter/material.dart';

class SettingModel {
  final String title;
  final IconData? icon;
  final Color? colorIcon;
  final Function()? onTap;

  SettingModel({
    required this.title,
    this.icon,
    this.colorIcon,
    required this.onTap,
  });
}
