import 'package:flutter/widgets.dart';

class Section {
  final String? title;
  final List<SectionItem>? items;
  Section({this.title, this.items});
}

class SectionItem {
  final String? cover;
  final String? title;
  final String? subtitle;
  final GestureTapCallback? onTap;

  final String? headerTitleText;

  final String? headerSubtitleText;

  final double? cardAspectRatio;

  final double? itemAspectRatio;

  final GlobalKey? key;

  final EdgeInsets? padding;

  final bool? showCover;

  final bool? showFooter;

  final bool? showHeader;

  SectionItem({
    this.cardAspectRatio,
    this.itemAspectRatio,
    this.key,
    this.padding,
    this.showCover,
    this.showFooter,
    this.showHeader,
    this.headerTitleText,
    this.headerSubtitleText,
    this.cover,
    this.title,
    this.subtitle,
    this.onTap,
  });
}
