import 'package:flutter/material.dart';
import 'package:tutor_bin_assignment/constants/screen_name_constants.dart';
import 'package:tutor_bin_assignment/models/cart_model.dart';
import 'package:tutor_bin_assignment/utils/my_singelton.dart';

import '../themes/colors.dart';
import '../themes/font_styles.dart';
import '../utils/utils.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GestureDetector(
        onTap: (){
          Navigator.pushReplacementNamed(context, menuScreen);
          MySingelton().cartBloc.clearData();
        },
        child: Container(
          height: 52,
          alignment: Alignment.center,
          padding: EdgeInsets.all(Utils.deviceWidth!*.03),
          margin: EdgeInsets.fromLTRB(Utils.deviceWidth!*.03,0,Utils.deviceWidth!*.03,Utils.deviceWidth!*.03),
          decoration: BoxDecoration(color: ORANGE_COLOR,borderRadius: BorderRadius.circular(10)),
          width: Utils.deviceWidth,
          child: Text("Go To Menu",style: ROBOTO_FONT_WHITE,)),
        ),

      body: SizedBox(
        width: Utils.deviceWidth,
        child: ListView(
          padding: EdgeInsets.all(Utils.deviceWidth!*.03),
          children: [
          SizedBox(height: Utils.deviceWidth!*.1,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Thank You",style: OSWALD_FONT_BLACK,),
                SizedBox(height: Utils.deviceWidth!*.03,),
                Text("Your order successfully placed with us",style: PLAYFAIR_DISPLAY_FONT,),
              ],
            ),
            SizedBox(height: Utils.deviceWidth!*.1,),

            Text("Order Summary : -",style: OSWALD_FONT_BLACK,),
            Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Text("Item",style: PLAYFAIR_DISPLAY_FONT,)),
                Expanded(
                    flex: 1,
                    child: Text("Qty.",style: PLAYFAIR_DISPLAY_FONT,textAlign: TextAlign.start)),
                Expanded(
                    flex: 1,
                    child: Text("Amount",style: PLAYFAIR_DISPLAY_FONT,textAlign: TextAlign.end)),
              ],
            ),
            ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (ctx,index){
              return Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${MySingelton().cartBloc.cartItemsList[index].itemName}",style: NOTO_SANS_FONT_BLACK,),
                      Text("\$${MySingelton().cartBloc.cartItemsList[index].itemPrice}",style: NOTO_SANS_FONT_GREY,),
                    ],
                  )),
                  Expanded(flex:1,child: Text("x${MySingelton().cartBloc.cartItemsList[index].quantity}",style: NOTO_SANS_FONT_GREY,textAlign: TextAlign.start,))
                  ,Expanded(flex:1,child: Text("\$${MySingelton().cartBloc.cartItemsList[index].quantity*MySingelton().cartBloc.cartItemsList[index].itemPrice}",style: NOTO_SANS_FONT_GREY,textAlign: TextAlign.end,))
                ],
              );
            }, separatorBuilder: (ctx,index){
              return const Divider();
            }, itemCount: MySingelton().cartBloc.cartItemsList.length),
            Row(
              children: [
                Expanded(

                    child: Text("Total Amount",style: PLAYFAIR_DISPLAY_FONT,textAlign: TextAlign.end,)),
                SizedBox(width: Utils.deviceWidth!*.1,),

                Text("\$${MySingelton().cartBloc.totalPriceStreamController.value}",style: PLAYFAIR_DISPLAY_FONT,textAlign: TextAlign.end),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
