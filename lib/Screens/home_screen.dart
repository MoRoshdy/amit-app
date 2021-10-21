import 'package:amit_app/Logic/API.dart';
import 'package:amit_app/Models/productVM.dart';
import 'package:amit_app/Screens/product_detail.dart';
import 'package:amit_app/bloc/cart_bloc.dart';
import 'package:amit_app/bloc/cart_events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<ProductVm>(
      future: getProductsFun(),
      builder: (context, snapShot) {
        if (snapShot.connectionState == ConnectionState.done) {
          return Container(
            height: size.height,
            width: size.width,
            color: Colors.grey,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: GridView.count(
                scrollDirection: Axis.vertical,
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: List.generate(
                    snapShot.data.products.length,
                    (index) => Container(
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProductDetail(
                                                selectedItem: snapShot
                                                    .data.products[index],
                                              )));
                                },
                                child: Image(
                                  width: size.width,
                                  height: size.height * .14,
                                  image: NetworkImage(
                                      snapShot.data.products[index].avatar),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Text(
                                "${snapShot.data.products[index].title}",
                                maxLines: 1,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "${snapShot.data.products[index].name}",
                                maxLines: 1,
                                style: TextStyle(
                                  color: Colors.black,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 20,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  MaterialButton(
                                      onPressed: () {
                                        CartBloc cartBloc =
                                            BlocProvider.of(context);
                                        cartBloc.add(AddProductEvent(
                                            newProduct:
                                                snapShot.data.products[index]));
                                      },
                                      color: Colors.red,
                                      height: 20,
                                      minWidth: 20,
                                      child: Text(
                                        '+',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: size.height * .025),
                                      )),
                                  Text(
                                    "${snapShot.data.products[index].priceFinalText}",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )),
              ),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Future<ProductVm> getProductsFun() async {
    return await API.getProducts();
  }
}
