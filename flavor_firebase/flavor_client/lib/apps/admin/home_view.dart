import 'package:flavor/apps/admin/state.dart';
import 'package:flavor/components/list.dart';
import 'package:flavor/components/page.dart';
import 'package:flavor/components/refactor_components.dart';
import 'package:flavor/components/route.dart';
import 'package:flavor/models/media.dart';
import 'package:flavor/models/models.dart';
import 'package:flavor/samples.dart';
import 'package:flavor/theme/clay/clay.dart';
import 'package:flavor/theme/clay/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeConsumer extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final adminState = watch(flavorAdminStateProvider);
    var controller = ScrollController(keepScrollOffset: true);
    // flavorAdminStateProvider.select((value) => null);
    // final age = watch(personProvider.select((p) => p.age));

    return FutureBuilder(
      future: adminState.service!.search('', ''),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return ClayTileCard(
              body: Text('No Data!'),
            );
            break;
          case ConnectionState.waiting:
            return ClayTileCard(
              body: Text('Preparing yo order chef!'),
            );
            break;
          case ConnectionState.active:
            return ClayTileCard(
              body: Text('No Data!'),
            );
            break;
          case ConnectionState.done:
            if (snapshot.hasError) {
              return ClayTileCard(
                body: Column(
                  children: [
                    Text(
                      'Error',
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(color: Theme.of(context).errorColor),
                    ),
                    Text(snapshot.error.toString()),
                  ],
                ),
              );
            }
            if (snapshot.hasData) {
              // return ClayTileCard(
              //   body: Text(snapshot.data.toString()),
              // );

              List<Track> data = snapshot.data;
              var title = 'Latests Media';
              // print(data.length);

              return FlavorPageView(
                controller: controller,
                children: [
                  FlavorTileSection(
                    title: '$title',
                    child: ClayLayoutGrid(
                      clayTileCardLayout: ClayTileCardLayout.seperated,
                      onbackgoundImage: (index) => DecorationImage(
                        image: Image.network(data[index].coverUrl!).image,
                        fit: BoxFit.cover,
                      ),
                      // onHeroTag: (index) => data[index],
                      // onHeader: (index) => Container(
                      //   // color: Colors.deepPurpleAccent,
                      //   // child: header,
                      //   padding: EdgeInsets.all(8),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       CircleAvatar(
                      //         radius: 6,
                      //         backgroundColor: adminState.useDark
                      //             ? Colors.green
                      //             : Colors.grey,
                      //       ),
                      //       Spacer(),
                      //       ClayButton(
                      //         spread: 0,
                      //         surfaceColor: Colors.red,
                      //         // parentColor: Colors.transparent,
                      //         depth: 0,
                      //         child: Icon(Icons.edit),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      // onHeader: (index) => ListTile(
                      //   contentPadding: EdgeInsets.only(bottom: 10),
                      //   leading: CircleAvatar(
                      //     radius: 16,
                      //     backgroundImage:
                      //         Image.network(sampleNetworkProfileCover).image,
                      //   ),
                      //   title: FlavorText.bodyText1(
                      //     context,
                      //     'aurthor.displayName',
                      //     maxLines: 1,
                      //   ),
                      //   // subtitle: Text(
                      //   //   '${data[index].title}',
                      //   //   maxLines: 1,
                      //   //   style: Theme.of(context).textTheme.caption,
                      //   // ),
                      //   subtitle: FlavorText.caption(
                      //     context,
                      //     '${data[index]}',
                      //     maxLines: 1,
                      //   ),
                      // ),
                      // onBody: (index) => FlavorText.bodyText1(
                      //   context,
                      //   '${data[index].title}',
                      //   maxLines: 2,
                      // ),
                      // onBody: (index) => Image.network(
                      //   sampleNetworkImageOwl,
                      //   fit: BoxFit.cover,
                      // ),
                      onBody: (index) {
                        return Container();
                        // return Padding(
                        //   padding: const EdgeInsets.all(0.0),
                        //   child: Image.network(
                        //     data[index].coverUrl,
                        //     fit: BoxFit.cover,
                        //   ),
                        // );
                      },
                      onTap: (index) {
                        // print(index);
                        // home[index]['ontap'](index);
                        Navigator.of(context)
                            .pushNamed('/details', arguments: data[index]);
                      },
                      // onFooter: (index) => Column(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     FlavorText.bodyText1(
                      //       context,
                      //       '${data[index].title}',
                      //       maxLines: 2,
                      //     ),
                      //     FlavorText.caption(
                      //       context,
                      //       '${data[index].title}',
                      //       maxLines: 1,
                      //     ),
                      //     SizedBox(
                      //       height: 16,
                      //     ),
                      //   ],
                      // ),

                      onFooter: (index) => ListTile(
                        contentPadding: EdgeInsets.all(0),
                        title: FlavorText.bodyText1(
                          context,
                          '${data[index].title}',
                          maxLines: 1,
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FlavorText.caption(
                              context,
                              'uploading 20%',
                              maxLines: 1,
                            ),
                            Spacer(),
                            Flexible(
                              child: ClayContainer(
                                contraints: BoxConstraints(
                                    minWidth: 8, maxWidth: double.infinity),
                                // color: Colors.red,
                                depth: 10,
                                // width: 10,
                                height: 2,
                                child: LinearProgressIndicator(
                                  value: .5,
                                  backgroundColor: Colors.grey.shade400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      itemCount: 4,
                      crossAxisCount: 2,
                      controller: controller,
                    ),
                  ),
                  FlavorTileSection(
                    title: 'Title',
                    child: ListView.builder(
                      shrinkWrap: true,
                      controller: controller,
                      itemCount: 2,
                      itemBuilder: (context, index) => ClayButton(
                        onTap: () {},
                        borderRadius: 16,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.all(8),
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  image: DecorationImage(
                                    image:
                                        Image.network(sampleNetworkProfileCover)
                                            .image,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FlavorText.bodyText1(
                                        context, 'Courses I attended 7'),
                                    // Text('Courses I attended',
                                    //     style: Theme.of(context)
                                    //         .textTheme
                                    //         .bodyText1
                                    //     // .copyWith(fontSize: 16),
                                    //     ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    FlavorText.caption(
                                        context, '11 courses in total'),
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
            return ClayTileCard(
              body: Text('Done'),
            );
            break;
        }

        return Container();
      },
    );
  }
}

FlavorRouteWidget get adminRoute => FlavorRouteWidget(
      path: '/admin',
      title: 'Admin',
      icon: Icons.admin_panel_settings,
      backgroundColor: Colors.teal,
      child: HomeConsumer(),
      // onRequired: ({appState, settings}) {
      //   print(appState.useDark);
      //   if (!appState.useDark) {
      //     return MaterialPageRoute(builder: (BuildContext context) {
      //       return LandingView();
      //     });
      //   } else {
      //     return null;
      //   }
      // },
    );

FlavorRouteWidget get homeRoute => FlavorRouteWidget(
      path: '/',
      title: 'Admin',
      icon: Icons.home,
      backgroundColor: Colors.teal,
      child: HomeConsumer(),
      // onRequired: ({appState, settings}) {
      //   print(appState.useDark);
      //   if (!appState.useDark) {
      //     return MaterialPageRoute(builder: (BuildContext context) {
      //       return LandingView();
      //     });
      //   } else {
      //     return null;
      //   }
      // },
    );

class LandingView extends StatelessWidget {
  const LandingView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size(double.infinity, 64),
      //   child: Container(
      //     padding: EdgeInsets.all(16),
      //     color: Theme.of(context).scaffoldBackgroundColor,
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         ClayText(
      //           'Flavor',
      //           size: 32,
      //         ),
      //         Row(
      //           children: [
      //             TextButton(
      //               onPressed: () {},
      //               child: Text('About'),
      //             ),
      //             TextButton(
      //               onPressed: () {},
      //               child: Text('Features'),
      //             ),
      //           ],
      //         ),
      //         ClayButton(
      //           padding: EdgeInsets.all(0),
      //           borderRadius: 16,
      //           parentColor: Theme.of(context).scaffoldBackgroundColor,
      //           surfaceColor: Theme.of(context).scaffoldBackgroundColor,
      //           onTap: () {},
      //           // text: 'Sum Text',
      //           // child: Text('Flavor'),
      //           child: Icon(Icons.person),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),

      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 600,
            flexibleSpace: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Flavor is a framwork for building apps and websites easily',
                            style:
                                Theme.of(context).textTheme.headline4?.copyWith(
                                      letterSpacing: 1,
                                      // fontSize: 16,
                                    ),

                            // overflow: TextOverflow.fade,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Image.asset('assets/images/Letter.png'),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text('Start now'),
                  ),
                ),
              ],
            ),
            floating: true,
            forceElevated: true,
            elevation: 4,
            // title: Text('data'),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Flavor is a framwork for building apps and websites easily',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
              Container(
                // color: Colors.red,
                padding: EdgeInsets.all(8),
                // width: 320,
                // height: 2000,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Start now'),
                    ),
                  ],
                ),
              )
            ]),
          ),
        ],
        // children: [
        //   FlavorResponsiveView(
        //     global: false,
        //     breakpoints: {
        //       DisplayType.s: Container(
        //         color: Colors.deepPurple,
        //         child: ListView(
        //           shrinkWrap: true,
        //           padding: EdgeInsets.all(16),
        //           children: [
        //             Container(
        //               padding: EdgeInsets.all(32),
        //               child: Image.asset('assets/images/Letter.png'),
        //             ),
        //             Padding(
        //               padding: const EdgeInsets.all(8.0),
        //               child: Text(
        //                 'Flavor is a framwork for building apps and websites easily',
        //                 style: Theme.of(context).textTheme.headline4,
        //               ),
        //             ),
        //             Container(
        //               // color: Colors.red,
        //               padding: EdgeInsets.all(8),
        //               // width: 320,
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.start,
        //                 children: [
        //                   ElevatedButton(
        //                     onPressed: () {},
        //                     child: Text('Start now'),
        //                   ),
        //                 ],
        //               ),
        //             )
        //           ],
        //         ),
        //       ),
        //       DisplayType.m: Container(
        //         width: double.infinity,
        //         height: double.infinity,
        //         child: Row(
        //           children: [
        //             Flexible(
        //               flex: 2,
        //               child: Container(
        //                 color: Colors.deepPurpleAccent,
        //               ),
        //             ),
        //             Flexible(
        //               flex: 8,
        //               child: Container(
        //                 color: Colors.deepPurple,
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     },
        //   ),
        // ],
      ),
    );
  }

  Widget buildSections(BuildContext context, int index) {
    var color = index.isEven;

    return Container(
      color: color ? Colors.greenAccent.shade700 : Colors.blueAccent.shade100,
    );
  }
}

FlavorRouteWidget get accountRoute => FlavorRouteWidget(
      path: '/',
      title: 'Account',
      icon: Icons.home,
      backgroundColor: Colors.teal,
      child: HomeConsumer(),
      onRequired: ({appState, settings}) {
        print(appState.useDark);
        // if (appState.useDark) {
        return MaterialPageRoute(builder: (BuildContext context) {
          return LandingView();
        });
        // } else {
        //   return null;
        // }
      },
    );
