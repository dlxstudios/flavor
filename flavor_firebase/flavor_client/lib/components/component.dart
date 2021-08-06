import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavor/components/list.dart';
import 'package:flavor/components/page.dart';
import 'package:flavor/components/tiles.dart';
import 'package:flavor/utilities/utils.dart';
import 'package:flutter/material.dart';

class FlavorComponentView extends StatelessWidget {
  final FlavorComponentModel model;
  final ScrollController? controller;
  FlavorComponentView(this.model, {this.controller});
  @override
  Widget build(BuildContext context) {
    if (model.widget != null) {
      return model.widget!;
    }

    Widget _child = Container();

    // print('model.type::${model.type}');
    // print('controller::${controller}');

    switch (model.type) {
      case 'list':

        /// direction : Axis
        Axis _axis = model.data.containsKey('direction')
            ? model.data['direction'] == 'vertical'
                ? Axis.vertical
                : Axis.horizontal
            : Axis.vertical;

        /// Items :
        /// determine of its a List/Array of items in json
        List items;
        if (model.data.containsKey('items')) {
          items = model.data['items'];
        } else {
          /// else wrap FlavorList in a fetch from a collection in the database
          if (model.data.containsKey('itemsCollection')) {
            _child = FirebaseComponent(
              path: model.data['itemsCollection'],
              isCollection: true,
              builder: (context, data) {
                // print('data::$data');
                List items = data['items'];
                return FlavorList(
                  builder: (context, index) {
                    // print('items::$index::${items[index]}');
                    Map<String, dynamic> item = items[index];

                    if (item.containsKey('type')) {
                      if (item['type'] == 'video') {}
                    }

                    Widget _card = FlavorCardTile(
                      backgroundImage: item.containsKey('coverUrl')
                          ? item['coverUrl']
                          : null,
                      key: ValueKey(item.toString()),
                      color: item.containsKey('backgroundColor')
                          ? item['backgroundColor']
                          : null,
                      headerTitle: item.containsKey('headerTitle')
                          ? stringVar(item['headerTitle'], item)
                          : null,
                      headerSubtitle: item.containsKey('headerSubtitle')
                          ? stringVar(item['headerSubtitle'], item)
                          : null,
                      footerTitle: item.containsKey('footerTitle')
                          ? stringVar(item['footerTitle'], item)
                          : null,
                      footerSubtitle: item.containsKey('footerSubtitle')
                          ? stringVar(item['footerSubtitle'], item)
                          : null,
                    );

                    return _card;
                  },
                  itemCount: items.length,
                  controller: controller,
                  aspectRatio: model.data.containsKey('aspectRatio')
                      ? double.tryParse(model.data['aspectRatio'])
                      : null,
                  scrollDirection: _axis,
                );
              },
            );
          } else {
            items = [];
          }
        }

        if (_axis == Axis.horizontal) {
          _child = AspectRatio(
            aspectRatio: 1,
            child: _child,
          );
        }

        break;
      default:
    }

    return Container(
      color: Colors.amber,
      // padding: EdgeInsets.all(16),
      child: Material(
        color: Colors.red.shade800,
        elevation: 6,
        child: _child,
      ),
    );
  }

  // static Widget fromFsReference(DocumentReference ref, {ScrollController? controller}) {
  //   return FutureBuilder<DocumentSnapshot>(
  //     future: ref.get(),
  //     builder: (context, snapshot) {
  //       switch (snapshot.connectionState) {
  //         case ConnectionState.none:
  //           return PageError();
  //         case ConnectionState.waiting:
  //         case ConnectionState.active:
  //           return Container(
  //             child: Center(
  //               child: CircularProgressIndicator(),
  //             ),
  //           );

  //         case ConnectionState.done:
  //           break;
  //         default:
  //       }

  //       if (snapshot.hasError) {
  //         return PageError(
  //           errorCode: 505.toString(),
  //           msg: snapshot.error.toString(),
  //           title: 'Future return error',
  //           // type: 'bad',
  //         );
  //       }
  //       if (snapshot.hasData) {
  //         print('nothin yet%%');
  //       }

  //       FlavorComponentModel _model = FlavorComponentModel({});
  //       return FlavorComponentView(_model, controller: controller,);
  //     },
  //   );
  // }
}

class FlavorComponentModel {
  final String? type;
  final String? name;
  final Map<String, dynamic> data;
  final Widget? widget;

  FlavorComponentModel(
    this.data, {
    this.name,
    this.type,
    this.widget,
  });

  static FlavorComponentModel fromJson(Map<String, dynamic> json) {
    return FlavorComponentModel(
      json,
      type: json['type'],
      name: json['name'],
    );
  }

  static FlavorComponentModel fromFsReference(DocumentReference ref) {
    return FlavorComponentModel({});
  }
}
