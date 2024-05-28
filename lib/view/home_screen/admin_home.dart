// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:login_reg/controller/home_screen_controller.dart';
import 'package:login_reg/model/user.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  late Future<List<Users>> _userList;
  @override
  void initState() {
    _userList = SQLDatabase.getAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
        body: FutureBuilder(
            future: _userList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                  child: Text("No Users Found"),
                );
              } else {
                return SingleChildScrollView(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Users user = snapshot.data![index];
                        return ListTile(
                          title: Text(user.name),
                          subtitle: Text(user.email),
                          trailing: Text("Phone : ${user.phone ?? 'N/A'}"),
                        );
                      }),
                );
              }
            }));
  }
}
