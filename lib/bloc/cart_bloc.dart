import 'package:amit_app/Models/productVM.dart';
import 'package:bloc/bloc.dart';
import 'cart_events.dart';
import 'cart_states.dart';



class CartBloc extends Bloc<CartEvents, CartState>
{

  CartBloc(CartState initialState) : super(initialState);
  //CartBloc() : super(null);

  List<Product> shoppingCartList  = [];


  @override
  Stream<CartState> mapEventToState(CartEvents event) async*
  {
    yield LoadingState();
    try
    {
      if (event is AddProductEvent)
      {
        event.newProduct.amount = 1;
        shoppingCartList.add(event.newProduct);
      }
      else if (event is DeleteProductEvent)
      {
        shoppingCartList.remove(event.newProduct);
      }
      else if (event is IncrementProductCountEvent)
      {
        shoppingCartList[event.productIndex].amount =
            shoppingCartList[event.productIndex].amount + 1;
      }
      else if (event is DecrementProductCountEvent)
      {
        if(shoppingCartList[event.productIndex].amount >  1)
        {
          shoppingCartList[event.productIndex].amount =
              shoppingCartList[event.productIndex].amount - 1;
        }
      }
      else if (event is ClearCartEvent)
      {
        shoppingCartList.clear();
      }
      else
      {
        //
      }
      yield LoadedState(shoppingCart: shoppingCartList);
    }
    catch(e)
    {
      yield FailedToLoadState(error: e.toString());
    }
  }

}


