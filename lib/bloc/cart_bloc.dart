
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tutor_bin_assignment/constants/screen_name_constants.dart';
import 'package:tutor_bin_assignment/models/cart_model.dart';
import 'package:tutor_bin_assignment/utils/my_singelton.dart';

import '../models/menu_model.dart';

class CartBloc{

  /*total price stream controller
  * this is responsible for stream updated amount
  * */
  final totalPriceStreamController=BehaviorSubject<num>();

  List<CartModel> cartItemsList=[];

  /*
  * this is responsible for add or remove items from the cart
  * */
  update_cart({required String itemName,required num itemPrice,required int qty}){
    //checking if user don't have any item in cart so it will add first item
    if(cartItemsList.isEmpty){
      cartItemsList.add(CartModel(quantity: qty, itemName: itemName, itemPrice: itemPrice));
    }else{
      /*if user's cart is not empty so it will check the index number of item.
      * if dish found in cart so it will return dish index number else it will return -1
      * */
     int index= cartItemsList.indexWhere((element) => element.itemName==itemName);
    if(index==-1){
      cartItemsList.add(CartModel(quantity: qty, itemName: itemName, itemPrice: itemPrice));
    }else{
      //if qty=0 that mean user remove that this from cart
      if(qty==0){
        cartItemsList.removeAt(index);
      }
      else {
        //updating dish quantity
          cartItemsList[index].quantity = qty;
        }
      }
    }

    updateFinalPrice();
  }

  //calculate total price of dishes added in cart and sink it to stream controller
  updateFinalPrice(){
    totalPriceStreamController.sink.add(0);
    cartItemsList.forEach((element) {
      totalPriceStreamController.sink.add((totalPriceStreamController.hasValue?totalPriceStreamController.value:0)+element.itemPrice*element.quantity);
    });
  }

  //this function will call when user click place order
  placeOder({required BuildContext context}){
    cartItemsList.forEach((element) {
      print("item name ${element.itemName} \t print ${element.itemPrice}\t qty${element.quantity}");
    });

    cartItemsList.forEach((element) {

     MySingelton().menuBloc.resentOrdersList.add(Menu(instock: true,name: element.itemName,price: element.itemPrice));
    });
    Navigator.pushReplacementNamed(context, successScreen);

    MySingelton().menuBloc.recentOrdersListStreamController.sink.add(Cat1(name: "Popular Items",
    menu: MySingelton().menuBloc.resentOrdersList.reversed.toList()));
  }

  //clear all unnecessary data
clearData(){
 cartItemsList.clear();
  totalPriceStreamController.sink.add(0);
}

}