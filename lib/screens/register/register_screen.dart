import 'package:flutter/material.dart';
import 'package:tubes/database/user_database.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => Screen();
}

class Screen extends State<RegisterScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
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
                      'Hi Friend 👋',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Register Here',
                      style: TextStyle(fontSize: 15),
                    )),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                  child: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      labelText: 'Full Name',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                  child: TextField(
                    controller: _usernameController,
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
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Example@gmail.com',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      labelText: 'Email',
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
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      labelText: 'Confirm Password',
                    ),
                  ),
                ),
                Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: const Text('Register'),
                      onPressed: () async {
                        // print(nameController.text);
                        // print(passwordController.text);
                        // Save new journal
                        User user = User(
                          username: _usernameController.text,
                          password: _passwordController.text,
                          email:  _emailController.text,
                          name: _nameController.text,
                          userImage: "assets/icons/Logo.png"
                        );
                        await UserTable.createUser(user);
                        Navigator.of(context).pushNamed(
                        '/login',
                      );
                        // Navigator.of(context).pushNamed(
                        //   '/login',
                        // );
                      },
                    )),
                Row(
                  children: <Widget>[
                    const Text('Have an Account?'),
                    TextButton(
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.blue,
                        ),
                      ),
                      onPressed: () {
                        //signup screen
                        Navigator.of(context).pushNamed(
                          '/login',
                        );
                      },
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
              ],
            )),
      ),
    );
  }
}
