// // Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// // for details. All rights reserved. Use of this source code is governed by a
// // BSD-style license that can be found in the LICENSE file.

// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:adaptive_breakpoints/adaptive_breakpoints.dart';
// import 'dart:math' as math;

// typedef NavigationType NavigationTypeResolver(BuildContext context);

// // The navigation mechanism to configure the [Scaffold] with.
// enum NavigationType {
//   // Used to configure a [Scaffold] with a [BottomNavigationBar].
//   bottom,

//   // Used to configure a [Scaffold] with a [NavigationRail].
//   rail,

//   // Used to configure a [Scaffold] with a modal [Drawer].
//   drawer,

//   // Used to configure a [Scaffold] with an always open [Drawer].
//   permanentDrawer,
// }

// /// Used to configure items or destinations in the various navigation
// /// mechanism. For [BottomNavigationBar], see [BottomNavigationBarItem]. For
// /// [NavigationRail], see [NavigationRailDestination]. For [Drawer], see
// /// [ListTile].
// class AdaptiveScaffoldDestination {
//   final String title;
//   final IconData icon;
//   final Widget widget;

//   const AdaptiveScaffoldDestination({
//     @required this.title,
//     @required this.icon,
//     this.widget,
//   })  : assert(title != null),
//         assert(icon != null);
// }

// /// A widget that adapts to the current display size, displaying a [Drawer],
// /// [NavigationRail], or [BottomNavigationBar]. Navigation destinations are
// /// defined in the [destinations] parameter.
// class AdaptiveNavigationScaffold extends StatefulWidget {
//   const AdaptiveNavigationScaffold({
//     Key key,
//     this.appBar,
//     this.body,
//     this.floatingActionButton,
//     this.floatingActionButtonLocation,
//     this.floatingActionButtonAnimator,
//     this.persistentFooterButtons,
//     this.endDrawer,
//     this.bottomSheet,
//     this.backgroundColor,
//     this.resizeToAvoidBottomInset,
//     this.primary = true,
//     this.drawerDragStartBehavior = DragStartBehavior.start,
//     this.extendBody = false,
//     this.extendBodyBehindAppBar = false,
//     this.drawerScrimColor,
//     this.drawerEdgeDragWidth,
//     this.drawerEnableOpenDragGesture = true,
//     this.endDrawerEnableOpenDragGesture = true,
//     @required this.selectedIndex,
//     @required this.destinations,
//     this.onDestinationSelected,
//     this.navigationTypeResolver,
//     this.drawerHeader,
//     this.fabInRail = true,
//     this.includeBaseDestinationsInMenu = true,
//   })  : assert(selectedIndex != null),
//         assert(destinations != null),
//         super(key: key);

//   /// See [Scaffold.appBar].
//   final Widget appBar;

//   /// See [Scaffold.body].
//   final Widget body;

//   /// See [Scaffold.floatingActionButton].
//   final FloatingActionButton floatingActionButton;

//   /// See [Scaffold.floatingActionButtonLocation].
//   ///
//   /// Ignored if [fabInRail] is true.
//   final FloatingActionButtonLocation floatingActionButtonLocation;

//   /// See [Scaffold.floatingActionButtonAnimator].
//   ///
//   /// Ignored if [fabInRail] is true.
//   final FloatingActionButtonAnimator floatingActionButtonAnimator;

//   /// See [Scaffold.persistentFooterButtons].
//   final List<Widget> persistentFooterButtons;

//   /// See [Scaffold.endDrawer].
//   final Widget endDrawer;

//   /// See [Scaffold.drawerScrimColor].
//   final Color drawerScrimColor;

//   /// See [Scaffold.backgroundColor].
//   final Color backgroundColor;

//   /// See [Scaffold.bottomSheet].
//   final Widget bottomSheet;

//   /// See [Scaffold.resizeToAvoidBottomInset].
//   final bool resizeToAvoidBottomInset;

//   /// See [Scaffold.primary].
//   final bool primary;

//   /// See [Scaffold.drawerDragStartBehavior].
//   final DragStartBehavior drawerDragStartBehavior;

//   /// See [Scaffold.extendBody].
//   final bool extendBody;

//   /// See [Scaffold.extendBodyBehindAppBar].
//   final bool extendBodyBehindAppBar;

//   /// See [Scaffold.drawerEdgeDragWidth].
//   final double drawerEdgeDragWidth;

//   /// See [Scaffold.drawerEnableOpenDragGesture].
//   final bool drawerEnableOpenDragGesture;

//   /// See [Scaffold.endDrawerEnableOpenDragGesture].
//   final bool endDrawerEnableOpenDragGesture;

//   /// The index into [destinations] for the current selected
//   /// [AdaptiveScaffoldDestination].
//   final int selectedIndex;

//   /// Defines the appearance of the items that are arrayed within the
//   /// navigation.
//   ///
//   /// The value must be a list of two or more [AdaptiveScaffoldDestination]
//   /// values.
//   final List<AdaptiveScaffoldDestination> destinations;

//   /// Called when one of the [destinations] is selected.
//   ///
//   /// The stateful widget that creates the adaptive scaffold needs to keep
//   /// track of the index of the selected [AdaptiveScaffoldDestination] and call
//   /// `setState` to rebuild the adaptive scaffold with the new [selectedIndex].
//   final ValueChanged<int> onDestinationSelected;

//   /// Determines the navigation type that the scaffold uses.
//   final NavigationTypeResolver navigationTypeResolver;

//   /// The leading item in the drawer when the navigation has a drawer.
//   ///
//   /// If null, then there is no header.
//   final Widget drawerHeader;

//   /// Whether the [floatingActionButton] is inside or the rail or in the regular
//   /// spot.
//   ///
//   /// If true, then [floatingActionButtonLocation] and
//   /// [floatingActionButtonAnimation] are ignored.
//   final bool fabInRail;

//   /// Weather the overflow menu defaults to include overflow destinations and
//   /// the overflow destinations.
//   final bool includeBaseDestinationsInMenu;

//   @override
//   _AdaptiveNavigationScaffoldState createState() =>
//       _AdaptiveNavigationScaffoldState();
// }

// class _AdaptiveNavigationScaffoldState
//     extends State<AdaptiveNavigationScaffold> {
//   //
//   @override
//   initState() {
//     _selectedIndex = widget.selectedIndex;
//     super.initState();
//   }

//   int _selectedIndex = 0;

//   NavigationType _defaultNavigationTypeResolver(BuildContext context) {
//     if (_isLargeScreen(context)) {
//       return NavigationType.permanentDrawer;
//     } else if (_isMediumScreen(context)) {
//       return NavigationType.rail;
//     } else {
//       return NavigationType.bottom;
//     }
//   }

//   Drawer _defaultDrawer(List<AdaptiveScaffoldDestination> destinations) {
//     return Drawer(
//       child: ListView(
//         children: [
//           if (widget.drawerHeader != null) widget.drawerHeader,
//           for (int i = 0; i < destinations.length; i++)
//             ListTile(
//               leading: Icon(destinations[i].icon),
//               title: Text(destinations[i].title),
//               onTap: () {
//                 if (widget.onDestinationSelected != null) {
//                   widget.onDestinationSelected(i);
//                 }
//               },
//             )
//         ],
//       ),
//     );
//   }

//   Widget _buildBottomNavigationScaffold() {
//     // print('### _buildBottomNavigationScaffold');
//     if (widget.destinations.length < 2) {
//       return Scaffold(
//         body: widget.body,
//         appBar: widget.appBar,
//         floatingActionButton: widget.floatingActionButton,
//       );
//     }

//     final int bottomNavigationOverflow = 5;
//     final bottomDestinations = widget.destinations.sublist(
//       0,
//       math.min(widget.destinations.length, bottomNavigationOverflow),
//     );
//     final drawerDestinations = widget.destinations.length >
//             bottomNavigationOverflow
//         ? widget.destinations.sublist(
//             widget.includeBaseDestinationsInMenu ? 0 : bottomNavigationOverflow)
//         : [];

//     final PageController _pageController =
//         PageController(initialPage: _selectedIndex, keepPage: true);

//     return Scaffold(
//       body: PageView(
//         controller: _pageController,
//         onPageChanged: (value) {
//           setState(() {
//             _selectedIndex = value;
//           });
//         },
//         children: [
//           for (final destination in bottomDestinations)
//             Builder(
//               key: PageStorageKey(
//                   '${destination.title} - ${destination.hashCode}'),
//               builder: (_) {
//                 return destination.widget;
//               },
//             )
//         ],
//       ),
//       appBar: widget.appBar,
//       drawer: drawerDestinations.isEmpty
//           ? null
//           : _defaultDrawer(drawerDestinations),
//       bottomNavigationBar: BottomNavigationBar(
//         items: [
//           for (final destination in bottomDestinations)
//             BottomNavigationBarItem(
//               icon: Icon(destination.icon),
//               label: destination.title,
//             ),
//         ],
//         currentIndex: _selectedIndex,
//         onTap: widget.onDestinationSelected ??
//             (indx) {
//               setState(() {
//                 _selectedIndex = indx;
//                 _pageController.animateToPage(
//                   indx,
//                   curve: Curves.easeInOutExpo,
//                   duration: Duration(
//                     milliseconds: 435,
//                   ),
//                 );
//               });
//             },
//         type: BottomNavigationBarType.shifting,
//       ),
//       floatingActionButton: widget.floatingActionButton,
//     );
//   }

//   Widget _buildNavigationRailScaffold() {
//     // print('### _buildNavigationRailScaffold');

//     final int railDestinationsOverflow = 7;
//     final railDestinations = widget.destinations.sublist(
//       0,
//       math.min(widget.destinations.length, railDestinationsOverflow),
//     );
//     final drawerDestinations = widget.destinations.length >
//             railDestinationsOverflow
//         ? widget.destinations.sublist(
//             widget.includeBaseDestinationsInMenu ? 0 : railDestinationsOverflow)
//         : [];

//     final PageController _pageController =
//         PageController(initialPage: _selectedIndex, keepPage: true);

//     return Scaffold(
//       appBar: widget.appBar,
//       drawer: drawerDestinations.isEmpty
//           ? null
//           : _defaultDrawer(drawerDestinations),
//       body: Row(
//         children: [
//           NavigationRail(
//             leading: widget.fabInRail ? widget.floatingActionButton : null,
//             destinations: [
//               for (final destination in railDestinations)
//                 NavigationRailDestination(
//                   icon: Icon(destination.icon),
//                   label: Text(destination.title),
//                 ),
//             ],
//             selectedIndex: widget.selectedIndex,
//             onDestinationSelected: widget.onDestinationSelected ??
//                 (indx) {
//                   setState(() {
//                     _selectedIndex = indx;
//                     _pageController.animateToPage(
//                       indx,
//                       curve: Curves.easeInOutExpo,
//                       duration: Duration(
//                         milliseconds: 435,
//                       ),
//                     );
//                   });
//                 },
//           ),
//           // VerticalDivider(
//           //   width: 1,
//           //   thickness: 1,
//           // ),
//           Expanded(
//             child: widget.body ??
//                 PageView(
//                   controller: _pageController,
//                   physics: NeverScrollableScrollPhysics(),
//                   children: [
//                     for (final destination in drawerDestinations)
//                       Builder(
//                         key: PageStorageKey(
//                             '${destination.title} - ${destination.hashCode}'),
//                         builder: (_) {
//                           return destination.widget;
//                         },
//                       )
//                   ],
//                 ),
//           ),
//         ],
//       ),
//       floatingActionButton:
//           widget.fabInRail ? null : widget.floatingActionButton,
//       floatingActionButtonLocation: widget.floatingActionButtonLocation,
//       floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
//       persistentFooterButtons: widget.persistentFooterButtons,
//       endDrawer: widget.endDrawer,
//       bottomSheet: widget.bottomSheet,
//       backgroundColor: widget.backgroundColor,
//       resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
//       primary: true,
//       drawerDragStartBehavior: widget.drawerDragStartBehavior,
//       extendBody: widget.extendBody,
//       extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
//       drawerScrimColor: widget.drawerScrimColor,
//       drawerEdgeDragWidth: widget.drawerEdgeDragWidth,
//       drawerEnableOpenDragGesture: widget.drawerEnableOpenDragGesture,
//       endDrawerEnableOpenDragGesture: widget.endDrawerEnableOpenDragGesture,
//     );
//   }

//   Widget _buildNavigationDrawerScaffold() {
//     return Scaffold(
//       body: widget.body,
//       appBar: widget.appBar,
//       drawer: Drawer(
//         child: Column(
//           children: [
//             if (widget.drawerHeader != null) widget.drawerHeader,
//             for (final destination in widget.destinations)
//               ListTile(
//                 leading: Icon(destination.icon),
//                 title: Text(destination.title),
//                 selected: widget.destinations.indexOf(destination) ==
//                     widget.selectedIndex,
//                 onTap: () => _destinationTapped(destination),
//               ),
//           ],
//         ),
//       ),
//       floatingActionButton: widget.floatingActionButton,
//       floatingActionButtonLocation: widget.floatingActionButtonLocation,
//       floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
//       persistentFooterButtons: widget.persistentFooterButtons,
//       endDrawer: widget.endDrawer,
//       bottomSheet: widget.bottomSheet,
//       backgroundColor: widget.backgroundColor,
//       resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
//       primary: true,
//       drawerDragStartBehavior: widget.drawerDragStartBehavior,
//       extendBody: widget.extendBody,
//       extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
//       drawerScrimColor: widget.drawerScrimColor,
//       drawerEdgeDragWidth: widget.drawerEdgeDragWidth,
//       drawerEnableOpenDragGesture: widget.drawerEnableOpenDragGesture,
//       endDrawerEnableOpenDragGesture: widget.endDrawerEnableOpenDragGesture,
//     );
//   }

//   Widget _buildPermanentDrawerScaffold() {
//     return Row(
//       children: [
//         Drawer(
//           child: Column(
//             children: [
//               if (widget.drawerHeader != null) widget.drawerHeader,
//               for (final destination in widget.destinations)
//                 ListTile(
//                   leading: Icon(destination.icon),
//                   title: Text(destination.title),
//                   selected: widget.destinations.indexOf(destination) ==
//                       widget.selectedIndex,
//                   onTap: () => _destinationTapped(destination),
//                 ),
//             ],
//           ),
//         ),
//         VerticalDivider(
//           width: 1,
//           thickness: 1,
//         ),
//         Expanded(
//           child: Scaffold(
//             appBar: widget.appBar,
//             body: widget.body,
//             floatingActionButton: widget.floatingActionButton,
//             floatingActionButtonLocation: widget.floatingActionButtonLocation,
//             floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
//             persistentFooterButtons: widget.persistentFooterButtons,
//             endDrawer: widget.endDrawer,
//             bottomSheet: widget.bottomSheet,
//             backgroundColor: widget.backgroundColor,
//             resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
//             primary: true,
//             drawerDragStartBehavior: widget.drawerDragStartBehavior,
//             extendBody: widget.extendBody,
//             extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
//             drawerScrimColor: widget.drawerScrimColor,
//             drawerEdgeDragWidth: widget.drawerEdgeDragWidth,
//             drawerEnableOpenDragGesture: widget.drawerEnableOpenDragGesture,
//             endDrawerEnableOpenDragGesture:
//                 widget.endDrawerEnableOpenDragGesture,
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final NavigationTypeResolver navigationTypeResolver =
//         this.widget.navigationTypeResolver ?? _defaultNavigationTypeResolver;
//     final navigationType = navigationTypeResolver(context);
//     switch (navigationType) {
//       case NavigationType.bottom:
//         return _buildBottomNavigationScaffold();
//       case NavigationType.rail:
//         return _buildNavigationRailScaffold();
//       case NavigationType.drawer:
//         return _buildNavigationDrawerScaffold();
//       case NavigationType.permanentDrawer:
//         return _buildPermanentDrawerScaffold();
//     }
//     throw Exception('Invalid navigation type: $navigationType');
//   }

//   void _destinationTapped(AdaptiveScaffoldDestination destination) {
//     final index = widget.destinations.indexOf(destination);
//     if (index != widget.selectedIndex) {
//       widget.onDestinationSelected(index);
//     }
//   }
// }

// bool _isLargeScreen(BuildContext context) =>
//     getWindowType(context) >= AdaptiveWindowType.large;
// bool _isMediumScreen(BuildContext context) =>
//     getWindowType(context) == AdaptiveWindowType.medium;
