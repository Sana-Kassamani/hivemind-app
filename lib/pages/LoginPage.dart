import 'package:flutter/material.dart';
import 'package:hivemind_app/providers/auth.provider.dart';
import 'package:hivemind_app/utils/HelperWidgets.dart';
import 'package:hivemind_app/utils/colors.dart';
import 'package:hivemind_app/widgets/general/FilledBtn.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _borderStyle = OutlineInputBorder(
    borderSide: BorderSide(
      color: ColorManager.INPUT_COLOR,
      width: 1,
    ),
  );
  final _globalKey = GlobalKey<FormState>();

  var _username = "";
  var _password = "";
  @override
  Widget build(BuildContext context) {
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
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              addVerticalSpace(40),
              Form(
                key: _globalKey,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Column(
                    children: [
                      TextFormField(
                        style: Theme.of(context).textTheme.bodyMedium,
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
                        style: Theme.of(context).textTheme.bodyMedium,
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
                      addVerticalSpace(10),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          "Forget Password?",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  color: Colors.amber[600],
                                  fontWeight: FontWeight.w400),
                        ),
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
