import 'package:flavor_app/features/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DLXLogo extends StatelessWidget {
  final double? height;
  const DLXLogo({Key? key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/logo.2021.svg',
      // color: FlavorColors().black,
      fit: BoxFit.cover,
    );
  }
}
