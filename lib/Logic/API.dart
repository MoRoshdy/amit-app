import 'dart:convert';
import 'package:amit_app/Models/categoriesVM.dart';
import 'package:http/http.dart' as http;
import 'package:amit_app/Models/productVM.dart';

class API
{
  static Future<ProductVm> getProducts() async
  {
    var url = "https://retail.amit-learning.com/api/products";

    var response = await http.get(Uri.parse(url));



    return  ProductVm.fromJson(Map<String, dynamic>.from(json.decode(response.body.toString())));
  }


  static Future<CategoriesVm> getCategories() async
  {
    var url = "https://retail.amit-learning.com/api/categories";

    var response = await http.get(Uri.parse(url));



    return  CategoriesVm.fromJson(Map<String, dynamic>.from(json.decode(response.body.toString())));
  }
}