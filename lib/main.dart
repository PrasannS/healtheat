import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<int> add(int a, int b) async {
    return a + b;
  }

  TextEditingController noteController = new TextEditingController();

  void printData() async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('notes').doc('note2').get();
    print(doc.data());
  }

  void onNoteAddded() {
    FirebaseFirestore.instance
        .collection('notes')
        .doc(DateTime.now().toString())
        .set({'content': noteController.text});

    noteController.clear();
  }

  @override
  Widget build(BuildContext context) {
    print(noteController.text);
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: onNoteAddded,
      ),
      body: ListView(children: [
        Column(
          children: [
            TextField(
              controller: noteController,
            ),
            StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('notes').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                print("SIHFGFPSOIDHFPSOFIDF");

                if (snapshot.data.docs != null) {
                  print("HDSAUHDGPOSDUKDHG");
                  List<DocumentSnapshot> docs = snapshot.data.docs;

                  List<Widget> noteList = [];

                  for (DocumentSnapshot d in docs) {
                    print(d.data());
                    if (d.data()['content'] != null)
                      noteList.add(GestureDetector(
                        child: Padding(
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width - 20,
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                offset: Offset(0, 1),
                                blurRadius: 4,
                              ),
                            ], color: Colors.white),
                            child: Center(
                              child: Text(d.data()['content']),
                            ),
                          ),
                          padding: EdgeInsets.all(6),
                        ),
                        onPanUpdate: (details) {
                          if (details.delta.dx > 0) {
                            // swiping in right direction
                            d.reference.delete();
                          }
                        },
                      ));
                  }
                  return Column(
                    children: noteList,
                  );
                } else {
                  return Text("No data");
                }
              },
            )
          ],
        ),
      ]),
    );
  }
}
