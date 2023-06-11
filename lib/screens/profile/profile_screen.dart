import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tubes/database/subscription_database.dart';
import 'package:tubes/database/user_database.dart';
import 'package:tubes/sharePref/user_session.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  State<UserProfileScreen> createState() => screen();
}

class screen extends State<UserProfileScreen> {
  List<Map<String, dynamic>> _data = [];
  bool _isLoading = true;
  bool _isDefault = true;
  File? _imageFile;
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

  Future<void> _pickImage(int id, Map<String, dynamic> user) async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        Navigator.of(context).pop();
        _uploadImageModal(id, user);
      });
    }
  }

  Future<void> _saveImageToAssets(Map<String, dynamic> user, int id) async {
    if (_imageFile == null) return;

    final now = DateTime.now();
    final formattedDate = DateFormat('yyyyMMdd_HHmmss').format(now);
    final imageName = 'image_profile_$formattedDate.png';

    final appDir = await getApplicationDocumentsDirectory();
    final savedImage = await _imageFile!.copy('${appDir.path}/$imageName');
    User u = User(
        username: user['username'],
        password: user['password'],
        email: user['email'],
        name: user['name'],
        userImage: '${appDir.path}/$imageName');
    _updateUser(id, u);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Image saved to assets. ${appDir.path}'),
    ));
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

  void _showForm(int? id, int key, String imgP) async {
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
                              name: _nameController.text,
                              userImage: imgP);

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

  void _showFAQModal() {
    showModalBottomSheet(
        context: context,
        builder: (_) => Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Frequently Asked Questions',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Q: What is Stwudy?',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'A: Stwudy is an e-learning application designed to provide a comprehensive platform for online education.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Q: Is Stwudy available on multiple platforms?',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'A: Yes, Stwudy is available on both iOS and Android platforms.',
                    style: TextStyle(fontSize: 16),
                  ),
                  // Add more questions and answers as needed
                ],
              ),
            ));
  }

  void _showHelpdeskModal() {
    showModalBottomSheet(
        context: context,
        builder: (_) => Container(
              padding: EdgeInsets.all(16),
              child: Column(
                children: const [
                  Text(
                    'Help Desk',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'If you need assistance or have any questions, '
                    'please contact our help desk at:',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'stwudy@gmail.com',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ));
  }

  Future<void> _uploadImageModal(int id, Map<String, dynamic> user) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Wrap(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _imageFile != null
                        ? Image.file(_imageFile!)
                        : Text('No image selected.'),
                    ElevatedButton(
                      onPressed: () {
                        _pickImage(id, user);
                      },
                      child: Text('Select Image'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _saveImageToAssets(user, id);
                        Navigator.of(context).pop();
                      },
                      child: Text('Set Image as Profile'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
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
    String imgPath = 'assets/icons/Logo.png';
    if (!_data.isEmpty) {
      user = _data[0];
      imgPath = user['userImage'];
    } else {
      user = {
        'user_id': 0,
      };
    }
    _isDefault = user['userImage'] == 'assets/icons/Logo.png';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).popAndPushNamed(
              '/home',
            );
          },
        ),
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
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(135, 45, 135, 45),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 96,
                          height: 96,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.white,
                            image: DecorationImage(
                              image: _isDefault
                                  ? AssetImage('${user['userImage']}')
                                  : FileImage(File('${user['userImage']}'))
                                      as ImageProvider<Object>,
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(55, 70, 0, 0),
                              child: IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  _uploadImageModal(user['user_id'], user);
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("${user['name']}")
                        // Text("$_isDefault")
                      ]),
                ),
              ),
            ),
            Card(
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  _showForm(user['user_id'], 1, imgPath);
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
                  _showForm(user['user_id'], 2, imgPath);
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
                  _showForm(user['user_id'], 3, imgPath);
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
                  _showForm(user['user_id'], 4, imgPath);
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
                onTap: () {
                  _showFAQModal();
                },
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
                onTap: () {
                  _showHelpdeskModal();
                },
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
