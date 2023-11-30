import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {


  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final textFieldFocusNode = FocusNode();
  bool _obscured = true;


  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) {
        return; // If focus is on text field, don't unfocused
      }
      textFieldFocusNode.canRequestFocus =
      false; // Prevents focus if tap on eye
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(18.0),
            margin: EdgeInsets.all(18.0),
            child: Column(
              children: [
                Text("Settings", style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                ),),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'Enter Password',
                          labelText: 'Password',
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.blue,
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                            child: GestureDetector(
                              onTap: _toggleObscured,
                              child: Icon(
                                _obscured
                                    ? Icons.visibility_rounded
                                    : Icons.visibility_off_rounded,
                              ),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(9.0)),
                          )),
                      validator: (passwordValue) {
                        RegExp regex = RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

                        // var passNonNullValue=passCurrentValue??"";
                        if (passwordValue!.isEmpty) {
                          return ("Password is required");
                        } else if (passwordValue.length < 8) {
                          return ("Password Must be more than 8 characters");
                        } else if (!regex.hasMatch(passwordValue)) {
                          return ("Password should contain upper,lower,digit and Special character ");
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _confirmPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      // obscureText: _obscured,
                      focusNode: textFieldFocusNode,
                      decoration: InputDecoration(
                        hintText: 'Enter Confirm Password',
                        labelText: 'Confirm Password',
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.blue,
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                          child: GestureDetector(
                            // onTap: _toggleObscured,
                            onTap: () {
                              setState(() {
                                _obscured = false;
                              });
                            },
                            child: Icon(
                              _obscured
                                  ? Icons.visibility_rounded
                                  : Icons.visibility_off_rounded,
                            ),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(9.0)),
                        ),
                      ),

                      validator: (confirmPasswordValue) {
                        RegExp regex = RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

                        // var confirmPassNonNullValue=confirmPassCurrentValue??"";
                        if (confirmPasswordValue!.isEmpty) {
                          return ("Confirm Password is required");
                        } else if (confirmPasswordValue.length < 8) {
                          return ("Confirm Password Must be more than 8 characters");
                        } else if (!regex.hasMatch(confirmPasswordValue)) {
                          return ("Confirm Password should contain upper,lower,digit and Special character ");
                        } else if (_passwordController.text.toString() !=
                            confirmPasswordValue) {
                          return "Confirm password does not match";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate())
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                        },
                        child: Text(
                          "Set Password",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orangeAccent
                          )
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                    ),
                  ],
                ),
              ],
            ),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.orangeAccent,
                )
            ),
          ),
        ),
      ),
    );;
  }
}
