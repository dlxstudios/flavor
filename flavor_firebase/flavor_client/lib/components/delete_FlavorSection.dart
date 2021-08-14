import 'package:flavor_client/models/section.dart';
import 'package:flutter/material.dart';

////
class FlavorSection extends StatelessWidget {
  final Axis? listDirection;

  final IndexedWidgetBuilder itemBuilder;

  final Widget? headerTrailing;

  final String? headerText;

  final int itemCount;

  final double? itemExtent;

  final Widget? emptyState;

  final ScrollController? controller;

  const FlavorSection({
    Key? key,
    Section? section,
    this.listDirection = Axis.vertical,
    required this.itemBuilder,
    this.headerTrailing,
    this.headerText,
    this.itemCount = 0,
    this.itemExtent,
    this.emptyState,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.deepPurpleAccent,
      child: Column(
        children: <Widget>[
          // !Header
          headerText != null
              ? ListTile(
                  title: Text(
                    headerText!,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  trailing: headerTrailing,
                )
              : Container(),
          // !ListView of items
          Flexible(
            flex: 1,
            child: Container(
              // height: 500,
              // width: 500,
              // color: Colors.pink,
              child: itemCount == 0
                  ? emptyState != null
                      ? emptyState
                      : EmptyState()
                  : listDirection == Axis.horizontal
                      ? ListView.builder(
                          controller: controller,
                          shrinkWrap: true,
                          scrollDirection: listDirection!,
                          itemBuilder: itemBuilder,
                          itemCount: itemCount,
                          itemExtent: itemExtent,
                        )
                      : Column(
                          children: List.generate(itemCount,
                              (index) => itemBuilder(context, index)),
                        ),
            ),
          )
        ],
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.greenAccent,
      // height: 400,
      width: 100,
      child: Center(
        child: Text('No Items'),
      ),
    );
  }
}
