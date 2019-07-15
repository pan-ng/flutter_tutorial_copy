import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
      child: Container(
          padding: EdgeInsets.only(left: 10, top: 40, right: 10),
          alignment: Alignment.center,
          color: Colors.deepPurple,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  centerText("Pan Ng"),
                  centerText(
                      "From Singapore but partially from Hong Kong and Cape Town",
                      fontSize: 20.0)
                ],
              ),
              Row(
                children: <Widget>[
                  centerText("Kelvin Tan"),
                  centerText("From Singapore", fontSize: 20.0)
                ],
              ),
              FlightImageAsset(),
              FlightBookButton()
            ],
          )));

  Widget centerText(String title, {double fontSize = 35.0}) => Expanded(
          child: Container(
              child: Text(
        title,
        textDirection: TextDirection.ltr,
        style: TextStyle(
            color: Colors.white,
            decoration: TextDecoration.none,
            fontSize: fontSize,
            fontFamily: 'OpenSansCondensed',
            fontWeight: FontWeight.w700),
      )));
}

class Images {
  static var airplane = AssetImage('images/airplane.png');
}

class FlightImageAsset extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container(
        margin: EdgeInsets.only(top: 24),
        child: Image(
          image: Images.airplane,
          width: 256,
          height: 256,
        ));
  }
}

class FlightBookButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(24),
      width: 256,
      child: RaisedButton(
          padding: EdgeInsets.all(8),
          child: Text(
            "Book flight",
            style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700),
          ),
          color: Colors.red,
          elevation: 12.0,
          onPressed: () => bookFlight(context)
          //action
          ),
    );
  }

  void bookFlight(BuildContext context) {
    var ctx = context;
    var alertDialog = AlertDialog(
      title: Text("Flight booked successfully"),
      content: Text("Have a nice flught"),
      actions: <Widget>[
        FlatButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.pop(ctx);
            }
            //action
            )
      ],
    );
    showDialog(
        context: context, builder: (BuildContext context) => alertDialog);
  }
}
