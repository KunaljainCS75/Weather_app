

import 'package:flutter/material.dart';
import "package:weatheronics/Worker_Folder/worker.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class Loading extends StatefulWidget {
  const Loading ({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  late String temperature;
  late String humidity;
  late String airSpeed;
  late String climate;
  late String country;
  late String iconUrl;
  late String city;
  late String main;
  late String time;
  late String pressure;
  late String windDirection;
  late String cloudCover;
  late String visibilityKm;
  late String UVIndex;

  void startApp(city_name) async
  {
    Worker instance = Worker(city: city_name);
    await instance.getData();

    temperature = instance.temperature;
    humidity = instance.humidity;
    airSpeed = instance.windSpeed;
    climate = instance.climate;
    country = instance.country;
    iconUrl = instance.iconUrl;
    city = city_name;
    time = instance.localtime;
    pressure = instance.pressure;
    windDirection = instance.windDirection;
    cloudCover = instance.cloudCover;
    visibilityKm = instance.visibilityKm;
    UVIndex = instance.UVIndex;


    Future.delayed(const Duration(seconds: 5), (){
      Navigator.pushReplacementNamed(context, '/home',arguments: {
        "temp_value" : temperature, // in °C
        "hum_value" : humidity,     // in %
        "wind_value" : airSpeed,    // in kph
        "climate_name" : climate,   // in String
        "country_name" : country,   // in String
        "icon" : iconUrl,
        "city" : city,
        "time" : time,
        "pressure" : pressure,
        "windDir" : windDirection,
        "cloud" : cloudCover,
        "uv" : UVIndex,
        "vis" : visibilityKm
      });
      instance.getData();
    });
    // ignore: use_build_context_synchronously
  }


  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String search_city = "";
    try {
      Map search = ModalRoute
          .of(context)
          ?.settings
          .arguments as Map;
      search_city = search["searchText"];
    }
    catch(e){
      print(e);
    }

    if (search_city == "") {
      startApp("Gwalior");
    }
    else{
      startApp(search_city);
    }

    return Scaffold(

        body: Container(

          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("images/img_2.png"),
            fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              const SizedBox(
                height: 120,
              ),

              Image.asset("images/img.png", height: 120, width: 150),

              const SizedBox(
                height: 20,
              ),
            Text("Weatheronics",
                style:
                  GoogleFonts.artifika(textStyle : const TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w500,
                    color: Colors.white
                ),),
            ),
              const SizedBox(height: 5),

              Text("A perfect plan for perfect day",
                style:
                GoogleFonts.ubuntu(textStyle : const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w100,
                    color: Colors.white,
                ),),
              ),

            const SizedBox(
              height: 40,
            ),

            const SpinKitThreeBounce(
              color: Colors.white,
              size: 30.0,),

             const SizedBox(
                height: 240,
              ),

              Text("Developed by KunalCS221075",
                style:
                GoogleFonts.alice(textStyle : const TextStyle(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),),
              ),



            ],
          ),
    )
    );
  }
}