import 'dart:convert';

import 'package:flavor_ui/flavor_ui.dart';

import 'package:flutter/material.dart';

enum FlavorThemeMode { system, dark, light }

class FlavorThemeData {
  final FlavorColor? primaryColor;

  final FlavorColor? backgroundColor;

  final FlavorColor? textColor;
  final FlavorColor? diabledTextColor;

  final FlavorColor? cardColor;

  final FlavorColor? buttonColor;

  final FlavorThemeMode themeMode;
  final FlavorTextTheme? textTheme;

  final int duration;

  FlavorThemeData({
    this.diabledTextColor,
    this.primaryColor,
    this.backgroundColor,
    this.textColor,
    this.cardColor,
    this.buttonColor,
    this.themeMode = FlavorThemeMode.light,
    this.textTheme,
    this.duration = 300,
  });

  FlavorThemeData copyWith({
    FlavorColor? primaryColor,
    FlavorColor? backgroundColor,
    FlavorColor? textColor,
    FlavorColor? cardColor,
    FlavorColor? buttonColor,
    FlavorThemeMode? themeMode,
    FlavorTextTheme? textTheme,
    int? duration,
  }) {
    return FlavorThemeData(
      primaryColor: primaryColor ?? primaryColor,
      backgroundColor: backgroundColor ?? backgroundColor,
      textColor: textColor ?? textColor,
      cardColor: cardColor ?? cardColor,
      buttonColor: buttonColor ?? buttonColor,
      themeMode: themeMode ?? this.themeMode,
      textTheme: textTheme ?? this.textTheme,
      duration: duration ?? this.duration,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'primaryColor': primaryColor?.toString(),
      'backgroundColor': backgroundColor?.toString(),
      'textColor': textColor?.toString(),
      'cardColor': cardColor?.toString(),
      'buttonColor': buttonColor?.toString(),
      'themeMode': themeMode.toString(),
      'textTheme': textTheme?.toMap(),
      'duration': duration,
    };
  }

  factory FlavorThemeData.fromMap(Map<String, dynamic> map) {
    return FlavorThemeData(
      primaryColor: FlavorColor(colorValue: map['primaryColor']),
      backgroundColor: FlavorColor(colorValue: map['backgroundColor']),
      textColor: FlavorColor(colorValue: map['textColor']),
      cardColor: FlavorColor(colorValue: map['cardColor']),
      buttonColor: FlavorColor(colorValue: map['buttonColor']),
      themeMode: _processAppThemeMode(map['themeMode']),
      textTheme: FlavorTextTheme.fromMap(map['textTheme']),
      duration: map['duration'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FlavorThemeData.fromJson(String source) =>
      FlavorThemeData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FlavorThemeData(primaryColor: $primaryColor, backgroundColor: $backgroundColor, textColor: $textColor, cardColor: $cardColor, buttonColor: $buttonColor, themeMode: $themeMode, textTheme: $textTheme, duration: $duration)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FlavorThemeData &&
        other.primaryColor == primaryColor &&
        other.backgroundColor == backgroundColor &&
        other.textColor == textColor &&
        other.cardColor == cardColor &&
        other.buttonColor == buttonColor &&
        other.themeMode == themeMode &&
        other.textTheme == textTheme &&
        other.duration == duration;
  }

  @override
  int get hashCode {
    return primaryColor.hashCode ^
        backgroundColor.hashCode ^
        textColor.hashCode ^
        cardColor.hashCode ^
        buttonColor.hashCode ^
        themeMode.hashCode ^
        textTheme.hashCode ^
        duration.hashCode;
  }
}

_processAppThemeMode(String? setting) {
  if (setting == null) {
    return ThemeMode.system;
  }

  switch (setting) {
    case 'com.flavor.theme_mode.system':
      return ThemeMode.system;
    case 'com.flavor.theme_mode.dark':
      return ThemeMode.dark;
    case 'com.flavor.theme_mode.light':
      return ThemeMode.light;

    default:
      return ThemeMode.system;
  }
}
