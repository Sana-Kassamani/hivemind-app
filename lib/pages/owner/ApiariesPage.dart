import 'package:flutter/material.dart';
import 'package:hivemind_app/utils/helperWidgets.dart';
import 'package:hivemind_app/widgets/general/FilledBtn.dart';
import 'package:hivemind_app/widgets/general/ListItem.dart';
import 'package:hivemind_app/widgets/general/NavBar.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Apiaries"),
      ),
      body: Column(
        children: [
          addVerticalSpace(24),
          Expanded(
            child: ListView(
              children: <Widget>[
                for (int i = 0; i < apiaries.length; i++)
                  ListItem(
                    data: apiaries[i],
                    icon: "assets/icons/apiary_icon.png",
                    onPress: () {},
                  )
              ],
            ),
          ),
          FilledBtn(
            text: "Add a New Apiary",
            icon: Icon(Icons.add),
          ),
        ],
      ),
      bottomNavigationBar: Navbar(),
    );
  }
}
