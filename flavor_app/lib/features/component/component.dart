import 'dart:convert';

import 'package:css_colors/css_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:flavor_app/features/button/button.dart';
import 'package:flavor_app/features/card/card_box.dart';
import 'package:flavor_app/features/list/list.dart';
import 'package:flavor_app/features/list_tile/list_tile.dart';
import 'package:flavor_app/features/page/page.dart';
import 'package:flavor_app/features/page/page_error.dart';

class FlavorComponentView extends StatelessWidget {
  final Widget? child;
  final ScrollController? controller;
  final FlavorComponentModel? model;
  const FlavorComponentView({
    Key? key,
    this.child,
    this.controller,
    this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? _child = child;

    return Container(
      color: CSSColors.gold,
      padding: const EdgeInsets.all(16),
      child: Container(
        color: CSSColors.red,
        child: _child,
      ),
    );
  }
}

class FlavorComponentModel {
  final String? type;
  final String? name;
  final Map<String, dynamic> data;
  Widget get widget => _processWidget(data);

  FlavorComponentModel({
    this.type,
    this.name,
    this.data = const {},
  });

  static FlavorComponentModel fromFsReference(
      // DocumentReference ref
      ) {
    return FlavorComponentModel();
  }

  FlavorComponentModel copyWith({
    String? type,
    String? name,
    Map<String, dynamic>? data,
    Widget? widget,
  }) {
    return FlavorComponentModel(
      type: type ?? this.type,
      name: name ?? this.name,
      data: data ?? this.data,
      // widget:widget ?? this.widget,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'name': name,
      'data': data,
      // 'widget': widget?.toMap(),
    };
  }

  factory FlavorComponentModel.fromMap(Map<String, dynamic> map) {
    return FlavorComponentModel(
      type: map['type'],
      name: map['name'],
      // data: map,
      // Widget.fromMap(map['widget']),
    );
  }

  String toJson() => json.encode(toMap());

  factory FlavorComponentModel.fromJson(String source) =>
      FlavorComponentModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FlavorComponentModel(type: $type, name: $name, data: $data, widget: $widget)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FlavorComponentModel &&
        other.type == type &&
        other.name == name &&
        mapEquals(other.data, data) &&
        other.widget == widget;
  }

  @override
  int get hashCode {
    return type.hashCode ^ name.hashCode ^ data.hashCode ^ widget.hashCode;
  }
}

Map<String, Type> flavorComponentsMap = {
  'com.flavor.text': Text,
  'com.flavor.cardbox': CardBox,
  'com.flavor.list': FlavorList,
  'com.flavor.page': FlavorPage,
  'com.flavor.button': FlavorButton,
};

Widget _processWidget(Map<dynamic, dynamic> data) {
  print('_processWidget::');
  // String type = data.containsKey('_type') ? data['_type'] : null;
  return Container(
    padding: const EdgeInsets.all(16),
    child: const Center(
      child: Text('No Components'),
    ),
  );
  // if (type.isEmpty)
  //   for (var value in flavorComponentsMap.entries) {
  //     print('value.runtimeType::${value.value}');
  //   }
  // switch (type) {
  //   case 'text':
  //     return Text(data['text']);
  //   case 'list':
  //     return buildFlavorListView(data);
  //   default:
  //     return _widget;
  // }
}

Widget buildFlavorListView(Map data) {
  List items = data['items'] ?? [];

  Axis _axis = data.containsKey('direction')
      ? data['direction'] == 'vertical'
          ? Axis.vertical
          : Axis.horizontal
      : Axis.vertical;

  if (items.isEmpty) {
    return FlavorPageError(message: 'No items in list', code: 404.toString());
  }

  return FlavorList(
    builder: (context, index) {
      // print('items::$index::${items[index]}');
      Map<String, dynamic> item = items[index];

      return CardBox(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListTile(
            title: Text('Comonents $index'),
            subtitle: Text(item.toString()),
          ),
        ),
      );
    },
    itemCount: items.length,
    aspectRatio: data.containsKey('aspectRatio')
        ? double.tryParse(data['aspectRatio'])
        : null,
    scrollDirection: _axis,
  );
}

Widget _widget = Container(
  padding: const EdgeInsets.all(16),
  child: const Center(
    child: Text('No Components'),
  ),
);
