// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlavorAppModel _$FlavorAppModelFromJson(Map<String, dynamic> json) {
  return FlavorAppModel(
    vars: json['vars'] as Map<String, dynamic>,
    splash: json['splash'] as Map<String, dynamic>,
    title: json['title'] as String,
    author: json['author'] as String,
    website: json['website'] as String,
    requireLogin: json['requireLogin'] as bool,
    firebaseConfig: json['firebaseConfig'] as Map<String, dynamic>,
    breakpoints: json['breakpoints'] as Map<String, dynamic>,
    theme: json['theme'] as Map<String, dynamic>,
    pages: json['pages'] as Map<String, dynamic>,
    plugins: json['plugins'] as Map<String, dynamic>,
    id: json['id'] as String,
    image: json['image'] as String,
  );
}

Map<String, dynamic> _$FlavorAppModelToJson(FlavorAppModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'title': instance.title,
      'author': instance.author,
      'website': instance.website,
      'requireLogin': instance.requireLogin,
      'firebaseConfig': instance.firebaseConfig,
      'breakpoints': instance.breakpoints,
      'theme': instance.theme,
      'splash': instance.splash,
      'pages': instance.pages,
      'plugins': instance.plugins,
      'vars': instance.vars,
    };
