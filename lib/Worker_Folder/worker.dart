import "package:http/http.dart";
import 'dart:convert';

class Worker {

  String location = "";
  String country = "";
  String climate = "";
  String temperature = "";
  String humidity = "";
  String windSpeed = "";
  String iconUrl = "";
  String localtime = "";
  String pressure = "";
  String windDirection = "";
  String cloudCover = "";
  String visibilityKm = "";
  String UVIndex = "";



  Worker({city = "Gwalior"}){
    location = city;
  }


  Future<void> getData() async {
    try {
      //Getting all data
      var url = Uri.parse(
          "https://api.weatherapi.com/v1/current.json?key=3e892b7ef47743a790455552233010&q=$location");
      Response resp = await get(url);
      Map data = jsonDecode(resp.body);

      //Storing useful data

      Map locate = data["location"];
      String getCountry = locate["country"];

      Map status = data["current"];
      Map climateCondition = status["condition"];
      String getClimate = climateCondition["text"];
      String getIconUrl = climateCondition["icon"];
      String getTemperature = status["temp_c"].toString(); // double type
      String getHumidity = status["humidity"].toString(); //double type
      String getWindSpeed = status["wind_kph"].toString();
      String getLocalTime = status["last_updated"];
      String getPressure = status["pressure_mb"].toString();
      String getWindDirection = status["wind_dir"].toString();
      String getCloudCover = status["cloud"].toString();
      String getVisibilityKm = status["vis_km"].toString();
      String getUVIndex = status["uv"].toString();



      //Assigning above values:

      country = getCountry;
      climate = getClimate;
      windSpeed = getWindSpeed.toString();
      humidity = getHumidity.toString();
      temperature = getTemperature.toString();
      iconUrl = getIconUrl;
      localtime = getLocalTime;
      pressure = getPressure;
      visibilityKm = getVisibilityKm;
      UVIndex = getUVIndex;
      windDirection = getWindDirection;
      cloudCover = getCloudCover;
    }
    catch(e){
      country = "No data";
      climate = "N/A";
      windSpeed = "N/A";
      humidity = "N/A";
      temperature = "N/A";
      iconUrl = "//cdn.weatherapi.com/weather/64x64/day/377.png";
      localtime = "----";
      pressure = "N/A";
      visibilityKm = "N/A";
      UVIndex = "N/A";
      windDirection = "N/A";
      cloudCover = "N/A";
    }
  }
}