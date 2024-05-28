// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:login_reg/view/home_screen/admin_home.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  bool isVisible = true;
  String username = "admin";
  String password = "1234";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                // Image.network(
                //   "https://lh3.googleusercontent.com/proxy/juK09w4LMUaYnlKLQY_wcfCZSVhhJrujGx2ed1Mr9svs7dFMr7sIW2B4nBPMLL0ZS-9R-CdnvmFo_NNVjzP1vHk",
                //   scale: 2,
                // ),
                Image.asset(
                  "assets/admin_logo.png",
                  scale: 2,
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.deepPurple.withOpacity(0.8)),
                  child: TextFormField(
                    controller: namecontroller,
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.email_rounded,
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
                    controller: passcontroller,
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
                            isVisible = !isVisible;
                            setState(() {});
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
                    onPressed: () {
                      if (namecontroller.text == username &&
                          passcontroller.text == password) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AdminHome(),
                            ));
                        namecontroller.clear();
                        passcontroller.clear();
                      } else if (namecontroller.text.isEmpty ||
                          passcontroller.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text("Username and Password must not be empty"),
                          backgroundColor: Colors.red,
                        ));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Username or Password is incorrect"),
                          backgroundColor: Colors.red,
                        ));
                      }
                    },
                    style: ButtonStyle(
                        fixedSize: MaterialStatePropertyAll(Size(130, 40)),
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.deepPurple)),
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
