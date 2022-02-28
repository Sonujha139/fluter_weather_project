import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather/worker/worker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  late String city = "Saharsa";
  late String temp;
  late String hum;
  late String air_speed;
  late String des;
  late String main;
  late String icon;

  void startApp(String city) async {
    worker instance = worker(location: city);
    await instance.getData();

    temp = instance.temp; //
    hum = instance.humidity;
    air_speed = instance.air_speed;
    des = instance.description;
    main = instance.main;
    icon = instance.icon;
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        "temp_value": temp,
        "hum_value": hum,
        "air_speed_value": air_speed,
        "des_value": des,
        "main_value": main,
        "icon_value": icon,
        "city_value": city,
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState

   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map? search = ModalRoute.of(context)!.settings.arguments as Map?;

    
    if(search?.isNotEmpty ?? false)
    {
      city = search?['searchText'];
    }
     startApp(city);
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            Image.asset("assets/images/weather.png"),
            Text(
              "Weather App",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Devloped By Sonu Jha",
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: 30,
            ),
            SpinKitWave(
              color: Colors.white,
              size: 50.0,
            ),
          ],
        )),
      ),
      backgroundColor: Colors.blueAccent,
    );
  }
}
