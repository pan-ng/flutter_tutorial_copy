import 'package:flutter/material.dart';

/// for iOS, see https://github.com/mac-cain13/R.swift
/// Also Android https://developer.android.com/guide/topics/resources/providing-resources
/// We create the concept of R class here for referencing purposesx
var R = Resource();

const bool showUntranslatedWarning = false;
String languageCode = "zh_CN";

class Resource {
  var string = StringResource();
  var map = MapResource();
  var image = ImageResource();
  var dimen = DimenResource();
  var style = StyleResource();
  var color = ColorResource();
  var fontSize = FontSizeResource();
}

class FontSizeResource {
  var textField = FontSize(20);
}

class StringResource {
  String appName() => localize("Simple Interest Calculator", zhCN: "简单利息计算器");

  String usDollar() => localize("US Dollar");

  String singaporeDollar() => localize("Singapore Dollar");

  String hongKongDollar() => localize("Hong Kong Dollar");

  String defaultCurrencyCode() => "USD";

  String labelPrinciple() => localize("Principle");

  String hintPrinciple() => localize("Enter Principle e.g. 12000");

  String labelRateOfInterest() => localize("Rate of interest");

  String hintRateOfInterest() => localize("Enter Rate of interest e.g. 12%");

  String labelTerm() => localize("Term");

  String hintTimeInYears() => localize("Time in years");

  /// use this method for strings that can be translated or just hardcode
  static String localize(String en, {String zhCN, bool translatable = true}) {
    var s = en;
    if (translatable) {
      switch (languageCode) {
        case "zh_CN":
          s = zhCN;
          break;
      }
      if (showUntranslatedWarning && s == null) {
        s = "???[$languageCode]";
      }
    }
    return s ?? en;
  }
}

class MapResource {
  Map<String, String> currencies() {
    return {'USD': R.string.usDollar(), 'SGD': R.string.singaporeDollar(), 'HKD': R.string.hongKongDollar()};
  }
}

class ImageResource {
  final coin = AssetImage("images/coin.png");
}

class DimenResource {
  final double margin = 10;
}

class StyleResource {
  ThemeData appTheme() => ThemeData(primaryColor: R.color.primaryColor, accentColor: R.color.accentColor, brightness: Brightness.dark);

  TextStyle inputErrorStyle() => _textStyle(error: true, focused: false, fontSize: FontSize.SS);

  InputBorder focusedErrorBorder() => _inputBorder(error: true, focused: true);

  InputBorder inputErrorBorder() => _inputBorder(error: true);

  InputBorder inputBorder() => _inputBorder();

  TextStyle textfieldStyle() => TextStyle(inherit: true, fontSize: R.fontSize.textField.px, color: R.color.defaultTextColor);



  static _inputBorder({bool error = false, bool focused = false}) {
    try {
      return OutlineInputBorder(
          borderSide: error ? BorderSide(color: focused ? R.color.inputErrorFocusColor : R.color.inputErrorColor) : BorderSide(),
          borderRadius: BorderRadius.circular(5.0));
    } catch (e) {
      return Border.all();
    }
  }

  static _textStyle({bool error = false, bool focused = false, FontSize fontSize = FontSize.M}) {
    var color = R.color.defaultTextColor;
    if (focused) {
      color = R.style.appTheme().accentColor;
    }

    if (error) {
      color = R.color.inputErrorColor;
      if (focused) {
        color = R.color.inputErrorFocusColor;
      }
    }

    return TextStyle(color: color, fontSize: fontSize.px);
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

class ColorResource {
  final primaryColor = Colors.indigo;
  final accentColor = Colors.indigoAccent;
  final defaultTextColor = Colors.white;
  final inputErrorColor = Colors.redAccent;
  final inputErrorFocusColor = Colors.indigoAccent;
}
