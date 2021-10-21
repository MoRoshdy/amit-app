import 'package:amit_app/Models/productVM.dart';
import 'package:equatable/equatable.dart';


class CartEvents extends Equatable {

  @override
  // TODO: implement props
  List<Object> get props => [];

}

// ignore: must_be_immutable
class AddProductEvent extends CartEvents {
  Product newProduct;
  AddProductEvent({this.newProduct});
}

// ignore: must_be_immutable
class DeleteProductEvent extends CartEvents {
  Product newProduct;
  DeleteProductEvent({this.newProduct});
}

// ignore: must_be_immutable
class IncrementProductCountEvent extends CartEvents {
  int productIndex;
  IncrementProductCountEvent({this.productIndex});
}

// ignore: must_be_immutable
class DecrementProductCountEvent extends CartEvents {
  int productIndex;
  DecrementProductCountEvent({this.productIndex});
}


class ClearCartEvent extends CartEvents {}
