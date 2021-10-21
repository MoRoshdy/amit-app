import 'package:amit_app/Models/productVM.dart';
import 'package:amit_app/bloc/cart_bloc.dart';
import 'package:amit_app/bloc/cart_events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetail extends StatefulWidget {
  Product selectedItem;
  ProductDetail({this.selectedItem});

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  void initState() {
    widget.selectedItem.amount = 1;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      color: Colors.white,
      child: ListView(children: [
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.selectedItem.avatar,
                height: size.height * .4,
                width: size.width,
                fit: BoxFit.fill,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                widget.selectedItem.title.toString(),
                style: TextStyle(
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.black),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                widget.selectedItem.name.toString(),
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 15.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Divider(
                thickness: 6,
                color: Colors.black,
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Text(
                    widget.selectedItem.priceFinalText.toString(),
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.red),
                  ),
                  SizedBox(
                    width: 130,
                  ),
                  MaterialButton(
                      onPressed: () {
                        if (widget.selectedItem.amount > 1) {
                          setState(() {
                            widget.selectedItem.amount =
                                widget.selectedItem.amount - 1;
                          });
                        }
                      },
                      color: Colors.red,
                      height: 20,
                      minWidth: 20,
                      child: Text(
                        '-',
                        style: TextStyle(
                            color: Colors.white, fontSize: size.height * .025),
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "${widget.selectedItem.amount}",
                    style: TextStyle(color: Colors.red, fontSize: 25),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  MaterialButton(
                      onPressed: () {
                        setState(() {
                          widget.selectedItem.amount =
                              widget.selectedItem.amount + 1;
                        });
                      },
                      color: Colors.red,
                      height: 20,
                      minWidth: 20,
                      child: Text(
                        '+',
                        style: TextStyle(
                            color: Colors.white, fontSize: size.height * .025),
                      )),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Divider(
                thickness: 6,
                color: Colors.black,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                widget.selectedItem.description.toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13.7,
                ),
              ),
              SizedBox(
                height: 70.0,
              ),
              Container(
                width: size.width,
                height: 40,
                color: Colors.red,
                child: MaterialButton(
                  child: Text(
                    'Add to Cart',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    CartBloc cartBloc = BlocProvider.of(context);
                    cartBloc
                        .add(AddProductEvent(newProduct: widget.selectedItem));
                    Navigator.pop(context);
                  },
                  color: Colors.red,
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
