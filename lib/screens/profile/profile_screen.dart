import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tubes/database/subscription_database.dart';
import 'package:tubes/database/user_database.dart';
import 'package:tubes/sharePref/user_session.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  State<UserProfileScreen> createState() => screen();
}

class screen extends State<UserProfileScreen> {
  List<Map<String, dynamic>> _data = [];
  bool _isLoading = true;
  int _id = -1;

  Future<void> loadId() async {
    int? temp = await UserSession.getId();
    setState(() {
      _id = temp!;
    });
  }

  Future<void> _refreshJournals(int id) async {
    final data = await UserTable.getUser(id);
    setState(() {
      _data = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadId().then((_) {
      _refreshJournals(_id);
    });
  }

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  void _showForm(int? id, int key) async {
    if (id != null) {
      // id == null -> create new item
      // id != null -> update an existing item
      final existingJournal =
          _data.firstWhere((element) => element['user_id'] == id);
      _usernameController.text = existingJournal['username'];
      _passwordController.text = existingJournal['password'];
      _emailController.text = existingJournal['email'];
      _nameController.text = existingJournal['name'];
    }

    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
              padding: EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                // this will prevent the soft keyboard from covering the text fields
                bottom: MediaQuery.of(context).viewInsets.bottom + 50,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (key == 1)
                    TextField(
                      controller: _nameController,
                    ),
                  if (key == 2)
                    TextField(
                      controller: _emailController,
                    ),
                  if (key == 3)
                    TextField(
                      controller: _usernameController,
                    ),
                  if (key == 4)
                    TextField(
                      controller: _passwordController,
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          // Save new journal
                          User user = User(
                              username: _usernameController.text,
                              password: _passwordController.text,
                              email: _emailController.text,
                              name: _nameController.text);

                          if (id != null) {
                            await _updateUser(id, user);
                          }

                          // Clear the text fields
                          _usernameController.text = '';
                          _passwordController.text = '';
                          _emailController.text = '';
                          _nameController.text = '';

                          // Close the bottom sheet
                          Navigator.of(context).pop();
                        },
                        child: Text(id == null ? 'Create New' : 'Update'),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor:
                              Colors.red, // Set the text color to white
                        ),
                        child: Text('Cancel'),
                      )
                    ],
                  )
                ],
              ),
            ));
  }

  // Update an existing journal
  Future<void> _updateUser(int id, User user) async {
    await UserTable.updateUser(id, user);
    loadId().then((_) {
      _refreshJournals(_id);
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> user;
    if (!_data.isEmpty) {
      user = _data[0];
    } else {
      user = {
        'user_id': 0,
      };
    }
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, // Change arrow color here
        ),
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Container(
                color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(135, 45, 135, 45),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("${user['name']}")
                      ]),
                ),
              ),
            ),
            Card(
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  _showForm(user['user_id'], 1);
                },
                child: SizedBox(
                    width: double.infinity,
                    height: 70,
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text("Name"), Icon(Icons.arrow_forward_ios)],
                      ),
                    )),
              ),
            ),
            Card(
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  _showForm(user['user_id'], 2);
                },
                child: SizedBox(
                    width: double.infinity,
                    height: 70,
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Email"),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    )),
              ),
            ),
            Card(
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  _showForm(user['user_id'], 3);
                },
                child: SizedBox(
                    width: double.infinity,
                    height: 70,
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Username"),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    )),
              ),
            ),
            Card(
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  _showForm(user['user_id'], 4);
                },
                child: SizedBox(
                    width: double.infinity,
                    height: 70,
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Password"),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    )),
              ),
            ),
            Card(
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {},
                child: SizedBox(
                    width: double.infinity,
                    height: 70,
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text("FAQ"), Icon(Icons.arrow_forward_ios)],
                      ),
                    )),
              ),
            ),
            Card(
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {},
                child: SizedBox(
                    width: double.infinity,
                    height: 70,
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Helpdesk"),
                          Icon(Icons.arrow_forward_ios)
                        ],
                      ),
                    )),
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: const Text('Log Out'),
                  onPressed: () async {
                    UserSession.clearUserData();
                    Navigator.of(context).pushNamed(
                      '/login',
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
