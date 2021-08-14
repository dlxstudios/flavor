import 'package:flavor_client/utilities/FlavorAppState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlavorPageDashboard extends StatefulWidget {
  @override
  _FlavorPageDashboardState createState() => _FlavorPageDashboardState();
}

class _FlavorPageDashboardState extends State<FlavorPageDashboard> {
  @override
  Widget build(BuildContext context) {
    FlavorAppState state = Provider.of<FlavorAppState>(context);

    return ListView(
      children: <Widget>[
        Container(
          height: 200,
          color: Colors.deepOrangeAccent,
        ),
        ListTile(
          title: Text(
            'Applications',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        GridView(
          shrinkWrap: true,
          padding: EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200, childAspectRatio: 16 / 9),
          children: state.apps.length < 1
              ? [
                  Card(
                    child: Center(
                      child: Icon(Icons.add),
                    ),
                  ),
                  ListTile(
                    title: Text('No apps yet!'),
                  )
                ]
              : state.apps
                  .map((e) => Card(
                        child: Center(
                          child: Text(e.title!),
                        ),
                      ))
                  .toList(),
        ),
      ],
    );
  }
}
