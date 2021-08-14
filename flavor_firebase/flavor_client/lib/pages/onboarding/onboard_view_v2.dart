import 'package:flavor_client/layout/adaptive_view.dart';
import 'package:flavor_client/pages/onboarding/emailLogin_view.dart';
import 'package:flavor_client/pages/onboarding/emailSignup_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flavor_auth/src/models/user.dart';

class PageOnboardingView extends StatefulWidget {
  final Future Function(String email, String password)? onEmailLogin;
  final Future<FlavorUser> Function(
      String email, String password, String passwordReEnter)? onEmailSignup;

  final String? title;

  final String? description;

  final Widget? flexiableSpace;
  final ThemeData? themeData;
  PageOnboardingView({
    Key? key,
    this.onEmailLogin,
    this.onEmailSignup,
    this.title,
    this.description,
    this.flexiableSpace,
    this.themeData,
  }) : super(key: key);

  @override
  _PageOnboardingViewState createState() => _PageOnboardingViewState();
}

class _PageOnboardingViewState extends State<PageOnboardingView>
    with SingleTickerProviderStateMixin {
  bool notBusy = true;
  var signinError;

  final _onBoardFormLoginKey = GlobalKey<FormState>();
  final _onBoardFormSignUpKey = GlobalKey<FormState>();
  final _passwordTextController = TextEditingController(
    text: 'golucky6',
  );
  final _repasswordTextController = TextEditingController(
    text: 'golucky66',
  );
  final _usernameTextController = TextEditingController(
    text: 'ben@guy.com',
  );

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  Widget? _endDrawer;

  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(vsync: this, length: myTabs.length, initialIndex: 1);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _usernameTextController.dispose();
    _passwordTextController.dispose();
    _repasswordTextController.dispose();
    super.dispose();
  }

  final List<Tab> myTabs = <Tab>[
    Tab(
      text: 'Login',
      // icon: new Icon(Icons.show_chart),
    ),
    Tab(
      text: 'Sign up',
      // icon: new Icon(Icons.show_chart),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     theme: widget.themeData == null ? ThemeData.dark() : widget.themeData,
    // )
    return Container(
      // height: double.infinity,
      // width: double.infinity,
      // color: Colors.white,
      // padding: EdgeInsets.all(16),
      child: SafeArea(
        // top: false,
        child: Navigator(onPopPage: (route, result) => true, pages: [
          MaterialPage(
            child: Scaffold(
              // navigationTypeResolver: (context) {
              //   return NavigationType.drawer;
              // },
              // destinations: [
              //   AdaptiveScaffoldDestination(
              //     title: 'Login',
              //     icon: Icons.login_outlined,
              //   ),
              //   AdaptiveScaffoldDestination(
              //     title: 'Login',
              //     icon: Icons.person_add_alt_1_outlined,
              //   ),
              // ],
              // selectedIndex: 0,
              // appBar: AdaptiveAppBar(
              //   elevation: 0,
              //   actions: [
              //     IconButton(
              //       onPressed: () {},
              //       icon: Icon(Icons.account_circle_outlined),
              //     ),
              //   ],
              //   // bottom: PreferredSize(
              //   //   preferredSize: Size.fromHeight(64),
              //   //   child: Container(
              //   //     color: Colors.tealAccent,
              //   //   ),
              //   // ),
              //   bottom: TabBar(
              //     controller: _tabController,
              //     tabs: myTabs,
              //   ),
              //   // title: ClayTileHeader(
              //   //   title: 'Login',
              //   // ),
              //   automaticallyImplyLeading: false,

              //   // flexibleSpace: Container(
              //   //   height: 300,
              //   //   // color: Colors.red,
              //   //   child: Center(
              //   //     child: Image.network(
              //   //         'https://firebasestorage.googleapis.com/v0/b/dlxstudios-f6e64.appspot.com/o/images%2F3VMM8eIJxSg.jpg?alt=media&token=f051bcae-aa6b-4ea5-be6e-38c391255e97'),
              //   //   ),
              //   // ),
              // ),
              body: Container(
                // margin: EdgeInsets.all(12),
                // height: double.infinity,
                // width: double.infinity,
                // color: Colors.amber,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          Container(
                            padding: EdgeInsets.all(16),
                            child: EmailLoginFormView(
                              onBoardFormLoginKey: _onBoardFormLoginKey,
                              usernameTextController: _usernameTextController,
                              passwordTextController: _passwordTextController,
                              scaffoldKey: scaffoldKey,
                              onEmailLogin: (email, password) async {
                                if (widget.onEmailLogin != null) {
                                  await widget.onEmailLogin!(email, password);
                                }
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(16),
                            child: EmailSignUpFormView(
                              onBoardFormSignUpKey: _onBoardFormSignUpKey,
                              usernameTextController: _usernameTextController,
                              passwordTextController: _passwordTextController,
                              repasswordTextController:
                                  _repasswordTextController,
                              onEmailSignup:
                                  (email, password, passwordReEnter) async {
                                if (widget.onEmailSignup == null) {
                                  return Future.error(
                                      'onEmailSignup functions doesn\'t exists');
                                }
                                return await widget.onEmailSignup!(
                                    email, password, passwordReEnter);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    // $Providers
                    // Flexible(
                    //   flex: 0,
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(16.0),
                    //     child: Column(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         ElevatedButton.icon(
                    //           color: Colors.redAccent.shade200,
                    //           label: Text('Google'),
                    //           icon: Text('G'),
                    //           onPressed: () {},
                    //         ),
                    //         ElevatedButton.icon(
                    //           color: Colors.grey,
                    //           label: Text('Apple'),
                    //           icon: Text('A'),
                    //           onPressed: () {},
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void showSnackBarError(dynamic error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      // backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 60),
      content: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.error_outline,
              color: Colors.red,
            ),
          ),
          Text(error.toString()),
        ],
      ),
      elevation: 8,
      behavior: SnackBarBehavior.fixed,
      action: SnackBarAction(
          textColor: Colors.red, label: 'Send Error', onPressed: () {}),
    ));
  }
}

class BuildLargeView extends StatelessWidget {
  final onBoardFormLoginKey;
  final notBusy;

  final TextEditingController? usernameTextController;
  final TextEditingController? passwordTextController;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  BuildLargeView({
    Key? key,
    this.onBoardFormLoginKey,
    this.notBusy,
    this.usernameTextController,
    this.passwordTextController,
    this.scaffoldKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(56.0),
      child: Row(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: Container(
              // color: Colors.redAccent,
              constraints: BoxConstraints(minWidth: 320, maxWidth: 480),
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Flavor Studio',
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(color: Colors.white),
                  ),
                  Text(
                    'The manager for your Flavor projects all in one place.',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            // child: CustomPaint(
            //   painter: FlavorGradientPainter(
            //     strokeWidth: 3,
            //     radius: 20,
            //   ),
            child: Container(
              child: AnimatedContainer(
                decoration: BoxDecoration(
                  border: new Border.all(
                      color: Colors.transparent,
                      width: 5.0,
                      style: BorderStyle.solid),
                  borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.white.withOpacity(0.1),
                  //     spreadRadius: 5,
                  //     blurRadius: 7,
                  //     offset: Offset(0, 3), // changes position of shadow
                  //   ),
                  // ],
                ),
                duration: Duration(milliseconds: 1000),
                constraints: BoxConstraints(minWidth: 320, maxWidth: 580),
                padding: EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: EmailLoginFormView(
                    onBoardFormLoginKey: onBoardFormLoginKey,
                    usernameTextController: usernameTextController!,
                    passwordTextController: passwordTextController!,
                    scaffoldKey: scaffoldKey!,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
