import 'package:flavor/utilities/services.dart';
import 'package:flutter/material.dart';

enum DisplayType { s, m, l, xl }

const _sPortraitBreakpoint = 480.0;
const _sLandscapeBreakpoint = 480.0;

const _mPortraitBreakpoint = 500.0;
const _mLandscapeBreakpoint = 500.0;

const _lPortraitBreakpoint = 720.0;
const _lLandscapeBreakpoint = 720.0;

const _xlPortraitBreakpoint = 1080.0;
const _xlLandscapeBreakpoint = 1080.0;

DisplayType fDisplayMediaQuery(BuildContext context) {
  final orientation = MediaQuery.of(context).orientation;
  final width = MediaQuery.of(context).size.width;

  if ((orientation == Orientation.landscape &&
          width > _xlLandscapeBreakpoint) ||
      (orientation == Orientation.portrait && width > _xlPortraitBreakpoint)) {
    return DisplayType.xl;
  } else if ((orientation == Orientation.landscape &&
          width > _lLandscapeBreakpoint) ||
      (orientation == Orientation.portrait && width > _lPortraitBreakpoint)) {
    return DisplayType.l;
  } else if ((orientation == Orientation.landscape &&
          width > _mLandscapeBreakpoint) ||
      (orientation == Orientation.portrait && width > _mPortraitBreakpoint)) {
    return DisplayType.m;
  } else {
    return DisplayType.s;
  }
}

DisplayType fMediaQuery(BuildContext context, double width) {
  final orientation = MediaQuery.of(context).orientation;

  if ((orientation == Orientation.landscape &&
          width > _xlLandscapeBreakpoint) ||
      (orientation == Orientation.portrait && width > _xlPortraitBreakpoint)) {
    return DisplayType.xl;
  } else if ((orientation == Orientation.landscape &&
          width > _lLandscapeBreakpoint) ||
      (orientation == Orientation.portrait && width > _lPortraitBreakpoint)) {
    return DisplayType.l;
  } else if ((orientation == Orientation.landscape &&
          width > _mLandscapeBreakpoint) ||
      (orientation == Orientation.portrait && width > _mPortraitBreakpoint)) {
    return DisplayType.m;
  } else {
    return DisplayType.s;
  }
}

bool fMediaQueryFromWidth(double width, DisplayType displayType) {
  log.wtf(displayTypeWidth(displayType));
  log.wtf(width);
  if (width <= displayTypeWidth(displayType)) {
    return true;
  } else {
    return false;
  }
}

bool fMediaQueryFromDisplayType(DisplayType from, DisplayType to) {
  return displayTypeWidth(from) <= displayTypeWidth(to);
}

double displayTypeWidth(DisplayType displayType) {
  if (displayType == DisplayType.xl) {
    return _xlLandscapeBreakpoint;
  } else if (displayType == DisplayType.l) {
    return _lLandscapeBreakpoint;
  } else if (displayType == DisplayType.m) {
    return _mLandscapeBreakpoint;
  } else {
    return _sLandscapeBreakpoint;
  }
}
