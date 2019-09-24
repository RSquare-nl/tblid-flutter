import 'package:flutter/material.dart';


class AddEmailRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Email address"),
      ),
      body: Center(
        child:
        Column(
          children: [
             Text("Enter Email address:"),
             TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Email:'
              ),
            ),
          RaisedButton(
          onPressed: () {

            Navigator.pop(context);
          },
          child: Text('Save'),
        ),
    ],

    ),
    ),
    );
  }
}