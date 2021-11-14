import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jsonparseflutter/login.dart';
import 'package:http/http.dart' as http;
import 'package:jsonparseflutter/constants.dart' as constant;
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => Login()),
          (Route<dynamic> route) => false);
    }
  }

  getRestoData() async {
      Uri restoUri = Uri.parse(
        'https://zippy-server-1.herokuapp.com/restaurant?from=0&size=10');
    String token = '618be9b8479293e09d8e00c3';
    final restoRespo = await http.get(
      restoUri,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        "accessToken": token
      },
    );
    var jsondata = json.decode(restoRespo.body);

    if (restoRespo.statusCode == 200) {
      print('restaurant data is : $jsondata');
    } else {
      print('failed to load resto data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page", style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              sharedPreferences.clear();
              sharedPreferences.commit();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (BuildContext context) => Login()),
                  (Route<dynamic> route) => false);
            },
            child: Text("Log Out", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Center(
          child: ElevatedButton(
            child: Text('Get Restos'),
        onPressed: () {
            getRestoData();
        },
      )),
      drawer: Drawer(),
    );
  }
}