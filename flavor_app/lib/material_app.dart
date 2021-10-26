import 'package:flutter/material.dart';

import 'package:css_colors/css_colors.dart';
import 'package:flavor_app/features/colors/colors.dart';
import 'package:flavor_app/features/theme/theme_defaults.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class FlavorMaterialApp extends StatelessWidget {
  const FlavorMaterialApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: ScreenHome()),
    );
  }
}

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var _themeStateController = Theme.of(context);

    return Scaffold(
      // appBar: AppBar(),
      // bottomNavigationBar: AppBar(
      //   backgroundColor: FlavorColors().yellow,
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) => Card(
              child: Column(
                children: List.generate(
                  8,
                  (index) => SizedBox(
                    height: 60,
                    child: ListTile(
                        leading: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            // color: FlavorColors().gold,
                            child: const Text('wwqeqeq'),
                          ),
                        ),
                        title: const Text('Check Tho'),
                        subtitle: const Text('SirSkii')
                        // trailing: Container(
                        //   color: FlavorColors().amber,
                        //   child: const DLXLogo(),
                        // ),
                        ),
                  ),
                ),
              ),
            ),
            separatorBuilder: (context, index) => const SizedBox(
              height: 24,
            ),
            itemCount: 2,
          ),
        ),
      ),
    );
  }
}
