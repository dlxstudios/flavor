import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flavor_client/apps/admin/repository.dart';
import 'package:flavor_client/colors.dart';
import 'package:flavor_client/components/manager/repo_manager.dart';
import 'package:flavor_client/components/route.dart';
import 'package:flavor_auth/flavor_auth.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

// ignore: top_level_function_literal_block
// final flavorStateProvider = ChangeNotifierProvider((_) {
//   return FlavorClientState();
// });

// ProviderBase flavorStateProvider({
//   Color? primaryColor,
//   Color? accentColor,
//   TextTheme? textTheme,
//   List<FlavorRouteWidget>? routes,
// }) =>
//     ChangeNotifierProvider(
//       (r) {
//         return FlavorClientState(
//           accentColor: accentColor,
//           primaryColor: primaryColor,
//           textTheme: textTheme,
//           routes: [],
//           user: FlavorUser(),
//         );
//       },
//     );
dynamic flavorState(FlavorClientState settings) => ChangeNotifierProvider((_) {
      return settings;
    });

class AppStateConsumer extends ConsumerWidget {
  final dynamic appProvider;
  final Widget consumer;

  AppStateConsumer({
    required this.consumer,
    this.appProvider,
  });

  @override
  Widget build(BuildContext context, ref) {
    final FlavorClientState app = ref.watch(appProvider);
    return consumer;
  }
}

class FlavorClientState extends ChangeNotifier {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool isReady = false;

  FlavorUser? _user;
  FlavorUser? get user => _user;
  set user(FlavorUser? value) {
    print('new user ${value!.email}');
    _user = value;
    notifyListeners();
  }

  // ChangeNotifierProvider<FlavorSearchService>? searchService;
  late FlavorSearchService ss;
  // FlavorSearchService(user!);

  // ChangeNotifierProvider<FlavorFileManager>? filemanager;
  FlavorFileManager? filemanager;

  final Color? primaryColor;
  final Color? accentColor;
  final TextTheme? textTheme;

  final List<FlavorRouteWidget> routes;

  final FlavorStore store = FlavorStore.instance;

  Box? hivebox;

  Map<String, FlavorRouteWidget> get routesMap {
    Map<String, FlavorRouteWidget> map = {};
    for (var route in routes) {
      map.putIfAbsent(route.path, () => route);
    }
    return map;
  }

  List<String> currentPages = ['/'];

  Iterable<FlavorRouteWidget?> get routesForTabs => routes.map((e) {
        if (e.routeInTab!) {
          return e;
        }
      });

  Iterable<FlavorRouteWidget?> get routesForDrawer => routes.map((e) {
        if (e.routeInDrawer!) {
          return e;
        }
      });

  get userState => FirebaseAuth.instance.currentUser != null;

  FlavorClientState({
    this.primaryColor = const Color(0xffA16AE8),
    this.accentColor = const Color(0xffA16AE8),
    this.textTheme,
    required this.routes,
  }) {
    FirebaseAuth.instance.userChanges().listen((_user) {
      user = _user != null
          ? FlavorUser(
              displayName: _user.displayName,
              email: _user.email,
              emailVerified: _user.emailVerified,
              photoUrl: _user.photoURL,
              // refreshToken: _user.getIdToken(),
              // localId: _user.getIdToken(),
            )
          : null;
    });

    Hive.openBox('dlxapp').then((value) {
      hivebox = value;
      isReady = true;
      notifyListeners();
    });

    _currentTheme = mainTheme;

    // Check is user already signed in
    //

    // user = FlavorUser(
    //   email: 'skii',
    //   displayName: 'Test Skii',
    // );
    // searchService = ChangeNotifierProvider((_) {
    //   return FlavorSearchService(user!);
    // });

    // filemanager = ChangeNotifierProvider((_) {
    //   return FlavorFileManager(user!);
    // });
  }

  ThemeData get mainTheme {
    // print(
    //     'ThemeData.estimateBrightnessForColor(primaryColor!)::${ThemeData.estimateBrightnessForColor(primaryColor!).toString()}');
    return useDark
        ? flavorThemeMaterialDark.copyWith(
            inputDecorationTheme: InputDecorationTheme(fillColor: Colors.red),
            accentColor: primaryColor,
            primaryColor: primaryColor,
            // scaffoldBackgroundColor: useColor ? primaryColor : null,
            textTheme: GoogleFonts.catamaranTextTheme()
                .merge(flavorThemeMaterialDark.textTheme),
            tabBarTheme: TabBarTheme(
              labelColor: primaryColor,
              unselectedLabelColor: Colors.grey.shade400,
            ),
            appBarTheme:
                AppBarTheme(backgroundColor: Colors.transparent, elevation: 0),
            cardTheme: CardTheme(
              clipBehavior: Clip.antiAlias,
              color: Colors.grey.shade800,
              elevation: 4,
              shadowColor: Colors.grey.shade800,
              margin: EdgeInsets.all(0),
            ),

            indicatorColor: primaryColor,
            // visualDensity: VisualDensity.adaptivePlatformDensity,
          )
        : flavorThemeMaterialLight.copyWith(
            accentColor: primaryColor,
            primaryColor: primaryColor,
            scaffoldBackgroundColor: useColor ? primaryColor : null,
            textTheme: GoogleFonts.catamaranTextTheme(),
            tabBarTheme: TabBarTheme(
              labelColor: primaryColor,
              unselectedLabelColor: Colors.grey.shade400,
            ),
            indicatorColor: primaryColor,
            // visualDensity: VisualDensity.adaptivePlatformDensity,
          );
  }

  // ThemeData(
  //       visualDensity: VisualDensity.adaptivePlatformDensity,
  //       scaffoldBackgroundColor: primaryColor,
  //       cardColor: primaryColor,
  //       canvasColor: primaryColor,
  //       navigationRailTheme: NavigationRailThemeData(
  //         backgroundColor: primaryColor,
  //       ),
  //       bottomNavigationBarTheme: BottomNavigationBarThemeData(
  //         backgroundColor: primaryColor,
  //         selectedItemColor: accentColor,
  //         elevation: 0,
  //       ),
  //       primaryColor: primaryColor,
  //       accentColor: accentColor,
  //     );

  ThemeData? _currentTheme;
  get currentTheme => _currentTheme;
  set currentTheme(value) {
    _currentTheme = value;
    notifyListeners();
  }

  bool _useDark = true;
  bool get useDark => _useDark;
  set useDark(value) {
    print('toggle dark mode');
    print('$value');
    _useDark = value;
    notifyListeners();
  }

  bool _useColor = false;
  bool get useColor => _useColor;
  set useColor(value) {
    _useColor = value;
    notifyListeners();
  }
}

class FlavorStore {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<FlavorStoreCollection> collection(String index) {
    return firestore.collection(index).get().then(
          (value) => FlavorStoreCollection.fromFsQuery(value),
        );
  }

  Future<FlavorStoreItem> doc(String documentPath) {
    return firestore.doc(documentPath).get().then(
          (value) => FlavorStoreItem.fromFsDocument(value),
        );
  }

  FlavorStore._privateConstructor();

  static final FlavorStore instance = FlavorStore._privateConstructor();
}

class FlavorStoreCollection {
  int? size;

  bool? hasPendingWrites;

  bool? isFromCache;

  FlavorStoreCollection();

  List<FlavorStoreItem> get items => _items!;
  List<FlavorStoreItem>? _items;

  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  FlavorStoreCollection.fromFsQuery(QuerySnapshot snapshot) {
    this.hasPendingWrites = snapshot.metadata.hasPendingWrites;
    this.isFromCache = snapshot.metadata.isFromCache;
    // print('snapshot.docs.length::${snapshot.docs.length}');
    _items = snapshot.docs.map((e) {
      // print('snapshot.docs.map:: ${e.id}');
      return FlavorStoreItem.fromFs(e);
    }).toList();
  }
}

class FlavorStoreItem {
  String? _id;

  dynamic _data = {};

  // bool get exists => _fsSnapshot!.exists || true;

  String get id =>
      // _fsSnapshot != null ? _fsSnapshot!.id :
      _id.toString();

  Map<String, dynamic> get data =>

      // _fsSnapshot != null ? _fsSnapshot!.data() :
      _data;

  late QueryDocumentSnapshot? _fsQueryDocumentSnapshot;
  late DocumentSnapshot? _fsDocumentSnapshot;
  DocumentReference get _fsReference => _fsDocumentSnapshot != null
      ? _fsDocumentSnapshot!.reference
      : _fsQueryDocumentSnapshot!.reference;

  FlavorStoreItem.fromFs(QueryDocumentSnapshot snapshot) {
    _fsQueryDocumentSnapshot = snapshot;
    _data = snapshot.data();
    _id = snapshot.id;
    // _fsReference = snapshot.reference;
  }

  FlavorStoreItem.fromFsDocument(DocumentSnapshot snapshot) {
    _fsDocumentSnapshot = snapshot;
    _data = snapshot.data()!;
    _id = snapshot.id;
    // _fsReference = _fsDocumentSnapshot.reference;
  }
}
