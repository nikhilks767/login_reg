// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:login_reg/model/user.dart';

class HomeScreen extends StatelessWidget {
  final Users user;
  const HomeScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade200,
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.2),
        automaticallyImplyLeading: false,
        title: Text("Welcome, ${user.name.toUpperCase()}"),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text("Logout"))
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: MediaQuery.sizeOf(context).width,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.amber.shade100),
                child: Text("Name : ${user.name}",
                    style: TextStyle(fontSize: 25))),
            SizedBox(height: 15),
            Container(
                width: MediaQuery.sizeOf(context).width,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.amber.shade100),
                child: Text("Email : ${user.email}",
                    style: TextStyle(fontSize: 25))),
            SizedBox(height: 15),
            Container(
                width: MediaQuery.sizeOf(context).width,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.amber.shade100),
                child: Text("Phone No : ${user.phone}",
                    style: TextStyle(fontSize: 25))),
          ],
        ),
      ),
    );
  }
}
