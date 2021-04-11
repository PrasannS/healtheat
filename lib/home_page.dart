import 'dart:html';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:healtheat/api/api_interface.dart';
import 'package:healtheat/constants/restaurants.dart';
import 'package:healtheat/items_page.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    setItems();
  }

  String selectedValue = "";

  void setItems() {
    for (Map<String, String> r in restaurants) {
      items.add(
        DropdownMenuItem(
            child: GestureDetector(
              onTap: () {
                print(r["url"]);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ItemsPage(
                            url: r['url'],
                          )),
                );
              },
              child: Container(
                child: Text(r['name']),
                width: 500,
              ),
            ),
            value: r["name"]),
      );
    }
  }

  List<DropdownMenuItem> items = [];

  Widget getSearch() {
    return AppBar(
      backgroundColor: Colors.grey[800],
      title: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Color.fromARGB(50, 70, 70, 70),
          borderRadius: BorderRadius.all(Radius.circular(22.0)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: SearchableDropdown.single(
                  items: items,
                  value: selectedValue,
                  hint: "Type a restaurant",
                  searchHint: "Select one",
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },
                  isExpanded: true,
                ),
                /*TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search Food",
                  hintStyle: TextStyle(color: Colors.white),
                  icon: Icon(Icons.search, color: Colors.white),
                ),
              ),*/
              ),
            ),
            Expanded(
              flex: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.mic, color: Colors.white),
                    ),
                    VerticalDivider(color: Colors.white54),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.more_vert, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String src = "Hello";

  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.grey[800]));
    var imageVal =
        "https://www.applesfromny.com/wp-content/uploads/2020/05/Jonagold_NYAS-Apples2.png";
    return Scaffold(
        appBar: getSearch(), //Search Bar
        backgroundColor: Colors.grey[600], //Main Background Color
        body: Column(
          children: [
            Container(
              //Horizontal Scroll
              margin: EdgeInsets.symmetric(vertical: 20.0),
              height: 300,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  MyRecipes(imageVal, "Heading", "Subheading1", "Subheading2"),
                  MyRecipes(imageVal, "Heading", "Subheading1", "Subheading2"),
                  MyRecipes(imageVal, "Heading", "Subheading1", "Subheading2"),
                  MyRecipes(imageVal, "Heading", "Subheading1", "Subheading2"),
                  MyRecipes(imageVal, "Heading", "Subheading1", "Subheading2"),
                  MyRecipes(imageVal, "Heading", "Subheading1", "Subheading2"),
                  MyRecipes(imageVal, "Heading", "Subheading1", "Subheading2"),
                  MyRecipes(imageVal, "Heading", "Subheading1", "Subheading2"),
                  MyRecipes(imageVal, "Heading", "Subheading1", "Subheading2"),
                  MyRecipes(imageVal, "Heading", "Subheading1", "Subheading2")
                ],
              ),
            ),
            Container(
              //Horizontal Scroll
              margin: EdgeInsets.symmetric(vertical: 20.0),
              height: 300,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  MyRecipes(imageVal, "Heading", "Subheading1", "Subheading2"),
                  MyRecipes(imageVal, "Heading", "Subheading1", "Subheading2"),
                  MyRecipes(imageVal, "Heading", "Subheading1", "Subheading2"),
                  MyRecipes(imageVal, "Heading", "Subheading1", "Subheading2"),
                  MyRecipes(imageVal, "Heading", "Subheading1", "Subheading2"),
                  MyRecipes(imageVal, "Heading", "Subheading1", "Subheading2"),
                  MyRecipes(imageVal, "Heading", "Subheading1", "Subheading2"),
                  MyRecipes(imageVal, "Heading", "Subheading1", "Subheading2"),
                  MyRecipes(imageVal, "Heading", "Subheading1", "Subheading2"),
                  MyRecipes(imageVal, "Heading", "Subheading1", "Subheading2")
                ],
              ),
            ),
          ],
        ));
  }

  Container MyRecipes(
      String imageVal, String heading, String subheading1, String subheading2) {
    return Container(
      width: 160.0,
      child: Card(
        child: Wrap(
          children: <Widget>[
            Image.network(imageVal),
            ListTile(
                title: Text("Recipe 1"),
                subtitle: Column(
                  children: [
                    Text("Calories:" + src),
                    Text("Cost:" + src),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
