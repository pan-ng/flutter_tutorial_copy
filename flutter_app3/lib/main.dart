import 'package:flutter/material.dart';

import 'res.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, title: R.string.appName(), home: SIForm(), theme: R.style.appTheme()));
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SIFormState();
}

class _SIFormState extends State<SIForm> {
  String selectedCurrencyCode = null;

  String selectedCurrency() {
    return R.map.currencies()[selectedCurrencyCode] ?? R.string.defaultCurrencyCode;
  }

  var _formKey = GlobalKey<FormState>();
  var lastCalculatedResult = "";
  var principleController = TextEditingController();
  var roiController = TextEditingController();
  var termController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedCurrencyCode = R.string.defaultCurrencyCode();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = R.style.textfieldStyle();

    InputDecoration createInputDecoration(String label, String hint) => InputDecoration(
        focusedErrorBorder: R.style.focusedErrorBorder(),
        errorBorder: R.style.inputErrorBorder(),
        errorStyle: R.style.inputErrorStyle(),
        labelStyle: textStyle,
        labelText: label,
        hintText: hint,
        border: R.style.inputBorder());

    return Scaffold(
      appBar: AppBar(
        title: Text(R.string.appName()),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.only(left: R.dimen.margin * 1, right: R.dimen.margin * 1),
          child: ListView(
            children: <Widget>[
              getCoinImage(),
              Padding(
                padding: EdgeInsets.only(top: R.dimen.margin),
                child: TextFormField(
                  validator: (String input) {
                    return (tryParseNumber(input) == null) ? "Please enter principle amount" : null;
                  },
                  controller: principleController,
                  style: textStyle,
                  keyboardType: TextInputType.number,
                  decoration: createInputDecoration(R.string.labelPrinciple(), R.string.hintPrinciple()),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: R.dimen.margin),
                child: TextFormField(
                  validator: (input) {
                    var percentage = tryParseNumber(input);
                    return (percentage == null) ? "Please enter rate of interest %" : null;
                  },
                  controller: roiController,
                  style: textStyle,
                  keyboardType: TextInputType.number,
                  decoration: createInputDecoration(R.string.labelRateOfInterest(), R.string.hintRateOfInterest()),

                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: R.dimen.margin),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: TextFormField(
                        validator: (input) {
                          var terms = double.tryParse(input);
                          return (terms == null) ? "Please enter the term in years" : null;
                        },
                        controller: termController,
                        style: textStyle,
                        keyboardType: TextInputType.number,
                            decoration: createInputDecoration(R.string.labelTerm(), R.string.hintTimeInYears()),


                      )),
                      Container(
                        width: R.dimen.margin,
                      ),
                      Expanded(
                          child: DropdownButton<String>(
                        value: selectedCurrencyCode,
                        items: R.map.currencies().entries.map((entry) {
                          return DropdownMenuItem<String>(
                            value: entry.key,
                            child: Text(
                              entry.value,
                            ),
                          );
                        }).toList(),
                        onChanged: (String selectedKey) {
                          setState(() {
                            selectedCurrencyCode = selectedKey;
                          });
                        },
                      )),
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.only(top: R.dimen.margin),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: RaisedButton(
                              color: Theme.of(context).accentColor,
                              textColor: Theme.of(context).primaryColorDark,
                              child: Text("Calculate", textScaleFactor: 1.5),
                              onPressed: () {
                                setState(() {
                                  if (_formKey.currentState.validate()) {
                                    lastCalculatedResult = _calculateTotalReturn();
                                  }
                                });
                              })),
                      Expanded(
                        child: RaisedButton(
                            color: Theme.of(context).primaryColorDark,
                            textColor: Theme.of(context).primaryColorLight,
                            child: Text("Reset", textScaleFactor: 1.5),
                            onPressed: () {
                              setState(() {
                                _reset();
                              });
                            }),
                      )
                    ],
                  )),
              Padding(
                padding: EdgeInsets.only(top: R.dimen.margin),
                child: Center(
                    child: Text(
                  lastCalculatedResult,
                  style: textStyle,
                )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getCoinImage() {
    return Container(
        margin: EdgeInsets.all(R.dimen.margin * 3),
        child: Image(
          color: Colors.lightGreenAccent,
          image: R.image.coin,
          width: 125,
          height: 125,
        ));
  }

  String _calculateTotalReturn() {
    var principle = tryParseNumber(principleController.text) ?? 0;
    var roi = tryParseNumber(roiController.text) ?? 0;
    var term = double.tryParse(termController.text) ?? 1;
    print("_calculateTotalReturn: $principle $roi $term");
    double totalAmountPayable = principle + (principle * roi * term) / 100;
    return "After $term years at ${roi}%, your investment will be worth ${totalAmountPayable} ${selectedCurrency()}";
  }

  void _reset() {
    principleController.text = "";
    roiController.text = "";
    termController.text = "";
    lastCalculatedResult = "";
    selectedCurrencyCode = R.string.defaultCurrencyCode();
  }
}

///
/// convert input string to [double] removing illegal characters
///
double tryParseNumber(String input, {List<String> invalidChars = const [",", " ", "+", "\$", "%"]}) {
  input = input?.trim();
  if (input?.isEmpty ?? true) {
    return null;
  }

  for (String invalidChar in invalidChars) {
    while (input.contains(invalidChar)) {
      input = input.replaceAll(invalidChar, "");
    }
  }
  return double.tryParse(input);
}
