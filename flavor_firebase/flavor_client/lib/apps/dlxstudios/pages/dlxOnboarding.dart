import 'package:flavor/components/page.dart';
// import 'package:flavor/utilities/FlavorAuth.dart';
import 'package:flutter/material.dart';
import 'package:flavor/components/tiles.dart';

class DLXOnboarding extends StatefulWidget {
  @override
  _DLXOnboardingState createState() => _DLXOnboardingState();
}

class _DLXOnboardingState extends State<DLXOnboarding> {
  var loginError;
  bool notBusy = true;
  var signinError;

  PageController _formPageViewController =
      PageController(initialPage: 0, keepPage: true);

  final _onBoardFormLoginKey = GlobalKey<FormState>();
  final _onBoardFormSignUpKey = GlobalKey<FormState>();
  final _passwordTextController = TextEditingController(text: 'golucky6');
  final _repasswordTextController = TextEditingController(text: 'golucky66');
  final _usernameTextController = TextEditingController(
    text: 'ben@guy.com',
  );

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _usernameTextController.dispose();
    _passwordTextController.dispose();
    _repasswordTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // cTODO: implement initState
    super.initState();
  }

  void formPage(int i) {
    _formPageViewController.animateToPage(i,
        duration: Duration(milliseconds: 600), curve: Curves.ease);
    // print(_formPageViewController.page.toDouble().toString());
  }

  Widget buildBody(bool showLeftColumn) {
    return Container(
      // color: Colors.red,
      // width: 350,
      // height: 800,
      // padding: EdgeInsets.all(20),
      child: Material(
        // color: Colors.purpleAccent,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.all(Radius.circular(12)),
        elevation: showLeftColumn ? 8 : 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            /// ! Logo

            Column(
              children: <Widget>[
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: LogoAssetImage(),
                )),
                Text(
                  'DLX Studios',
                  style: TextStyle(
                      color: Color(0xFFffbf00), fontSize: 36, fontFamily: ''),
                )
              ],
            ),

            // /// ! signup/signin pager
            Flexible(
              flex: 1,
              child: Container(
                // height: 360,
                // width: 300,
                child: PageView(
                  controller: _formPageViewController,
                  scrollDirection: Axis.horizontal,
                  pageSnapping: true,
                  children: <Widget>[
                    buildFormLogin(),
                    buildFormSignUp(),
                  ],
                ),
              ),
            ),

            /// ! signin services footer

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                TextButton(
                  onPressed: notBusy
                      ? () {
                          notBusy = false;
                          // Provider.of<FlavorAuthStateOld>(context)
                          //     .googleSignIn()
                          //     .then((value) =>
                          //         Future.delayed(Duration(seconds: 3)))
                          //     .then((value) => setState(() {
                          //           notBusy = true;
                          //         }))
                          //     .catchError((e) {
                          //   print('ERROR : googleSignIn : $e');
                          //   setState(() {
                          //     notBusy = true;
                          //   });
                          // });
                          // print('Google button pressed');
                        }
                      : null,
                  child: Text(
                    'Google',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Text('_contactText')
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFormSignUp() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: _onBoardFormSignUpKey,
        child: ListView(
          children: <Widget>[
            // Center(
            //   child: Text(
            //     'Sign Up',
            //     style: TextStyle(
            //       fontSize: 26,
            //       fontWeight: FontWeight.w900,
            //     ),
            //   ),
            // ),

            signinError != null
                ? Center(
                    child: Text(
                      '$signinError',
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  )
                : Container(
                    height: 20,
                  ),

            // SizedBox(
            //   height: 10,
            // ),

            /// Fields
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  // Username BOX

                  Material(
                    clipBehavior: Clip.antiAlias,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    // elevation: 5,
                    child: Container(
                      // padding: EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        enabled: notBusy,
                        controller: _usernameTextController,
                        validator: (txt) {
                          // print(txt);
                          return null;
                        },
                        style: TextStyle(),
                        decoration: InputDecoration(
                          labelText: 'Username',
                          // border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 16,
                  ),
                  // Password BOX
                  Material(
                    clipBehavior: Clip.antiAlias,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    // elevation: 5,
                    child: Container(
                      // padding: EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        enabled: notBusy,
                        controller: _passwordTextController,
                        obscureText: true,
                        style: TextStyle(),
                        decoration: InputDecoration(
                          labelText: 'Password',
                          // border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),

                  // Password TWOOO
                  SizedBox(
                    height: 16,
                  ),
                  Material(
                    clipBehavior: Clip.antiAlias,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    // elevation: 5,
                    child: Container(
                      // padding: EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        enabled: notBusy,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _repasswordTextController,
                        obscureText: true,
                        style: TextStyle(),
                        validator: (txt) {
                          // print(txt == _passwordTextController.text);
                          return txt == _passwordTextController.text
                              ? null
                              : 'Password field do not match!';
                        },
                        decoration: InputDecoration(
                          labelText: 'Re-enter Password',
                          // border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 20,
            ),

            // Login Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextButton(
                  onPressed: !notBusy
                      ? null
                      : () {
                          formPage(0);
                        },
                  child: Row(
                    children: <Widget>[
                      Text('Already a user?  '),
                      Text(
                        'Login',
                        style: TextStyle(color: Colors.amber),
                      )
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: !notBusy
                      ? null
                      : () {
                          if (_onBoardFormSignUpKey.currentState!.validate()) {
                            _formSignup();
                          }
                        },
                  child: Text('Signup'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFormLogin() {
    return Container(
      // width: 480,
      // color: Colors.lime,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _onBoardFormLoginKey,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              // SizedBox(
              //   height: 20,
              // ),
              // Center(
              //   child: Text(
              //     'Login',
              //     style: TextStyle(
              //       fontSize: 26,
              //       fontWeight: FontWeight.w300,
              //     ),
              //   ),
              // ),

              loginError != null
                  ? Center(
                      child: Text(
                        '$loginError',
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    )
                  : Container(
                      height: 20,
                    ),

              // SizedBox(
              //   height: 10,
              // ),

              /// Fields
              Padding(
                padding: const EdgeInsets.all(0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    // Username BOX

                    Material(
                      clipBehavior: Clip.antiAlias,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      // elevation: 5,
                      child: Container(
                        // padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          enabled: notBusy,
                          controller: _usernameTextController,
                          validator: (txt) {
                            // print(txt);
                            return null;
                          },
                          style: TextStyle(),
                          decoration: InputDecoration(
                            labelText: 'Username',
                            // border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 16,
                    ),
                    // Password BOX
                    Material(
                      clipBehavior: Clip.antiAlias,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      // elevation: 5,
                      child: Container(
                        // padding: EdgeInsets.symmetric(horizontal: 10),
                        child: TextFormField(
                          enabled: notBusy,
                          controller: _passwordTextController,
                          obscureText: true,
                          style: TextStyle(),
                          decoration: InputDecoration(
                            labelText: 'Password',
                            // border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),

              Container(
                // color: Colors.purple,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // Forgot Password

                    TextButton(
                      // color: Colors.red,
                      onPressed: !notBusy ? null : () {},
                      child: Text('forgot password'),
                    ),

                    // Login Button
                    ElevatedButton(
                      onPressed: !notBusy
                          ? null
                          : () {
                              if (_onBoardFormLoginKey.currentState!
                                  .validate()) {
                                _formLogin();
                              }
                            },
                      child: Text('LOGIN'),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),

              // SignUp Button
              TextButton(
                onPressed: !notBusy
                    ? null
                    : () {
                        formPage(1);
                      },
                child: Row(
                  children: <Widget>[
                    Text('New user? '),
                    Text(
                      'Signup',
                      style: TextStyle(color: Colors.amber),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _formSignup() async {
    setState(() {
      notBusy = false;
      loginError = null;
    });
    // ignore: unused_local_variable
    // var error = await Provider.of<FlavorAuthStateOld>(context).signInWithEmail(
    //     _usernameTextController.text, _passwordTextController.text);

    // print(error);

    setState(() {
      notBusy = true;
    });
  }

  void _formLogin() async {
    setState(() {
      notBusy = false;
      loginError = null;
    });

    await Future.delayed(Duration(seconds: 2));
    // ignore: unused_local_variable
    // var error = await Provider.of<FlavorAuthStateOld>(context)
    //     .signInWithEmail(
    //         _usernameTextController.text, _passwordTextController.text)
    //     .catchError((error) {
    //   setState(() {
    //     loginError = error['error']['message'];
    //     notBusy = true;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    // FlavorAppState state = Provider.of<FlavorAppState>(context);

    return LayoutBuilder(builder: (context, size) {
      // print('size.maxWidth : ${size.maxWidth}');
      var _showLeftColumn = false;
      var _width = size.maxWidth;
      // var children = [];

      if (_width > 765) {
        _showLeftColumn = true;
      }

      return PageShell(
        statusbarColor: Colors.transparent,
        child: Scaffold(
          // body: SingleChildScrollView(child: Container(
          //   height: 200,
          //   width: 200,
          //   color: Colors.blueGrey,
          // )),
          body: Stack(
            children: <Widget>[
              SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    padding: _showLeftColumn
                        ? EdgeInsets.only(
                            top: 16, left: 16, right: 16, bottom: 16)
                        : null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _showLeftColumn
                            ? Flexible(
                                flex: 1,
                                child: Container(
                                  // color: Colors.orange,
                                  // height: 800,
                                  // width: 350,
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text('Easy Content and App Management',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3
                                          // .copyWith(
                                          //   color: Colors.amber,
                                          // ),
                                          ),
                                      Text(
                                        'Description Text Here. Description Text Here. Description Text Here. vDescription Text Here. ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(fontSize: 22),

                                        // .copyWith(color: Colors.amber),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(),
                        Flexible(
                            flex: 1,
                            child: Container(
                                padding: _showLeftColumn
                                    ? EdgeInsets.all(30)
                                    : EdgeInsets.only(
                                        top: 80,
                                        left: 16,
                                        right: 16,
                                        bottom: 24),
                                // opacity: 1, // !notBusy ? .3 : 1,
                                // duration: Duration(milliseconds: 1300),
                                // curve: Curves.ease,
                                child: buildBody(_showLeftColumn))),
                      ],
                    ),
                    height: size.maxHeight,
                    width: size.minWidth,
                  ),
                ),
              ),
              !notBusy
                  ? Positioned.fill(
                      child: ShimmerPlaceholder(
                      child: Container(),
                    ))
                  : Container()
            ],
          ),
        ),
      );
    });
  }
}

class LogoAssetImage extends StatelessWidget {
  const LogoAssetImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage('assets/images/logo_top.png'),
      fit: BoxFit.fitHeight,
    );
  }
}
