class MenuModel {
  Cat1? cat1;
  Cat1? cat2;
  Cat1? cat3;
  Cat1? cat4;
  Cat1? cat5;
  Cat1? cat6;

  MenuModel({this.cat1, this.cat2, this.cat3, this.cat4, this.cat5, this.cat6});

  MenuModel.fromJson(Map<String, dynamic> json) {
    cat1 = json['cat1'] != null ? new Cat1.fromJson(json['cat1']) : null;
    cat2 = json['cat2'] != null ? new Cat1.fromJson(json['cat2']) : null;
    cat3 = json['cat3'] != null ? new Cat1.fromJson(json['cat3']) : null;
    cat4 = json['cat4'] != null ? new Cat1.fromJson(json['cat4']) : null;
    cat5 = json['cat5'] != null ? new Cat1.fromJson(json['cat5']) : null;
    cat6 = json['cat6'] != null ? new Cat1.fromJson(json['cat6']) : null;
  }

}

class Cat1 {
  String? name;
  List<Menu>? menu;

  Cat1({this.name, this.menu});

  Cat1.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['menu'] != null) {
      menu = <Menu>[];
      json['menu'].forEach((v) {
        menu!.add(new Menu.fromJson(v));
      });
    }
  }
}

class Menu {
  String? name;
  num? price;
  bool? instock;

  Menu({this.name, this.price, this.instock});

  Menu.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    instock = json['instock'];
  }
}
