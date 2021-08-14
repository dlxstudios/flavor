import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavor_client/components/component.dart';
import 'package:flavor_client/components/list.dart';
import 'package:flavor_client/layout/FlavorResponsiveView.dart';
import 'package:flavor_client/layout/adaptive.dart';
import 'package:flavor_client/repository/firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        statusBarColor: statusbarColor != null ? statusbarColor : null,
      ),
      child: this.safeArea == true ? _finalComponent : child,
    );
  }
}

class PageError extends StatelessWidget {
  final String msg;
  final String title;
  final String errorCode;
  final String type;

  PageError({
    this.title = 'Unknown',
    this.errorCode = "Unknown Error",
    this.msg = '',
    this.type = '',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        // backgroundColor: Theme.of(context).accentColor,
        // backgroundColor: Colors.transparent,
        body: Container(
          padding: EdgeInsets.all(32),
          child: Center(
            child: Column(
              children: <Widget>[
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  errorCode,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  msg,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  type,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ],
            ),
          ),
        ));
  }
}

final ScrollController _scrollController = ScrollController();

class FlavorPage extends StatelessWidget {
  final FlavorPageModel model;
  final List<FlavorComponentModel> components = const [];

  FlavorPage(
    this.model, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (model.components.length < 1) {
      return PageError(
        errorCode: 508.toString(),
        msg: 'No content to display at this time.',
        title: 'Error : {components} missing',
        // type: 'bad',
      );
    }

    // print('_scrollController::$_scrollController');

    final List<Widget> _comps = model.components
        .map(
          (e) => FlavorComponentView(
            e,
            controller: _scrollController,
          ),
        )
        .toList();

    return _buildBody(_comps);

    // return Scaffold(
    //   body: Container(
    //     child: FlavorResponsiveView(
    //       breakpoints: {
    //         DisplayType.s: _buildBody(_comps),
    //         DisplayType.l: Row(
    //           children: [
    //             Flexible(
    //               flex: 0,
    //               child: Container(
    //                 constraints: BoxConstraints(maxWidth: 240),
    //                 child: _buildBody(_comps),
    //               ),
    //             ),
    //             Expanded(
    //               child: Container(
    //                 padding: EdgeInsets.all(16),
    //                 constraints: BoxConstraints(maxWidth: 240),
    //                 child: ,
    //               ),
    //             ),
    //           ],
    //         ),
    //       },
    //     ),
    //   ),
    // );
  }

  _buildBody(List<Widget> _comps) {
    return CustomScrollView(
      cacheExtent: 100,
      controller: _scrollController,
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            _comps,
          ),
        )
      ],
    );
  }

  static Widget fromFsDocumentPath(String path) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    return FutureBuilder<DocumentSnapshot>(
        future: firestore.doc(path).get(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return PageError();

            case ConnectionState.waiting:
            case ConnectionState.active:
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );

            case ConnectionState.done:
              break;

            default:
          }

          if (snapshot.hasError) {
            return PageError(
              errorCode: 505.toString(),
              msg: snapshot.error.toString(),
              title: 'Future return error',
              // type: 'bad',
            );
          }

          FlavorPageModel page = FlavorPageModel.formFS(snapshot.data!);
          return FlavorPage(page);

          return FlavorPageView(
            // controller: _controller,
            children: List.generate(
              page.components.length,
              (sectionIndex) {
                return AspectRatio(
                  aspectRatio: 1,
                  child: FlavorTileSection(
                    title: 'Section Title',
                    child: Container(
                      // padding: EdgeInsets.all(8),
                      // color: Colors.red,
                      child: FlavorList(
                        scrollDirection: Axis.horizontal,
                        itemCount: page.components.length,
                        // backgroundImage: sampleCover3,
                        headerTitle: 'Header Title',
                        headerSubtitle: 'header subtitle goes here',
                        footerTitle: 'Footer Title',
                        footerSubtitle: 'footoer subtitle',
                        footerLeading: Container(
                          color: Colors.indigo,
                        ),
                        headerLeading: Container(
                          color: Colors.indigo,
                        ),
                        footerTrailing: Container(
                          color: Colors.indigo,
                        ),
                        headerTrailing: Container(
                          color: Colors.indigo,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        });
  }
}

class FlavorPageModel {
  final String? id;
  final String? name;
  final String? path;

  late List<FlavorComponentModel> components;
  // List get components => _components;

  final String? title;
  final String? color;
  final bool? dialog;
  final bool? safeArea;
  final String? statusbarColor;

  Map<String, List>? viewStates;

  FlavorPageModel({
    this.components = const [],
    this.name,
    this.id,
    this.path,
    this.title,
    this.color,
    this.dialog,
    this.safeArea,
    this.statusbarColor,
  });

  /// FIX
  static FlavorPageModel formJson(Map<String, dynamic> json) {
    if (json.containsKey('components')) {
      List comps = json['components'] as List;
      print(comps);
    }

    return FlavorPageModel(
      path: json['path'] ?? null,
      id: json['id'] ?? null,
      title: json['title'] ?? null,
      // components: json['components'] ?? null,
    );
  }

  static FlavorPageModel formFS(DocumentSnapshot doc) {
    final dynamic data = doc.data()!;

    final ScrollController _sc = ScrollController();

    FlavorPageModel _pageModel = FlavorPageModel(
      path: data['path'] ?? null,
      id: data['id'] ?? null,
      title: data['title'] ?? null,
    );

    final List<FlavorComponentModel> _comps = [];
    if (data.containsKey('components')) {
      List comps = data['components'] as List;
      for (var comp in comps) {
        if (comp is DocumentReference) {
          _comps.add(FlavorComponentModel(
            data,
            widget: FirebaseComponent(
              ref: comp,
              controller: _sc,
            ),
          ));
        } else {
          _comps.add(comp);
        }
      }
    }

    _pageModel.components = _comps;

    print("hh:${_comps.length}");

    return _pageModel;
  }

  // List<Widget> processedComponents = [];

  // var _comps = pageJson != null ? pageJson['components'] : [];

  // for (var comp in _comps) {
  //   processedComponents.add(BuildComponent(
  //     componentJson: comp,
  //   ));

  // }

}

class FirebaseComponent extends StatelessWidget {
  final String? path;
  final bool? isCollection;
  final DocumentReference? ref;
  final ScrollController? controller;

  final Widget Function(BuildContext, Map<String, dynamic>)? builder;

  const FirebaseComponent({
    Key? key,
    this.path,
    this.ref,
    this.controller,
    this.builder,
    this.isCollection = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var store = FlavorFirestoreRepository();

    return FutureBuilder(
        future: path != null
            ? isCollection!
                ? store.getCollection(path!)
                : store.getDocument(path!)
            : ref != null
                ? ref!
                    .get()
                    // ignore: unnecessary_cast
                    .then((value) => value.data()! as Map<String, dynamic>)
                : Future.error('error, no path or reference was givin.'),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:

            case ConnectionState.waiting:
            case ConnectionState.active:
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );

            case ConnectionState.done:
              break;

            default:
          }

          if (snapshot.hasError) {
            return Container(
              height: 500,
              child: PageError(
                errorCode: 505.toString(),
                msg: snapshot.error.toString(),
                title: 'Future return error',
                // type: 'bad',
              ),
            );
          }

          if (builder != null) {
            return builder!(context, snapshot.data as Map<String, dynamic>);
          }

          return FlavorComponentView(
            FlavorComponentModel.fromJson(
                snapshot.data as Map<String, dynamic>),
            controller: controller,
          );
        });
  }
}

class FlavorPageView extends StatelessWidget {
  final ScrollController? controller;
  final List<Widget>? children;

  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  FlavorPageView({
    Key? key,
    this.children,
    this.controller,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  }) : super(key: key);

  static fromJson(Map<String, dynamic> json) {
    json.containsKey('components');
  }

  @override
  Widget build(BuildContext context) {
    if (children == null) {
      return Container(
        child: Center(child: Text('No page components')),
      );
    }
    final _controller = controller != null ? controller : ScrollController();

    return Container(
      // color: Colors.teal,
      child: SingleChildScrollView(
        controller: _controller,
        child: Column(
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          children: children ?? [],
        ),
      ),
    );
  }

  static listview({
    required IndexedWidgetBuilder itemBuilder,
    required int itemCount,
    bool shrinkWrap = false,
    Axis scrollDirection = Axis.vertical,
  }) {
    return _FlavorPageViewList(
        itemBuilder, itemCount, shrinkWrap, scrollDirection);
  }
}

class _FlavorPageViewList extends FlavorPageView {
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final bool shrinkWrap;
  final Axis scrollDirection;
  _FlavorPageViewList(
      this.itemBuilder, this.itemCount, this.shrinkWrap, this.scrollDirection)
      : super();

  @override
  Widget build(BuildContext context) {
    if (itemBuilder == null) {
      return Container(
        child: Center(child: Text('No items')),
      );
    }
    final _controller = controller != null
        ? controller
        : ScrollController(keepScrollOffset: true);

    return Container(
      // color: Colors.teal,
      child: ListView.builder(
        padding: EdgeInsets.all(0),
        controller: _controller,
        itemCount: itemCount,
        itemBuilder: itemBuilder,
        shrinkWrap: shrinkWrap,
        scrollDirection: scrollDirection,
      ),
    );
  }
}
