import 'package:flavor_auth/flavor_auth.dart';
import 'package:flavor_client/pages/onboarding/emailLogin_view.dart';
import 'package:flavor_client/pages/onboarding/emailSignup_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FlavorOnboardingV3 extends StatefulWidget {
  // final void Function()? onPressedLoginEmail;

  final Future Function(String email, String password)? onEmailLogin;
  final Future Function(String email, String password, String passwordReEnter)?
      onEmailSignup;

  final String? title;
  final String? description;
  final Widget? flexiableSpace;
  final ThemeData? themeData;
  //
  final String gApiKey;

  final bool isLoggedIn;

  const FlavorOnboardingV3({
    Key? key,
    // this.onPressedLoginEmail,
    this.onEmailLogin,
    this.onEmailSignup,
    this.title,
    this.description,
    this.flexiableSpace,
    this.themeData,
    required this.gApiKey,
    this.isLoggedIn = false,
  }) : super(key: key);

  @override
  _OnboardingV3State createState() => _OnboardingV3State();
}

class _OnboardingV3State extends State<FlavorOnboardingV3>
    with SingleTickerProviderStateMixin {
  bool notBusy = true;
  var signinError;

  final _onBoardFormLoginKey = GlobalKey<FormState>();
  final _onBoardFormSignUpKey = GlobalKey<FormState>();
  final _passwordTextController = TextEditingController();
  final _repasswordTextController = TextEditingController();
  final _usernameTextController = TextEditingController();

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  Widget? _endDrawer;

  TabController? _tabController;

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
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _usernameTextController.dispose();
    _passwordTextController.dispose();
    _repasswordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoggedIn) {
      return Center(
        child: Text('already logged in'),
      );
    }

    return Scaffold(
      // appBar: AppBar(),
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 600, minWidth: 320),
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Stack(
                children: <Widget>[
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    // decoration: BoxDecoration(
                    //   gradient: LinearGradient(
                    //     begin: Alignment.topLeft,
                    //     end: Alignment.bottomRight,
                    //     colors: [
                    //       Color(0xFFFDFDFD),
                    //       Color(0xFFFFDFDF),
                    //       Color(0xFFFFFFFF),
                    //       Color(0xFFFFFFFF),
                    //     ],
                    //     stops: [0.1, 0.4, 0.7, 0.9],
                    //   ),
                    // ),
                  ),
                  Container(
                    // height: double.infinity,
                    child: SafeArea(
                      child: SingleChildScrollView(
                        primary: true,
                        physics: AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                          // vertical: 16.0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 24,
                            ),
                            // AspectRatio(
                            //   aspectRatio: 4,
                            //   child: Image.asset('assets/images/logo.png'),
                            // ),
                            SizedBox(
                              height: 36,
                            ),
                            Container(
                              constraints: BoxConstraints(
                                minHeight: 340,
                                maxHeight: 460,
                                minWidth: 300,
                                maxWidth: 480,
                              ),
                              padding: const EdgeInsets.all(8.0),
                              child: TabBarView(
                                controller: _tabController,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(16),
                                    child: EmailLoginFormView(
                                      onBoardFormLoginKey: _onBoardFormLoginKey,
                                      usernameTextController:
                                          _usernameTextController,
                                      passwordTextController:
                                          _passwordTextController,
                                      scaffoldKey: scaffoldKey,
                                      onPressedLoginEmail:
                                          (email, password) async {
                                        if (widget.onEmailLogin != null) {
                                          await widget.onEmailLogin!(
                                              email, password);
                                        } else {
                                          await AuthenticationRepository(
                                            widget.gApiKey,
                                          ).loginEmail(email, password);
                                        }
                                      },
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(16),
                                    child: EmailSignUpFormView(
                                      onBoardFormSignUpKey:
                                          _onBoardFormSignUpKey,
                                      usernameTextController:
                                          _usernameTextController,
                                      passwordTextController:
                                          _passwordTextController,
                                      repasswordTextController:
                                          _repasswordTextController,
                                      onEmailSignup: (email, password,
                                          passwordReEnter) async {
                                        // if (widget.onEmailSignup == null) {
                                        //   // return Future.error(
                                        //   //     'onEmailSignup functions doesn\'t exists');
                                        //   // await AuthenticationRepository(
                                        //   //   widget.gApiKey,
                                        //   // ).signupEmail(
                                        //   //     email, password, passwordReEnter);
                                        // }

                                        if (widget.onEmailSignup != null) {
                                          await await widget.onEmailSignup!(
                                            _usernameTextController.text,
                                            _passwordTextController.text,
                                            _repasswordTextController.text,
                                          );
                                        } else {
                                          await AuthenticationRepository(
                                            widget.gApiKey,
                                          ).loginEmail(email, password);
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
