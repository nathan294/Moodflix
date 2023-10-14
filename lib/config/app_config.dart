import 'package:flutter/material.dart';

class AppConfig extends InheritedWidget {
  // ignore: prefer_const_constructors_in_immutables
  AppConfig({
    super.key,
    required this.appName,
    required this.flavorName,
    required this.apiBaseUrl,
    required this.apiAnonKey,
    required Widget child,
  }) : super(child: child);

  final String appName;
  final String flavorName;
  final String apiBaseUrl;
  final String apiAnonKey;

  static AppConfig? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppConfig>();
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
