import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../themes/colors.dart';
import '../themes/font_styles.dart';

class CounterWidget extends StatelessWidget{
  final Function(int) onValueUpdate;
   CounterWidget({required this.onValueUpdate,Key? key}):super(key: key);
  final itemQtyController=BehaviorSubject<int>();
  @override
  Widget build(BuildContext context){
    itemQtyController.sink.add(0);
    return    Container(
      decoration: BoxDecoration(
          border: Border.all(color: ORANGE_COLOR,),
          borderRadius: BorderRadius.circular(16)
      ),
      child:        StreamBuilder<int>(
          stream: itemQtyController.stream,
        builder: (context, snapshot) {
          return snapshot.data==0?GestureDetector(
            onTap: (){
              itemQtyController.sink.add(itemQtyController.value+1);
              onValueUpdate(itemQtyController.value);
            },
            child: Container(

                decoration: BoxDecoration(color: Colors.white,
                    borderRadius: BorderRadius.circular(16)
                ),
              alignment: Alignment.center,
                height: 32,
                width: 95,
                child: Text("Add",style: NOTO_SANS_FONT_ORANGE,)),
          ): Row(
            children: [
             GestureDetector(
               onTap: (){
                 if(itemQtyController.value>0) {
                    itemQtyController.sink.add(itemQtyController.value - 1);
                    onValueUpdate(itemQtyController.value);
                  }
                },
               child:  SizedBox(
                    width: 30,
                    child: Icon(Icons.remove,color: ORANGE_COLOR,size: 20,)),
             ),
              Container(height: 32,width: 35,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: ORANGE_COLOR,shape: BoxShape.circle),
                    child: Text("${snapshot.data}",style: NOTO_SANS_FONT_WHITE,),
                  ),
              GestureDetector(
                onTap: (){
                  itemQtyController.sink.add(itemQtyController.value+1);
                  onValueUpdate(itemQtyController.value);
                },
                child:  SizedBox(
                    width: 30,
                    child: Icon(Icons.add,color: ORANGE_COLOR,size: 20,)),
              )
            ],
          );
        }
      ),
    );
  }
}