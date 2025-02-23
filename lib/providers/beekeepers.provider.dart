import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hivemind_app/models/user.model.dart';
import 'package:hivemind_app/utils/enums/RequestMethods.dart';
import 'package:hivemind_app/utils/request.dart';

class Beekeepers extends ChangeNotifier {
  List<Beekeeper> _beekeepersList = [];

  List<Beekeeper> get beekeepersList => _beekeepersList;

  int getBeekeepersCount({context, apiaries}) {
    int count = 0;

    for (var beekeeper in beekeepersList) {
      if (beekeeper.assignedApiaryId != null &&
          apiaries.contains(beekeeper.assignedApiaryId)) {
        count += 1;
      }
    }
    return count;
  }

  Future load() async {
    try {
      final response =
          await request(route: "/users/beekeepers", method: RequestMethods.get);
      save(beekeepers: jsonDecode(response));
    } catch (error) {
      rethrow;
    }
  }

  void save({beekeepers}) {
    for (int i = 0; i < beekeepers.length; i++) {
      var beekeeper = beekeepers[i];
      final newBeekeeper = Beekeeper(
        id: beekeeper["_id"],
        username: beekeeper["username"],
        assignedApiaryId: beekeeper["assignedApiary"],
      );
      beekeepersList.add(newBeekeeper);
    }
    notifyListeners();
  }

  String findNameById({required String id}) {
    try {
      Beekeeper beekeeper = beekeepersList.firstWhere((b) => b.getId == id);
      return beekeeper.getUsername;
    } catch (error) {
      rethrow;
    }
  }

  String findByAssignedApiary({required String id}) {
    try {
      Beekeeper beekeeper =
          beekeepersList.firstWhere((b) => b.getassignedApiaryId == id);
      return beekeeper.getUsername;
    } catch (error) {
      rethrow;
    }
  }

  void addAssignedApiary({required apiaryId, required userId}) {
    Beekeeper beekeeper = beekeepersList.firstWhere((b) => b.getId == userId);
    beekeeper.assignedApiaryId = apiaryId;
  }

  void deleteAssignedApiary({required apiaryId}) {
    Beekeeper beekeeper =
        beekeepersList.firstWhere((b) => b.getassignedApiaryId == apiaryId);
    beekeeper.assignedApiaryId = null;
  }

  void reset() {
    _beekeepersList = [];
    notifyListeners();
  }
}
