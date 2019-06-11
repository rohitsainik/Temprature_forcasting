import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import '../util/utility.dart' as utils;
import 'package:http/http.dart' as http;

class home extends StatefulWidget {
  final String city_n;

  home({Key key, this.city_n}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("weather"),
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
      ),
      body: Stack(
        children: <Widget>[
          new Center(
            child: new Image.asset(
              'images/umbrella.png',
              fit: BoxFit.fill,
              height: 1000.0,
            ),
          ),
          new Container(
            alignment: Alignment.topRight,
            margin: const EdgeInsets.fromLTRB(0.0, 2.3, 3.3, 0.0),
            child: new Text(
              "${widget.city_n}",
              style: cityStyle(),
            ),
          ),
          new Container(
            margin: const EdgeInsets.fromLTRB(30.0, 350.0, 0.0, 0.0),
            child: mycontent('${widget.city_n}'),
          ),
        ],
      ),
    );
  }

  Future<Map> getJSON(String appId, String city) async {
    String apiUrl =
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=${utils.appId}&&units=imperial";
    http.Response response = await http.get(apiUrl);

    return json.decode(response.body);
  }

  Widget mycontent(String city) {
    return FutureBuilder(
        future: getJSON(utils.appId, city),
        builder: (BuildContext context, AsyncSnapshot<Map> Snapshot) {
          if (Snapshot.hasData) {
            Map content = Snapshot.data;
            return new Container(
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      'Temp: ${content['main']['temp'].toString()}F',
                      style: Tempstyle(),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Humidity:${content['main']['humidity'].toString()}',
                      style: Otherstyle(),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'min-Temp: ${content['main']['temp_min'].toString()}F',
                      style: Otherstyle(),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'max-Temp: ${content['main']['temp_max'].toString()}F',
                      style: Otherstyle(),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return new Container();
          }
        });
  }
}

TextStyle cityStyle() {
  return new TextStyle(
      fontSize: 20.5,
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic);
}

TextStyle Tempstyle() {
  return new TextStyle(
      color: Colors.white,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 40.5);
}

TextStyle Otherstyle() {
  return new TextStyle(
      color: Colors.white,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w200,
      fontSize: 20.5);
}
