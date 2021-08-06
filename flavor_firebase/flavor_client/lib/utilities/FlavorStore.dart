import 'dart:io';

import 'package:flavor/utilities/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  // ! valid adapter type ids are 0-223
  // ! valid field numbers are 0-255
  static const int assignmentTypeID = 1;
  static const int subjectTypeID = 2;
  static const int holidayTypeID = 3;
  static const int timeBlockTypeID = 4;
  static const int colorTypeID = 200;
  static const int timeTypeID = 201;
  static const int brightnessTypeID = 202;
  static const int themeModeTypeID = 203;

  static Future<void> initializeHiveBoxes() async {
    _registerHiveAdapters();
    // await Future.wait([
    //   Hive.openBox<HiveUser>(Databases.subjectsBox),
    //   Hive.openBox<Assignment>(Databases.assignmentsBox),
    //   Hive.openBox<dynamic>(Databases.settingsBox),
    //   Hive.openBox<Holiday>(Databases.holidaysBox),
    // ]);
  }

  static void _registerHiveAdapters() {
    // Hive.registerAdapter<Color>(ColorAdapter());
    // Hive.registerAdapter<TimeOfDay>(TimeAdapter());
    // Hive.registerAdapter<Brightness>(BrightnessAdapter());
    // Hive.registerAdapter<ThemeMode>(ThemeModeAdapter());
    // Hive.registerAdapter<Assignment>(AssignmentAdapter());
    // Hive.registerAdapter<Subject>(SubjectAdapter());
    // Hive.registerAdapter<Holiday>(HolidayAdapter());
    // Hive.registerAdapter<TimeBlock>(TimeBlockAdapter());
  }
}

class FlavorStoreInterface {
  FlavorStoreInterface({this.box, String appId = 'flavor'});

  Future<Box<dynamic>> init([String appId = 'flavor']) async {
    if (Platform.isAndroid || Platform.isIOS) {
      var dir = await getApplicationDocumentsDirectory();
      Hive.init(dir.path);
    } else if (Platform.isWindows) {
      log.e('HIVE location : .flavor ');
      Hive.init('.flavor');
    } else if (Platform.isLinux) {
      log.e('HIVE location : ~/.flavor ');
      Hive.init('~/.flavor');
    } else {
      Hive.init('');
    }
    box = await Hive.openBox(appId);
    return Future.value(box);
  }

  Box? box;

  open() async {}

  read(dynamic key) {
    return box?.get(key);
  }

  void write(dynamic key, dynamic value) {
    box?.put(key, value);
  }

  void delete(dynamic key) {
    box?.delete(key);
  }
}

final FlavorStoreInterface FlavorStore = FlavorStoreInterface();
