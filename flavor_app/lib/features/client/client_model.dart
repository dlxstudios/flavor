import 'dart:convert';

import 'package:flavor_ui/flavor_ui.dart';
import 'package:flutter/foundation.dart';

import 'package:flavor_app/features/page/page.dart';

class FlavorAppClientModel {
  FlavorAppClientModel({
    this.id,
    this.image,
    this.title,
    this.author,
    this.website,
    this.requireLogin,
    this.breakpoints,
    this.theme,
    this.splash,
    this.pages,
    this.plugins,
    this.vars,
  });

  final String? id;

  final String? image;

  final String? title;
  final String? author;
  final String? website;

  final bool? requireLogin;

  final Map? breakpoints;

  final FlavorThemeData? theme;

  final Map? splash;

  final List<FlavorPageModel>? pages;

  final Map<String, dynamic>? plugins;
  final Map<String, dynamic>? vars;

  FlavorAppClientModel copyWith({
    String? id,
    String? image,
    String? title,
    String? author,
    String? website,
    bool? requireLogin,
    Map? breakpoints,
    FlavorThemeData? theme,
    Map? splash,
    List<FlavorPageModel>? pages,
    Map<String, dynamic>? plugins,
    Map<String, dynamic>? vars,
  }) {
    return FlavorAppClientModel(
      id: id ?? this.id,
      image: image ?? this.image,
      title: title ?? this.title,
      author: author ?? this.author,
      website: website ?? this.website,
      requireLogin: requireLogin ?? this.requireLogin,
      breakpoints: breakpoints ?? this.breakpoints,
      theme: theme ?? this.theme,
      splash: splash ?? this.splash,
      pages: pages ?? this.pages,
      plugins: plugins ?? this.plugins,
      vars: vars ?? this.vars,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'title': title,
      'author': author,
      'website': website,
      'requireLogin': requireLogin,
      'breakpoints': breakpoints,
      'theme': theme?.toString(),
      'splash': splash?.toString(),
      'pages': pages,
      'plugins': plugins,
      'vars': vars,
    };
  }

  factory FlavorAppClientModel.fromMap(Map<String, dynamic> map) {
    return FlavorAppClientModel(
      id: map['id'],
      image: map['image'],
      title: map['title'],
      author: map['author'],
      website: map['website'],
      requireLogin: map['requireLogin'],
      breakpoints: map['breakpoints'],
      theme: map.containsKey('theme')
          ? FlavorThemeData.fromMap(map['theme'])
          : null,
      splash: map['splash'],
      pages: processPages(map['pages'] as List),
      // plugins: Map<String, dynamic>.from(map['plugins']),
      // vars: Map<String, dynamic>.from(map['vars']),
    );
  }

  String toJson() => json.encode(toMap());

  factory FlavorAppClientModel.fromJson(String source) =>
      FlavorAppClientModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FlavorAppClientModel(id: $id, image: $image, title: $title, author: $author, website: $website, requireLogin: $requireLogin, breakpoints: $breakpoints, theme: $theme, splash: $splash, pages: $pages, plugins: $plugins, vars: $vars)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FlavorAppClientModel &&
        other.id == id &&
        other.image == image &&
        other.title == title &&
        other.author == author &&
        other.website == website &&
        other.requireLogin == requireLogin &&
        other.breakpoints == breakpoints &&
        other.theme == theme &&
        other.splash == splash &&
        listEquals(other.pages, pages) &&
        mapEquals(other.plugins, plugins) &&
        mapEquals(other.vars, vars);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        image.hashCode ^
        title.hashCode ^
        author.hashCode ^
        website.hashCode ^
        requireLogin.hashCode ^
        breakpoints.hashCode ^
        theme.hashCode ^
        splash.hashCode ^
        pages.hashCode ^
        plugins.hashCode ^
        vars.hashCode;
  }
}

List<FlavorPageModel> processPages(List pagesJsonList) {
  // ignore: avoid_print
  print(pagesJsonList);

  List<FlavorPageModel> pages = pagesJsonList.map((element) {
    var _pageJson = element as Map<String, dynamic>;

    // print('_pageJson::$_pageJson');

    return FlavorPageModel.fromMap(_pageJson);
  }).toList();
  return pages;
}
