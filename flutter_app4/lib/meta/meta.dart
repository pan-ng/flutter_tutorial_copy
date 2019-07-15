import 'package:flutter/material.dart';

import '../res.dart';

class Priority {
  final ColorSwatch<int> iconColor;
  final IconData iconData;
  final int id;
  final String Function(BuildContext) toStringFunc;

  const Priority(this.id, this.iconColor, this.iconData, this.toStringFunc);

  String displayString(BuildContext context) {
    return toStringFunc(context);
  }

  static bool isValidPriorityValue(int value) => high.id <= value && value <= low.id;

  static var high = Priority(0, Colors.pink, Icons.new_releases, (context) => R.string.priorityHigh(context));
  static var medium = Priority(1, Colors.amber, Icons.error, (context) => R.string.priorityMedium(context));
  static var low = Priority(2, Colors.lightGreen, Icons.error_outline, (context) => R.string.priorityLow(context));
  static var normal = medium;

  static List<Priority> asList = [high, medium, low];

  static Priority findById(int id) {
    return asList.firstWhere((p) => p.id == id);
  }

  static Map<int, Priority> asMap = asList.asMap().map((k, v) {
    return MapEntry(v.id, v);
  });

  Widget createIcon() {
//    return CircleAvatar(
//        backgroundColor: iconColor[100], child: IconButton(icon: R.image.cellphoneArrowDown(color: iconColor)));

    return CircleAvatar(backgroundColor: iconColor[100], child: Icon(Icons.brightness_1, color: iconColor));
  }
//static Map<int, PriorityMeta> prioritiesMap = Map.fromIterable(prioritiesList, key: (i) => i, value: (v) => v);
}
