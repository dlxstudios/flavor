import 'package:flavor_client/models/section.dart';
import 'package:flutter/material.dart';

class FlavorMenu extends StatefulWidget {
  final GlobalKey<NavigatorState>? navigatorKey;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final Color? backgroundColor;
  final List<Section>? sections;
  final List<Widget>? children;
  const FlavorMenu({
    Key? key,
    this.navigatorKey,
    this.backgroundColor,
    this.sections,
    this.children,
    this.scaffoldKey,
  }) : super(key: key);
  @override
  _FlavorMenuState createState() => _FlavorMenuState();
}

class _FlavorMenuState extends State<FlavorMenu> {
  @override
  Widget build(BuildContext context) {
    List<Widget> _children = [];

    if (widget.children != null) {
      _children = widget.children!;
    }

    if (widget.sections != null) {
      for (var section in widget.sections!) {
        // print(section.title);
        _children
            // .add(FlavorMenuTile.fromFlavorItem(FlavorItem(title: section.title)));
            .add(ListTile(
          title: Text(
            section.title!,
            // style: Theme.of(context).textTheme.headlisne6,
          ),
        ));

        for (var flavorItem in section.items!) {
          _children.add(FlavorMenuTile.fromFlavorItem(flavorItem));
        }
      }
    }

    // List<Widget> _FlavorItems(FlavorItems) {
    //   return List.generate(
    //     FlavorItems.length,
    //     (FlavorItemIndex) {
    //       return FlavorMenuTile.fromFlavorItem(FlavorItems[FlavorItemIndex]);
    //     },
    //   );
    // }

    return Scaffold(
        backgroundColor: widget.backgroundColor,
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        //   title: Text('data'),
        // ),
        // bottomNavigationBar: Padding(
        //   padding: const EdgeInsets.only(left:16.0, right: 16, bottom: 20),
        //   child: Row(
        //       mainAxisAlignment: MainAxisAlignment.start,
        //       children: <Widget>[CircleAvatar()],
        //     ),
        // ),
        body: SafeArea(
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: _children,
          ),
        )

        // body: Column(
        //   children: <Widget>[
        //     Container(
        //       height: 200,
        //       color: Colors.blueGrey,
        //     ),
        //     Material(
        //       elevation: 3,
        //       color: widget.backgroundColor != null
        //           ? widget.backgroundColor
        //           : Colors.black.withOpacity(1),
        //       // child: ListView(
        //       //   shrinkWrap: true,
        //       //   padding: EdgeInsets.all(0),
        //       //   children: _children,
        //       //   // children: List.generate(widget.sections.length, (sectionIndex) {
        //       //   //   return Column(
        //       //   //     children: _children,
        //       //   //   );
        //       //   //   // ListTile(
        //       //   //   //   title: TextOneLine(widget.sections[sectionIndex].title,
        //       //   //   //       style: Theme.of(context).textTheme.headline4),
        //       //   //   //   contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        //       //   //   //   trailing: DLXElevatedButton(
        //       //   //   //     text: 'MORE',
        //       //   //   //     onPressed: () {
        //       //   //   //       print('object');
        //       //   //   //     },
        //       //   //   //   ),
        //       //   //   // );
        //       //   //   // return List.generate(widget.sections[sectionIndex].items.length,
        //       //   //   //     (FlavorItemIndex) {
        //       //   //   //   return FlavorMenuTile.fromFlavorItem(
        //       //   //   //       widget.sections[0].items[FlavorItemIndex]);
        //       //   //   // });
        //       //   // }),
        //       // ),
        //     ),
        //   ],
        // ),
        );
  }
}

class FlavorMenuTile extends StatelessWidget {
  final void Function()? onTap;
  final IconData? icon;
  final String? title;
  const FlavorMenuTile({
    Key? key,
    this.onTap,
    this.title,
    this.icon = Icons.whatshot,
  }) : super(key: key);

  factory FlavorMenuTile.fromFlavorItem(SectionItem sectionItem) {
    return FlavorMenuTile(
      icon: Icons.ac_unit,
      // onTap: flavorItem,
      title: sectionItem.title,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: title != null ? Text(title!) : null,
      onTap: onTap!,
    );
  }
}
