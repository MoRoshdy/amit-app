import 'package:amit_app/Models/productVM.dart';
import 'package:equatable/equatable.dart';


abstract class CartState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

// ignore: must_be_immutable
class InitialState extends CartState {}

// ignore: must_be_immutable
class LoadedState  extends CartState {
  List<Product> shoppingCart;
  LoadedState ({this.shoppingCart});
}

class LoadingState extends CartState{}

// ignore: must_be_immutable
class FailedToLoadState extends CartState {
  String error;
  FailedToLoadState({this.error});
}



