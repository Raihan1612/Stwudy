import 'package:flutter/material.dart';
import 'package:tubes/database/subscription_database.dart';
import 'package:tubes/database/user_database.dart';
import 'package:tubes/database/wishlist_database.dart';
import 'package:tubes/sharePref/user_session.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  screen createState() => screen();
}

class screen extends State<WishlistScreen> {
  // All journals
  UserTable user = UserTable();
  List<Map<String, dynamic>> _journals = [];
  bool _isLoading = true;
  int? _id;

  Future<void> loadId() async {
    int? temp = await UserSession.getId();
    setState(() {
      _id = temp;
    });
  }

  // This function is used to fetch all data from the database
  void _refreshJournals(int id) async {
    final data = await WishlistTable.getKursusWish(id);
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadId().then((_) {
      _refreshJournals(_id!);
    });
  }

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

  void showPaymentModal(int idUser, int idKursus) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Course Payment',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Please proceed with the payment to access the course content.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  SubsTable.createSubscription(idUser, idKursus);
                  WishlistTable.deleteWishlist(idUser, idKursus);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text('Proceed to Payment'),
              ),
            ],
          ),
        );
      },
    );
  }

  // Delete an item
  void _deleteItem(int idUser, int idKursus) async {
    await WishlistTable.deleteWishlist(idUser, idKursus);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a wishlist!'),
    ));
    _refreshJournals(idUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(
          color: Colors.black, // Change arrow color here
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _journals.length,
              itemBuilder: (context, index) {
                return Card(
                    color: Colors.white,
                    margin: const EdgeInsets.all(15),
                    child: InkWell(
                      splashColor: Colors.purple.withAlpha(30),
                      onTap: () {
                        UserSession.saveDataKursus(_journals[index]['kursus_id']);
                        Navigator.of(context).pushNamed(
                          '/detail_course',
                        );
                      },
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.asset(
                              _journals[index]['kursusImage'],
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${_journals[index]['judul_kursus']}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    _deleteItem(
                                        _id!, _journals[index]['kursus_id']);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ));
              }),
    );
  }
}

// ListTile(
                  //     title: Text("${_journals[index]['judul_kursus']}"),
                  //     subtitle: Text(_journals[index]['kategori']),
                  //     trailing: SizedBox(
                  //       width: 100,
                  //       child: Row(
                  //         children: [
                  //           IconButton(
                  //             icon: const Icon(Icons.shopping_cart_checkout),
                  //             onPressed: () {
                  //               showPaymentModal(
                  //                   _id!, _journals[index]['kursus_id']);
                  //             },
                  //           ),
                  //           IconButton(
                  //             icon: const Icon(Icons.delete),
                  //             onPressed: () => _deleteItem(
                  //                 _id!, _journals[index]['kursus_id']),
                  //           ),
                  //         ],
                  //       ),
                  //     )),