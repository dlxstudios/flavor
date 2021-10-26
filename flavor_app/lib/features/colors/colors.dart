import 'dart:ui';

class FlavorColor {
  Color get value => _value;
  late Color _value;
  final String colorValue;
  FlavorColor(
    this.colorValue,
  ) {
    // print(selected);
    // print('1:colorValue::$colorValue');
    String valueString = colorValue.split('0x')[1]; // kind of hacky..

    // print('2:colorValue::${valueString}');

    int __value = int.parse(valueString, radix: 16);
    Color otherColor = Color(__value);

    // print('3:colorValue::$otherColor');
    // _value = Color(int.parse(colorValue));
    _value = otherColor;
  }

  @override
  String toString() => 'FlavorColor(_value: $_value)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FlavorColor && other._value == _value;
  }

  @override
  int get hashCode => _value.hashCode;
}

class FlavorColors {
  static String transparent = '0x00000000';
  static String aliceBlue = '0xFFF0F8FF';
  static String antiqueWhite = '0xFFFAEBD7';
  static String aqua = '0xFF00FFFF';
  static String aquamarine = '0xFF7FFFD4';
  static String azure = '0xFFF0FFFF';
  static String beige = '0xFFF5F5DC';
  static String bisque = '0xFFFFE4C4';
  static String black = '0xFF000000';
  static String blanchedAlmond = '0xFFFFEBCD';
  static String blue = '0xFF0000FF';
  static String blueViolet = '0xFF8A2BE2';
  static String brown = '0xFFA52A2A';
  static String burlyWood = '0xFFDEB887';
  static String cadetBlue = '0xFF5F9EA0';
  static String chartreuse = '0xFF7FFF00';
  static String chocolate = '0xFFD2691E';
  static String coral = '0xFFFF7F50';
  static String cornflowerBlue = '0xFF6495ED';
  static String cornsilk = '0xFFFFF8DC';
  static String crimson = '0xFFDC143C';
  static String cyan = '0xFF00FFFF';
  static String darkBlue = '0xFF00008B';
  static String darkCyan = '0xFF008B8B';
  static String darkGoldenRod = '0xFFB8860B';
  static String darkGray = '0xFFA9A9A9';
  static String darkGreen = '0xFF006400';
  static String darkGrey = '0xFFA9A9A9';
  static String darkKhaki = '0xFFBDB76B';
  static String darkMagenta = '0xFF8B008B';
  static String darkOliveGreen = '0xFF556B2F';
  static String darkOrange = '0xFFFF8C00';
  static String darkOrchid = '0xFF9932CC';
  static String darkRed = '0xFF8B0000';
  static String darkSalmon = '0xFFE9967A';
  static String darkSeaGreen = '0xFF8FBC8F';
  static String darkSlateBlue = '0xFF483D8B';
  static String darkSlateGray = '0xFF2F4F4F';
  static String darkSlateGrey = '0xFF2F4F4F';
  static String darkTurquoise = '0xFF00CED1';
  static String darkViolet = '0xFF9400D3';
  static String deepPink = '0xFFFF1493';
  static String deepSkyBlue = '0xFF00BFFF';
  static String dimGray = '0xFF696969';
  static String dimGrey = '0xFF696969';
  static String dodgerBlue = '0xFF1E90FF';
  static String fireBrick = '0xFFB22222';
  static String floralWhite = '0xFFFFFAF0';
  static String forestGreen = '0xFF228B22';
  static String fuchsia = '0xFFFF00FF';
  static String gainsboro = '0xFFDCDCDC';
  static String ghostWhite = '0xFFF8F8FF';
  static String gold = '0xFFFFD700';
  static String goldenRod = '0xFFDAA520';
  static String gray = '0xFF808080';
  static String green = '0xFF008000';
  static String greenYellow = '0xFFADFF2F';
  static String grey = '0xFF808080';
  static String honeyDew = '0xFFF0FFF0';
  static String hotPink = '0xFFFF69B4';
  static String indianRed = '0xFFCD5C5C';
  static String indigo = '0xFF4B0082';
  static String ivory = '0xFFFFFFF0';
  static String khaki = '0xFFF0E68C';
  static String lavender = '0xFFE6E6FA';
  static String lavenderBlush = '0xFFFFF0F5';
  static String lawnGreen = '0xFF7CFC00';
  static String lemonChiffon = '0xFFFFFACD';
  static String lightBlue = '0xFFADD8E6';
  static String lightCoral = '0xFFF08080';
  static String lightCyan = '0xFFE0FFFF';
  static String lightGoldenRodYellow = '0xFFFAFAD2';
  static String lightGray = '0xFFD3D3D3';
  static String lightGreen = '0xFF90EE90';
  static String lightGrey = '0xFFD3D3D3';
  static String lightPink = '0xFFFFB6C1';
  static String lightSalmon = '0xFFFFA07A';
  static String lightSeaGreen = '0xFF20B2AA';
  static String lightSkyBlue = '0xFF87CEFA';
  static String lightSlateGray = '0xFF778899';
  static String lightSlateGrey = '0xFF778899';
  static String lightSteelBlue = '0xFFB0C4DE';
  static String lightYellow = '0xFFFFFFE0';
  static String lime = '0xFF00FF00';
  static String limeGreen = '0xFF32CD32';
  static String linen = '0xFFFAF0E6';
  static String magenta = '0xFFFF00FF';
  static String maroon = '0xFF800000';
  static String mediumAquaMarine = '0xFF66CDAA';
  static String mediumBlue = '0xFF0000CD';
  static String mediumOrchid = '0xFFBA55D3';
  static String mediumPurple = '0xFF9370DB';
  static String mediumSeaGreen = '0xFF3CB371';
  static String mediumSlateBlue = '0xFF7B68EE';
  static String mediumSpringGreen = '0xFF00FA9A';
  static String mediumTurquoise = '0xFF48D1CC';
  static String mediumVioletRed = '0xFFC71585';
  static String midnightBlue = '0xFF191970';
  static String mintCream = '0xFFF5FFFA';
  static String mistyRose = '0xFFFFE4E1';
  static String moccasin = '0xFFFFE4B5';
  static String navajoWhite = '0xFFFFDEAD';
  static String navy = '0xFF000080';
  static String oldLace = '0xFFFDF5E6';
  static String olive = '0xFF808000';
  static String oliveDrab = '0xFF6B8E23';
  static String orange = '0xFFFFA500';
  static String orangeRed = '0xFFFF4500';
  static String orchid = '0xFFDA70D6';
  static String paleGoldenRod = '0xFFEEE8AA';
  static String paleGreen = '0xFF98FB98';
  static String paleTurquoise = '0xFFAFEEEE';
  static String paleVioletRed = '0xFFDB7093';
  static String papayaWhip = '0xFFFFEFD5';
  static String peachPuff = '0xFFFFDAB9';
  static String peru = '0xFFCD853F';
  static String pink = '0xFFFFC0CB';
  static String plum = '0xFFDDA0DD';
  static String powderBlue = '0xFFB0E0E6';
  static String purple = '0xFF800080';
  static String rebeccaPurple = '0xFF663399';
  static String red = '0xFFFF0000';
  static String rosyBrown = '0xFFBC8F8F';
  static String royalBlue = '0xFF4169E1';
  static String saddleBrown = '0xFF8B4513';
  static String salmon = '0xFFFA8072';
  static String sandyBrown = '0xFFF4A460';
  static String seaGreen = '0xFF2E8B57';
  static String seaShell = '0xFFFFF5EE';
  static String sienna = '0xFFA0522D';
  static String silver = '0xFFC0C0C0';
  static String skyBlue = '0xFF87CEEB';
  static String slateBlue = '0xFF6A5ACD';
  static String slateGray = '0xFF708090';
  static String slateGrey = '0xFF708090';
  static String snow = '0xFFFFFAFA';
  static String springGreen = '0xFF00FF7F';
  static String steelBlue = '0xFF4682B4';
  static String tan = '0xFFD2B48C';
  static String teal = '0xFF008080';
  static String thistle = '0xFFD8BFD8';
  static String tomato = '0xFFFF6347';
  static String turquoise = '0xFF40E0D0';
  static String violet = '0xFFEE82EE';
  static String wheat = '0xFFF5DEB3';
  static String white = '0xFFFFFFFF';
  static String whiteSmoke = '0xFFF5F5F5';
  static String yellow = '0xFFFFFF00';
  static String yellowGreen = '0xFF9ACD32';
}
