import 'package:css_colors/css_colors.dart';
import 'package:flavor_app/features/card/card_box.dart';
import 'package:flavor_app/features/scaffold/scaffold.dart';
import 'package:flutter/cupertino.dart';

class FlavorPageError extends StatelessWidget {
  final String message;
  final String code;
  const FlavorPageError({
    Key? key,
    required this.message,
    required this.code,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlavorScaffold(
        child: Center(
      child: SizedBox(
        width: 300,
        height: 300,
        child: CardBox(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    'Error',
                    style: TextStyle(fontSize: 40, color: CSSColors.red),
                  ),
                  Text(code, style: const TextStyle(fontSize: 40)),
                ],
              ),
              Text(message, style: const TextStyle(fontSize: 28)),
            ],
          ),
        ),
      ),
    ));
  }
}
