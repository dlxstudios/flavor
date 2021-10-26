import 'dart:convert';

import 'package:flavor_app/features/text/text_theme.dart';
import 'package:flavor_app/features/theme/theme_data.dart';
import 'package:flavor_app/features/colors/colors.dart';

class FlavorThemeModeValue {
  final String value;
  FlavorThemeModeValue({
    required this.value,
  });

  FlavorThemeModeValue copyWith({
    String? value,
  }) {
    return FlavorThemeModeValue(
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
    };
  }

  factory FlavorThemeModeValue.fromMap(Map<String, dynamic> map) {
    return FlavorThemeModeValue(
      value: map['value'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FlavorThemeModeValue.fromJson(String source) =>
      FlavorThemeModeValue.fromMap(json.decode(source));

  @override
  String toString() => 'FlavorThemeModeValue(value: $value)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FlavorThemeModeValue && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}

final defaultLightTheme = FlavorThemeData(
  primaryColor: FlavorColor(FlavorColors.gold),
  backgroundColor: FlavorColor(FlavorColors.ghostWhite.toString()),
  themeMode: FlavorThemeMode.light,
  buttonColor: FlavorColor(FlavorColors.lightGoldenRodYellow),
  cardColor: FlavorColor(FlavorColors.gold),
  textColor: FlavorColor(FlavorColors.darkSlateGray),
  textTheme: defualtTextThemeLight(),
  duration: 200,
);

final defaultDarkTheme = FlavorThemeData(
  primaryColor: FlavorColor(FlavorColors.darkViolet),
  backgroundColor: FlavorColor(FlavorColors.black),
  themeMode: FlavorThemeMode.dark,
  buttonColor: FlavorColor(FlavorColors.gold),
  cardColor: FlavorColor(FlavorColors.white)..value.withOpacity(.00),
  textColor: FlavorColor(FlavorColors.white)..value.withAlpha(100),
  textTheme: defualtTextThemeDark(),
  duration: 200,
);

FlavorTextTheme defualtTextThemeLight() => const FlavorTextTheme();

FlavorTextTheme defualtTextThemeDark() => const FlavorTextTheme();

Duration defaultThemeDuration = const Duration(milliseconds: 100);
