import 'package:flutter/material.dart';
import 'package:hivemind_app/pages/Owner/ApiaryPage.dart';
import 'package:hivemind_app/providers/apiaries.provider.dart';
import 'package:hivemind_app/utils/helperWidgets.dart';
import 'package:hivemind_app/widgets/general/FilledBtn.dart';
import 'package:hivemind_app/widgets/general/ListItem.dart';
import 'package:hivemind_app/widgets/general/NavBar.dart';
import 'package:hivemind_app/widgets/owner/AddDialogue.dart';
import 'package:provider/provider.dart';

List<Map<String, String>> apiaries = [
  {"label": "Apiary #1", "Beekeeper name": "Yehya"},
  {"label": "Apiary #2", "Beekeeper name": "Hatem"},
  {"label": "Apiary #3", "Beekeeper name": "Seri"},
  {"label": "Apiary #4", "Beekeeper name": "Nour"},
];

class ApiariesPage extends StatefulWidget {
  const ApiariesPage({super.key});

  @override
  State<ApiariesPage> createState() => _ApiariesPageState();
}

class _ApiariesPageState extends State<ApiariesPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadApiaries();
  }

  loadApiaries() async {
    await Apiaries().loadApiaries();
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AddDialogue(context, "New Apiary", "form");
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Apiaries"),
      ),
      body: Column(
        children: [
          addVerticalSpace(24),
          Expanded(
            child: Consumer<Apiaries>(
              builder: (BuildContext context, Apiaries value, Widget? child) {
                return ListView.builder(
                  itemCount: value.apiariesList.length,
                  itemBuilder: (context, index) => ListItem(
                    data: value.apiariesList[index],
                    icon: "assets/icons/apiary_icon.png",
                    onPress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ApiaryPageOwner(),
                          settings: RouteSettings(
                            arguments: value.apiariesList[index].getId(),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          FilledBtn(
            text: "Add a New Apiary",
            icon: Icon(Icons.add),
            onPress: _showDialog,
          ),
        ],
      ),
      // bottomNavigationBar: NavbarOwner(),
    );
  }
}
