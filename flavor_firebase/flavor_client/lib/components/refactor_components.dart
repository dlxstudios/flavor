import 'package:flavor_client/utilities/AppSettings.dart';
import 'package:flutter/material.dart';

class TextOneLine extends StatelessWidget {
  final TextStyle? style;
  const TextOneLine(
    this.string, {
    Key? key,
    this.style,
  }) : super(key: key);

  final String string;

  @override
  Widget build(BuildContext context) {
    return Text(
      string,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      softWrap: false,
      style: style,
    );
  }
}

class FlavorText extends StatelessWidget {
  final String? text;

  final TextStyle? style;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;
  final Locale? locale;

  @override
  Widget build(BuildContext context) => Text(
        '$text',
        maxLines: maxLines,
        overflow: overflow,
        softWrap: softWrap,
        locale: locale,
        style: style,
      );

  const FlavorText(
    this.text, {
    Key? key,
    this.style,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.locale,
  }) : super(key: key);

  static Widget headline6(
    context,
    String text, {
    TextStyle? style,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
    Locale? locale,
  }) {
    return Text(
      '$text',
      style: style != null ? style : Theme.of(context).textTheme.headline6,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      locale: locale,
    );
  }

  static Widget headline5(
    context,
    String text, {
    TextStyle? style,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
    Locale? locale,
  }) {
    return Text(
      '$text',
      style: style != null ? style : Theme.of(context).textTheme.headline5,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      locale: locale,
    );
  }

  static Widget headline4(
    context,
    String text, {
    TextStyle? style,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
    Locale? locale,
  }) {
    return Text(
      '$text',
      style: style != null ? style : Theme.of(context).textTheme.headline4,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      locale: locale,
    );
  }

  static Widget headline3(
    context,
    String text, {
    TextStyle? style,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
    Locale? locale,
  }) {
    return Text(
      '$text',
      style: style != null ? style : Theme.of(context).textTheme.headline3,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      locale: locale,
    );
  }

  static Widget headline2(
    context,
    String? text, {
    TextStyle? style,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
    Locale? locale,
  }) {
    return Text(
      '$text',
      style: style != null ? style : Theme.of(context).textTheme.headline2,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      locale: locale,
    );
  }

  static Widget headline1(
    context,
    String text, {
    TextStyle? style,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
    Locale? locale,
  }) {
    return Text(
      '$text',
      style: style != null ? style : Theme.of(context).textTheme.headline1,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      locale: locale,
    );
  }

  static Widget bodyText1(
    context,
    String text, {
    TextStyle? style,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
    Locale? locale,
  }) {
    return Text(
      '$text',
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      locale: locale,
      style: style != null ? style : Theme.of(context).textTheme.bodyText1,
    );
  }

  static Widget bodyText2(
    context,
    String text, {
    TextStyle? style,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
    Locale? locale,
  }) {
    return Text(
      '$text',
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      locale: locale,
      style: style != null ? style : Theme.of(context).textTheme.bodyText2,
    );
  }

  static Widget caption(
    context,
    String text, {
    TextStyle? style,
    int? maxLines,
    TextOverflow? overflow,
    bool? softWrap,
    Locale? locale,
  }) {
    return Text(
      '$text',
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      locale: locale,
      style: style != null ? style : Theme.of(context).textTheme.caption,
    );
  }
}

extension FlavorTextExtention on Text {
  static Widget headline6(context, String text) {
    return Text(
      '$text',
      style: Theme.of(context).textTheme.headline6,
    );
  }

  Widget headline5(context, String text) {
    return Text(
      '$text',
      style: Theme.of(context).textTheme.headline5,
    );
  }

  Widget headline4(context, String text) {
    return Text(
      '$text',
      style: Theme.of(context).textTheme.headline4,
    );
  }

  Widget headline3(context, String text) {
    return Text(
      '$text',
      style: Theme.of(context).textTheme.headline3,
    );
  }

  Widget headline2(context, String text) {
    return Text(
      '$text',
      style: Theme.of(context).textTheme.headline2,
    );
  }

  Widget headline1(context, String text) {
    return Text(
      '$text',
      style: Theme.of(context).textTheme.headline1,
    );
  }
}

class DLXOutlinedButton extends StatelessWidget {
  final void Function()? onPressed;
  final String? text;
  final Color? color;

  const DLXOutlinedButton(
      {Key? key, required this.onPressed, this.text, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color _color = color ?? Theme.of(context).accentColor;

    return TextButton(
      // shape: OutlineInputBorder(borderSide: BorderSide(color: _color)),
      child: Text(text!),
      onPressed: onPressed,
    );
  }
}

class DLXElevatedButton extends StatelessWidget {
  final void Function()? onPressed;
  final String? text;
  final Color? color;

  const DLXElevatedButton({Key? key, this.onPressed, this.text, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color _color = color ?? Theme.of(context).primaryColor;

    return ElevatedButton(
      // shape: OutlineInputBorder(borderSide: BorderSide(color: _color)),
      // color: _color,
      child: Text(
        text!,
      ),
      onPressed: onPressed,
    );
  }
}

class DLXAppBar extends AppBar {
  final String? titleString;
  final Color? color;

  DLXAppBar({this.titleString, this.color});

  @override
  Color get backgroundColor => color ?? super.backgroundColor!;

  @override
  Widget get title =>
      Text(titleString!, style: TextStyle(color: Colors.white, fontSize: 18.0));

  @override
  IconThemeData get iconTheme => IconThemeData(color: Colors.white);
}

class DLXTextFormField extends StatefulWidget {
  final TextEditingController? controller;

  final void Function(String)? completeAction;

  final InputDecoration? decoration;

  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;

  final bool? numberKeyboard;
  final bool? email;
  final bool? autoFocus;
  final bool? obscureText;

  final TextInputAction? textInputAction;

  final String? Function(String?)? validator;

  const DLXTextFormField(
      {Key? key,
      this.controller,
      this.completeAction,
      this.decoration,
      this.focusNode,
      this.nextFocusNode,
      this.numberKeyboard,
      this.email,
      this.autoFocus,
      this.obscureText = false,
      this.textInputAction,
      this.validator})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _DLXTextFormFieldState();
}

class _DLXTextFormFieldState extends State<DLXTextFormField> {
  @override
  Widget build(BuildContext context) => TextFormField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        autofocus: widget.autoFocus!,
        decoration: widget.decoration,
        textInputAction: widget.textInputAction != null
            ? widget.textInputAction
            : widget.nextFocusNode != null
                ? TextInputAction.next
                : null,
        onFieldSubmitted: widget.completeAction != null
            ? widget.completeAction
            : (e) {
                if (widget.nextFocusNode != null) {
                  widget.focusNode!.unfocus();
                  FocusScope.of(context).requestFocus(widget.nextFocusNode);
                }
              },
        keyboardType: widget.numberKeyboard!
            ? TextInputType.numberWithOptions(decimal: false)
            : widget.email!
                ? TextInputType.emailAddress
                : TextInputType.text,
        validator: widget.validator,
        obscureText: widget.obscureText!,
      );
}

// remove
// var context;

void showAlertDialog(BuildContext context) {
  DLXCustomDialog.showBasicDialog(
      context,
      DLXDialogModel.alert("DLXDialogTitle",
          text: "DLXDialogText",
          backText: "DLXBackText",
          actionText: "DLXActionText", action: (dialogContext) {
        print("Do something");
        Navigator.pop(dialogContext);
      }));
}

// void showDialog() {
//   // No action button if not specified
//   DLXCustomDialog.showBasicDialog(
//       context,
//       DialogModel(
//           title: "DLXDialogTitle",
//           text: "DLXDialogText",
//           backText: "DLXBackText",
//           backAction: (dialogContext) {
//             print("Do something when user press DLX")
//             Navigator.pop(dialogContext);
//           }

//       )
//   );
// }

typedef FunctionWithContext = Function(BuildContext context);

class DLXDialogModel {
  String? text;
  String? title;
  String? actionText;
  String? backText;

  Function? backAction;
  FunctionWithContext? action;

  TextAlign? textAlign;
  MainAxisAlignment? actionsMainAxisAlignment;
  CrossAxisAlignment? dialogCrossAxisAlignment;

  DLXDialogModel(
      {this.text,
      this.title,
      this.actionText,
      this.action,
      this.backAction,
      this.backText,
      this.textAlign,
      this.actionsMainAxisAlignment});

  DLXDialogModel.alert(this.title,
      {this.text, this.backText, this.actionText, this.action}) {
    actionsMainAxisAlignment = MainAxisAlignment.spaceBetween;
    textAlign = TextAlign.left;
    dialogCrossAxisAlignment = CrossAxisAlignment.start;
  }
}

class DLXCustomDialog extends StatefulWidget {
  final DLXDialogModel? model;

  const DLXCustomDialog({Key? key, @required this.model}) : super(key: key);

  /// Use that to show a BasicDialog from the given context.
  static Future showBasicDialog(BuildContext context, model) {
    return showDialog(
        context: context, builder: (context) => DLXCustomDialog(model: model));
  }

  @override
  State<StatefulWidget> createState() => _DLXCustomDialogState();
}

class _DLXCustomDialogState extends State<DLXCustomDialog> {
  DLXDialogModel? get model => widget.model;

  // Pop the current view if there is no back action set
  void back() {
    if (model!.backAction != null) {
      return model!.backAction!();
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: FractionalOffset.center,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  constraints: BoxConstraints(maxWidth: 600.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.5),
                    color: Colors.white,
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 30.0),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 20.0),
                  child: Material(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: model!.dialogCrossAxisAlignment ??
                            CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          title,
                          text,
                          actions,
                        ],
                      )))
            ]));
  }

  Widget get title => model!.title == null
      ? SizedBox()
      : Text(model!.title!,
          style: TextStyle(fontSize: 18.0),
          textAlign: model!.textAlign ?? TextAlign.center);

  Widget get text => model!.text == null
      ? SizedBox()
      : Padding(
          padding: EdgeInsets.only(top: 10.0),
          child: Text(model!.text!,
              style: TextStyle(fontSize: 16.0),
              textAlign: model!.textAlign ?? TextAlign.center));

  Widget get actions => Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          backButton,
          model!.action != null ? SizedBox(width: 20.0) : Container(),
          actionButton()
        ]..removeWhere(
            (e) => e == null), // We don't want null values in the widget list
      ));

  Widget get backButton => DLXOutlinedButton(
        text: model!.backText ?? "Retour",
        onPressed: back,
      );

  Widget actionButton() {
    // We don't want to show anything if there's no special action specified
    if (model!.action != null)
      return DLXElevatedButton(
          text: model!.actionText, onPressed: () => model!.action!(context));

    return Container();
  }
}

abstract class DLXWidgetState<T extends StatefulWidget> extends State<T> {
  ThemeData get theme => Theme.of(context);

  TextTheme get textTheme => theme.textTheme;

  // Translations get translation => Translations.of(context);
}

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends DLXWidgetState<MyWidget> {
  @override
  Widget build(BuildContext context) {
    print(textTheme);
    // print(translation);
    print(theme);
    return Container();
  }
}

class DLXSliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double? expandedHeight;
  final bool? overlapsContent;
  //

  final Widget? leading;
  final Widget? trailing;
  final Widget? title;
  final bool? floating;
  final bool? pinned;

  DLXSliverPersistentHeaderDelegate(
      {this.leading,
      this.trailing,
      this.title,
      this.floating,
      this.pinned,
      this.overlapsContent = false,
      this.expandedHeight = 120});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // var _opacity = ((shrinkOffset / expandedHeight) * 10) == double.infinity
    //     ? 1.0
    //     : ((expandedHeight / shrinkOffset) - 1);

    return Padding(
      padding: EdgeInsets.only(left: 50, right: 50, top: 40),
      child: Opacity(
        opacity: 1 - shrinkOffset / expandedHeight!,
        child: Material(
          type: MaterialType.card,
          // color: Colors.red,
          clipBehavior: Clip.antiAlias,
          elevation: shrinkOffset / expandedHeight!,
          borderRadius: BorderRadius.circular(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // MenuButton

              leading != null
                  ? leading!
                  : Container(
                      // child: Text('data'),
                      ),

              // Title

              this.title != null ? title! : Container(),

              trailing != null ? trailing! : Container(),

              // Spacer
            ],
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight!;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

class DLXSliverAppBar extends StatelessWidget {
  final Widget? leading;
  final Widget? trailing;
  final Widget? title;
  final double? expandedHeight;
  final bool? overlapsContent;
  final bool? floating;
  final bool? pinned;

  const DLXSliverAppBar(
      {Key? key,
      this.leading,
      this.trailing,
      this.title,
      this.expandedHeight = 88,
      this.overlapsContent,
      this.floating = true,
      this.pinned = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: DLXSliverPersistentHeaderDelegate(
          expandedHeight: expandedHeight,
          overlapsContent: overlapsContent,
          floating: floating,
          leading: leading,
          pinned: pinned,
          title: title,
          trailing: trailing),
      floating: true,
      pinned: true,
    );
  }
}

class DLXSearchButton extends StatelessWidget {
  const DLXSearchButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Row(
        children: <Widget>[
          Text(
            "Search",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w200,
              fontSize: 23,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.search,
            color: Theme.of(context).primaryColor,
          )
        ],
      ),
    );
  }
}

class DLXLogo extends StatelessWidget {
  final double? fontSize;
  final String? text;

  const DLXLogo({Key? key, this.fontSize = 60, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? 'flavor',
      style: Theme.of(context).textTheme.headline4!.copyWith(
          color: Theme.of(context).primaryColor,
          fontSize: this.fontSize,
          fontFamily: 'Zengo'),
    );
  }
}

class DLXAvatarDropdown extends StatefulWidget {
  const DLXAvatarDropdown({
    Key? key,
  }) : super(key: key);

  @override
  _DLXAvatarDropdownState createState() => _DLXAvatarDropdownState();
}

class _DLXAvatarDropdownState extends State<DLXAvatarDropdown> {
  @override
  Widget build(BuildContext context) {
    // FlavorAppState app = Provider.of<FlavorAppState>(context);

    return IconButton(
      icon: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor,
        backgroundImage: NetworkImage(
          'https://firebasestorage.googleapis.com/v0/b/dlxstudios-f6e64.appspot.com/o/images%2Favatar.jpg?alt=media&token=e8873df9-c4bd-48ec-bd98-515b69fa4f57',
        ),
      ),
      onPressed: () {
        // app.pushTo(
        //   '/profile',
        // );
      },
    );
  }
}

class DLXSliverBox extends StatelessWidget {
  const DLXSliverBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 300,
        margin: EdgeInsets.all(16),
        child: Material(
          elevation: 1,
          borderRadius: BorderRadius.circular(30),
          type: MaterialType.card,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 16,
                ),
                Text('Some Random ass text bro!'),
                AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(
                      'https://firebasestorage.googleapis.com/v0/b/dlxstudios-f6e64.appspot.com/o/images%2Favatar.jpg?alt=media&token=e8873df9-c4bd-48ec-bd98-515b69fa4f57'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DLXAppMenu extends StatefulWidget {
  @override
  _DLXAppMenuState createState() => _DLXAppMenuState();
}

class _DLXAppMenuState extends State<DLXAppMenu> {
  String selected = "/";

  @override
  Widget build(BuildContext context) {
    // FlavorAppState app = Provider.of<FlavorAppState>(context);
    List<Widget> _menuItems = [
      MenuItem(
        icon: Icons.dashboard,
        title: 'Dashboard',
        // onPress: () => changePage('/', app),
        path: '/',
        selected: selected == '/',
      )
    ];

    // for (var _page in app.keys) {
    //   Map page = app.pagesMap[_page];

    //   if (page.containsKey('showInMenu')) {
    //     if (page['showInMenu'] == true) {
    //       _menuItems.add(MenuItem(
    //         icon: Icons.settings,
    //         title: page['title'] ?? page['path'],
    //         onPress: () => changePage(page['path'], app),
    //         path: page['path'],
    //         selected: selected == page['path'],
    //       ));
    //     }
    //   }
    // }
    // print(app.pagesMap.keys.length);

    return Container(
      width: 280,
      padding: EdgeInsets.only(top: 0, right: 0),
      child: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Container(
                child: Center(child: DLXLogo()),
              ),
              SizedBox(
                height: 60,
              ),
              ListView(shrinkWrap: true, itemExtent: 50, children: _menuItems),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Material(
              clipBehavior: Clip.antiAlias,
              textStyle: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.white),
              borderRadius:
                  BorderRadiusDirectional.only(topEnd: Radius.circular(10)),
              color: Theme.of(context).primaryColor,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Support',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    DLXOutlinedButton(
                      onPressed: () {},
                      text: 'Preview',
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  changePage(String path, AppSettingsModel app) {
    setState(() {
      app.setCurrentPage(path);
      this.selected = path;
    });
  }
}

class MenuItem extends StatefulWidget {
  final IconData? icon;
  final String? title;
  final bool? selected;
  final String? path;
  final void Function()? onPress;

  const MenuItem(
      {Key? key,
      this.icon,
      this.title = 'item',
      this.selected,
      this.onPress,
      this.path})
      : super(key: key);
  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  int duration = 200;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPress,
      child: Container(
        height: 200,
        width: 200,
        margin: EdgeInsets.all(1),
        child: Material(
          clipBehavior: Clip.antiAlias,
          color: Colors.transparent,
          animationDuration: Duration(milliseconds: duration),
          elevation: widget.selected! ? 1 : 0,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
          child: AnimatedContainer(
            color: widget.selected!
                ? Theme.of(context).primaryColor.withOpacity(.8)
                : Colors.transparent,
            duration: Duration(milliseconds: duration),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 30,
                ),
                widget.icon != null
                    ? Icon(widget.icon,
                        color: widget.selected! ? Colors.white : null)
                    : Container(),
                SizedBox(
                  width: 16,
                ),
                Text(
                  '${widget.title}',
                  style: widget.selected!
                      ? Theme.of(context)
                          .primaryTextTheme
                          .headline6!
                          .copyWith(color: Colors.white.withOpacity(.9))
                      : Theme.of(context).primaryTextTheme.headline6!.copyWith(
                          fontWeight: FontWeight.w500,
                          color:
                              Theme.of(context).primaryColor.withOpacity(.6)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
