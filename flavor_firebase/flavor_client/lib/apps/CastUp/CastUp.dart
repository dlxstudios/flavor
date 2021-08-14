import 'package:flavor_client/apps/CastUp/CastModels.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class CastUp extends StatefulWidget {
  @override
  _CastUpState createState() => _CastUpState();
}

class _CastUpState extends State<CastUp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CastUpAppState>(
      create: (BuildContext context) {
        return CastUpAppState(context)..init();
      },
      child: CupertinoApp(
        debugShowCheckedModeBanner: false,
        home: CupertinoCastHomePage(),
      ),
    );
  }
}

class CupertinoCastHomePage extends StatefulWidget {
  @override
  _CupertinoCastHomePageState createState() => _CupertinoCastHomePageState();
}

class _CupertinoCastHomePageState extends State<CupertinoCastHomePage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.shopping_cart),
            label: 'Cart',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: ProductListTab(),
              );
            });
          case 1:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: ProductListTab(),
              );
            });
          case 2:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                child: ProductListTab(),
              );
            });
        }
        // Default
        return CupertinoTabView(builder: (context) {
          return CupertinoPageScaffold(
            child: ProductListTab(),
          );
        });
      },
    );
  }
}

class ProductListTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CastUpAppState>(
      builder: (context, model, child) {
        return CustomScrollView(
          slivers: const <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Text('CastUp'),
            ),
          ],
        );
      },
    );
  }
}
