import 'package:flutter/material.dart';
import 'package:hivemind_app/pages/Owner/ApiaryPage.dart';
import 'package:hivemind_app/providers/apiaries.provider.dart';
import 'package:hivemind_app/utils/helperWidgets.dart';
import 'package:hivemind_app/widgets/general/FilledBtn.dart';
import 'package:hivemind_app/widgets/general/ListItem.dart';
import 'package:hivemind_app/widgets/general/empty.state.dart';
import 'package:hivemind_app/widgets/owner/AddDialogue.dart';
import 'package:provider/provider.dart';

class ApiariesPage extends StatefulWidget {
  const ApiariesPage({super.key});

  @override
  State<ApiariesPage> createState() => _ApiariesPageState();
}

class _ApiariesPageState extends State<ApiariesPage> {
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
                return value.apiariesList.isEmpty
                    ? EmptyState(context: context)
                    : ListView.builder(
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
