import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hivemind_app/models/apiary.model.dart';
import 'package:hivemind_app/utils/HelperWidgets.dart';
import 'package:hivemind_app/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class LocationCard extends StatefulWidget {
  const LocationCard({super.key, required this.apiary});
  final Apiary apiary;

  @override
  State<LocationCard> createState() => _LocationCardState();
}

class _LocationCardState extends State<LocationCard> {
  var weather = "";
  @override
  void initState() {
    super.initState();
    // getWeather(lat: widget.apiary.latitude, lng: widget.apiary.longitude);
  }

  // Future getWeather({lat, lng}) async {
  //   const String API_KEY = "e1374b46eeca4be471688468a060334f";
  //   try {
  //     String baseURL = 'https://api.openweathermap.org/data/2.5/weather';
  //     String request =
  //         '$baseURL?lat=$lat&lon=$lng&exclude=minutely,hourly,daily,alerts&appid=$API_KEY';
  //     var response = await http.get(Uri.parse(request));
  //     var data = jsonDecode(response.body);
  //     print(response.body.toString());
  //     if (response.statusCode == 200) {
  //       print(response.body.toString());
  //       setState(() {
  //         weather = data["weather"][0]["main"];
  //       });
  //     } else {
  //       throw Exception('Failed to load weather');
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorManager.CARD_BG,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        padding: EdgeInsets.all(10),
        child: Column(
          spacing: 10,
          children: [
            Row(
              spacing: 10,
              children: [
                iconBox(Icons.location_on_outlined,
                    Theme.of(context).colorScheme.primary),
                Flexible(
                  child: Tooltip(
                    message: widget.apiary.getLocation(),
                    child: Text(widget.apiary.getLocation(),
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
              ],
            ),
            Row(
              spacing: 10,
              children: [
                iconBox(
                    Icons.cloud_queue, Theme.of(context).colorScheme.primary),
                Text(
                  widget.apiary.weather!,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
