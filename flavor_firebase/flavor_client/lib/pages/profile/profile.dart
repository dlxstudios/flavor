import 'package:flavor_auth/src/models/user.dart';

import 'package:flutter/material.dart';

class FlavorPageProfile extends StatefulWidget {
  @override
  _FlavorPageProfileState createState() => _FlavorPageProfileState();
}

class _FlavorPageProfileState extends State<FlavorPageProfile>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  int _selectedTab = 1;

  late ScrollController _pageScrollController;
  late PageController _pageViewScrollController;

  @override
  void initState() {
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    _pageScrollController = ScrollController();
    _pageViewScrollController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // FlavorAuthStateOld state;// = Provider.of<FlavorAuthStateOld>(context);
    FlavorUser user; //= state.currentUser;

    return Scaffold(
      body: NestedScrollView(
        controller: _pageScrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: 360,
              elevation: 3,
              forceElevated: true,
              pinned: true,
              floating: true,
              // leading: IconButton(
              //     icon: Icon(Icons.arrow_back_ios),
              //     onPressed: () {
              //       // log.i();
              //       state.navigatorKey.currentState.pop();
              //     }),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(120),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      flex: 2,
                      child: Container(
                        height: 120,
                        padding: EdgeInsets.all(8),
                        child: AspectRatio(
                          aspectRatio: 1.6,
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            elevation: 4,
                            child: Image.network(
                              """https://raw.githubusercontent.com/Shashank02051997/FancyGifDialog-Android/master/GIF's/gif14.gif""",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(user.displayName ?? user.email),
                            // Text(user.email),
                          ],
                        )),
                    Expanded(
                      flex: 5,
                      child: Container(
                        height: 104,
                        // color: Colors.redAccent,
                        margin: EdgeInsets.only(left: 24),
                        child: TabBar(
                          controller: _tabController,
                          isScrollable: true,
                          onTap: (i) {
                            setState(() {
                              _selectedTab = i;
                            });
                          },
                          tabs: [
                            Tab(
                              text: 'Profile',
                            ),
                            Tab(
                              text: 'Profile',
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              flexibleSpace: ListView(
                children: [
                  Container(
                    constraints: BoxConstraints(
                      minHeight: 360,
                    ),
                    child: Material(
                      color: Theme.of(context).bottomAppBarColor,
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
        body: new TabBarView(
          children: <Widget>[],
          controller: _tabController,
        ),
      ),
    );
  }
}
