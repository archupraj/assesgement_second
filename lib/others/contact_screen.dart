import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();


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
                Text("Contact Us", style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                ),),
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

                SizedBox(
                  height: 200,
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      labelText: 'Enter Message',
                      contentPadding: EdgeInsets.all(8),
                      border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(9.0)),
                      ),
                    ),
                    style: TextStyle(fontSize: 18),
                    maxLines: 10,
                    minLines: 2,
                  ),
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
                      "Submit",
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
