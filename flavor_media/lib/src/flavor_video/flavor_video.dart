import 'package:flavor_media/src/settings/settings_controller.dart';
import 'package:flutter/widgets.dart';

class FlavorVideoAdapter extends InheritedWidget {
  final SettingsController controller;
  // ignore: use_key_in_widget_constructors
  const FlavorVideoAdapter({
    Key? key,
    required Widget child,
    required this.controller,
  }) : super(child: child);

  @override
  bool updateShouldNotify(covariant FlavorVideoAdapter oldWidget) {
    // print('updateShouldNotify');
    // return theme != oldWidget.theme;
    // print(
    //     'oldWidget.theme.hashCode == theme.hashCode::${oldWidget.theme.theme.toString() == theme.theme.toString()}');
    // oldWidget.theme.hashCode == theme.hashCode
    return true;
  }

  static FlavorVideoAdapter of(BuildContext context) {
    // assert(context != null);
    final FlavorVideoAdapter? result =
        context.dependOnInheritedWidgetOfExactType<FlavorVideoAdapter>();
    assert(result != null, 'No Theme found in context');
    return result!;
  }
}
