import 'package:flutter/material.dart';

import 'generated/i18n.dart';

/// for iOS, see https://github.com/mac-cain13/R.swift
/// Also Android https://developer.android.com/guide/topics/resources/providing-resources
/// We create the concept of R class here for referencing purposes (something similar)

class R {
  /// for string we use "flutter i18n" plugin
  /// https://plugins.jetbrains.com/plugin/10128-flutter-i18n
  static var map = MapResource();
  static var image = ImageResource();
  static var dimen = DimenResource();
  static var style = StyleResource();
  static var color = ColorResource();
  static var fontSize = FontSizeResource();
  static var string = StringResource();
}

class StringResource {

  ContextString get appName => (context, [args]) => S.of(context).appName;
  ContextString get delete => (context, [args]) => S.of(context).delete;
  ContextString get errorNoInternet => (context, [args]) => S.of(context).errorNoInternet;
  ContextString get hintNoteDescription => (context, [args]) => S.of(context).hintNoteDescription;
  ContextString get hintNoteTitle => (context, [args]) => S.of(context).hintNoteTitle;
  ContextString get labelNoteDescription => (context, [args]) => S.of(context).labelNoteDescription;
  ContextString get labelNoteTitle => (context, [args]) => S.of(context).labelNoteTitle;
  ContextString get priorityHigh => (context, [args]) => S.of(context).priorityHigh;
  ContextString get priorityLow => (context, [args]) => S.of(context).priorityLow;
  ContextString get priorityMedium => (context, [args]) => S.of(context).priorityMedium;
  ContextString get save => (context, [args]) => S.of(context).save;
  ContextString get testAction1 => (context, [args]) => S.of(context).testAction1;
  ContextString get titleAddNote => (context, [args]) => S.of(context).titleAddNote;
  ContextString get titleNoteDetail => (context, [args]) => S.of(context).titleNoteDetail;
  ContextString get titleNoteList => (context, [args]) => S.of(context).titleNoteList;
  ContextString get titleTestScreen => (context, [args]) => S.of(context).titleTestScreen;
  ContextString get tooltipAddFab => (context, [args]) => S.of(context).tooltipAddFab;
  ContextString get debugTestAction1 => (context, [args]) => S.of(context).debugTestAction1;
  ContextString get genres => (context, [args]) => S.of(context).genres;
  ContextString get retry => (context, [args]) => S.of(context).retry;
}


typedef ContextString = String Function(BuildContext, [List<String> args]);

 
/// naming convention
/// <classname><summary/description/context>
/// textField
/// textFieldLogin
class FontSizeResource {
  var textField = FontSize.M;
}

class MapResource {}

class ImageResource {
  Image cellphoneArrowDown({Color color}) =>
      Image.asset("images/ic_cellphone_arrow_down_white_48dp.png", color: color);
}

///
/// 1dp = 1lp (lp = logical pixel)
/// Flutter uses logical pixel
class DimenResource {
  final double margin = 8;
  final double cardElevation = 3;
  final double borderSize = 1;
  final double borderRadius = 10;
  final double buttonCornerRadius = 10;
  final double focusedBorderSize = 2;

  EdgeInsets margins({double l = 0, double t = 0, double r = 0, double b = 0, double all}) {
    return (all != null)
        ? EdgeInsets.all(R.dimen.margin * all)
        : EdgeInsets.only(
            left: l * R.dimen.margin,
            top: t * R.dimen.margin,
            right: r * R.dimen.margin,
            bottom: b * R.dimen.margin);
  }
}

/// naming convention
/// 1) functions should have no param or just BuildContext
/// 2) <caller_class_name_abbrivated><parameter_name_that_result_will_pass_to>
class StyleResource {
  ThemeData appTheme() => ThemeData(
      primaryColor: R.color.primaryColor,
      accentColor: R.color.accentColor,
      buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: R.color.borderColor, width: R.dimen.borderSize, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(R.dimen.buttonCornerRadius))),
      brightness: R.color.brightness,
      scaffoldBackgroundColor: R.color.scaffoldBackgroundColor,
      appBarTheme: AppBarTheme(color: R.color.appBarColor),
      inputDecorationTheme: InputDecorationTheme(
          border: _inputBorder(null),
          errorBorder: _inputBorder(null, error: true),
          focusedBorder: _inputBorder(null, focused: true),
          focusedErrorBorder: _inputBorder(null, focused: true, error: true)));

  TextStyle inputErrorStyle(BuildContext context) =>
      _textStyle(context, error: true, focused: false, fontSize: FontSize.SS);

  InputBorder focusedErrorBorder(BuildContext context) =>
      _inputBorder(context, error: true, focused: true);

  InputBorder inputErrorBorder(BuildContext context) => _inputBorder(context, error: true);

  InputBorder inputBorder(BuildContext context) => _inputBorder(context);

  TextStyle textfieldStyle(BuildContext context) =>
      TextStyle(inherit: true, fontSize: R.fontSize.textField.px, color: R.color.defaultTextColor);

  TextStyle raisedButtonTextStyle(BuildContext context) =>
      TextStyle(inherit: true, fontSize: FontSize.M.px, color: R.color.buttonTextColor);

  static _inputBorder(BuildContext context, {bool error = false, bool focused = false}) {
    try {
      double width = focused ? R.dimen.focusedBorderSize : R.dimen.borderSize;
      return OutlineInputBorder(
          borderSide: error
              ? BorderSide(
                  width: width,
                  color: focused ? R.color.inputErrorFocusColor : R.color.inputErrorColor)
              : BorderSide(
                  width: width,
                  color: focused ? R.color.inputBorderFocusColor : R.color.inputBorderColor),
          borderRadius: BorderRadius.circular(R.dimen.borderRadius));
    } catch (e) {
      return Border.all();
    }
  }

  static _textStyle(BuildContext context,
      {bool error = false, bool focused = false, FontSize fontSize = FontSize.M}) {
    var color = R.color.defaultTextColor;
    if (focused) {
      color = Theme.of(context).accentColor;
    }

    if (error) {
      color = R.color.inputErrorColor;
      if (focused) {
        color = R.color.inputErrorFocusColor;
      }
    }

    return TextStyle(color: color, fontSize: fontSize.px);
  }

  TextStyle listTileTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.subhead;
  }

  RaisedButton createTextRaisedButton(BuildContext context, String text, VoidCallback onPressed,
      {EdgeInsets padding}) {
    return RaisedButton(
        padding: padding == null ? R.dimen.margins(all: 2) : padding,
        color: R.color.buttonColor,
        textColor: R.color.buttonTextColor,
        onPressed: onPressed,
        child: Text(text, style: R.style.raisedButtonTextStyle(context)));
  }
}

///
/// https://stackoverflow.com/questions/21744677/how-does-the-const-constructor-actually-work
/// read about const constructor
///
class FontSize {
  final double px;

  const FontSize(this.px);

  static const XL = FontSize(28);
  static const L = FontSize(24);
  static const M = FontSize(18);
  static const S = FontSize(16);
  static const SS = FontSize(14);
}

/// naming convention
/// <color name>Color
class ColorResource {
  final brightness = Brightness.light;

  final primaryColor = Colors.blueAccent;
  final accentColor = Colors.blueAccent;
  final defaultTextColor = Colors.black;
  final iconTintColor = Colors.black38;
  final inputErrorColor = Colors.red;
  final inputErrorFocusColor = Colors.blue;

  final borderColor = Colors.grey;

  final inputBorderColor = Colors.grey;
  final inputBorderFocusColor = Colors.blue;

  final appBarColor = Colors.blueAccent;
  final scaffoldBackgroundColor = Colors.white;
  final cardBackgroundColor = Colors.white;

  final buttonColor = Colors.white;
  final buttonTextColor = Colors.black;

  final snackBarBackgroundColor = Colors.grey;
//
//  final brightness = Brightness.dark;
//
//  final primaryColor = _Colors.neonPink;
//  final accentColor = _Colors.turquoise;
//  final defaultTextColor = Colors.white;
//  final iconTintColor = Colors.white;
//  final inputErrorColor = Colors.red;
//  final inputErrorFocusColor = _Colors.turquoise;
//
//  final borderColor = Colors.grey;
//
//  final inputBorderColor = Colors.grey;
//  final inputBorderFocusColor = _Colors.turquoise;
//
//  final appBarColor = _Colors.neonPink;
//  final scaffoldBackgroundColor = _Colors.darkBlack;
//  final cardBackgroundColor = Colors.black;
//
//  //final buttonColor = _Colors.turquoise;
//  final buttonColor = Colors.black38;
//  final buttonTextColor = Colors.white;
//
//  final snackBarBackgroundColor = Colors.black;
}

class _Colors {
  static MaterialAccentColor neonPink = MaterialAccentColor(
    _neonPinkPrimaryValue,
    <int, Color>{
      100: Color(0xFFFF67FF),
      200: Color(_neonPinkPrimaryValue),
      400: Color(0xFFC324C6),
      700: Color(0xFF89008F),
    },
  );
  static final int _neonPinkPrimaryValue = 0xFFF800E6;

  static MaterialAccentColor turquoise = MaterialAccentColor(
    _turquoisePrimaryValue,
    <int, Color>{
      100: Color(0xFF75FFFF),
      200: Color(_turquoisePrimaryValue),
      400: Color(0xFF00C598),
      700: Color(0xFF008E65),
    },
  );
  static final int _turquoisePrimaryValue = 0xFF00FFCE;

  static MaterialAccentColor darkBlack = MaterialAccentColor(_darkBlackPrimaryValue, {
    100: Color(0xFF444444),
    200: Color(_darkBlackPrimaryValue),
    400: Color(0xFF222222),
    700: Color(0xFF111111),
  });

  static final int _darkBlackPrimaryValue = 0xFF333333;
}
