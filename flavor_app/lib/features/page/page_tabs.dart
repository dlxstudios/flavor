import 'dart:convert';

import 'package:css_colors/css_colors.dart';
import 'package:flavor_app/features/home/home_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_remix/flutter_remix.dart';

import 'package:flavor_app/features/page/page_error.dart';
import 'package:flavor_ui/flavor_ui.dart';

class ScreenPageTabs extends StatelessWidget {
  ScreenPageTabs({Key? key, required this.tabs}) : super(key: key);

  final PageController _pageController = PageController(keepPage: true);
  final List<Map> tabs;

  animatePageTo(int page) {
    _pageController.animateToPage(page,
        curve: Curves.easeInOutExpo,
        duration: const Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    if (tabs.isEmpty) {
      return const FlavorPageError(
        code: '600',
        message: 'tabs == null || tabs.length == 0',
      );
    }

    var _tabsPage = tabs
        .map(
          (e) => FlavorPageError(
            code: 200.toString(),
            message: 'You made it!',
          ),
        )
        .toList();
    var _tabsButtons = tabs
        .map(
          (e) => const TabButton(
            text: Text('button 1'),
            icon: Icon(FlutterRemix.home_3_line),
            page: ScreenHome(),
          ),
        )
        .toList();
    return FlavorScaffold(
      child: PageView(
        controller: _pageController,
        children: _tabsPage,
      ),
      bottomBar: SizedBox(
        height: 62,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 8,
                  color: CSSColors.white.withOpacity(.1),
                  spreadRadius: 0,
                  offset: const Offset(0, 0)),
            ],
            color: CSSColors.mediumPurple,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _tabsButtons,
          ),
        ),
      ),
    );
  }

  static fromPageTabData(Map<dynamic, dynamic> json) {}
}

class PageTabData {
  final String? title;
  final List components;
  final String type = 'flavor.page.tab';

  PageTabData(this.title, this.components);
}

class TabButton extends StatelessWidget {
  const TabButton({
    Key? key,
    this.onPressed,
    this.text,
    this.icon,
    required this.page,
  }) : super(key: key);

  final void Function()? onPressed;
  final Widget page;
  final Widget? text;
  final Widget? icon;

  factory TabButton.fromTabButtonData(FlavorTabButtonData flavorTabData,
      {void Function()? onPressed, Widget? page, Widget? icon}) {
    return TabButton(
      text: flavorTabData.text != null ? Text(flavorTabData.text!) : null,
      onPressed: onPressed,
      page: page ??
          FlavorPageError(
              message: 'Tab page doesn\'t exist', code: 404.toString()),
      icon: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var _final = text ?? icon ?? Container();

    if (icon != null && text != null) {
      _final = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [icon!, text!],
      );
    }

    // ignore: avoid_unnecessary_containers
    return Container(
      // color: CSSColors.red,
      child: FlavorElevatedButton(
        onPressed: onPressed,
        child: const Text('button 1'),
        icon: const Icon(FlutterRemix.newspaper_line),
      ),
    );
  }
}

class FlavorTabButtonData {
  final String? icon;
  final String? text;
  FlavorTabButtonData({
    this.icon,
    this.text,
  });

  FlavorTabButtonData copyWith({
    String? icon,
    String? text,
  }) {
    return FlavorTabButtonData(
      icon: icon ?? this.icon,
      text: text ?? this.text,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'icon': icon,
      'text': text,
    };
  }

  factory FlavorTabButtonData.fromMap(Map<String, dynamic> map) {
    return FlavorTabButtonData(
      icon: map['icon'],
      text: map['text'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FlavorTabButtonData.fromJson(String source) =>
      FlavorTabButtonData.fromMap(json.decode(source));

  @override
  String toString() => 'FlavorTabData(icon: $icon, text: $text)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FlavorTabButtonData &&
        other.icon == icon &&
        other.text == text;
  }

  @override
  int get hashCode => icon.hashCode ^ text.hashCode;
}

class FlavorElevatedButton extends StatefulWidget {
  final Widget? child;
  final Widget? icon;
  final void Function()? onPressed;
  const FlavorElevatedButton({
    Key? key,
    this.child,
    this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  _FlavorElevatedButtonState createState() => _FlavorElevatedButtonState();
}

class _FlavorElevatedButtonState extends State<FlavorElevatedButton> {
  @override
  Widget build(BuildContext context) {
    var _final = widget.child;
    if (widget.icon != null && widget.child != null) {
      _final = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [widget.icon!, widget.child!],
      );
    }

    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: _final,
        // color: CSSColors.red,
      ),
    );
  }
}
// constraints: const BoxConstraints(minWidth: 8, minHeight: 8, maxWidth: 3000),
