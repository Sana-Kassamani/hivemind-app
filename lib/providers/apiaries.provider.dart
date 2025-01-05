import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hivemind_app/models/apiary.model.dart';
import 'package:hivemind_app/providers/beekeepers.provider.dart';
import 'package:hivemind_app/providers/hives.provider.dart';
import 'package:hivemind_app/providers/tasks.provider.dart';
import 'package:hivemind_app/utils/enums/RequestMethods.dart';
import 'package:hivemind_app/utils/request.dart';
import 'package:provider/provider.dart';

class Apiaries extends ChangeNotifier {
  List<Apiary> _apiaries = [];
  late Apiary? _apiary;

  List<Apiary> get apiariesList => _apiaries;
  Apiary? get apiary => _apiary;
  void setApiariesList(apiaries) => _apiaries = apiaries;

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
  Apiary getById({apiaryId}) {
    Apiary apiary = _apiaries.firstWhere((a) => a.id == apiaryId);
    return apiary;
  }

  void saveApiaries({context, apiaries}) {
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
      _apiaries.add(newApiary);
    }

    notifyListeners();
  }

  void saveApiary({context, apiary}) {
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
      _apiary = newApiary;
    } else {
      _apiary = null;
    }
    notifyListeners();
  }

  Future addApiary({context, apiaryLabel, location, beekeeperId}) async {
    Map<String, dynamic> data = {
      "label": apiaryLabel,
      "location": location.location,
      "longitude": location.longitude,
      "latitude": location.latitude,
      "beekeeperId": beekeeperId
    };
    final response = await request(
      route: '/apiaries',
      method: RequestMethods.post,
      data: data,
    );
    String username = Provider.of<Beekeepers>(context, listen: false)
        .findNameById(id: beekeeperId);
    print('Im here');
    Apiary newApiary = Apiary(
      id: jsonDecode(response)["_id"],
      label: apiaryLabel,
      location: location.location,
      longitude: location.longitude.toDouble(),
      latitude: location.latitude.toDouble(),
      beekeeperName: username,
    );
    Provider.of<Hives>(context, listen: false)
        .save(context: context, apiaryId: newApiary.id, hives: []);
    Provider.of<Tasks>(context, listen: false)
        .save(apiaryId: newApiary.id, tasks: []);
    _apiaries.add(newApiary);
    notifyListeners();
  }
}
