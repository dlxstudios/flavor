import 'package:flavor/colors.dart';
import 'package:flavor/components/FlavorButton.dart';
import 'package:flutter/material.dart';

class EmailLoginFormView extends StatefulWidget {
  const EmailLoginFormView({
    Key? key,
    this.scaffoldKey,
    this.onEmailLogin,
    this.onBoardFormLoginKey,
    this.usernameTextController,
    this.passwordTextController,
  }) : super(key: key);

  final GlobalKey<FormState>? onBoardFormLoginKey;
  final TextEditingController? usernameTextController;
  final TextEditingController? passwordTextController;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  final Future Function(String email, String password)? onEmailLogin;

  @override
  _EmailLoginFormViewState createState() => _EmailLoginFormViewState();
}

class _EmailLoginFormViewState extends State<EmailLoginFormView> {
  bool isBusy = false;
  var loginError;

  void _formLogin() async {
    setState(() {
      isBusy = true;
      loginError = null;
    });
    // log.i('login');
    // log.wtf(
    //     '${usernameTextController.text} - ${passwordTextController.text}');

    try {
      // await Future.delayed(Duration(seconds: 2));
      await widget.onEmailLogin!(widget.usernameTextController!.text,
              widget.passwordTextController!.text)
          .catchError((error) {
        // showSnackBarError(error);
        // setState(() {
        //   isBusy = true;
        // });
      }).then((_) => setState(() {
                isBusy = false;
              }));
    } catch (error) {
      setState(() {
        isBusy = false;
      });
      // showSnackBarError(error);
    }
  }

  void setAndOpenEndDrawer(ScaffoldState state, Widget child, [String? title]) {
    setState(() {
      // _endDrawer = Container(
      //   constraints: BoxConstraints(
      //     minWidth: 300,
      //     maxWidth: 600,
      //   ),
      //   child: Scaffold(
      //       appBar: AppBar(
      //         title: Text(
      //           '$title',
      //           style: Theme.of(context)
      //               .textTheme
      //               .bodyText2
      //               .copyWith(color: Colors.white),
      //         ),
      //       ),
      //       body: Padding(
      //         padding: EdgeInsets.symmetric(horizontal: 24),
      //         child: child,
      //       )),
      // );
      state.openEndDrawer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.onBoardFormLoginKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // Text(
              //   'Login',
              //   style: Theme.of(context)
              //       .textTheme
              //       .headline4
              //       .copyWith(color: Colors.white),
              // ),
              // Spacer(),

              SizedBox(
                height: 16,
              ),
              TextFormField(
                cursorColor: Colors.white,
                cursorRadius: Radius.circular(16.0),
                cursorWidth: 1.0,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Colors.white),
                keyboardType: TextInputType.emailAddress,
                // textInputAction: TextInputAction.continueAction,
                // autofocus: true,
                enabled: !isBusy,
                controller: widget.usernameTextController,
                decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(color: Colors.white),
                    isDense: true),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                cursorColor: Colors.white,
                cursorRadius: Radius.circular(32.0),
                cursorWidth: 1.0,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Colors.white),
                textInputAction: TextInputAction.done,
                enabled: !isBusy,
                controller: widget.passwordTextController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: Colors.white),
                  isDense: true,
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: isBusy
                        ? null
                        : () {
                            // setAndOpenEndDrawer(
                            //     widget.ScaffoldMessenger.of(context),
                            //     EmailSignUpFormView(
                            //         onBoardFormSignUpKey: onBoardFormSignUpKey,
                            //         isBusy: isBusy,
                            //         usernameTextController:
                            //             usernameTextController,
                            //         passwordTextController:
                            //             passwordTextController,
                            //         repasswordTextController:
                            //             _repasswordTextController),
                            //     'SignUp');
                          },
                    child: Row(
                      children: <Widget>[
                        Text('New to the game?  '),
                        Text(
                          'Signup',
                          style:
                              TextStyle(color: Theme.of(context).accentColor),
                        )
                      ],
                    ),
                  ),
                  // FlavorOutlineButton(
                  //   onPressed: !isBusy
                  //       ? null
                  //       : () {
                  //           if (widget.onBoardFormLoginKey.currentState
                  //               .validate()) {
                  //             _formLogin();
                  //           }
                  //         },
                  //   strokeWidth: 2,
                  //   radius: 16,
                  //   gradient: LinearGradient(
                  //     colors: [cYellow, cRed, cBlue, cGreen, cPurple],
                  //     begin: Alignment.centerLeft,
                  //     end: Alignment.centerRight,
                  //   ),
                  //   child: Text('Login',
                  //       style: Theme.of(context)
                  //           .textTheme
                  //           .button
                  //           .copyWith(color: Colors.white)),
                  // ),

                  ElevatedButton(
                    onPressed: isBusy
                        ? null
                        : () {
                            if (widget.onBoardFormLoginKey!.currentState!
                                .validate()) {
                              _formLogin();
                            }
                          },
                    child: Text('Login',
                        style: Theme.of(context)
                            .textTheme
                            .button!
                            .copyWith(color: Colors.white)),
                  )
                ],
              ),

              // /// Providers
              // Spacer(),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: <Widget>[
              //     Flexible(
              //         child: Row(children: <Widget>[
              //       IconButton(icon: Icon(Icons.access_alarm), onPressed: () {}),
              //       IconButton(icon: Icon(Icons.access_alarm), onPressed: () {}),
              //       IconButton(icon: Icon(Icons.access_alarm), onPressed: () {}),
              //       IconButton(icon: Icon(Icons.access_alarm), onPressed: () {}),
              //     ])),

              //     // ElevatedButton(
              //     //   onPressed: isBusy
              //     //       ? null
              //     //       : () {
              //     //           if (widget.onBoardFormLoginKey.currentState
              //     //               .validate()) {
              //     //             // _formLogin();
              //     //           }
              //     //         },
              //     //   child: Text('login'),
              //     // )
              //   ],
              // ),
              // Spacer(),
            ],
          ),
        ));
  }
}
