import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:tutor_bin_assignment/themes/colors.dart';
import 'dart:math' as math;

import '../models/menu_model.dart';
import '../themes/font_styles.dart';
import '../themes/colors.dart';
import '../utils/my_singelton.dart';
import 'counter_widget.dart';
class CategoryItemWidget extends StatelessWidget {
  final Cat1 category;
  const CategoryItemWidget({required this.category,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   ExpandableTheme(
      data: const ExpandableThemeData(
        useInkWell: true,
      ),
      child: ExpandableNotifier(

          initialExpanded: false,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ScrollOnExpand(

              child: ExpandablePanel(

                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToExpand: true,
                  tapBodyToCollapse: false,
                  hasIcon: false,

                ),
                header: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${category.name}",
                                style: NOTO_SANS_FONT_BLACK.copyWith(fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "${category.menu!.where((element) => element.instock!).length}",
                                style: NOTO_SANS_FONT_GREY.copyWith(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        ExpandableIcon(
                          theme:  ExpandableThemeData(
                            expandIcon: Icons.keyboard_arrow_right_outlined,
                            collapseIcon: Icons.keyboard_arrow_down_sharp,
                            iconColor: GREY_COLOR,
                            iconSize: 28.0,
                            iconRotationAngle: math.pi / 2,
                            iconPadding: EdgeInsets.only(right: 5),
                            hasIcon: false,

                          ),
                        )

                      ],
                    ),
                  ),
                ),
                collapsed: Container(),
                expanded: ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context,index){
                      return !category.menu![index].instock!?SizedBox(): Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(
                                  children: [
                                    Text("${category.menu![index].name}",style: NOTO_SANS_FONT_BLACK,),
                                    SizedBox(width: 8,),
                                    if(MySingelton().menuBloc.mostPopularItems.contains(category.menu![index].name))
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                                      decoration: BoxDecoration(color: PINK_COLOR,borderRadius: BorderRadius.circular(12)),
                                      child: Text("Best Seller",style: NOTO_SANS_FONT_WHITE.copyWith(fontSize: 14.0.sp),),
                                    )
                                  ],
                                ),
                                Text("\$${category.menu![index].price}",style: NOTO_SANS_FONT_GREY,),
                              ],
                            ),
                          ),
                          CounterWidget(onValueUpdate: (val){
                            MySingelton().cartBloc.update_cart(itemName: category.menu![index].name!, itemPrice: category.menu![index].price!, qty: val);
                            print("current value $val");
                          },)
                        ],
                      );
                    }, separatorBuilder: (context,index){
                  return  !category.menu![index].instock!?const SizedBox():const Divider();

                }, itemCount: category.menu!.length),

              ),
            ),
          )),
    );
  }
}
