import 'package:firebase_core/firebase_core.dart';
import 'package:flavor_client/components/page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FirebaseBootstrap extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Function _initialization = Firebase.initializeApp;

  final Widget child;

  FirebaseBootstrap({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization(),
      builder: (context, snapshot) {
        print('snapshot.connectionState - ${snapshot.connectionState}');
        print('snapshot.data - ${snapshot.data}');
        // Check for errors
        if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: PageError(
                errorCode: 500.toString(),
                msg: snapshot.error.toString(),
                title: 'Issue connecting to database',
              ),
            ),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return child;
        }

        // Otherwise, show something whilst waiting for initialization to complete
        // return Loading();

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: Center(
              child: Text('-_<LOADING>_-'),
            ),
          ),
        );
      },
    );
  }
}
