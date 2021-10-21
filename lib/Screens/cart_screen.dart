import 'package:amit_app/bloc/cart_bloc.dart';
import 'package:amit_app/bloc/cart_events.dart';
import 'package:amit_app/bloc/cart_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class cart extends StatefulWidget {
  @override
  _cartState createState() => _cartState();
}

class _cartState extends State<cart> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
        if (state is LoadedState) {
          return Column(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.fromLTRB(5, 10, 0, 10),
                  height: size.height,
                  width: size.width,
                  child: ListView.builder(
                      itemCount: state.shoppingCart.length,
                      itemBuilder: (context, int index) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Image(
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          '${state.shoppingCart[index].avatar}')),
                                  flex: 2,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.shoppingCart[index].title
                                            .toString(),
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        state.shoppingCart[index].name
                                            .toString(),
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            state.shoppingCart[index]
                                                .priceFinalText
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 21,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          MaterialButton(
                                              onPressed: () {
                                                CartBloc cartBloc =
                                                    BlocProvider.of(context);
                                                cartBloc.add(
                                                    DecrementProductCountEvent(
                                                        productIndex: index));
                                              },
                                              color: Colors.red,
                                              height: 20,
                                              minWidth: 20,
                                              child: Text(
                                                '-',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize:
                                                        size.height * .025),
                                              )),
                                          Text(
                                            "\t" +
                                                state.shoppingCart[index].amount
                                                    .toString() +
                                                "\t",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 20),
                                          ),
                                          MaterialButton(
                                              onPressed: () {
                                                CartBloc cartBloc =
                                                    BlocProvider.of(context);
                                                cartBloc.add(
                                                    IncrementProductCountEvent(
                                                        productIndex: index));
                                              },
                                              color: Colors.red,
                                              height: 20,
                                              minWidth: 20,
                                              child: Text(
                                                '+',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize:
                                                        size.height * .025),
                                              )),
                                        ],
                                      )
                                    ],
                                  ),
                                  flex: 5,
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      CartBloc cartBloc =
                                          BlocProvider.of(context);
                                      cartBloc.add(DeleteProductEvent(
                                          newProduct:
                                              state.shoppingCart[index]));
                                    },
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.redAccent,
                                      size: 30,
                                    ),
                                  ),
                                  flex: 1,
                                ),
                              ],
                            ),
                            Divider(
                              thickness: 4,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        );
                      }),
                ),
                flex: 9,
              ),
              Expanded(
                child: Container(
                  width: size.width,
                  height: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          CartBloc cartBloc = BlocProvider.of(context);
                          cartBloc.add(ClearCartEvent());
                          setState(() {});
                        },
                        child: Text(
                          'clear cart',
                          style: TextStyle(color: Colors.black),
                        ),
                        color: Colors.white,
                      ),
                      MaterialButton(
                        child: Text(
                          'Go to checkout',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {},
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
                flex: 1,
              ),
            ],
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}
