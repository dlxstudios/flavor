import 'package:flutter/material.dart';

class EmailLoginFormView extends StatefulWidget {
  const EmailLoginFormView({
    Key? key,
    this.scaffoldKey,
    this.onPressedLoginEmail,
    this.onBoardFormLoginKey,
    this.usernameTextController,
    this.passwordTextController,
  }) : super(key: key);

  final GlobalKey<FormState>? onBoardFormLoginKey;
  final TextEditingController? usernameTextController;
  final TextEditingController? passwordTextController;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  final Future Function(String email, String password)? onPressedLoginEmail;

  @override
  _EmailLoginFormViewState createState() => _EmailLoginFormViewState();
}

class _EmailLoginFormViewState extends State<EmailLoginFormView> {
  bool isBusy = false;
  var loginError;
  bool _rememberMe = false;

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
      await widget.onPressedLoginEmail!(widget.usernameTextController!.text,
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
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Sign In',
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              // SizedBox(height: 16.0),
              _buildEmailTF(),
              SizedBox(
                height: 8.0,
              ),
              _buildPasswordTF(),
              SizedBox(
                height: 8.0,
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(child: _buildRememberMeCheckbox()),
                    Flexible(child: _buildForgotPasswordBtn()),
                  ],
                ),
              ),
              _buildLoginBtn(),
              // _buildSignInWithText(),
              // _buildSocialBtnRow(),
              // _buildSignupBtn(),
            ],
          ),
        ),
      ),
    );

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
                  isDense: true,
                ),
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

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Text(
        //   'Email',
        //   style: kLabelStyle,
        // ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          // decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: widget.usernameTextController,
            keyboardType: TextInputType.emailAddress,

            // style: TextStyle(
            //     // color: Colors.white,
            //     // fontFamily: 'OpenSans',
            //     ),
            decoration: InputDecoration(
              // border: InputBorder.none,
              border: OutlineInputBorder(),
              // contentPadding: EdgeInsets.only(top: 9.0),
              contentPadding: EdgeInsets.only(top: 14.0),

              prefixIcon: Icon(
                Icons.email,
                // color: Colors.white,
              ),
              hintText: 'Enter your Email',
              // hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Text(
        //   'Password',
        //   style: kLabelStyle,
        // ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          // decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: widget.passwordTextController,
            obscureText: true,
            // style: TextStyle(
            //     // color: Colors.white,
            //     // fontFamily: 'OpenSans',
            //     ),
            decoration: InputDecoration(
              // border: InputBorder.none,
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                // color: Colors.white,
              ),
              hintText: 'Enter your Password',
              // hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        // padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Forgot Password?',
          // style: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),

      // height: 20.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.black87),
            child: Checkbox(
              value: _rememberMe,
              // checkColor: Colors.green,
              // activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value!;
                });
              },
            ),
          ),
          Text(
            'Remember me',
            style: Theme.of(context).textTheme.bodyText2,
            // style: kLabelStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 32),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: widget.onPressedLoginEmail != null ? _formLogin : null,
        child: Text(
          'LOGIN',
          style: TextStyle(
            // color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSignInWithText() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Text(
            '- OR -',
            style: TextStyle(
              // color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            'Sign in with',
            // style: kLabelStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildSocialBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialBtnRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSocialBtn(
            () => print('Login with Apple'),
            AssetImage(
              'assets/logos/google.jpg',
            ),
          ),
          _buildSocialBtn(
            () => print('Login with Facebook'),
            AssetImage(
              'assets/logos/facebook.jpg',
            ),
          ),
          _buildSocialBtn(
            () => print('Login with Google'),
            AssetImage(
              'assets/logos/google.jpg',
            ),
          ),
          _buildSocialBtn(
            () => print('Login with Yelp'),
            AssetImage(
              'assets/logos/google.jpg',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () => print('Sign Up Button Pressed'),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                // color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                // color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
