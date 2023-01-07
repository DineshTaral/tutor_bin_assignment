import 'dart:math' as math;

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:tutor_bin_assignment/custom_widgets/category_item_widget.dart';
import 'package:tutor_bin_assignment/models/menu_model.dart';
import 'package:tutor_bin_assignment/themes/colors.dart';
import 'package:tutor_bin_assignment/utils/my_singelton.dart';
import 'package:tutor_bin_assignment/utils/utils.dart';

import '../themes/font_styles.dart';

class MenuScreen extends StatelessWidget{
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Utils.deviceWidth=MediaQuery.of(context).size.width;
    Utils.deviceHeight=MediaQuery.of(context).size.height;
    MySingelton().menuBloc.getTopMostItems();
    return Scaffold(
      appBar: AppBar(
        title:  Text("Tutor Bin Assignment",style: ROBOTO_FONT_WHITE,),
        backgroundColor: ORANGE_COLOR,
      ),
      bottomNavigationBar: GestureDetector(
        onTap: (){
          if(!MySingelton().cartBloc.totalPriceStreamController.hasValue||MySingelton().cartBloc.totalPriceStreamController.value==0){
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Your cart is empty 😔'),
            ));
          }else {
            MySingelton().cartBloc.placeOder(context: context);
          }
        },
        child: Container(
          height: 52,
          padding: EdgeInsets.all(Utils.deviceWidth!*.03),
          margin: EdgeInsets.fromLTRB(Utils.deviceWidth!*.03,0,Utils.deviceWidth!*.03,Utils.deviceWidth!*.03),
          decoration: BoxDecoration(color: ORANGE_COLOR,borderRadius: BorderRadius.circular(10)),
          width: Utils.deviceWidth,
          child: Stack(
            children: [
              Align(
                  alignment: Alignment.center,
                  child: Text("Place Order",style: ROBOTO_FONT_WHITE,)),
              StreamBuilder<num>(
                stream: MySingelton().cartBloc.totalPriceStreamController.stream,
                builder: (context, snapshot) {
                  return snapshot.data==null||snapshot.data==0?SizedBox():Align(
                    alignment: Alignment.centerRight,
                    child: Text("\$${snapshot.data}",style: ROBOTO_FONT_WHITE),
                  );
                }
              )
            ],
          ),
        ),
      ),
      body: FutureBuilder<MenuModel>(
        future: MySingelton().menuBloc.readJson(),
        builder: (ctx,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return Utils.loadingView();
          }else {
            return ListView(
              physics: BouncingScrollPhysics(),
              children: [
                StreamBuilder(
                    stream: MySingelton()
                        .menuBloc
                        .recentOrdersListStreamController
                        .stream,
                    builder: (ctx, popularSnapshot) {
                      return popularSnapshot.hasData
                          ? Column(
                            children: [
                              CategoryItemWidget(
                                  category: popularSnapshot.data!,
                                ),
                            const  Divider()
                            ],
                          )
                          : const SizedBox();
                    }),
                CategoryItemWidget(
                  category: snapshot.data!.cat1!,
                ),
                const  Divider(),
                CategoryItemWidget(
                  category: snapshot.data!.cat2!,
                ),
                const  Divider(),
                CategoryItemWidget(
                  category: snapshot.data!.cat3!,
                ),
                const  Divider(),
                CategoryItemWidget(
                  category: snapshot.data!.cat4!,
                ),
                const  Divider(),
                CategoryItemWidget(
                  category: snapshot.data!.cat5!,
                ),
                const  Divider(),
                CategoryItemWidget(
                  category: snapshot.data!.cat6!,
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
