import 'package:flavor/components/page.dart';
import 'package:flavor/components/flavorMenu.dart';
import 'package:flavor/models/models.dart';
import 'package:flavor/pages/dashboard.dart';
import 'package:flavor/utilities/AppSettings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageWebHome extends StatefulWidget {
  @override
  _PageWebHomeState createState() => _PageWebHomeState();
}

class _PageWebHomeState extends State<PageWebHome> {
  // @override
  Widget buildOLD(BuildContext context) {
    AppSettingsModel app = Provider.of<AppSettingsModel>(context);

    // var _maxHeight = ScreenUtil.screenHeight;
    Widget _body;
    // print(app.currentPage);

    switch (app.currentPage) {
      case '/':
        _body = FlavorPageDashboard();
        break;
      default:
        _body = FlavorPageDashboard();

      // _body = FlavorPageView.fromPageModel(
      //     PageModel.formJson(app.pagesMap[app.currentPage]));
    }

    // app.log.e(_maxWidth);

    // if (_maxWidth > 950) {
    //   _body = LView(width: _maxWidth, body: _body);
    // }
    // //  else if (_maxWidth > 1750) {
    // //   _body = XLView();
    // // }

    return Scaffold(body: _body);
  }

  @override
  Widget build(BuildContext context) {
    // AppSettingsModel app = Provider.of<AppSettingsModel>(context);

    Widget _body;
    // print(app.currentPage);

    // switch (app.currentPage) {
    //   case '/':
    _body = FlavorPageDashboard();
    //   break;
    // default:

    // }

    // app.log.e(_maxWidth);

    // if (_maxWidth > 950) {
    //   _body = LView(width: _maxWidth, body: _body);
    // }
    //  else if (_maxWidth > 1750) {
    //   _body = XLView();
    // }

    return Scaffold(body: _body);
  }
}

class LView extends StatelessWidget {
  final double? width;

  final Widget? body;
  final bool? wide;

  LView({Key? key, this.width, this.body, this.wide}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
            top: -120,
            right: -60,
            child: CustomPaint(
                painter: DrawCircle(
                    circleColor: Theme.of(context).primaryColor.withOpacity(.2),
                    circleSize: 3.2))),
        Positioned(
            top: -100,
            right: -0,
            child: CustomPaint(
                painter: DrawCircle(
                    circleColor: Theme.of(context).primaryColor.withOpacity(.4),
                    circleSize: 2))),
        Positioned(
            top: 50,
            right: 60,
            child: CustomPaint(
                painter: DrawCircle(
              circleColor: Theme.of(context).primaryColor,
            ))),
        Positioned(
            top: -60,
            right: -110,
            child: CustomPaint(
                painter: DrawCircle(
                    circleColor: Theme.of(context)
                        .primaryColor
                        .withAlpha(100)
                        .withGreen(200),
                    circleSize: 4))),
        Row(
          children: <Widget>[
            Container(
                width: width! - (wide == true ? 330 : 0),
                padding: EdgeInsets.only(
                  left: wide == true ? 50 : 0,
                ),
                // height: 1000,
                child: body)
          ]..insert(0, wide == true ? FlavorMenu() : Container()),
        ),
      ],
    );
  }
}

// class XLView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 600,
//       height: 600,
//       child: Row(
//         children: <Widget>[],
//       ),
//     );
//     ;
//   }
// }

class DrawCircle extends CustomPainter {
  late Paint _paint;
  double circleSize;
  Color circleColor;

  DrawCircle({this.circleColor = Colors.green, this.circleSize = 1}) {
    _paint = Paint()
      ..color = this.circleColor
      ..strokeWidth = 10.0
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(0.0, 0.0), 100.0 * this.circleSize, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
