

import 'dart:convert';
import 'dart:collection';

import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tutor_bin_assignment/models/menu_model.dart';

class MenuBloc{

  //resent orders stream controller using rxdart
  final recentOrdersListStreamController=BehaviorSubject<Cat1>();
  List<Menu> resentOrdersList=[];
  List<String> mostPopularItems=[];

  //this function will get most orders items
  getTopMostItems(){
    mostPopularItems.clear();
    final tempList=<String>[];
    resentOrdersList.forEach((element) {
      tempList.add(element.name!);
    });
    final popular = Map<String,int>();

    tempList.forEach((l) {
      if(!popular.containsKey(l)) {
        popular[l] = 1;
      } else {
        popular[l] =popular[l]!+1;
      }
    });
    List<MapEntry<String,int>> listMappedEntries = popular.entries.toList();
    listMappedEntries.sort((a,b)=> a.value.compareTo(b.value));
    final Map<String,int> sortedMapData = Map.fromEntries(listMappedEntries);

    if(sortedMapData.keys.toList().length>=3){
      mostPopularItems.add(sortedMapData.keys.toList().reversed.elementAt(0));
      mostPopularItems.add(sortedMapData.keys.toList().reversed.elementAt(1));
      mostPopularItems.add(sortedMapData.keys.toList().reversed.elementAt(2));
    }else if(sortedMapData.keys.toList().length>=2){
      mostPopularItems.add(sortedMapData.keys.toList().reversed.elementAt(0));
      mostPopularItems.add(sortedMapData.keys.toList().reversed.elementAt(1));
    }else if(sortedMapData.keys.toList().length>=1){
      mostPopularItems.add(sortedMapData.keys.toList().reversed.elementAt(0));
    }
    tempList.clear();
    popular.clear();
  }

  //load menu from json file
  Future<MenuModel> readJson() async {
    final String response = await rootBundle.loadString('assets/menu.json');
    return MenuModel.fromJson(json.decode(response));
  }
}