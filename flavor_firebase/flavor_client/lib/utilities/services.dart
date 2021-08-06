import 'dart:io';

import 'package:logger/logger.dart';

Logger log = Logger();

// bool isMobile = Platform.isAndroid || Platform.isIOS;

// bool get fIsDesktop {
//   try {
//     return Platform.isLinux || Platform.isWindows || Platform.isMacOS;
//   } catch (e) {
//     return false;
//   }
// }

bool fIsMobile = Platform.isAndroid || Platform.isIOS;

bool get fIsDesktop {
  try {
    return Platform.isLinux || Platform.isWindows || Platform.isMacOS;
  } catch (e) {
    return false;
  }
}
