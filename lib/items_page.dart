import 'dart:html';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:healtheat/api/api_interface.dart';
import 'package:healtheat/constants/restaurants.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class ItemsPage extends StatefulWidget {
  ItemsPage({Key key, this.url}) : super(key: key);

  final String url;

  @override
  _ItemsPageState createState() => _ItemsPageState();
}

class _ItemsPageState extends State<ItemsPage> {
  List<MenuItem> menu = [];
  List<bool> selected = [];
  List<MenuItem> selection = [];
  @override
  void initState() {
    super.initState();
    setup();
  }

  Future setup() async {
    menu = await ApiInterface.getMenu(widget.url);
    for (var m in menu) {
      selected.add(false);
      selection.add(null);
    }
    setState(() {});
  }

  String selectedValue = "";

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: menu.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selected[index] = !selected[index];
                if (selected[index]) {
                  selection[index] = menu[index];
                } else {
                  selection[index] = null;
                }
              });
            },
            child: ListTile(
              tileColor:
                  selected[index] ? Colors.greenAccent.shade100 : Colors.white,
              title: ListTile(
                leading: Text(menu[index].item),
                trailing: Column(
                  children: [
                    Text("\$" + menu[index].price.toString()),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
