import 'dart:convert';

import 'package:flutter/widgets.dart';

class FlavorButton extends StatelessWidget {
  const FlavorButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

        // onTap: () => processButton(model.ontap),

        );
  }
}

class FlavorButtonModel {
  final String onTap;
  FlavorButtonModel({
    required this.onTap,
  });

  FlavorButtonModel copyWith({
    String? onTap,
  }) {
    return FlavorButtonModel(
      onTap: onTap ?? this.onTap,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'onTap': onTap,
    };
  }

  factory FlavorButtonModel.fromMap(Map<String, dynamic> map) {
    return FlavorButtonModel(
      onTap: map['onTap'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FlavorButtonModel.fromJson(String source) =>
      FlavorButtonModel.fromMap(json.decode(source));

  @override
  String toString() => 'FlavorButtonModel(onTap: $onTap)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FlavorButtonModel && other.onTap == onTap;
  }

  @override
  int get hashCode => onTap.hashCode;
}
