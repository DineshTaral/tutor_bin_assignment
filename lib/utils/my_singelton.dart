

import 'package:tutor_bin_assignment/bloc/cart_bloc.dart';
import 'package:tutor_bin_assignment/bloc/menu_bloc.dart';

class MySingelton{

  static final MySingelton _mySingelton=MySingelton._internal();

  factory MySingelton(){
    return _mySingelton;
  }

  MenuBloc menuBloc=MenuBloc();
  CartBloc cartBloc=CartBloc();

  MySingelton._internal();
}