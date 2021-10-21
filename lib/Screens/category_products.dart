import 'package:amit_app/Logic/API.dart';
import 'package:amit_app/Models/productVM.dart';
import 'package:amit_app/Screens/product_detail.dart';
import 'package:amit_app/bloc/cart_bloc.dart';
import 'package:amit_app/bloc/cart_events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryProducts extends StatefulWidget {
  int categoriesId;
  String categoryName;
  CategoryProducts ({this.categoriesId,this.categoryName});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<CategoryProducts> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey,
      body: FutureBuilder<ProductVm>(
        future: API.getProducts(),
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.done) {
            List<Product> Lists =snapShot.data.products.where((element) => element.categoryId == widget.categoriesId).toList();
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: GridView.count(
                scrollDirection: Axis.vertical,
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: List.generate(
                    Lists.length,
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
                                        selectedItem: Lists[index],
                                      )));
                            },
                            child: Image(
                              width: size.width,
                              height: size.height * .14,
                              image: NetworkImage(
                                  Lists[index].avatar),
                              fit: BoxFit.fill,
                            ),
                          ),
                          Text(
                            "${Lists[index].title}",
                            maxLines: 1,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              overflow: TextOverflow.ellipsis,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            "${Lists[index].name}",
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
                                        Lists[index]));
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
                                "${Lists[index].priceFinalText}",
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
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

}
// import 'package:amit_app/Logic/API.dart';
// import 'package:amit_app/Models/productVM.dart';
// import 'package:amit_app/Screens/product_detail.dart';
// import 'package:amit_app/bloc/cart_bloc.dart';
// import 'package:amit_app/bloc/cart_events.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
//
//
// class CategoriesProduct extends StatefulWidget {
//   int categoriesId;
//   String categoryName;
//   CategoriesProduct ({this.categoriesId,this.categoryName});
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<CategoriesProduct> {
//   final GlobalKey<ScaffoldState> keys = new GlobalKey<ScaffoldState>();
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//
//         backgroundColor: Colors.grey,
//         key: keys,
//         body: Container(
//           width: size.width,
//           height: size.height,
//           color: Colors.grey,
//           child: FutureBuilder<ProductVm>(
//             future: API.getProducts(),
//             builder: (context, snapshot)
//             {
//
//               if (snapshot.connectionState == ConnectionState.done)
//               {
//                 List<Product> Lists =snapshot.data.products.where((element) => element.categoryId == widget.categoriesId).toList();
//                 return GridView.count(
//                   crossAxisSpacing: 5,
//                   mainAxisSpacing: 5,
//                   crossAxisCount: 2,
//                   children: List.generate(
//                     Lists.length,
//                         (index) => Card(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                       child: Column(
//                         children: [
//                           Expanded(
//                               flex: 2,
//                               child: InkWell(
//                                 onTap: () {
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) => ProductDetail(
//                                               selectedItem: Lists[index])));
//                                 },
//                                 child: Image(
//                                   image: NetworkImage(
//                                       '${Lists[index].avatar}'),
//                                   fit: BoxFit.fill,
//                                   width: size.width * 0.5,
//                                   height: size.height ,
//                                 ),
//                               )),
//                           Expanded(
//                             flex: 3,
//                             child: Column(
//                               children: [
//                                 ListTile(
//                                   title: Text(
//                                     '${Lists[index].title}',
//                                     overflow: TextOverflow.ellipsis,
//                                     maxLines: 1,
//                                     style: TextStyle(
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                   subtitle: Text(
//                                     '${Lists[index].name}',
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                   MainAxisAlignment.spaceEvenly,
//                                   children: [
//                                     InkWell(
//                                         onTap: ()
//                                         {
//                                           CartBloc cartBloc = BlocProvider.of(context);
//                                           cartBloc.add(AddProductEvent(newProduct: Lists[index]));
//                                         },
//                                         child: Icon(Icons.add)),
//                                     Text(
//                                       '${Lists[index].price} EGP',
//                                       style: TextStyle(color: Colors.black),
//                                     )
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               }
//               else
//               {
//                 return Center(
//
//                     child: CircularProgressIndicator() );
//               }
//             },
//           ),
//         ));
//   }
// }