import 'package:flutter/material.dart';
import './wether_main.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final _citycontroller = new TextEditingController();
  bool _valid = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("weather"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: new Stack(
        children: <Widget>[
          new Center(
            child: new Image.asset(
              'images/white_snow.png',
              fit: BoxFit.fill,
              height: 1200.0,
              width: 400.0,
            ),
          ),
          new ListView(
            children: <Widget>[
              new ListTile(
                title: new TextField(
                  controller: _citycontroller,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Enter the city',
                    errorText: _valid ? 'enter the value' : null,
                  ),
                ),
              ),
              new ListTile(
                  title: new FlatButton(
                onPressed: () {
                  if (_citycontroller.text.isEmpty) {
                    _valid = true;
                  } else {
                    _valid = false;
                    var router =
                        new MaterialPageRoute(builder: (BuildContext context) {
                      return new home(
                        city_n: _citycontroller.text,
                      );
                    });
                    Navigator.of(context).push(router);
                  }
                },
                child: new Text('Check Temp'),
                textColor: Colors.white,
                color: Colors.blue,
              ))
            ],
          ),
        ],
      ),
    );
  }
}
