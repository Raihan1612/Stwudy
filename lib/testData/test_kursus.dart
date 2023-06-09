import 'package:flutter/material.dart';
import 'package:tubes/database/kursus_database.dart';

class testKursus extends StatefulWidget {
  const testKursus({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<testKursus> {
  // All journals
  List<Map<String, dynamic>> _journals = [];

  bool _isLoading = true;
  // This function is used to fetch all data from the database
  void _refreshJournals() async {
    final data = await KursusTable.getAllKursus();
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshJournals(); // Loading the diary when the app starts
  }

  final TextEditingController _field1 = TextEditingController();
  final TextEditingController _field2 = TextEditingController();
  final TextEditingController _field3 = TextEditingController();
  final TextEditingController _field4 = TextEditingController();
  final TextEditingController _field5 = TextEditingController();

  // This function will be triggered when the floating button is pressed
  // It will also be triggered when you want to update an item
  void _showForm(int? id) async {
    if (id != null) {
      // id == null -> create new item
      // id != null -> update an existing item
      final existingJournal =
          _journals.firstWhere((element) => element['kursus_id'] == id);
      _field1.text = existingJournal['judul_kursus'];
      _field2.text = existingJournal['kategori'];
      _field3.text = existingJournal['deskripsi_kursus'];
      _field4.text = existingJournal['jumlah_video'].toString();
      _field5.text = existingJournal['kursusImage'];
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
                bottom: MediaQuery.of(context).viewInsets.bottom + 120,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: _field1,
                    decoration: const InputDecoration(hintText: 'judul'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _field2,
                    decoration: const InputDecoration(hintText: 'kategori'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _field3,
                    decoration:
                        const InputDecoration(hintText: 'deskripsi_kursus'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _field4,
                    decoration: const InputDecoration(hintText: 'jumlah_video'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _field5,
                    decoration: const InputDecoration(hintText: 'kursusImage'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // Save new journal
                      if (id == null) {
                        await _addItem();
                      }

                      if (id != null) {
                        await _updateItem(id);
                      }

                      // Clear the text fields
                      _field1.text = '';
                      _field2.text = '';
                      _field3.text = '';
                      _field4.text = '';
                      _field5.text = '';

                      // Close the bottom sheet
                      Navigator.of(context).pop();
                    },
                    child: Text(id == null ? 'Create New' : 'Update'),
                  )
                ],
              ),
            ));
  }

// Insert a new journal to the database
  Future<void> _addItem() async {
    await KursusTable.createKursus(
        _field1.text, _field2.text, _field3.text, _field5.text);
    _refreshJournals();
  }

  // Update an existing journal
  Future<void> _updateItem(int id) async {
    await KursusTable.updateKursus(id, _field1.text, _field2.text, _field3.text,
        _field4.text, _field5.text);
    _refreshJournals();
  }

  // Delete an item
  void _deleteItem(int id) async {
    await KursusTable.deleteKursus(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a journal!'),
    ));
    _refreshJournals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SQL'),
      ),
  
          body: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: _journals.length,
                  itemBuilder: (context, index) => Card(
                    color: Colors.orange[200],
                    margin: const EdgeInsets.all(15),
                    child: ListTile(
                        title: Text("${_journals[index]['judul_kursus']}, ${_journals[index]['kursus_id']}]"),
                        subtitle: Text(_journals[index]['kategori']),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () => _showForm(_journals[index]['kursus_id']),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () =>
                                    _deleteItem(_journals[index]['kursus_id']),
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
        //   Container(
        // child: ClipOval(
        //   child: CircleAvatar(
        //     radius: 50,
        //     backgroundImage: AssetImage('assets/icons/logo.png'),
        //   ),
        // ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showForm(null),
      ),
    );
  }
}
