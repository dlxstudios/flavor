import 'package:flavor_client/colors.dart';
import 'package:flavor_client/components/FlavorButton.dart';
import 'package:flavor_auth/src/models/user.dart';

import 'package:flutter/material.dart';

class EmailSignUpFormView extends StatefulWidget {
  const EmailSignUpFormView({
    Key? key,
    this.onBoardFormSignUpKey,
    this.usernameTextController,
    this.passwordTextController,
    this.repasswordTextController,
    this.onEmailSignup,
  }) : super(key: key);

  final GlobalKey<FormState>? onBoardFormSignUpKey;
  final TextEditingController? usernameTextController;
  final TextEditingController? passwordTextController;
  final TextEditingController? repasswordTextController;

  final Future<FlavorUser> Function(
      String email, String password, String passwordReEnter)? onEmailSignup;

  @override
  _EmailSignUpFormViewState createState() => _EmailSignUpFormViewState();
}

class _EmailSignUpFormViewState extends State<EmailSignUpFormView> {
  bool isBusy = false;

  var loginError;

  void _formSignup() async {
    setState(() {
      isBusy = true;
      loginError = null;
    });

    try {
      // await Future.delayed(Duration(seconds: 2));
      await widget.onEmailSignup!(
              widget.usernameTextController!.text,
              widget.passwordTextController!.text,
              widget.usernameTextController!.text)
          .catchError((error) {
        // showSnackBarError(error);
        setState(() {
          isBusy = false;
        });
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

  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.onBoardFormSignUpKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Text(
              //   'Sign Up',
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
                enabled: isBusy,
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
                validator: (txt) {
                  Pattern pattern = r'(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)';
                  RegExp regex = new RegExp(pattern.toString());
                  if (!regex.hasMatch(txt.toString()))
                    return 'Must be over 8 charaters or longer, containing 1 Lowercase character, 1 Uppercase character, 1 Digit, and 1 Symbol !';
                  else
                    return null;
                },
                cursorColor: Colors.white,
                cursorRadius: Radius.circular(32.0),
                cursorWidth: 1.0,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Colors.white),
                textInputAction: TextInputAction.done,
                enabled: isBusy,
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
              TextFormField(
                validator: (txt) {
                  // print(txt == passwordTextController.text);
                  return txt == widget.passwordTextController!.text
                      ? null
                      : 'Password field do not match!';
                },
                cursorColor: Colors.white,
                cursorRadius: Radius.circular(32.0),
                cursorWidth: 1.0,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Colors.white),
                textInputAction: TextInputAction.done,
                enabled: isBusy,
                controller: widget.repasswordTextController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Re-enter Password',
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
                        Text('Have an account already?  '),
                        Text(
                          'Login',
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
                  //           if (widget.onBoardFormSignUpKey.currentState
                  //               .validate()) {
                  //             _formSignup();
                  //           }
                  //         },
                  //   strokeWidth: 2,
                  //   radius: 16,
                  //   gradient: LinearGradient(
                  //     colors: [cYellow, cRed, cBlue, cGreen, cPurple],
                  //     begin: Alignment.centerLeft,
                  //     end: Alignment.centerRight,
                  //   ),
                  //   child: Text('Signup',
                  //       style: Theme.of(context)
                  //           .textTheme
                  //           .button
                  //           .copyWith(color: Colors.white)),
                  // ),
                  ElevatedButton(
                    onPressed: isBusy
                        ? null
                        : () {
                            if (widget.onBoardFormSignUpKey!.currentState!
                                .validate()) {
                              _formSignup();
                            }
                          },
                    child: Text('Signup',
                        style: Theme.of(context)
                            .textTheme
                            .button!
                            .copyWith(color: Colors.white)),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
