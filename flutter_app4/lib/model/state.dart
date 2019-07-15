import 'package:flutter/material.dart';

import 'dart:math';

abstract class BlocState {}

abstract class BlocLoadingState extends BlocState {

}

abstract class BlockContentState extends BlocState {}

abstract class BlocMessageState extends BlocState {
  String displayMessage(BuildContext context);
}


