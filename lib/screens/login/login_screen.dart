import 'package:flutter/material.dart';
import 'package:tubes/database/user_database.dart';
import 'package:tubes/sharePref/user_session.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => Screen();
}

class Screen extends State<LoginScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  UserTable userTab = UserTable();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(30),
          child: ListView(
            children: <Widget>[
              Center(
                child: Container(
                  height: 200,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/Logo.png',
                        width: 62,
                        height: 62,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Welcome Back 👋',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  )),
              Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Please Login to Continue',
                    style: TextStyle(fontSize: 15),
                  )),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: 'Username',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                child: TextField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: 'Password',
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: <Widget>[
                  const Text(''),
                  TextButton(
                    child: const Text(
                      'Forget Password?',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.blue,
                      ),
                    ),
                    onPressed: () {
                      //signup screen
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: const Text('Login'),
                    onPressed: () async {
                      List<Map<String, dynamic>>? isFound = await userTab.login(
                          _nameController.text, _passwordController.text);
                      if (isFound != null) {
                        Map<String, dynamic> _data = isFound.first;
                        UserSession.saveUserData(_data['user_id']);
                        Navigator.of(context).pushNamed(
                          '/home',
                        );
                      } else {
                        _passwordController.text = '';
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('User not found, try again!'),
                          ),
                        );
                      }
                    },
                  )),
                  Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: const Text('Test DataBase'),
                    onPressed: () async {Navigator.of(context).pushNamed(
                        '/test2',
                      );},
                  )),
              SizedBox(height: 16),
              Row(
                children: <Widget>[
                  const Text("Don't Have an Account?"),
                  TextButton(
                    child: const Text(
                      'Register Here',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.blue,
                      ),
                    ),
                    onPressed: () {
                      //signup screen
                      Navigator.of(context).pushNamed(
                        '/register',
                      );
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ],
          )),
    );
  }
}
