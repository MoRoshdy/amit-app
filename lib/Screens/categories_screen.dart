import 'package:amit_app/Logic/API.dart';
import 'package:amit_app/Models/categoriesVM.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'category_products.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<CategoriesVm>(
      future: getCategoriesFun(),
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
                    snapShot.data.categories.length,
                    (index) => Container(
                        color: Colors.white,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => CategoryProducts(
                                  categoriesId: snapShot.data.categories[index].id,
                                  categoryName: snapShot.data.categories[index].name,
                                )));
                          },
                          child: Stack(
                            children: [
                              Image(
                                image: NetworkImage(
                                    snapShot.data.categories[index].avatar),
                                fit: BoxFit.fill,
                              ),
                              Center(
                                child: Container(
                                    color: Colors.black,
                                    child: Text(
                                      "${snapShot.data.categories[index].name}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                              )
                            ],
                          ),
                        ))),
              ),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Future<CategoriesVm> getCategoriesFun() async {
    return await API.getCategories();
  }
}
