import 'package:flavor_ui/flavor_ui.dart';
import 'package:flutter/material.dart';

class FlavorTextModel {
  // Easy ones first!
  final String? text;
  final int? maxLines;
  final bool? softWrap;
  final Map<String, dynamic>? data;

  FlavorTextModel({this.data, this.text, this.maxLines, this.softWrap});
  //

  factory FlavorTextModel.fromMap(Map<String, dynamic> map) {
    return FlavorTextModel(
      text: map['text'],
      maxLines: map['maxLines'],
      softWrap: map['softWrap'],
      data: map,
      // Widget.fromMap(map['widget']),
    );
  }
}

class TextOneLine extends StatelessWidget {
  final TextStyle? style;
  const TextOneLine(
    this.string, {
    Key? key,
    this.style,
  }) : super(key: key);

  final String string;

  @override
  Widget build(BuildContext context) {
    return Text(
      string,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      softWrap: false,
      style: style,
    );
  }
}

class FlavorText extends StatelessWidget {
  factory FlavorText.fromMap(Map<String, dynamic> map) {
    return FlavorText(
      map['text'],
      maxLines: map['maxLines'],
      softWrap: map['softWrap'],
      // Widget.fromMap(map['widget']),
    );
  }

  final String? text;

  final TextStyle? style;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;
  final Locale? locale;

  @override
  Widget build(BuildContext context) => Text(
        '$text',
        maxLines: maxLines,
        overflow: overflow,
        softWrap: softWrap,
        locale: locale,
        style: style,
      );

  const FlavorText(
    this.text, {
    Key? key,
    this.style,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.locale,
  }) : super(key: key);
}
