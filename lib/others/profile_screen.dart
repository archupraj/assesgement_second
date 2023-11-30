import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _firstAddressController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final textFieldFocusNode = FocusNode();
  bool _obscured = true;



  XFile? image;

  final ImagePicker picker = ImagePicker();

  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }

  String? validateMobile(String? mobileValue) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10}$)';
    RegExp regExp = RegExp(pattern);
    if (mobileValue != null && mobileValue.isEmpty) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(mobileValue!)) {
      return 'Please enter valid mobile number';
    }
    // else if (mobileValue.length==10) {
    //   return 'Entered mobile number is invalid';
    // }
    return null;
  }

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
                Text("Profile", style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                ),),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: ClipOval(
                        child: Container(
                          height: 80,
                          width: 80,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                            ),
                            onPressed: () {
                              myAlert();
                            },
                            child: Center(
                              child: image != null ? Container(
                                child: Image.file(
                                  //to show image, you type like this.
                                  File(image!.path),
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width,
                                  height: 80,

                                ),
                              ) :Container(
                                child: Icon(Icons.person, size: 40,),
                                height: 80, width: 80,),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _fullNameController,
                      decoration: InputDecoration(
                          hintText: 'Enter Full Name',
                          labelText: 'Full Name',
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.blue,
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(9.0)),
                          )),
                      keyboardType: TextInputType.text,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (fullNameValue) {
                        if (fullNameValue!.isEmpty) {
                          return 'Full Name is required';
                        } else if (fullNameValue!.split(' ').length < 3) {
                          return 'Full name is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          hintText: 'Enter Email ID',
                          labelText: 'Email ID',
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.blue,
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(9.0)),
                          )),
                      keyboardType: TextInputType.text,
                      validator: validateEmail,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _mobileController,
                      decoration: InputDecoration(
                          hintText: 'Enter Mobile Number',
                          labelText: 'Mobile Number',
                          prefixIcon: Icon(
                            Icons.mobile_friendly,
                            color: Colors.blue,
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(9.0)),
                          )),
                      keyboardType: TextInputType.phone,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: validateMobile,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _firstAddressController,
                      decoration: InputDecoration(
                          hintText: 'Enter Address',
                          labelText: 'Address',
                          prefixIcon: Icon(
                            Icons.place_sharp,
                            color: Colors.blue,
                          ),
                          border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(9.0)),
                          )),
                      validator: (firstAddressValue) {
                        if (firstAddressValue!.isEmpty) {
                          return "Address is required";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
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
                          "Register",
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
    );
  }
}
