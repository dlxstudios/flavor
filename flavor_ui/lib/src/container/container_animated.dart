import 'package:flavor_ui/flavor_ui.dart';
import 'package:flutter/widgets.dart';

class FlavorAnimatedContainer extends StatelessWidget {
  final AlignmentGeometry? alignment;

  /// Empty space to inscribe inside the [decoration]. The [child], if any, is
  /// placed inside this padding.
  final EdgeInsetsGeometry? padding;

  /// The decoration to paint behind the [child].
  ///
  /// A shorthand for specifying just a solid color is available in the
  /// constructor: set the `color` argument instead of the `decoration`
  /// argument.
  final Decoration? decoration;

  /// The decoration to paint in front of the child.
  final Decoration? foregroundDecoration;

  /// Additional constraints to apply to the child.
  ///
  /// The constructor `width` and `height` arguments are combined with the
  /// `constraints` argument to set this property.
  ///
  /// The [padding] goes inside the constraints.
  final BoxConstraints? constraints;

  /// Empty space to surround the [decoration] and [child].
  final EdgeInsetsGeometry? margin;

  /// The transformation matrix to apply before painting the container.
  final Matrix4? transform;

  /// The alignment of the origin, relative to the size of the container, if [transform] is specified.
  ///
  /// When [transform] is null, the value of this property is ignored.
  ///
  /// See also:
  ///
  ///  * [Transform.alignment], which is set by this property.
  final AlignmentGeometry? transformAlignment;

  /// The clip behavior when [AnimatedContainer.decoration] is not null.
  ///
  /// Defaults to [Clip.none]. Must be [Clip.none] if [decoration] is null.
  ///
  /// Unlike other properties of [AnimatedContainer], changes to this property
  /// apply immediately and have no animation.
  ///
  /// If a clip is to be applied, the [Decoration.getClipPath] method
  /// for the provided decoration must return a clip path. (This is not
  /// supported by all decorations; the default implementation of that
  /// method throws an [UnsupportedError].)
  final Clip clipBehavior;

  final Widget? child;

  final Color? color;
  final double? width;
  final double? height;

  final Curve curve = Curves.linear;
  final Duration? duration;
  final VoidCallback? onEnd;

  const FlavorAnimatedContainer({
    Key? key,
    this.alignment,
    this.padding,
    this.foregroundDecoration,
    this.margin,
    this.transform,
    this.transformAlignment,
    this.child,
    this.clipBehavior = Clip.none,
    this.decoration,
    this.constraints,
    this.color,
    this.width,
    this.height,
    this.duration,
    this.onEnd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// TODO: fix animation duration
    ///
    // ignore: unused_local_variable
    Theme themeStateController = Theme.of(context).theme;

    return AnimatedContainer(
      alignment: alignment,
      clipBehavior: clipBehavior,
      constraints: constraints,
      curve: curve,
      decoration: decoration,
      foregroundDecoration: foregroundDecoration,
      height: height,
      width: width,
      key: key,
      margin: margin,
      onEnd: onEnd,
      padding: padding,
      transform: transform,
      transformAlignment: transformAlignment,
      duration: defaultThemeDuration,
      color: color,
      child: child,
    );
  }
}
