import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import "dart:async";
import "dart:convert";
import 'package:provider/provider.dart';
import "package:geocoder/geocoder.dart";
import "package:autocomplete_textfield/autocomplete_textfield.dart";

import 'package:weather_app/services/location_service.dart';
import 'package:weather_app/widget/auto_complete.dart';
import 'package:weather_app/widget/temp_item.dart';
import 'models/temperature.dart';
import 'models/user_location.dart';
import 'widget/c_temp.dart';
import 'widget/f_temp.dart';

void main() => runApp(
      StreamProvider<UserLocation>(
        create: (context) => LocationService().locationStream,
        child: MaterialApp(
          title: "Weather",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Color(0xFF3B3B3B),
            accentColor: Colors.blue,
          ),
          home: HomeScreen(),
        ),
      ),
    );

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const API_KEY = "INSERT API KEY HERE";
  TextEditingController _inputController = new TextEditingController();
  bool loading = true;
  bool c = true;
  List<Temperature> _tempList = new List<Temperature>();
  final List<String> locations = new List<String>();
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  int listKey = 0;

  @override
  void initState() {
    _loadCitiesAsset();
    super.initState();
  }

  _loadCitiesAsset() async {
    var cities = await DefaultAssetBundle.of(context)
        .loadString("assets/city_list.json");
    var decoded = json.decode(cities);
    for (var item in decoded) {
      locations.add(item["name"] + ", " + item["country"]);
    }
    setState(() {
      loading = false;
    });
  }

  _getWeather(String query) async {
    if (query == "") {
      return;
    }

    List<String> location = query.split(",");
    String city = location[0];
    String country = location[1];
    String URL =
        "http://api.openweathermap.org/data/2.5/weather?q=${city},${country}&appid=${API_KEY}&units=metric";
    http.Response response = await http.get(Uri.encodeFull(URL));
    Map<String, dynamic> data = jsonDecode(response.body);

    // Variables for the Temperature object
    var temp = data["main"]["temp"].round();
    var minTemp = data["main"]["temp_min"].round();
    var maxTemp = data["main"]["temp_max"].round();
    String description = data["weather"][0]["description"];
    description = description[0].toUpperCase() + description.substring(1);

    Temperature t = new Temperature(
        city: city,
        country: country,
        temp: temp,
        minTemp: minTemp,
        maxTemp: maxTemp,
        description: description);

    setState(() {
      _tempList.add(t);
    });

    _inputController.clear();
  }

  _deleteItem(int index) {
    setState(() {
      _tempList.removeAt(index);
    });
  }

  Future<void> _getLocation() async {
    var userLocation = Provider.of<UserLocation>(context, listen: false);
    final coordinates =
        new Coordinates(userLocation.longitude, userLocation.latitude);
    //final address = await Geocoder.local.findAddressesFromCoordinates(coordinates);
  }

  swapTemp(){
    Function swap = c ? convertCtoF : convertFtoC;

    for (int i = 0; i < _tempList.length; i++){
      var temp = _tempList[i].temp;
      var minTemp = _tempList[i].minTemp;
      var maxTemp = _tempList[i].maxTemp;
      _tempList[i].temp = swap(temp);
      _tempList[i].minTemp = swap(minTemp);
      _tempList[i].maxTemp = swap(maxTemp);
    }
    setState((){
      c = !c;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text("Weather"),
        backgroundColor: Colors.black,
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                AutoComplete(locations: locations, submit: _getWeather),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CTemp(enabled: c, swap: swapTemp),
                    FTemp(enabled: !c, swap: swapTemp),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(bottom: 5.0),
                    itemCount: _tempList.length,
                    itemBuilder: (BuildContext context, int index) {
                      Temperature t = _tempList[index];
                      return TempItem(t, () => _deleteItem(index));
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
