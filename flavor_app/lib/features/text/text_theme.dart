import 'dart:convert';

import 'package:flutter/foundation.dart';

class FlavorTextTheme with Diagnosticable {
  const FlavorTextTheme({
    this.headline1,
    this.headline2,
    this.headline3,
    this.headline4,
    this.headline5,
    this.headline6,
    this.subtitle1,
    this.subtitle2,
    this.bodyText1,
    this.bodyText2,
    this.caption,
    this.button,
    this.overline,
  });

  final FlavorTextStyle? headline1;
  final FlavorTextStyle? headline2;
  final FlavorTextStyle? headline3;
  final FlavorTextStyle? headline4;
  final FlavorTextStyle? headline5;
  final FlavorTextStyle? headline6;
  final FlavorTextStyle? subtitle1;
  final FlavorTextStyle? subtitle2;
  final FlavorTextStyle? bodyText1;
  final FlavorTextStyle? bodyText2;
  final FlavorTextStyle? caption;
  final FlavorTextStyle? button;
  final FlavorTextStyle? overline;

  fromGoogle(String name) {}

  FlavorTextTheme copyWith({
    FlavorTextStyle? headline1,
    FlavorTextStyle? headline2,
    FlavorTextStyle? headline3,
    FlavorTextStyle? headline4,
    FlavorTextStyle? headline5,
    FlavorTextStyle? headline6,
    FlavorTextStyle? subtitle1,
    FlavorTextStyle? subtitle2,
    FlavorTextStyle? bodyText1,
    FlavorTextStyle? bodyText2,
    FlavorTextStyle? caption,
    FlavorTextStyle? button,
    FlavorTextStyle? overline,
  }) {
    return FlavorTextTheme(
      headline1: headline1 ?? this.headline1,
      headline2: headline2 ?? this.headline2,
      headline3: headline3 ?? this.headline3,
      headline4: headline4 ?? this.headline4,
      headline5: headline5 ?? this.headline5,
      headline6: headline6 ?? this.headline6,
      subtitle1: subtitle1 ?? this.subtitle1,
      subtitle2: subtitle2 ?? this.subtitle2,
      bodyText1: bodyText1 ?? this.bodyText1,
      bodyText2: bodyText2 ?? this.bodyText2,
      caption: caption ?? this.caption,
      button: button ?? this.button,
      overline: overline ?? this.overline,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'headline1': headline1?.toMap(),
      'headline2': headline2?.toMap(),
      'headline3': headline3?.toMap(),
      'headline4': headline4?.toMap(),
      'headline5': headline5?.toMap(),
      'headline6': headline6?.toMap(),
      'subtitle1': subtitle1?.toMap(),
      'subtitle2': subtitle2?.toMap(),
      'bodyText1': bodyText1?.toMap(),
      'bodyText2': bodyText2?.toMap(),
      'caption': caption?.toMap(),
      'button': button?.toMap(),
      'overline': overline?.toMap(),
    };
  }

  factory FlavorTextTheme.fromMap(Map<String, dynamic> map) {
    return FlavorTextTheme(
      headline1: FlavorTextStyle.fromMap(map['headline1']),
      headline2: FlavorTextStyle.fromMap(map['headline2']),
      headline3: FlavorTextStyle.fromMap(map['headline3']),
      headline4: FlavorTextStyle.fromMap(map['headline4']),
      headline5: FlavorTextStyle.fromMap(map['headline5']),
      headline6: FlavorTextStyle.fromMap(map['headline6']),
      subtitle1: FlavorTextStyle.fromMap(map['subtitle1']),
      subtitle2: FlavorTextStyle.fromMap(map['subtitle2']),
      bodyText1: FlavorTextStyle.fromMap(map['bodyText1']),
      bodyText2: FlavorTextStyle.fromMap(map['bodyText2']),
      caption: FlavorTextStyle.fromMap(map['caption']),
      button: FlavorTextStyle.fromMap(map['button']),
      overline: FlavorTextStyle.fromMap(map['overline']),
    );
  }

  String toJson() => json.encode(toMap());

  factory FlavorTextTheme.fromJson(String source) =>
      FlavorTextTheme.fromMap(json.decode(source));

  // @override
  // String toString() {
  //   return 'FlavorTextTheme(headline1: $headline1, headline2: $headline2, headline3: $headline3, headline4: $headline4, headline5: $headline5, headline6: $headline6, subtitle1: $subtitle1, subtitle2: $subtitle2, bodyText1: $bodyText1, bodyText2: $bodyText2, caption: $caption, button: $button, overline: $overline)';
  // }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FlavorTextTheme &&
        other.headline1 == headline1 &&
        other.headline2 == headline2 &&
        other.headline3 == headline3 &&
        other.headline4 == headline4 &&
        other.headline5 == headline5 &&
        other.headline6 == headline6 &&
        other.subtitle1 == subtitle1 &&
        other.subtitle2 == subtitle2 &&
        other.bodyText1 == bodyText1 &&
        other.bodyText2 == bodyText2 &&
        other.caption == caption &&
        other.button == button &&
        other.overline == overline;
  }

  @override
  int get hashCode {
    return headline1.hashCode ^
        headline2.hashCode ^
        headline3.hashCode ^
        headline4.hashCode ^
        headline5.hashCode ^
        headline6.hashCode ^
        subtitle1.hashCode ^
        subtitle2.hashCode ^
        bodyText1.hashCode ^
        bodyText2.hashCode ^
        caption.hashCode ^
        button.hashCode ^
        overline.hashCode;
  }
}

class FlavorTextStyle {
  FlavorTextStyle({
    String? fontFamily,
    List<String>? fontFamilyFallback,
    String? package,
    this.color,
    this.backgroundColor,
    this.fontSize,
    this.fontWeight,
    this.fontStyle,
    this.letterSpacing,
    this.wordSpacing,
    this.overflow,
  }) : fontFamily =
            package == null ? fontFamily : 'packages/$package/$fontFamily';

  /// The color to use when painting the text.
  ///
  /// If [foreground] is specified, this value must be null. The [color] property
  /// is shorthand for `Paint()..color = color`.
  ///
  /// In [merge], [apply], and [lerp], conflicts between [color] and [foreground]
  /// specification are resolved in [foreground]'s favor - i.e. if [foreground] is
  /// specified in one place, it will dominate [color] in another.
  final String? color;

  /// The color to use as the background for the text.
  ///
  /// If [background] is specified, this value must be null. The
  /// [backgroundColor] property is shorthand for
  /// `background: Paint()..color = backgroundColor`.
  ///
  /// In [merge], [apply], and [lerp], conflicts between [backgroundColor] and [background]
  /// specification are resolved in [background]'s favor - i.e. if [background] is
  /// specified in one place, it will dominate [color] in another.
  final String? backgroundColor;

  /// The name of the font to use when painting the text (e.g., Roboto). If the
  /// font is defined in a package, this will be prefixed with
  /// 'packages/package_name/' (e.g. 'packages/cool_fonts/Roboto'). The
  /// prefixing is done by the constructor when the `package` argument is
  /// provided.
  ///
  /// The value provided in [fontFamily] will act as the preferred/first font
  /// family that glyphs are looked for in, followed in order by the font families
  /// in [fontFamilyFallback]. When [fontFamily] is null or not provided, the
  /// first value in [fontFamilyFallback] acts as the preferred/first font
  /// family. When neither is provided, then the default platform font will
  /// be used.
  final String? fontFamily;

  /// The size of glyphs (in logical pixels) to use when painting the text.
  ///
  /// During painting, the [fontSize] is multiplied by the current
  /// `textScaleFactor` to let users make it easier to read text by increasing
  /// its size.
  ///
  /// [getParagraphStyle] will default to 14 logical pixels if the font size
  /// isn't specified here.
  final double? fontSize;

  /// The typeface thickness to use when painting the text (e.g., bold).
  final String? fontWeight;

  /// The typeface variant to use when drawing the letters (e.g., italics).
  final String? fontStyle;

  /// The amount of space (in logical pixels) to add between each letter.
  /// A negative value can be used to bring the letters closer.
  final double? letterSpacing;

  /// The amount of space (in logical pixels) to add at each sequence of
  /// white-space (i.e. between each word). A negative value can be used to
  /// bring the words closer.
  final double? wordSpacing;

  /// The common baseline that should be aligned between this text span and its
  /// parent text span, or, for the root text spans, with the line box.
  // final TextBaseline? textBaseline;

  /// How visual text overflow should be handled.
  final String? overflow;

  FlavorTextStyle copyWith({
    String? color,
    String? backgroundColor,
    String? fontFamily,
    double? fontSize,
    String? fontWeight,
    String? fontStyle,
    double? letterSpacing,
    double? wordSpacing,
    String? overflow,
  }) {
    return FlavorTextStyle(
      color: color ?? this.color,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      fontFamily: fontFamily ?? this.fontFamily,
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      fontStyle: fontStyle ?? this.fontStyle,
      letterSpacing: letterSpacing ?? this.letterSpacing,
      wordSpacing: wordSpacing ?? this.wordSpacing,
      overflow: overflow ?? this.overflow,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'color': color,
      'backgroundColor': backgroundColor,
      'fontFamily': fontFamily,
      'fontSize': fontSize,
      'fontWeight': fontWeight,
      'fontStyle': fontStyle,
      'letterSpacing': letterSpacing,
      'wordSpacing': wordSpacing,
      'overflow': overflow,
    };
  }

  factory FlavorTextStyle.fromMap(Map<String, dynamic> map) {
    return FlavorTextStyle(
      color: map['color'],
      backgroundColor: map['backgroundColor'],
      fontFamily: map['fontFamily'],
      fontSize: map['fontSize'],
      fontWeight: map['fontWeight'],
      fontStyle: map['fontStyle'],
      letterSpacing: map['letterSpacing'],
      wordSpacing: map['wordSpacing'],
      overflow: map['overflow'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FlavorTextStyle.fromJson(String source) =>
      FlavorTextStyle.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FlavorTextStyle(color: $color, backgroundColor: $backgroundColor, fontFamily: $fontFamily, fontSize: $fontSize, fontWeight: $fontWeight, fontStyle: $fontStyle, letterSpacing: $letterSpacing, wordSpacing: $wordSpacing, overflow: $overflow)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FlavorTextStyle &&
        other.color == color &&
        other.backgroundColor == backgroundColor &&
        other.fontFamily == fontFamily &&
        other.fontSize == fontSize &&
        other.fontWeight == fontWeight &&
        other.fontStyle == fontStyle &&
        other.letterSpacing == letterSpacing &&
        other.wordSpacing == wordSpacing &&
        other.overflow == overflow;
  }

  @override
  int get hashCode {
    return color.hashCode ^
        backgroundColor.hashCode ^
        fontFamily.hashCode ^
        fontSize.hashCode ^
        fontWeight.hashCode ^
        fontStyle.hashCode ^
        letterSpacing.hashCode ^
        wordSpacing.hashCode ^
        overflow.hashCode;
  }
}
