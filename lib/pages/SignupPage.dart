import 'package:flutter/material.dart';
import 'package:hivemind_app/providers/apiaries.provider.dart';
import 'package:hivemind_app/providers/auth.provider.dart';
import 'package:hivemind_app/utils/HelperWidgets.dart';
import 'package:hivemind_app/utils/colors.dart';
import 'package:hivemind_app/widgets/general/FilledBtn.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _borderStyle = OutlineInputBorder(
    borderSide: BorderSide(
      color: ColorManager.INPUT_COLOR,
      width: 1,
    ),
  );

  final _globalKey = GlobalKey<FormState>();
  var errorMessage = "";
  var _username = "";
  var _email = "";
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  Future signup(context) async {
    try {
      print("Hello 1");
      final response = await Provider.of<Auth>(context, listen: false).signup(
          username: _username,
          email: _email,
          password: _passwordController.text,
          context: context);
      Provider.of<Apiaries>(context, listen: false).saveApiary(
          context: context, apiary: response["user"]["assignedApiary"]);
      Navigator.pushReplacementNamed(
        context,
        "/homeBeekeeper",
      );
    } catch (error) {
      setState(() {
        errorMessage = error.toString();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Signup failed: ${error.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      _globalKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
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
                        decoration: InputDecoration(
                          label: Text("Email"),
                          border: _borderStyle,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email field cannot be empty!";
                          }

                          return null;
                        },
                        onSaved: (value) {
                          _email = value!;
                        },
                      ),
                      addVerticalSpace(12),
                      TextFormField(
                        style: inputTextStyle,
                        controller: _passwordController,
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
                      ),
                      addVerticalSpace(12),
                      TextFormField(
                        style: inputTextStyle,
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          label: Text("Confirm Password"),
                          border: _borderStyle,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Confirm password field cannot be empty!";
                          }
                          if (_passwordController.text != value) {
                            print(_passwordController.text);
                            print(value);
                            return "Incorrect password!";
                          }
                          return null;
                        },
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FilledBtn(
                              text: "Sign Up",
                              onPress: () async {
                                if (_globalKey.currentState!.validate()) {
                                  _globalKey.currentState!.save();
                                  await signup(context);
                                }
                              }),
                          Row(
                            spacing: 10,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account?",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge!
                                    .copyWith(fontWeight: FontWeight.w400),
                              ),
                              InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      "/",
                                    );
                                  },
                                  child: Text(
                                    "Login",
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
