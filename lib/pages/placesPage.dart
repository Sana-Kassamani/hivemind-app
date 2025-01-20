import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hivemind_app/utils/HelperWidgets.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class GoogleMapSearchPlacesApi extends StatefulWidget {
  const GoogleMapSearchPlacesApi({super.key});

  @override
  State<GoogleMapSearchPlacesApi> createState() =>
      _GoogleMapSearchPlacesApiState();
}

class _GoogleMapSearchPlacesApiState extends State<GoogleMapSearchPlacesApi> {
  final _controller = TextEditingController();
  var uuid = const Uuid();
  String _sessionToken = '1234567890';
  List<dynamic> _placeList = [];
  var placeId;
  var desc;
  var _lat;
  var _lng;
  var weather;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _onChanged();
    });
  }

  _onChanged() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(_controller.text);
  }

  void getSuggestion(String input) async {
    const String PLACES_API_KEY = "AIzaSyDdMDAiVG9qJjLqXBY1YrIVFNUgMU0H9Pw";

    try {
      String baseURL =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      String request =
          '$baseURL?input=$input&key=$PLACES_API_KEY&sessiontoken=$_sessionToken';
      var response = await http.get(Uri.parse(request));
      var data = json.decode(response.body);
      if (kDebugMode) {
        print('mydata');
        print(data);
      }
      if (response.statusCode == 200) {
        setState(() {
          _placeList = json.decode(response.body)['predictions'];
        });
      } else {
        throw Exception('Failed to load predictions');
      }
    } catch (e) {
      print(e);
    }
  }

  void getLocation(String place_id) async {
    const String PLACES_API_KEY = "AIzaSyDdMDAiVG9qJjLqXBY1YrIVFNUgMU0H9Pw";
    try {
      String baseURL =
          'https://maps.googleapis.com/maps/api/place/details/json';
      String request =
          '$baseURL?fields=geometry&place_id=$place_id&key=$PLACES_API_KEY';
      var response = await http.get(Uri.parse(request));
      if (response.statusCode == 200) {
        print(response.body.toString());
        setState(() {
          _lat = json.decode(response.body)["result"]['geometry']["location"]
              ["lat"];
          _lng = json.decode(response.body)["result"]['geometry']["location"]
              ["lng"];
        });
      } else {
        throw Exception('Failed to load location details');
      }
    } catch (e) {
      print(e);
    }
  }

  void getWeather() async {
    const String API_KEY = "e1374b46eeca4be471688468a060334f";
    try {
      String baseURL = 'https://api.openweathermap.org/data/2.5/weather';
      String request =
          '$baseURL?lat=$_lat&lon=$_lng&exclude=minutely,hourly,daily,alerts&appid=$API_KEY';
      var response = await http.get(Uri.parse(request));
      var data = json.decode(response.body);
      print(response.body.toString());
      if (response.statusCode == 200) {
        print(response.body.toString());
        setState(() {
          weather = json.decode(response.body)["weather"][0]["main"];
        });
      } else {
        throw Exception('Failed to load weather');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Search places Api',
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Search your location here",
                focusColor: Colors.white,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                prefixIcon: const Icon(Icons.map),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.cancel),
                  onPressed: () {
                    _controller.clear();
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _placeList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    setState(() {
                      placeId = _placeList[index]["place_id"];
                      desc = _placeList[index]["description"];
                    });

                    print(_placeList[index]);
                    _controller.clear();
                  },
                  child: ListTile(
                    title: Text(_placeList[index]["description"]),
                  ),
                );
              },
            ),
          ),
          Card(
            child: Column(
              children: [
                Text(placeId.toString()),
                addVerticalSpace(20),
                Text(desc.toString())
              ],
            ),
          ),
          FilledButton(
            onPressed: () {
              getLocation(placeId);
            },
            child: Text("Get long lat"),
          ),
          Text("Lat : $_lat, Lng: $_lng"),
          FilledButton(
            onPressed: () {
              getWeather();
            },
            child: Text("Get weather"),
          ),
          Card(
            child: Text(weather.toString()),
          )
        ],
      ),
    );
  }
}
