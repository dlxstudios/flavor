import 'package:flavor_client/apps/admin/state.dart';
import 'package:flavor_client/components/list.dart';
import 'package:flavor_client/components/page.dart';
import 'package:flavor_client/components/refactor_components.dart';
import 'package:flavor_client/components/route.dart';
import 'package:flavor_client/samples.dart';
import 'package:flavor_client/theme/clay/clay.dart';
import 'package:flavor_client/theme/clay/widget.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsConsumer extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    final adminState = ref.watch(flavorAdminStateProvider);
    var controller = ScrollController();
    // flavorAdminStateProvider.select((value) => null);
    // final age = watch(personProvider.select((p) => p.age));

    List settings = [
      {
        'title': 'Dark Theme',
        'subtitle': 'Use the "Dark" theme.',
        'value': {'type': 'bool', 'data': ''},
        'ontap': (index) {
          // print(index);
          // print('object');
          adminState.useDark = !adminState.useDark;
        }
      },
      {
        'title': 'Use Color',
        'subtitle': 'Use the "Dark" theme.',
        'value': {'type': 'bool', 'data': ''},
        'ontap': (index) {
          // print(index);
          // print('object');
          adminState.useColor = !adminState.useColor;
        }
      }
    ];
    return FlavorPageView(
      controller: controller,
      children: [
        FlavorTileSection(
          title:
              'Theme (dark is ${adminState.useDark == false ? 'off' : 'on'} )',
          child: ClayLayoutGrid(
            onHeader: (index) => Container(
              // color: Colors.deepPurpleAccent,
              // child: header,
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor:
                        adminState.useDark ? Colors.green : Colors.grey,
                  )
                ],
              ),
            ),
            onBody: (index) => Center(
              child:
                  FlavorText.bodyText1(context, '${settings[index]['title']}',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontSize: 26,
                          )),
            ),
            onTap: (index) {
              // print(index);
              settings[index]['ontap'](index);
            },
            onFooter: (index) => FlavorText.caption(
              context,
              'in progrogress...',
            ),
            itemCount: settings.length,
            crossAxisCount: 2,
            controller: controller,
          ),
        ),
        FlavorTileSection(
          title: 'Course collection',
          child: ClayLayoutGrid(),
        ),
        ClayTileHeader(
          title: 'Course collection',
        ),
        FlavorTileSection(
          title: 'Title',
          child: ClayLayoutGrid(
            controller: controller,
            itemCount: 2,
            childAspectRatio: 3.6,
            itemBuilder: (context, index) => ClayButton(
              onTap: () {},
              borderRadius: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: Image.network(sampleNetworkProfileCover).image,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FlavorText.bodyText1(context, 'Courses I attended'),
                          // Text('Courses I attended',
                          //     style: Theme.of(context)
                          //         .textTheme
                          //         .bodyText1
                          //     // .copyWith(fontSize: 16),
                          //     ),
                          SizedBox(
                            height: 8,
                          ),
                          FlavorText.caption(context, '11 courses in total'),
                          // Text('11 courses in total',
                          //     style:
                          //         Theme.of(context).textTheme.caption
                          //     // .copyWith(fontSize: 16),
                          //     ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

FlavorRouteWidget get settingsRoute => FlavorRouteWidget(
      path: '/settings',
      title: 'Settings',
      icon: Icons.settings,
      backgroundColor: Colors.teal,
      child: SettingsConsumer(),
    );
