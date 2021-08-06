import 'package:json_annotation/json_annotation.dart';

part 'app.g.dart';

@JsonSerializable(
    nullable: true,
    createFactory: true,
    createToJson: true,
    explicitToJson: true)
class FlavorAppModel {
  factory FlavorAppModel.fromJson(Map<String, dynamic> json) =>
      _$FlavorAppModelFromJson(json);
  Map<String, dynamic> toJson() => _$FlavorAppModelToJson(this);

  FlavorAppModel({
    this.vars,
    this.splash,
    this.title,
    this.author,
    this.website,
    this.requireLogin,
    this.firebaseConfig,
    this.breakpoints,
    this.theme,
    this.pages,
    this.plugins,
    this.id,
    this.image,
  });

  /// TODO: implement
  final String? id;

  /// TODO: implement
  final String? image;

  final String? title;
  final String? author;
  final String? website;

  /// TODO: implement
  final bool? requireLogin;

  /// TODO: implement
  final Map? firebaseConfig;

  /// TODO: implement
  final Map? breakpoints;

  /// TODO: implement
  final Map? theme;

  /// TODO: implement
  final Map? splash;

  /// TODO: implement
  final Map<String, dynamic>? pages;

  /// TODO: implement
  final Map<String, dynamic>? plugins;
  final Map<String, dynamic>? vars;
}
