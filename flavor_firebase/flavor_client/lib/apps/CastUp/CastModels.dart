import 'dart:math';

import 'package:flutter/foundation.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';

List<String> jobTypes = [
  "Any",
  "Acting - Acrobatics/Stunts",
  "Acting - Comedy/Clown",
  "Acting - Variety Acts",
  "Commercials - Non-SAG",
  "Commercials - SAG-AFTRA",
  "Crew - Acounting/Payroll/HR",
  "Crew - Assistant & Entry Level",
  "Crew - Camera/Editor",
  "Crew - Graphic/Web/Animation",
  "Crew - Lighting/Sound",
  "Crew - Make Up/ Stylist",
  "Crew - Management",
  "Crew - Marketing / PR",
  "Crew - Other",
  "Crew - Producer/Director",
  "Crew - Showbiz Internship",
  "Crew - TV/Radio",
  "Crew - Talent/Casting Mgmtv",
  "Crew - Technology/MIS",
  "Crew - Writing/Script/Edit",
  "Dance - Ballet/Classic",
  "Dance - Choreography",
  "Dance - Club/Gogo",
  "Dance - HipHop",
  "Dance - Modern/Jazz",
  "Dance - Other/General",
  "Dance - Teacher",
  "Dance - Traditional/Latin",
  "Episodic TV - AFTRA",
  "Episodic TV - Non-Union",
  "Episodic TV - Pilots",
  "Episodic TV - SAG-AFTRA",
  "Extras",
  "Feature Film - Documentaries",
  "Feature Film - Low Budget/Independent",
  "Feature Film - Non-SAG",
  "Feature Film - SAG-AFTRA",
  "Feature Film - Short Film",
  "Feature Film - Student Films",
  "Industrial/Traning Films",
  "Infomercials",
  "Internet",
  "Modeling - Hair/Cosmetics",
  "Modeling - Print",
  "Modeling - Runway",
  "Music - Band",
  "Music - DJ/Sound",
  "Music - Drums",
  "Music - Horns",
  "Music - Keyboards",
  "Music - Other",
  "Music - Strings",
  "Music - Teacher",
  "Music - Vocals",
  "Music Videos",
  "Reality TV",
  "Theatre - Equity (Union)",
  "Theatre - Non-Equity",
  "Trade Shows/Live Events/Promo Model",
  "Voice-Over",
];

List<String> jobTitles = [
  'Lion King on Ice',
  'Childs Play',
  '',
  '',
  '',
  '',
];

List jobs = List.generate(200, (index) {
  var job = JobObject();

  /// Add 3 tags

  for (var i = 0; i < 3; i++) {}
  job.tags.add(jobTypes[Random().nextInt(jobTypes.length)]);
  print(job);
  return job;
});

class JobObject {
  String title = "";
  List tags = [];
}

class CastUpAppState extends ChangeNotifier {
  BuildContext _context;
  BuildContext get context => _context;
  CastUpAppState(this._context);

  init() {
    // this._context
    // print(jobs.length);
  }
}
