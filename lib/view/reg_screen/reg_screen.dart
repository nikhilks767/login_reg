// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:login_reg/controller/home_screen_controller.dart';

import 'package:login_reg/model/user.dart';
import 'package:login_reg/view/login_screen/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool isVisible = true;

  void registerUser() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String phoneStr = phoneController.text.trim();
    String pass = passController.text.trim();

    if (name.isEmpty || email.isEmpty || phoneStr.isEmpty || pass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("All fields must be filled"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (await SQLDatabase.emailExists(email)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Email already exists"),
        backgroundColor: Colors.red,
      ));
      return;
    }
    int? phone = int.tryParse(phoneStr);
    if (phone == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Phone number is not valid")),
      );
      return;
    }

    Users newUser = Users(
      name: name,
      email: email,
      phone: phone,
      pass: pass,
    );

    int result = await SQLDatabase.register(newUser);
    if (result != -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Successfully registered"),
          backgroundColor: Colors.green,
        ),
      );
      log("Login query result: ${newUser.name},${newUser.email},${newUser.phone},${newUser.pass}");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error registering user")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 80),
                ListTile(
                  title: Text(
                    "Register New Account",
                    style: TextStyle(
                        color: Colors.purple,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(color: Colors.black, blurRadius: 1.4)
                        ]),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.deepPurple.withOpacity(0.8)),
                  child: TextFormField(
                    controller: nameController,
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        hintText: "Username",
                        hintStyle: TextStyle(color: Colors.white)),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.deepPurple.withOpacity(0.8)),
                  child: TextFormField(
                    controller: emailController,
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.email_rounded,
                          color: Colors.white,
                        ),
                        hintText: "Email",
                        hintStyle: TextStyle(color: Colors.white)),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.deepPurple.withOpacity(0.8)),
                  child: TextFormField(
                    controller: phoneController,
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(Icons.phone, color: Colors.white),
                        hintText: "Phone no",
                        hintStyle: TextStyle(color: Colors.white)),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.deepPurple.withOpacity(0.8)),
                  child: TextFormField(
                    controller: passController,
                    cursorColor: Colors.white,
                    obscureText: isVisible,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(Icons.lock, color: Colors.white),
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.white),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          icon: Icon(!isVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                          color: Colors.white,
                        )),
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                    onPressed: registerUser,
                    style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(Size(130, 40)),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.deepPurple)),
                    child: Text(
                      "Register",
                      style: TextStyle(color: Colors.white),
                    )),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Login"))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
