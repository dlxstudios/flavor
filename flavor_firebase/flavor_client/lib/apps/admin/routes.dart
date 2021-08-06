import 'package:flavor/apps/admin/home_view.dart';
import 'package:flavor/apps/admin/mediaDetail_view.dart';
import 'package:flavor/apps/admin/settings_view.dart';
import 'package:flutter/material.dart';
//
import 'package:flavor/components/route.dart';
//

//
List<FlavorRouteWidget> adminRoutes = [
  homeRoute,
  FlavorRouteWidget(
    path: '/events',
    title: 'Events',
    icon: Icons.calendar_today,
    backgroundColor: Colors.blueAccent,
    child: Container(),
  ),
  FlavorRouteWidget(
    path: '/players',
    title: 'Players',
    icon: Icons.people_alt_outlined,
    backgroundColor: Colors.greenAccent,
    child: Container(),
  ),
  FlavorRouteWidget(
    path: '/profile',
    title: 'Profile',
    icon: Icons.person,
    backgroundColor: Colors.deepPurple,
    child: Container(),
  ),
  settingsRoute,
  mediaDetailRoute,
];
