import 'dart:convert';
import 'dart:math';
import 'package:weatheronics/Worker_Folder/worker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:dynamic_weather_icons/dynamic_weather_icons.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
// Async = Function start, but return after some delay
// Future.delayed = Function start after some delay;

  TextEditingController searchFacility = TextEditingController();


  @override
  void initState() {
    super.initState();
    print("This is a init state");
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    print("setState called...");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("Widget Destroyed...");
  }

  @override
  Widget build(BuildContext context) {
    var city_name = [
      "Mumbai",
      "Gwalior",
      "Delhi",
      "Indore",
      "Bhopal",
      "London",
      "California"
    ];
    final _random = new Random();
    var city = city_name[_random.nextInt(city_name.length)];

    Map info = ModalRoute.of(context)?.settings.arguments as Map;

    String dateTime = info["time"];
    String time = dateTime.substring(11,16);
    var backgroundImage = "";

    var s1 = '06:00';
    var s2 = '17:00';
    var s3 = "20:00";

    var t1 = DateTime.parse('2000-01-01 $s1');
    var t2 = DateTime.parse('2000-01-01 $s2');
    var t3 = DateTime.parse('2000-01-01 $s3');

    var t = DateTime.parse('2000-01-01 $time');

    if(t.isBefore(t1) || t.isAfter(t3)){       //20:00 --- 06:00
      backgroundImage = "images/img_3.png";
    }
    else if (t.isAfter(t2) && t.isBefore(t3)){ // 17:00 --- 20:00
      backgroundImage = "images/img_6.png";
    }
    else{
      backgroundImage = "images/img_4.png";
    }

    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(0),
      //   child: AppBar(
      //     backgroundColor: Colors.blue[800],
      //   ),
      // ),

      resizeToAvoidBottomInset: false,

      body: SafeArea(
        top: false, // For transparent Status bar
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(backgroundImage), fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                //Search bar container
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 27),
                decoration: BoxDecoration(
                    color: Colors.white30,
                    borderRadius: BorderRadius.circular(25)),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, "/loading",
                            arguments: {
                              "searchText": searchFacility.text,
                            });
                      },
                      child: Container(
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      ),
                    ),
                    Expanded(
                        child: TextField(
                      controller: searchFacility,
                      style: const TextStyle(color: Colors.white),
                      cursorColor: Colors.black87,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search $city",
                          hintStyle: const TextStyle(color: Colors.white70)),
                    )),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white.withOpacity(0.0),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                        padding: EdgeInsets.all(2),
                        child:
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      info["city"],
                                      style: GoogleFonts.openSans(
                                          textStyle: const TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 30,
                                              color: Colors.white)),
                                    ),
                                    Text(
                                      info["country_name"],
                                      style: GoogleFonts.nunito(
                                          textStyle: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 20,
                                              color: Colors.white)),
                                    ),
                                  ],
                                ),
                              ],
                            )
                        ),
                  ),
                ],
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white.withOpacity(0),
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                        padding: EdgeInsets.all(0),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            // Image.network(
                            //   "https:" + info["icon"],
                            //   height: 64,
                            //   width: 64,
                            // ),
                            Column(
                              children: [
                                Text(info["temp_value"] + "°",
                                    style: GoogleFonts.rubik(
                                        textStyle: const TextStyle(
                                            fontSize: 50,
                                            fontWeight: FontWeight.w100,
                                            color: Colors.white))),
                                Text(
                                  "Time: " + info["time"],
                                  style: GoogleFonts.nunito(
                                      textStyle: const TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 10,
                                          color: Colors.white)),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                SizedBox(height: 30,),
                                Text(info["climate_name"],
                                    style: GoogleFonts.rubik(
                                        textStyle: const TextStyle(
                                            fontSize: 20, color: Colors.white,
                                            fontWeight: FontWeight.w100))),

                              ],
                            ),
                          ],
                        )),
                  ),
                  SizedBox(height: 120,),
                  // Expanded(child: Container(
                  //   margin: EdgeInsets.fromLTRB(100, 0, 20, 0),
                  // ))
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.black.withOpacity(0.2),
                    ),
                    child: Image.network(
                      "https:" + info["icon"],
                      height: 70,
                      width: 70,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                  SizedBox(width: 20,)
                ],
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20,0,0,0),
                child: Text("Weather Details: ",
                    style: GoogleFonts.alice(
                        textStyle: const TextStyle(
                            fontSize: 20,
                            color: Colors.white))),
              ),


              Column(
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white.withOpacity(0.2),
                            ),
                            margin: EdgeInsets.fromLTRB(20, 5, 5, 5),
                            padding: EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      WeatherIcon.getIcon('wi-day-windy'),
                                      size: 25,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 20,),
                                    Text("Wind_Speed",
                                        style: GoogleFonts.rubik(
                                            textStyle: TextStyle(
                                                fontSize: 15, color: Colors.white)))
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(width: 50,),
                                    Text(info["wind_value"],
                                        style: GoogleFonts.rubik(
                                            textStyle: TextStyle(
                                              fontSize: 20,
                                            ),
                                            color: Colors.white)),
                                    Text(" km/hr",
                                        style: GoogleFonts.rubik(
                                            textStyle: TextStyle(
                                                fontSize: 10, color: Colors.white)))
                                  ],
                                ),
                              ],
                            )),
                      ),
                      Expanded(
                        child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white.withOpacity(0.2),
                            ),
                            margin: EdgeInsets.fromLTRB(5, 5, 20, 5),
                            padding: EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      WeatherIcon.getIcon('wi-wind-direction'),
                                      size: 25,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 20,),
                                    Text("Wind_Dir",
                                        style: GoogleFonts.rubik(
                                            textStyle: TextStyle(
                                                fontSize: 15, color: Colors.white)))
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(width: 50,),
                                    Text(info["windDir"],
                                        style: GoogleFonts.rubik(
                                            textStyle: TextStyle(
                                              fontSize: 20,
                                            ),
                                            color: Colors.white)),
                                    // Text(" %",
                                    //     style: GoogleFonts.rubik(
                                    //         textStyle: TextStyle(
                                    //             fontSize: 10, color: Colors.white)))
                                  ],
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),

                ],
              ),
              Column(
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white.withOpacity(0.2),
                            ),
                            margin: EdgeInsets.fromLTRB(20, 5, 5, 5),
                            padding: EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      WeatherIcon.getIcon('wi-humidity'),
                                      size: 25,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 20,),
                                    Text("Humidity",
                                        style: GoogleFonts.rubik(
                                            textStyle: TextStyle(
                                                fontSize: 15, color: Colors.white)))
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(width: 50,),
                                    Text(info["hum_value"],
                                        style: GoogleFonts.rubik(
                                            textStyle: TextStyle(
                                              fontSize: 20,
                                            ),
                                            color: Colors.white)),
                                    Text(" %",
                                        style: GoogleFonts.rubik(
                                            textStyle: TextStyle(
                                                fontSize: 10, color: Colors.white)))
                                  ],
                                ),
                              ],
                            )),
                      ),
                      Expanded(
                        child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white.withOpacity(0.2),
                            ),
                            margin: EdgeInsets.fromLTRB(5, 5, 20, 5),
                            padding: EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      WeatherIcon.getIcon('wi-sunrise'),
                                      size: 25,
                                      color: Colors.yellow,
                                    ),
                                    SizedBox(width: 20,),
                                    Text("UV Index",
                                        style: GoogleFonts.rubik(
                                            textStyle: TextStyle(
                                                fontSize: 15, color: Colors.white)))
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(width: 50,),
                                    Text(info["uv"],
                                        style: GoogleFonts.rubik(
                                            textStyle: TextStyle(
                                              fontSize: 20,
                                            ),
                                            color: Colors.white)),
                                    // Text(" km/hr",
                                    //     style: GoogleFonts.rubik(
                                    //         textStyle: TextStyle(
                                    //             fontSize: 10, color: Colors.white)))
                                  ],
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),

                ],
              ),
              Column(
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white.withOpacity(0.2),
                            ),
                            margin: EdgeInsets.fromLTRB(20, 5, 5, 5),
                            padding: EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      WeatherIcon.getIcon('wi-barometer'),
                                      size: 25,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 20,),
                                    Text("Air Pressure",
                                        style: GoogleFonts.rubik(
                                            textStyle: TextStyle(
                                                fontSize: 15, color: Colors.white)))
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(width: 50,),
                                    Text(info["pressure"],
                                        style: GoogleFonts.rubik(
                                            textStyle: TextStyle(
                                              fontSize: 15,
                                            ),
                                            color: Colors.white)),
                                    Text(" mbar",
                                        style: GoogleFonts.rubik(
                                            textStyle: TextStyle(
                                                fontSize: 10, color: Colors.white)))
                                  ],
                                ),
                              ],
                            )),
                      ),
                      Expanded(
                        child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white.withOpacity(0.2),
                            ),
                            margin: EdgeInsets.fromLTRB(5, 5, 20, 5),
                            padding: EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      WeatherIcon.getIcon('wi-train'),
                                      size: 25,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 20,),
                                    Text("Visibility",
                                        style: GoogleFonts.rubik(
                                            textStyle: TextStyle(
                                                fontSize: 15, color: Colors.white)))
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(width: 50,),
                                    Text(info["vis"],
                                        style: GoogleFonts.rubik(
                                            textStyle: TextStyle(
                                              fontSize: 20,
                                            ),
                                            color: Colors.white)),
                                    Text(" km",
                                        style: GoogleFonts.rubik(
                                            textStyle: TextStyle(
                                                fontSize: 10, color: Colors.white)))
                                  ],
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
