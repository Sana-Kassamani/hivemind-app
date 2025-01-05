import 'dart:convert';
import 'package:hivemind_app/models/apiary.model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hivemind_app/pages/placesPage.dart';
import 'package:hivemind_app/providers/beekeepers.provider.dart';
import 'package:hivemind_app/utils/HelperWidgets.dart';
import 'package:hivemind_app/utils/colors.dart';
import 'package:hivemind_app/widgets/general/FilledBtn.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddDialogue extends StatefulWidget {
  const AddDialogue({super.key});

  @override
  State<AddDialogue> createState() => _AddDialogueState();
}

class _AddDialogueState extends State<AddDialogue> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      actionsAlignment: MainAxisAlignment.center,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      titleTextStyle: Theme.of(context).textTheme.titleLarge,
      backgroundColor: ColorManager.SCAFFOLD_BG,
      title: Text(
        "Add Apiary",
        textAlign: TextAlign.center,
      ),
      content: SizedBox(height: 300, child: AddApiary()),
      buttonPadding: EdgeInsets.all(45),
      actions: [],
    );
  }
}

// Widget AddDialogue(context, title, form) {
//   return
// }

class AddApiary extends StatefulWidget {
  const AddApiary({super.key});

  @override
  State<AddApiary> createState() => _AddApiaryState();
}

class _AddApiaryState extends State<AddApiary> {
  // final _controller = TextEditingController();
  var uuid = const Uuid();
  String? _sessionToken = "";
  final _globalKey = GlobalKey<FormState>();

  List<dynamic> _placeList = [];
  var placeId;
  var apiaryLabel = "";
  var beekeeperId = "";
  var _location = "";

  // @override
  // void initState() {
  //   super.initState();
  // }

  // _onChanged() {
  //   if (_sessionToken == null) {
  //     setState(() {
  //       _sessionToken = uuid.v4();
  //     });
  //   }
  //   // getSuggestion(_controller.text);
  // }
  dynamic getIndex(String desc) {
    return _placeList.firstWhere((p) => p["description"] == desc)["place_id"];
  }

  Future getSuggestion(String input) async {
    if (input.length < 3) {
      return;
    }
    const String PLACES_API_KEY = "AIzaSyDdMDAiVG9qJjLqXBY1YrIVFNUgMU0H9Pw";
    print("session token $_sessionToken");
    try {
      String baseURL =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json';
      String request =
          '$baseURL?input=$input&key=$PLACES_API_KEY&sessiontoken=$_sessionToken';
      var response = await http.get(Uri.parse(request));
      var data = jsonDecode(response.body);
      print('mydata');
      print(data);

      if (response.statusCode == 200) {
        setState(() {
          _placeList = jsonDecode(response.body)['predictions'];
        });
      } else {
        throw Exception('Failed to load predictions');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<Location> getLocation(String place_id) async {
    const String PLACES_API_KEY = "AIzaSyDdMDAiVG9qJjLqXBY1YrIVFNUgMU0H9Pw";
    try {
      String baseURL =
          'https://maps.googleapis.com/maps/api/place/details/json';
      String request =
          '$baseURL?fields=geometry&place_id=$place_id&key=$PLACES_API_KEY&sessiontoken=$_sessionToken';
      var response = await http.get(Uri.parse(request));
      var data = json.decode(response.body);
      if (response.statusCode == 200) {
        print(response.body.toString());
        Location location = Location(
            latitude: data["result"]['geometry']["location"]["lat"],
            longitude: data["result"]['geometry']["location"]["lng"],
            location: _location);

        return location;
      } else {
        throw Exception('Failed to load location details');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final inputTextStyle =
        Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14);
    print("place list is $_placeList");

    return Column(
      children: [
        Form(
          key: _globalKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(label: Text("Apiary Label")),
                style: inputTextStyle,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Label field cannot be empty";
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    apiaryLabel = value!;
                  });
                },
              ),
              Consumer<Beekeepers>(builder:
                  (BuildContext context, Beekeepers value, Widget? child) {
                return DropdownButtonFormField(
                  decoration: InputDecoration(label: Text("Beekeeper Name")),
                  style: inputTextStyle,
                  validator: (value) {
                    if (value == null) {
                      return "Choose a beekeeper";
                    }
                    return null;
                  },
                  items: value.beekeepersList.map((b) {
                    bool free = b.assignedApiaryId == null ? true : false;
                    return DropdownMenuItem(
                      enabled: free,
                      value: b.getId,
                      child: Text(
                        b.getUsername,
                        style: free
                            ? inputTextStyle.copyWith(
                                color: ColorManager.COLOR_SECONDARY)
                            : inputTextStyle.copyWith(color: Colors.grey),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    print(value);
                  },
                  onSaved: (value) {
                    setState(() {
                      beekeeperId = value!;
                    });
                  },
                );
              }),
              // Autocomplete(
              //   optionsBuilder: (TextEditingValue textEditingValue) {},
              // ),
              Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) async {
                print("heyyyy");
                if (_sessionToken == "") {
                  setState(() {
                    _sessionToken = uuid.v4();
                  });
                }
                await getSuggestion(textEditingValue.text);
                if (_placeList.isEmpty || textEditingValue.text.isEmpty) {
                  return const Iterable<String>.empty();
                }
                return Iterable.generate(
                    _placeList.length, (p) => _placeList[p]["description"]);
              }, onSelected: (String selection) {
                debugPrint('You just selected $selection');
                setState(() {
                  placeId = getIndex(selection);
                  _location = selection;
                  _sessionToken = "";
                });
                print(placeId);
              }, fieldViewBuilder: (context, textEditingController, focusNode,
                      onFieldSubmitted) {
                return TextFormField(
                  controller: textEditingController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Location field cannot be empty";
                    }
                    return null;
                  },
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    labelText: "Search location",
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.cancel),
                      onPressed: () {
                        textEditingController.clear();
                      },
                    ),
                  ),
                );
              })
            ],
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: FilledBtn(
              text: "Add",
              onPress: () async {
                if (_globalKey.currentState!.validate()) {
                  _globalKey.currentState!.save();
                }
                final loc = await getLocation(placeId);
                print("Lat : ${loc.latitude}");
                print("Lng : ${loc.longitude}");
                print("loc : ${loc.location}");

                print("Label : $apiaryLabel");
                print("id beekeeper: $beekeeperId");
              }),
        ),
      ],
    );
  }
}
