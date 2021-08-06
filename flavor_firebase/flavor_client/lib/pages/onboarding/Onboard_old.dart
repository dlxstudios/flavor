// import 'package:flavor/colors.dart';
// import 'package:flavor/components/FlavorButton.dart';
// // ignore: implementation_imports
// import 'package:flavor_auth/src/models/user.dart';

// // import 'package:flavor/utilities/FlavorAuth.dart';
// import 'package:flavor/utilities/services.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flavor/components/Tiles.dart';

// class FlavorPageOnBoarding extends StatefulWidget {
//   final String navigateToNamed;
//   final Widget child;

//   const FlavorPageOnBoarding({
//     Key key,
//     this.navigateToNamed,
//     this.child,
//   }) : super(key: key);
//   @override
//   _FlavorPageOnBoardingState createState() => _FlavorPageOnBoardingState();
// }

// class _FlavorPageOnBoardingState extends State<FlavorPageOnBoarding> {
//   var loginError;
//   bool notBusy = true;
//   var signinError;
//   GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

//   PageController _formPageViewController = PageController(
//     initialPage: 0,
//     keepPage: false,
//   );

//   final _onBoardFormLoginKey = GlobalKey<FormState>();
//   final _onBoardFormSignUpKey = GlobalKey<FormState>();
//   final _passwordTextController = TextEditingController(text: 'golucky6');
//   final _repasswordTextController = TextEditingController(text: 'golucky66');
//   final _usernameTextController = TextEditingController(
//     text: 'ben@guy.com',
//   );

//   @override
//   void dispose() {
//     // Clean up the controller when the widget is removed from the
//     // widget tree.
//     _usernameTextController.dispose();
//     _passwordTextController.dispose();
//     _repasswordTextController.dispose();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     // cTODO: implement initState
//     super.initState();
//   }

//   void formPage(int i) {
//     _formPageViewController.animateToPage(i,
//         duration: Duration(milliseconds: 600), curve: Curves.ease);
//     // print(_formPageViewController.page.toDouble().toString());
//   }

//   Widget buildBody(bool showLeftColumn) {
//     // log.e(Provider.of<FlavorAppState>(context).appModel);
//     return Container(
//       // color: Colors.red,
//       // width: 350,
//       // height: 600,
//       // padding: EdgeInsets.all(20),
//       child: Material(
//         // color: Colors.purpleAccent,
//         clipBehavior: Clip.antiAlias,
//         borderRadius: BorderRadius.all(Radius.circular(12)),
//         elevation: showLeftColumn ? 8 : 0,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             /// ! Logo

//             Stack(
//               children: <Widget>[
//                 CustomPaint(
//                   child: Container(
//                     // color: Colors.lime.withOpacity(.3),
//                     height: 120.0,
//                   ),
//                   painter: SauceDrip(color: Theme.of(context).accentColor),
//                 ),
//                 Center(
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Text(
//                       'Flavor',
//                       style: Theme.of(context).primaryTextTheme.headline4,
//                     ),
//                   ),
//                 )
//               ],
//             ),

//             // /// ! signup/signin pager
//             Flexible(
//               flex: 1,
//               child: Container(
//                 // height: 360,
//                 // width: 300,
//                 child: PageView(
//                   controller: _formPageViewController,
//                   scrollDirection: Axis.horizontal,
//                   pageSnapping: true,
//                   children: <Widget>[
//                     buildFormLogin(),
//                     buildFormSignUp(),
//                   ],
//                 ),
//               ),
//             ),

//             /// ! signin services footer

//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: <Widget>[
//                   // TextButton(
//                   //   color: Colors.red,
//                   //   onPressed: notBusy
//                   //       ? () {
//                   //           notBusy = false;
//                   //           Provider.of<FlavorAppState>(context)
//                   //               .googleSignIn()
//                   //               .then((value) =>
//                   //                   Future.delayed(Duration(seconds: 3)))
//                   //               .then((value) => setState(() {
//                   //                     notBusy = true;
//                   //                   }))
//                   //               .catchError((e) {
//                   //             print('ERROR : googleSignIn : $e');
//                   //             setState(() {
//                   //               notBusy = true;
//                   //             });
//                   //           });
//                   //           // print('Google button pressed');
//                   //         }
//                   //       : null,
//                   //   child: Text(
//                   //     'Google',
//                   //     style: TextStyle(color: Colors.white),
//                   //   ),
//                   // ),
//                   TextButton(
//                       onPressed: () {},
//                       child: Row(
//                         children: [
//                           Icon(Icons.contact_phone),
//                           Padding(
//                             padding: const EdgeInsets.only(left: 8.0),
//                             child: Text('Contact Support'),
//                           )
//                         ],
//                       )),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildFormSignUp() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Form(
//         key: _onBoardFormSignUpKey,
//         child: ListView(
//           children: <Widget>[
//             // Center(
//             //   child: Text(
//             //     'Sign Up',
//             //     style: TextStyle(
//             //       fontSize: 26,
//             //       fontWeight: FontWeight.w900,
//             //     ),
//             //   ),
//             // ),

//             signinError != null
//                 ? Center(
//                     child: Text(
//                       '$signinError',
//                       maxLines: 1,
//                       style: TextStyle(
//                         color: Colors.redAccent,
//                         fontSize: 10,
//                         fontWeight: FontWeight.w900,
//                       ),
//                     ),
//                   )
//                 : Container(
//                     height: 20,
//                   ),

//             // SizedBox(
//             //   height: 10,
//             // ),

//             /// Fields
//             Padding(
//               padding: const EdgeInsets.all(0.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: <Widget>[
//                   // Username BOX

//                   Material(
//                     clipBehavior: Clip.antiAlias,
//                     borderRadius: BorderRadius.all(Radius.circular(10)),
//                     // elevation: 5,
//                     child: Container(
//                       // padding: EdgeInsets.symmetric(horizontal: 10),
//                       child: TextFormField(
//                         enabled: notBusy,
//                         controller: _usernameTextController,
//                         validator: (txt) {
//                           // print(txt);
//                           return null;
//                         },
//                         style: TextStyle(),
//                         decoration: InputDecoration(
//                           labelText: 'Username',
//                           // border: InputBorder.none,
//                         ),
//                       ),
//                     ),
//                   ),

//                   SizedBox(
//                     height: 16,
//                   ),
//                   // Password BOX
//                   Material(
//                     clipBehavior: Clip.antiAlias,
//                     borderRadius: BorderRadius.all(Radius.circular(10)),
//                     // elevation: 5,
//                     child: Container(
//                       // padding: EdgeInsets.symmetric(horizontal: 10),
//                       child: TextFormField(
//                         enabled: notBusy,
//                         controller: _passwordTextController,
//                         obscureText: true,
//                         style: TextStyle(),
//                         decoration: InputDecoration(
//                           labelText: 'Password',
//                           // border: InputBorder.none,
//                         ),
//                       ),
//                     ),
//                   ),

//                   // Password TWOOO
//                   SizedBox(
//                     height: 16,
//                   ),
//                   Material(
//                     clipBehavior: Clip.antiAlias,
//                     borderRadius: BorderRadius.all(Radius.circular(10)),
//                     // elevation: 5,
//                     child: Container(
//                       // padding: EdgeInsets.symmetric(horizontal: 10),
//                       child: TextFormField(
//                         enabled: notBusy,
//                         autovalidate: true,
//                         controller: _repasswordTextController,
//                         obscureText: true,
//                         style: TextStyle(),
//                         validator: (txt) {
//                           // print(txt == _passwordTextController.text);
//                           return txt == _passwordTextController.text
//                               ? null
//                               : 'Password field do not match!';
//                         },
//                         decoration: InputDecoration(
//                           labelText: 'Re-enter Password',
//                           // border: InputBorder.none,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             SizedBox(
//               height: 20,
//             ),

//             // Login Button
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 TextButton(
//                   onPressed: !notBusy
//                       ? null
//                       : () {
//                           formPage(0);
//                         },
//                   child: Row(
//                     children: <Widget>[
//                       Text('Already a user?  '),
//                       Text(
//                         'Login',
//                         style: TextStyle(color: Theme.of(context).accentColor),
//                       )
//                     ],
//                   ),
//                 ),
//                 ElevatedButton(
//                   // color: Theme.of(context).accentColor,
//                   // colorBrightness: Brightness.dark,
//                   onPressed: !notBusy
//                       ? null
//                       : () {
//                           if (_onBoardFormSignUpKey.currentState.validate()) {
//                             _formSignup();
//                           }
//                         },
//                   child: Text('Signup'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildFormLogin() {
//     return Container(
//       // width: 480,
//       // color: Colors.lime,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: Form(
//           key: _onBoardFormLoginKey,
//           child: ListView(
//             shrinkWrap: true,
//             children: <Widget>[
//               // SizedBox(
//               //   height: 20,
//               // ),
//               // Center(
//               //   child: Text(
//               //     'Login',
//               //     style: TextStyle(
//               //       fontSize: 26,
//               //       fontWeight: FontWeight.w300,
//               //     ),
//               //   ),
//               // ),

//               loginError != null
//                   ? Center(
//                       child: Text(
//                         '$loginError',
//                         maxLines: 1,
//                         style: TextStyle(
//                           color: Colors.redAccent,
//                           fontSize: 10,
//                           fontWeight: FontWeight.w900,
//                         ),
//                       ),
//                     )
//                   : Container(
//                       height: 20,
//                     ),

//               // SizedBox(
//               //   height: 10,
//               // ),

//               /// Fields
//               Padding(
//                 padding: const EdgeInsets.all(0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: <Widget>[
//                     // Username BOX

//                     Material(
//                       clipBehavior: Clip.antiAlias,
//                       borderRadius: BorderRadius.all(Radius.circular(10)),
//                       // elevation: 5,
//                       child: Container(
//                         // padding: EdgeInsets.symmetric(horizontal: 10),
//                         child: TextFormField(
//                           enabled: notBusy,
//                           controller: _usernameTextController,
//                           validator: (txt) {
//                             // print(txt);
//                             return null;
//                           },
//                           style: TextStyle(),
//                           decoration: InputDecoration(
//                             labelText: 'Username',
//                             // border: InputBorder.none,
//                           ),
//                         ),
//                       ),
//                     ),

//                     SizedBox(
//                       height: 16,
//                     ),
//                     // Password BOX
//                     Material(
//                       clipBehavior: Clip.antiAlias,
//                       borderRadius: BorderRadius.all(Radius.circular(10)),
//                       // elevation: 5,
//                       child: Container(
//                         // padding: EdgeInsets.symmetric(horizontal: 10),
//                         child: TextFormField(
//                           enabled: notBusy,
//                           controller: _passwordTextController,
//                           obscureText: true,
//                           style: TextStyle(),
//                           decoration: InputDecoration(
//                             labelText: 'Password',
//                             // border: InputBorder.none,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),

//               Container(
//                 // color: Colors.purple,
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     // Forgot Password

//                     TextButton(
//                       // color: Colors.red,
//                       // textColor: Colors.red,
//                       onPressed: !notBusy ? null : () {},
//                       child: Text('forgot password'),
//                     ),

//                     // Login Button
//                     ElevatedButton(
//                       // color: Theme.of(context).accentColor,
//                       // colorBrightness: Brightness.dark,
//                       onPressed: !notBusy
//                           ? null
//                           : () {
//                               if (_onBoardFormLoginKey.currentState
//                                   .validate()) {
//                                 _formLogin();
//                               }
//                             },
//                       child: Text('LOGIN'),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),

//               // SignUp Button
//               TextButton(
//                 onPressed: !notBusy
//                     ? null
//                     : () {
//                         formPage(1);
//                       },
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: <Widget>[
//                     Text('New user? '),
//                     Text(
//                       'Signup',
//                       style: TextStyle(color: Theme.of(context).accentColor),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _formSignup() async {
//     setState(() {
//       notBusy = false;
//       loginError = null;
//     });
//     // var error = await Provider.of<FlavorAuthStateOld>(context)
//     //     .signInWithEmail(_usernameTextController.text, _passwordTextController.text);

//     // print(error);

//     setState(() {
//       notBusy = true;
//     });
//   }

//   void _formLogin() async {
//     setState(() {
//       notBusy = false;
//       loginError = null;
//     });

//     try {
//       var state; //= Provider.of<FlavorAuthStateOld>(context);

//       // await Future.delayed(Duration(seconds: 2));
//       await state
//           // .login(_usernameTextController.text, _passwordTextController.text)
//           .googleSignIn()
//           .catchError((error) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           // backgroundColor: Colors.redAccent,
//           duration: Duration(seconds: 60),
//           content: Row(
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.only(right: 16.0),
//                 child: Icon(
//                   Icons.error_outline,
//                   color: Colors.red,
//                 ),
//               ),
//               Text(error.toString()),
//             ],
//           ),
//           elevation: 8,
//           behavior: SnackBarBehavior.fixed,
//           action: SnackBarAction(
//               textColor: Colors.red, label: 'Send Error', onPressed: () {}),
//         ));

//         log.wtf(error);
//         setState(() {
//           // loginError = error['error']['message'];
//           notBusy = true;
//         });
//       }).then((_) => setState(() {
//                 // loginError = error['error']['message'];
//                 if (widget.navigateToNamed != null) {
//                   Navigator.pushNamedAndRemoveUntil(context,
//                       widget.navigateToNamed ?? '/home', (route) => false);
//                 }
//                 notBusy = true;
//               }));
//     } catch (error) {
//       setState(() {
//         // loginError = error['error']['message'];
//         notBusy = true;
//       });

//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         // backgroundColor: Colors.redAccent,
//         duration: Duration(seconds: 60),
//         content: Row(
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.only(right: 16.0),
//               child: Icon(
//                 Icons.error_outline,
//                 color: Colors.red,
//               ),
//             ),
//             Text(error.toString()),
//           ],
//         ),
//         elevation: 8,
//         behavior: SnackBarBehavior.fixed,
//         action: SnackBarAction(
//             textColor: Colors.red, label: 'Send Error', onPressed: () {}),
//       ));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // FlavorAppState state = Provider.of<FlavorAppState>(context);

//     return LayoutBuilder(builder: (context, size) {
//       // print('size.maxWidth : ${size.maxWidth}');
//       var _showLeftColumn = false;
//       var _width = size.maxWidth;
//       var children = [];

//       if (_width > 765) {
//         _showLeftColumn = true;
//       }

//       return Scaffold(
//         // body: SingleChildScrollView(child: Container(
//         //   height: 200,
//         //   width: 200,
//         //   color: Colors.blueGrey,
//         // )),
//         key: scaffoldKey,
//         body: Stack(
//           children: <Widget>[
//             SafeArea(
//               child: SingleChildScrollView(
//                 child: Container(
//                   padding: _showLeftColumn
//                       ? EdgeInsets.only(
//                           top: 16, left: 16, right: 16, bottom: 16)
//                       : null,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       _showLeftColumn
//                           ? Flexible(
//                               flex: 1,
//                               child: Container(
//                                 // color: Colors.orange,
//                                 // height: 800,
//                                 // width: 350,
//                                 padding: EdgeInsets.all(20),
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     Text('Easy Content and App Management',
//                                         style: Theme.of(context)
//                                             .textTheme
//                                             .headline3
//                                         // .copyWith(
//                                         //   color: Colors.amber,
//                                         // ),
//                                         ),
//                                     Text(
//                                       'Description Text Here. Description Text Here. Description Text Here. vDescription Text Here. ',
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .bodyText1
//                                           .copyWith(fontSize: 22),

//                                       // .copyWith(color: Colors.amber),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             )
//                           : Container(),
//                       Flexible(
//                           flex: 1,
//                           child: Container(
//                               padding: _showLeftColumn
//                                   ? EdgeInsets.all(30)
//                                   : EdgeInsets.only(
//                                       top: 80, left: 16, right: 16, bottom: 24),
//                               // opacity: 1, // !notBusy ? .3 : 1,
//                               // duration: Duration(milliseconds: 1300),
//                               // curve: Curves.ease,
//                               child: buildBody(_showLeftColumn))),
//                     ],
//                   ),
//                   height: size.maxHeight,
//                   width: size.minWidth,
//                 ),
//               ),
//             ),
//             !notBusy
//                 ? Positioned.fill(child: ShimmerPlaceholder())
//                 : Container()
//           ],
//         ),
//       );
//     });
//   }
// }

// class SauceDrip extends CustomPainter {
//   final Color color;

//   SauceDrip({this.color});
//   @override
//   void paint(Canvas canvas, Size size) {
//     Path path = Path();
//     Paint paint = Paint();

//     path = Path();
//     path.lineTo(0, size.height * 0.75);
//     path.quadraticBezierTo(size.width * 0.10, size.height * 0.55,
//         size.width * 0.22, size.height * 0.70);
//     path.quadraticBezierTo(size.width * 0.30, size.height * 0.90,
//         size.width * 0.40, size.height * 0.75);
//     path.quadraticBezierTo(size.width * 0.52, size.height * 0.50,
//         size.width * 0.65, size.height * 0.70);
//     path.quadraticBezierTo(
//         size.width * 0.75, size.height * 0.85, size.width, size.height * 0.60);
//     path.lineTo(size.width, 0);
//     path.close();

//     paint.color = color;
//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return oldDelegate != this;
//   }
// }

// // extension on Scaffold {

// // void sf(){

// // }

// // }

// class PageOnboarding extends StatefulWidget {
//   final String title;
//   final String description;
//   final Future Function(String email, String password) onEmailLogin;
//   final Future<FlavorUser> Function(
//       String email, String password, String passwordReEnter) onEmailSignup;

//   PageOnboarding({
//     Key key,
//     this.onEmailLogin,
//     this.onEmailSignup,
//     this.title,
//     this.description,
//   }) : super(key: key);

//   @override
//   _PageOnboardingState createState() => _PageOnboardingState();
// }

// class _PageOnboardingState extends State<PageOnboarding> {
//   var loginError;
//   bool notBusy = true;
//   var signinError;

//   final _onBoardFormLoginKey = GlobalKey<FormState>();
//   final _onBoardFormSignUpKey = GlobalKey<FormState>();
//   final _passwordTextController = TextEditingController(text: 'golucky6');
//   final _repasswordTextController = TextEditingController(text: 'golucky66');
//   final _usernameTextController = TextEditingController(
//     text: 'ben@guy.com',
//   );

//   GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

//   Widget _endDrawer;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: flavorThemeMaterial,
//       // color: Colors.purple,
//       home: Scaffold(
//         key: scaffoldKey,
//         endDrawer: _endDrawer,
//         body: Padding(
//           padding: const EdgeInsets.all(56.0),
//           child: Row(
//             children: <Widget>[
//               Flexible(
//                 flex: 1,
//                 child: Container(
//                   // color: Colors.redAccent,
//                   constraints: BoxConstraints(minWidth: 320, maxWidth: 480),
//                   padding: EdgeInsets.symmetric(horizontal: 24),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Text(
//                         widget.title == null ? 'Flavor App' : widget.title,
//                         style: Theme.of(context)
//                             .textTheme
//                             .headline3
//                             .copyWith(color: Colors.white),
//                       ),
//                       Text(
//                         widget.description == null
//                             ? 'Application description.'
//                             : widget.description,
//                         style: Theme.of(context)
//                             .textTheme
//                             .headline6
//                             .copyWith(color: Colors.white),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Flexible(
//                 flex: 1,
//                 // child: CustomPaint(
//                 //   painter: FlavorGradientPainter(
//                 //     strokeWidth: 3,
//                 //     radius: 20,
//                 //   ),
//                 child: Container(
//                   child: AnimatedContainer(
//                     decoration: BoxDecoration(
//                       border: new Border.all(
//                           color: Colors.transparent,
//                           width: 5.0,
//                           style: BorderStyle.solid),
//                       borderRadius:
//                           new BorderRadius.all(new Radius.circular(20.0)),
//                       // boxShadow: [
//                       //   BoxShadow(
//                       //     color: Colors.white.withOpacity(0.1),
//                       //     spreadRadius: 5,
//                       //     blurRadius: 7,
//                       //     offset: Offset(0, 3), // changes position of shadow
//                       //   ),
//                       // ],
//                     ),
//                     duration: Duration(milliseconds: 1000),
//                     constraints: BoxConstraints(minWidth: 320, maxWidth: 580),
//                     padding: EdgeInsets.all(16),
//                     child: Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: buildFormLogin(context),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildFormLogin(BuildContext context) {
//     return Form(
//         key: _onBoardFormLoginKey,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             Text(
//               'Login',
//               style: Theme.of(context)
//                   .textTheme
//                   .headline5
//                   .copyWith(color: Colors.white),
//             ),
//             TextFormField(
//               cursorColor: Colors.white,
//               cursorRadius: Radius.circular(16.0),
//               cursorWidth: 1.0,
//               style: Theme.of(context)
//                   .textTheme
//                   .headline5
//                   .copyWith(color: Colors.white),
//               keyboardType: TextInputType.emailAddress,
//               // textInputAction: TextInputAction.continueAction,
//               // autofocus: true,
//               enabled: notBusy,
//               controller: _usernameTextController,
//               decoration: InputDecoration(
//                   labelText: 'Email',
//                   labelStyle: Theme.of(context)
//                       .textTheme
//                       .headline5
//                       .copyWith(color: Colors.white),
//                   isDense: true),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             TextFormField(
//               cursorColor: Colors.white,
//               cursorRadius: Radius.circular(32.0),
//               cursorWidth: 1.0,
//               style: Theme.of(context)
//                   .textTheme
//                   .headline5
//                   .copyWith(color: Colors.white),
//               textInputAction: TextInputAction.done,
//               enabled: notBusy,
//               controller: _passwordTextController,
//               obscureText: true,
//               decoration: InputDecoration(
//                 labelText: 'Password',
//                 labelStyle: Theme.of(context)
//                     .textTheme
//                     .headline5
//                     .copyWith(color: Colors.white),
//                 isDense: true,
//                 border: const UnderlineInputBorder(
//                   borderSide: BorderSide(
//                     color: Colors.red,
//                   ),
//                 ),
//               ),
//             ),
//             Spacer(),
//             Row(
//               children: <Widget>[
//                 TextButton(
//                   onPressed: !notBusy
//                       ? null
//                       : () {
//                           setAndOpenEndDrawer(
//                               buildFormSignUp(context), 'SignUp');
//                         },
//                   child: Row(
//                     children: <Widget>[
//                       Text('New to the game?  '),
//                       Text(
//                         'Signup',
//                         style: TextStyle(color: Theme.of(context).accentColor),
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: <Widget>[
//                 Flexible(
//                     child: Row(children: <Widget>[
//                   IconButton(icon: Icon(Icons.access_alarm), onPressed: () {}),
//                   IconButton(icon: Icon(Icons.access_alarm), onPressed: () {}),
//                   IconButton(icon: Icon(Icons.access_alarm), onPressed: () {}),
//                   IconButton(icon: Icon(Icons.access_alarm), onPressed: () {}),
//                 ])),

//                 ElevatedButton(
//                   onPressed: !notBusy
//                       ? null
//                       : () {
//                           if (_onBoardFormLoginKey.currentState.validate()) {
//                             _formLogin();
//                           }
//                         },
//                   child: Text('login'),
//                 )
//                 // FlavorOutlineButton(
//                 //   onPressed: !notBusy
//                 //       ? null
//                 //       : () {
//                 //           if (_onBoardFormLoginKey.currentState.validate()) {
//                 //             _formLogin();
//                 //           }
//                 //         },
//                 //   strokeWidth: 2,
//                 //   radius: 16,
//                 //   gradient: LinearGradient(
//                 //     colors: [yellow, red, blue, green, purple],
//                 //     begin: Alignment.centerLeft,
//                 //     end: Alignment.centerRight,
//                 //   ),
//                 //   child: Text('Login',
//                 //       style: Theme.of(context)
//                 //           .textTheme
//                 //           .button
//                 //           .copyWith(color: Colors.white)),
//                 // ),
//               ],
//             )
//           ],
//         ));
//   }

//   Widget buildFormSignUp(BuildContext context) {
//     return Form(
//         key: _onBoardFormSignUpKey,
//         child: ListView(
//           // mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             SizedBox(
//               height: 30,
//             ),
//             TextFormField(
//               cursorColor: Colors.white,
//               cursorRadius: Radius.circular(16.0),
//               cursorWidth: 1.0,
//               style: Theme.of(context)
//                   .textTheme
//                   .headline5
//                   .copyWith(color: Colors.white),
//               keyboardType: TextInputType.emailAddress,
//               // textInputAction: TextInputAction.continueAction,
//               // autofocus: true,
//               enabled: notBusy,
//               controller: _usernameTextController,
//               decoration: InputDecoration(
//                   labelText: 'Email',
//                   labelStyle: Theme.of(context)
//                       .textTheme
//                       .headline5
//                       .copyWith(color: Colors.white),
//                   isDense: true),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             TextFormField(
//               validator: (txt) {
//                 Pattern pattern = r'(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)';
//                 RegExp regex = new RegExp(pattern);
//                 if (!regex.hasMatch(txt))
//                   return 'Must be over 8 charaters or longer, containing 1 Lowercase character, 1 Uppercase character, 1 Digit, and 1 Symbol !';
//                 else
//                   return null;
//               },
//               cursorColor: Colors.white,
//               cursorRadius: Radius.circular(32.0),
//               cursorWidth: 1.0,
//               style: Theme.of(context)
//                   .textTheme
//                   .headline5
//                   .copyWith(color: Colors.white),
//               textInputAction: TextInputAction.done,
//               enabled: notBusy,
//               controller: _passwordTextController,
//               obscureText: true,
//               decoration: InputDecoration(
//                 labelText: 'Password',
//                 labelStyle: Theme.of(context)
//                     .textTheme
//                     .headline5
//                     .copyWith(color: Colors.white),
//                 isDense: true,
//                 border: const UnderlineInputBorder(
//                   borderSide: BorderSide(
//                     color: Colors.red,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             TextFormField(
//               validator: (txt) {
//                 // print(txt == _passwordTextController.text);
//                 return txt == _passwordTextController.text
//                     ? null
//                     : 'Password field do not match!';
//               },
//               cursorColor: Colors.white,
//               cursorRadius: Radius.circular(32.0),
//               cursorWidth: 1.0,
//               style: Theme.of(context)
//                   .textTheme
//                   .headline5
//                   .copyWith(color: Colors.white),
//               textInputAction: TextInputAction.done,
//               enabled: notBusy,
//               controller: _repasswordTextController,
//               obscureText: true,
//               decoration: InputDecoration(
//                 labelText: 'Re-enter Password',
//                 labelStyle: Theme.of(context)
//                     .textTheme
//                     .headline5
//                     .copyWith(color: Colors.white),
//                 isDense: true,
//                 border: const UnderlineInputBorder(
//                   borderSide: BorderSide(
//                     color: Colors.red,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: <Widget>[
//                 Flexible(
//                     child: Row(children: <Widget>[
//                   IconButton(icon: Icon(Icons.access_alarm), onPressed: () {}),
//                   IconButton(icon: Icon(Icons.access_alarm), onPressed: () {}),
//                   IconButton(icon: Icon(Icons.access_alarm), onPressed: () {}),
//                   IconButton(icon: Icon(Icons.access_alarm), onPressed: () {}),
//                 ])),
//                 FlavorOutlineButton(
//                   onPressed: !notBusy
//                       ? null
//                       : () {
//                           if (_onBoardFormSignUpKey.currentState.validate()) {
//                             _formSignup();
//                           }
//                         },
//                   strokeWidth: 2,
//                   radius: 16,
//                   gradient: LinearGradient(
//                     colors: [cYellow, cRed, cBlue, cGreen, cPurple],
//                     begin: Alignment.centerLeft,
//                     end: Alignment.centerRight,
//                   ),
//                   child: Text('Signup',
//                       style: Theme.of(context)
//                           .textTheme
//                           .button
//                           .copyWith(color: Colors.white)),
//                 ),
//               ],
//             )
//           ],
//         ));
//   }

//   @override
//   void dispose() {
//     // Clean up the controller when the widget is removed from the
//     // widget tree.
//     _usernameTextController.dispose();
//     _passwordTextController.dispose();
//     _repasswordTextController.dispose();
//     super.dispose();
//   }

//   void _formLogin() async {
//     setState(() {
//       notBusy = false;
//       loginError = null;
//     });
//     // log.i('login');
//     // log.wtf(
//     //     '${_usernameTextController.text} - ${_passwordTextController.text}');

//     try {
//       // await Future.delayed(Duration(seconds: 2));
//       await widget
//           .onEmailLogin(
//               _usernameTextController.text, _passwordTextController.text)
//           .catchError((error) {
//         showSnackBarError(error);
//         setState(() {
//           notBusy = true;
//         });
//       }).then((_) => setState(() {
//                 notBusy = true;
//               }));
//     } catch (error) {
//       setState(() {
//         notBusy = true;
//       });
//       showSnackBarError(error);
//     }
//   }

//   void _formSignup() async {
//     setState(() {
//       notBusy = false;
//       loginError = null;
//     });
//     log.i('message');

//     try {
//       // await Future.delayed(Duration(seconds: 2));
//       await widget
//           .onEmailSignup(_usernameTextController.text,
//               _passwordTextController.text, _usernameTextController.text)
//           .catchError((error) {
//         showSnackBarError(error);
//         setState(() {
//           notBusy = true;
//         });
//       }).then((_) => setState(() {
//                 notBusy = true;
//               }));
//     } catch (error) {
//       setState(() {
//         notBusy = true;
//       });
//       showSnackBarError(error);
//     }
//   }

//   void showSnackBarError(dynamic error) {
//     Scaffold.of(context).showSnackBar(SnackBar(
//       // backgroundColor: Colors.redAccent,
//       duration: Duration(seconds: 60),
//       content: Row(
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.only(right: 16.0),
//             child: Icon(
//               Icons.error_outline,
//               color: Colors.red,
//             ),
//           ),
//           Text(error.toString()),
//         ],
//       ),
//       elevation: 8,
//       behavior: SnackBarBehavior.fixed,
//       action: SnackBarAction(
//           textColor: Colors.red, label: 'Send Error', onPressed: () {}),
//     ));
//   }

//   void setAndOpenEndDrawer(Widget child, [String title]) {
//     setState(() {
//       _endDrawer = Container(
//         constraints: BoxConstraints(
//           minWidth: 300,
//           maxWidth: 600,
//         ),
//         child: Scaffold(
//             appBar: AppBar(
//               title: Text(
//                 '$title',
//                 style: Theme.of(context)
//                     .textTheme
//                     .headline5
//                     .copyWith(color: Colors.white),
//               ),
//             ),
//             body: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 24),
//               child: child,
//             )),
//       );
//       // state.openEndDrawer();
//     });
//   }
// }
