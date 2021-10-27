import 'dart:convert';

import 'package:flavor_ui/flavor_ui.dart' show FlavorScaffold;
import 'package:flutter/material.dart'
    show
        AnnotatedRegion,
        BuildContext,
        Color,
        CustomScrollView,
        Key,
        SafeArea,
        ScrollController,
        SliverChildListDelegate,
        SliverList,
        StatelessWidget,
        Widget;
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'package:flutter/widgets.dart'
    show
        AnnotatedRegion,
        BuildContext,
        Color,
        CustomScrollView,
        Key,
        SafeArea,
        ScrollController,
        SliverChildListDelegate,
        SliverList,
        StatelessWidget,
        Widget;

import 'package:flavor_app/features/component/component.dart';
import 'package:flavor_app/features/page/page_error.dart';

enum FlavorPageType { listView, singlePageScrollView }

class PageShell extends StatelessWidget {
  final Widget child;
  final bool? safeArea;
  final Color? statusbarColor;

  PageShell({
    required this.child,
    this.safeArea = false,
    this.statusbarColor,
  });

  @override
  Widget build(BuildContext context) {
    Widget _finalComponent = SafeArea(
      top: safeArea!,
      maintainBottomViewPadding: true,
      child: child,
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: statusbarColor,
      ),
      child: safeArea == true ? _finalComponent : child,
    );
  }
}

final ScrollController _scrollController = ScrollController();

class FlavorPage extends StatelessWidget {
  final FlavorPageModel model;

  const FlavorPage(
    this.model, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (model.components == null) {
      return FlavorPageError(
        code: 508.toString(),
        message: 'No content to display at this time.',
        // title: 'Error : {components} missing',
        // type: 'bad',
      );
    }

    // print('_scrollController::$_scrollController');

    return _buildBody();
  }

  _buildBody() {
    return FlavorScaffold(
      // color: Colors.amber,
      child: CustomScrollView(
        cacheExtent: 100,
        controller: _scrollController,
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              model.components!
                  .map(
                    (e) => FlavorComponentView(
                      model: e,
                    ),
                    // controller: _scrollController,
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}

class FlavorPageModel {
  final String? id;
  final String? name;
  final String? path;

  final List<FlavorComponentModel>? components;
  // List get components => [];

  final String? title;
  final String? color;
  final bool? dialog;
  final bool? safeArea;
  final String? statusbarColor;

  // Map<String, List>? viewStates;

  FlavorPageModel({
    this.components,
    this.id,
    this.name,
    this.path,
    this.title,
    this.color,
    this.dialog,
    this.safeArea,
    this.statusbarColor,
  });

  FlavorPageModel copyWith({
    String? id,
    String? name,
    String? path,
    String? title,
    String? color,
    bool? dialog,
    bool? safeArea,
    String? statusbarColor,
  }) {
    return FlavorPageModel(
      id: id ?? this.id,
      name: name ?? this.name,
      path: path ?? this.path,
      title: title ?? this.title,
      color: color ?? this.color,
      dialog: dialog ?? this.dialog,
      safeArea: safeArea ?? this.safeArea,
      statusbarColor: statusbarColor ?? this.statusbarColor,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'path': path,
      'title': title,
      'color': color,
      'dialog': dialog,
      'safeArea': safeArea,
      'statusbarColor': statusbarColor,
    };
  }

  factory FlavorPageModel.fromMap(Map<String, dynamic> map) {
    return FlavorPageModel(
      id: map['id'],
      name: map['name'],
      path: map['path'],
      title: map['title'],
      color: map['color'],
      dialog: map['dialog'],
      safeArea: map['safeArea'],
      statusbarColor: map['statusbarColor'],
      components: map.containsKey('components')
          ? processComponents(map['components'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FlavorPageModel.fromJson(String source) =>
      FlavorPageModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FlavorPageModel(id: $id, name: $name, path: $path, title: $title, color: $color, dialog: $dialog, safeArea: $safeArea, statusbarColor: $statusbarColor)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FlavorPageModel &&
        other.id == id &&
        other.name == name &&
        other.path == path &&
        other.title == title &&
        other.color == color &&
        other.dialog == dialog &&
        other.safeArea == safeArea &&
        other.statusbarColor == statusbarColor;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        path.hashCode ^
        title.hashCode ^
        color.hashCode ^
        dialog.hashCode ^
        safeArea.hashCode ^
        statusbarColor.hashCode;
  }
}

List<FlavorComponentModel>? processComponents(
    List<Map<String, dynamic>> componentsJson) {
  // print('componentsJson::$componentsJson');
  // componentsJson.map((e) => print('e::$e')).toList();
  List<FlavorComponentModel> components;
  try {
    components =
        componentsJson.map((e) => FlavorComponentModel.fromMap(e)).toList();
  } catch (e) {
    print(componentsJson);
    print(e);
    components = [];
  }

  return components;
}
