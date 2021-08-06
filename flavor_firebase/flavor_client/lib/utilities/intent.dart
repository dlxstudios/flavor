import 'dart:async';

import 'package:flutter/material.dart';

import 'package:uni_links/uni_links.dart';

class IntentLink extends StatefulWidget {
  const IntentLink({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  _IntentLinkState createState() => _IntentLinkState();
}

class _IntentLinkState extends State<IntentLink> {
  late StreamSubscription _sub;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.child,
    );
  }

  initPlatformStateForStringUniLinks(context) {
    // Attach a listener to the links stream
    _sub = linkStream.listen((String? link) {
      print("*Link : $link");
    }, onError: (err) {
      if (!mounted) return;
      print('Failed to get latest link: $err.');
    }, onDone: () {
      print('**DONE');
    });
  }

  @override
  initState() {
    super.initState();
    initPlatformStateForStringUniLinks(context);
  }

  @override
  void dispose() {
    super.dispose();
    _sub.cancel();
  }
}
