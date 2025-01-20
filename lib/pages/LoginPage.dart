import 'package:flutter/material.dart';
import 'package:hivemind_app/main.dart';
import 'package:hivemind_app/providers/apiaries.provider.dart';
import 'package:hivemind_app/providers/auth.provider.dart';
import 'package:hivemind_app/providers/beekeepers.provider.dart';
import 'package:hivemind_app/utils/HelperWidgets.dart';
import 'package:hivemind_app/utils/colors.dart';
import 'package:hivemind_app/utils/enums/UserTypes.dart';
import 'package:hivemind_app/widgets/general/FilledBtn.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _globalKey = GlobalKey<FormState>();
  var errorMessage = "";
  var _username = "";
  var _password = "";

  Future login(context) async {
    try {
      final response = await Provider.of<Auth>(context, listen: false)
          .login(username: _username, password: _password, context: context);
      if (Provider.of<Auth>(context, listen: false).user.getUserType ==
          UserTypes.Owner) {
        await Provider.of<Beekeepers>(context, listen: false).load();
        await Provider.of<Apiaries>(context, listen: false).saveApiaries(
            context: context, apiaries: response["user"]["apiaries"]);

        Navigator.pushNamedAndRemoveUntil(
          context,
          "/homeOwner",
          (Route<dynamic> route) => false,
        );
      } else if (Provider.of<Auth>(context, listen: false).user.getUserType ==
          UserTypes.Beekeeper) {
        await Provider.of<Apiaries>(context, listen: false).saveApiary(
            context: context, apiary: response["user"]["assignedApiary"]);
        Navigator.pushNamedAndRemoveUntil(
          context,
          "/homeBeekeeper",
          (Route<dynamic> route) => false,
        );
      }
    } catch (error) {
      setState(() {
        errorMessage = error.toString();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed: ${error.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      _globalKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    final _borderStyle = OutlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.tertiaryFixed,
        width: 1,
      ),
    );
    final inputTextStyle =
        Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage("assets/images/Logo_with_text.png"),
              ),
              addVerticalSpace(40),
              Text(
                "Welcome Back",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 24,
                    ),
                textAlign: TextAlign.center,
              ),
              addVerticalSpace(100),
              Form(
                key: _globalKey,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Column(
                    children: [
                      TextFormField(
                        style: inputTextStyle,
                        decoration: InputDecoration(
                          label: Text("Username"),
                          border: _borderStyle,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Username field cannot be empty!";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _username = value!;
                        },
                      ),
                      addVerticalSpace(12),
                      TextFormField(
                        style: inputTextStyle,
                        obscureText: true,
                        decoration: InputDecoration(
                          label: Text("Password"),
                          border: _borderStyle,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password field cannot be empty!";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _password = value!;
                        },
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FilledBtn(
                              text: "Login",
                              onPress: () async {
                                if (_globalKey.currentState!.validate()) {
                                  _globalKey.currentState!.save();
                                  await login(context);
                                }
                              }),
                          Row(
                            spacing: 10,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(fontWeight: FontWeight.w400),
                              ),
                              InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      "/signup",
                                    );
                                  },
                                  child: Text(
                                    "Sign Up",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(
                                            color: Colors.amber[600],
                                            fontWeight: FontWeight.w400),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
