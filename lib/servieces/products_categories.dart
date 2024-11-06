import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/categories_model.dart';
import '../model/product_model.dart';

Future<List<Products>> fetchProducts() async {
  try {
    final response = await http.get(Uri.parse('https://prethewram.pythonanywhere.com/api/parts_categories/'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      print("Products data fetched successfully");
      return data.map((json) => Products.fromJson(json)).toList();
    } else {
      print("Failed to fetch products. Status code: ${response.statusCode}");
      throw Exception('Failed to load products');
    }
  } catch (e) {
    print("Error fetching products: $e");
    throw e;
  }
}

Future<List<Categories>> fetchCategories() async {
  try {
    final response = await http.get(Uri.parse('https://prethewram.pythonanywhere.com/api/Top_categories/'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      print("Categories data fetched successfully");
      return data.map((json) => Categories.fromJson(json)).toList();
    } else {
      print("Failed to fetch categories. Status code: ${response.statusCode}");
      throw Exception('Failed to load categories');
    }
  } catch (e) {
    print("Error fetching categories: $e");
    throw e;
  }
}
