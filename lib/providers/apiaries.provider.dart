import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hivemind_app/models/apiary.model.dart';
import 'package:hivemind_app/providers/beekeepers.provider.dart';
import 'package:hivemind_app/providers/hives.provider.dart';
import 'package:hivemind_app/providers/tasks.provider.dart';
import 'package:hivemind_app/utils/enums/RequestMethods.dart';
import 'package:hivemind_app/utils/request.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Apiaries extends ChangeNotifier {
  List<Apiary> _apiaries = [];
  late Apiary? _apiary;

  List<Apiary> get apiariesList => _apiaries;
  Apiary? get apiary => _apiary;
  void setApiariesList(apiaries) => _apiaries = apiaries;

  int getApiariesCount() {
    int totalSize = _apiaries.length;
    return totalSize;
  }
  // Future loadApiary({context, apiaryId}) async {
  //   try {
  //     final response =
  //         await request(route: "/apiaries/owner", method: RequestMethods.get);

  //     saveApiary(apiary: jsonDecode(response)["apiaries"], context: context);
  //   } catch (error) {
  //     rethrow;
  //   }
  // }

  // Future loadApiaries({context}) async {
  //   try {
  //     final response =
  //         await request(route: "/apiaries/owner", method: RequestMethods.get);

  //     saveApiaries(
  //         apiaries: jsonDecode(response)["apiaries"], context: context);
  //   } catch (error) {
  //     rethrow;
  //   }
  // }
  Future<String?> getWeather({lat, lng}) async {
    const String API_KEY = "e1374b46eeca4be471688468a060334f";
    try {
      String baseURL = 'https://api.openweathermap.org/data/2.5/weather';
      String request =
          '$baseURL?lat=$lat&lon=$lng&exclude=minutely,hourly,daily,alerts&appid=$API_KEY';
      var response = await http.get(Uri.parse(request));
      var data = jsonDecode(response.body);
      print(response.body.toString());
      if (response.statusCode == 200) {
        print(response.body.toString());

        String weather = data["weather"][0]["main"];
        return weather;
      } else {
        throw Exception('Failed to load weather');
      }
    } catch (e) {
      rethrow;
    }
  }

  Apiary getById({apiaryId}) {
    Apiary apiary = _apiaries.firstWhere((a) => a.id == apiaryId);
    return apiary;
  }

  Future saveApiaries({context, apiaries}) async {
    try {
      for (int i = 0; i < apiaries.length; i++) {
        var apiary = apiaries[i];
        Provider.of<Hives>(context, listen: false).save(
            context: context, apiaryId: apiary["_id"], hives: apiary["hives"]);
        Provider.of<Tasks>(context, listen: false)
            .save(apiaryId: apiary["_id"], tasks: apiary["tasks"]);
        String username = Provider.of<Beekeepers>(context, listen: false)
            .findByAssignedApiary(id: apiary["_id"]);

        final newApiary = Apiary(
          id: apiary["_id"],
          label: apiary["label"],
          location: apiary["location"],
          latitude: apiary["latitude"].toDouble(),
          longitude: apiary["longitude"].toDouble(),
          beekeeperName: username,
        );
        final weather =
            await getWeather(lat: newApiary.latitude, lng: newApiary.longitude);
        newApiary.weather = weather;
        _apiaries.add(newApiary);
      }

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future saveApiary({context, apiary}) async {
    try {
      if (apiary != null) {
        Provider.of<Hives>(context, listen: false).save(
            context: context, apiaryId: apiary["_id"], hives: apiary["hives"]);
        Provider.of<Tasks>(context, listen: false)
            .save(apiaryId: apiary["_id"], tasks: apiary["tasks"]);

        final newApiary = Apiary(
          id: apiary["_id"],
          label: apiary["label"],
          location: apiary["location"],
          latitude: apiary["latitude"].toDouble(),
          longitude: apiary["longitude"].toDouble(),
          beekeeperName: null,
        );
        final weather =
            await getWeather(lat: newApiary.latitude, lng: newApiary.longitude);
        newApiary.weather = weather;
        _apiary = newApiary;
      } else {
        _apiary = null;
      }
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future addApiary({context, apiaryLabel, location, beekeeperId}) async {
    Map<String, dynamic> data = {
      "label": apiaryLabel,
      "location": location.location,
      "longitude": location.longitude,
      "latitude": location.latitude,
      "beekeeperId": beekeeperId
    };
    try {
      final response = await request(
        route: '/apiaries',
        method: RequestMethods.post,
        data: data,
      );
      String username = Provider.of<Beekeepers>(context, listen: false)
          .findNameById(id: beekeeperId);
      //TODo make beekeeper assigned

      print('Im here');
      Apiary newApiary = Apiary(
        id: jsonDecode(response)["_id"],
        label: apiaryLabel,
        location: location.location,
        longitude: location.longitude.toDouble(),
        latitude: location.latitude.toDouble(),
        beekeeperName: username,
      );
      Provider.of<Beekeepers>(context, listen: false)
          .addAssignedApiary(apiaryId: newApiary.id, userId: beekeeperId);
      Provider.of<Hives>(context, listen: false)
          .save(context: context, apiaryId: newApiary.id, hives: []);
      Provider.of<Tasks>(context, listen: false)
          .save(apiaryId: newApiary.id, tasks: []);
      final weather =
          await getWeather(lat: newApiary.latitude, lng: newApiary.longitude);
      newApiary.weather = weather;
      _apiaries.add(newApiary);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future deleteApiary({context, apiaryId}) async {
    try {
      final response = await request(
        route: '/apiaries/$apiaryId',
        method: RequestMethods.delete,
      );
      Provider.of<Beekeepers>(context, listen: false)
          .deleteAssignedApiary(apiaryId: apiaryId);
      print("here");
      Provider.of<Hives>(context, listen: false)
          .deleteDetailsOfHive(apiaryId: apiaryId);
      Provider.of<Hives>(context, listen: false).hives.remove(apiaryId);
      Provider.of<Tasks>(context, listen: false).tasks.remove(apiaryId);
      print("here");
      Apiary apiaryToDelete = _apiaries.firstWhere((a) => a.id == apiaryId);
      _apiaries.remove(apiaryToDelete);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  void reset() {
    _apiaries = [];
    _apiary = null;
    notifyListeners();
  }
}
