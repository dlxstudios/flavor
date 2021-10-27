import 'dart:convert';

import 'package:flavor_ui/flavor_ui.dart';

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

FlavorThemeData get defaultLightTheme => FlavorThemeData(
      primaryColor: FlavorColor(color: Purp.purp.shade900),
      backgroundColor:
          FlavorColor(colorValue: FlavorColors.ghostWhite.toString()),
      themeMode: FlavorThemeMode.light,
      buttonColor: FlavorColor(colorValue: FlavorColors.lightGoldenRodYellow),
      cardColor: FlavorColor(color: Purp.purp.shade900),
      textColor: FlavorColor(colorValue: FlavorColors.darkSlateGray),
      textTheme: defualtTextThemeLight(),
      duration: 200,
    );

FlavorThemeData get defaultDarkTheme => FlavorThemeData(
      primaryColor: FlavorColor(color: Purp.purp),
      backgroundColor: FlavorColor(color: Purp.purp.shade900),
      themeMode: FlavorThemeMode.dark,
      buttonColor: FlavorColor(colorValue: FlavorColors.gold),
      cardColor: FlavorColor(color: Purp.purp.shade500)..value.withOpacity(.00),
      textColor: FlavorColor(colorValue: FlavorColors.white)
        ..value.withAlpha(100),
      diabledTextColor: FlavorColor(colorValue: FlavorColors.white)
        ..value.withAlpha(45),
      textTheme: defualtTextThemeDark(),
      duration: 400,
    );

FlavorTextTheme defualtTextThemeLight() => FlavorTextTheme(
      bodyText1: FlavorTextStyle(
        color: FlavorColors.black,
      ),
      bodyText2: FlavorTextStyle(
        color: FlavorColors.black,
      ),
      button: FlavorTextStyle(
        color: FlavorColors.black,
      ),
      caption: FlavorTextStyle(
        color: FlavorColors.black,
      ),
      headline1: FlavorTextStyle(
        color: FlavorColors.black,
      ),
      headline2: FlavorTextStyle(
        color: FlavorColors.black,
      ),
      headline3: FlavorTextStyle(
        color: FlavorColors.black,
      ),
      headline4: FlavorTextStyle(
        color: FlavorColors.black,
      ),
      headline5: FlavorTextStyle(
        color: FlavorColors.black,
      ),
      headline6: FlavorTextStyle(
        color: FlavorColors.black,
      ),
      overline: FlavorTextStyle(
        color: FlavorColors.black,
      ),
      subtitle1: FlavorTextStyle(
        color: FlavorColors.black,
      ),
      subtitle2: FlavorTextStyle(
        color: FlavorColors.black,
      ),
    );

FlavorTextTheme defualtTextThemeDark() => FlavorTextTheme(
      bodyText1: FlavorTextStyle(
        color: FlavorColors.white,
      ),
      bodyText2: FlavorTextStyle(
        color: FlavorColors.white,
      ),
      button: FlavorTextStyle(
        color: FlavorColors.white,
      ),
      caption: FlavorTextStyle(
        color: FlavorColors.white,
      ),
      headline1: FlavorTextStyle(
        color: FlavorColors.white,
      ),
      headline2: FlavorTextStyle(
        color: FlavorColors.white,
      ),
      headline3: FlavorTextStyle(
        color: FlavorColors.white,
      ),
      headline4: FlavorTextStyle(
        color: FlavorColors.white,
      ),
      headline5: FlavorTextStyle(
        color: FlavorColors.white,
      ),
      headline6: FlavorTextStyle(
        color: FlavorColors.white,
      ),
      overline: FlavorTextStyle(
        color: FlavorColors.white,
      ),
      subtitle1: FlavorTextStyle(
        color: FlavorColors.white,
      ),
      subtitle2: FlavorTextStyle(
        color: FlavorColors.white,
      ),
    );

Duration defaultThemeDuration = const Duration(milliseconds: 100);
