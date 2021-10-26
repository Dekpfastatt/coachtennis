import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Users',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');

  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();

  Future<void> _createOrUpdate([documentSnapshot]) async {
    String action = 'create';

    if (documentSnapshot != null) {
      action = 'update';
      _firstnameController.text = documentSnapshot['firstname'];
      _lastnameController.text = documentSnapshot['lastname'];
    }
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _firstnameController,
                  decoration: const InputDecoration(labelText: "FirstName"),
                ),
                TextField(
                  controller: _lastnameController,
                  decoration: const InputDecoration(labelText: "lastName"),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  child: Text(action == 'create' ? 'Create' : 'Update'),
                  onPressed: () async {
                    final fname = _firstnameController.text;
                    final lname = _lastnameController.text;
                    if (fname != null && lname != null) {
                      if (action == 'create') {
                        await _users
                            .add({"firstname": fname, "lastname": lname});
                      }

                      if (action == 'update') {
                        await _users
                            .doc(documentSnapshot.id)
                            .update({"firstname": fname, "lastname": lname});
                      }

                      _firstnameController.text = '';
                      _lastnameController.text = '';

                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  Future<void> _deleteuser(String user) async {
    await _users.doc(user).delete();
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('user deleted successfuly')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Details"),
      ),
      body: StreamBuilder(
          stream: _users.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
                  return Card(
                    child: ListTile(
                      title: Text(documentSnapshot['firstname']),
                      subtitle: Text(documentSnapshot['lastname']),
                      trailing: SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                _createOrUpdate(documentSnapshot);
                              },
                              icon: const Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () {
                                _deleteuser(documentSnapshot.id);
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _createOrUpdate();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
