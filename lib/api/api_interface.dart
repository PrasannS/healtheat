import 'dart:convert';

import 'package:http/http.dart' as http;

//sample request
//http://127.0.0.1:5000/get_menu_data?url=https://www.fastfoodmenuprices.com/and-pizza-prices/

class MenuItem {
  String item;
  double price;

  @override
  String toString() {
    // TODO: implement toString
    return "" + item + price.toString();
  }

  static MenuItem fromJson(Map<String, dynamic> j) {
    MenuItem m = MenuItem();
    m.item = j["item"];
    try {
      m.price = double.parse(j["price"].toString().substring(1));
    } catch (err) {
      m.price = 13.0;
    }
    return m;
  }
}

class RecipeItem {
  String url;
  String name;
  String image;
  List<String> ingredients;
}

class ApiInterface {
  static Future<List<MenuItem>> getMenu(String url) async {
    var params = {'url': url};
    http.Response r = await http
        .get(Uri.parse("http://127.0.0.1:5000/get_menu_data?url=" + url));

    var body = json.decode(r.body);
    print(body['items'][0]['price']);
    List<MenuItem> menu = [];

    for (var i in body['items']) {
      menu.add(MenuItem.fromJson(i));
    }

    return menu;
  }
}
