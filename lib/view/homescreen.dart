// import 'package:codeedexproject/view/product_detail.dart';
// import 'package:flutter/material.dart';
// import '../model/categories_model.dart';
// import '../model/product_model.dart';
// import '../servieces/products_categories.dart';
//
//
// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   late Future<List<Products>> productsFuture;
//   late Future<List<Categories>> categoriesFuture;
//   List<Products> products = [];
//
//   @override
//   void initState() {
//     super.initState();
//     productsFuture = fetchProducts();
//     categoriesFuture = fetchCategories();
//   }
//
//   void _sortProductsByRating() {
//     setState(() {
//       products.sort((a, b) {
//         double ratingA = double.tryParse(a.productRating ?? '0') ?? 0.0;
//         double ratingB = double.tryParse(b.productRating ?? '0') ?? 0.0;
//         return ratingB.compareTo(ratingA);
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Products and Categories'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.sort),
//             onPressed: _sortProductsByRating,
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           FutureBuilder<List<Categories>>(
//             future: categoriesFuture,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return CircularProgressIndicator();
//               } else if (snapshot.hasError) {
//                 return Text('Error loading categories');
//               } else {
//                 return Container(
//                   height: 100,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: snapshot.data?.length ?? 0,
//                     itemBuilder: (context, index) {
//                       final category = snapshot.data![index];
//                       return Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Chip(label: Text(category.catName ?? 'No Name')),
//                       );
//                     },
//                   ),
//                 );
//               }
//             },
//           ),
//           Expanded(
//             child: FutureBuilder<List<Products>>(
//               future: productsFuture,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return CircularProgressIndicator();
//                 } else if (snapshot.hasError) {
//                   return Text('Error loading products');
//                 } else {
//                   products = snapshot.data!;
//                   return ListView.builder(
//                     itemCount: products.length,
//                     itemBuilder: (context, index) {
//                       final product = products[index];
//                       return ListTile(
//                         leading: product.partImage != null
//                             ? Image.network(product.partImage!, width: 50, height: 50)
//                             : Icon(Icons.image_not_supported, size: 50),
//                         title: Text(product.partsName ?? 'No name'),
//                         subtitle: Text('Rating: ${product.productRating ?? 'N/A'}'),
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => ProductDetailsScreen(product: product),
//                             ),
//                           );
//                         },
//                       );
//                     },
//                   );
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/categories_model.dart';
import '../model/product_model.dart';
import '../servieces/products_categories.dart';
// Ensure this imports your login page correctly
import 'login_screen.dart';

import 'product_detail.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Products>> productsFuture;
  late Future<List<Categories>> categoriesFuture;
  List<Products> products = [];
  List<Products> filteredProducts = [];
  Categories? selectedCategory;

  @override
  void initState() {
    super.initState();
    productsFuture = fetchProducts();
    categoriesFuture = fetchCategories();
  }

  void _filterProductsByCategory() {
    if (selectedCategory == null) {
      setState(() {
        filteredProducts = products;
      });
    } else {
      setState(() {
        filteredProducts = products
            .where((product) => product.partsCat == selectedCategory!.id)
            .toList();
      });
    }
  }

  Future<void> _logout() async {
    // Clear user session from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    // Navigate to Login Page and remove HomeScreen from stack
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products and Categories'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Column(
        children: [
      // Text(
      // "Name : ${user.displayName!}",
          // Dropdown to select category
          FutureBuilder<List<Categories>>(
            future: categoriesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                print("Error loading categories: ${snapshot.error}");
                return Center(child: Text('Error loading categories'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                print("No categories data found");
                return Center(child: Text('No categories available'));
              } else {
                final categories = snapshot.data!;
                return DropdownButton<Categories>(
                  hint: Text('Select Category'),
                  value: selectedCategory,
                  onChanged: (category) {
                    setState(() {
                      selectedCategory = category;
                      _filterProductsByCategory();
                    });
                  },
                  items: categories.map((category) {
                    return DropdownMenuItem<Categories>(
                      value: category,
                      child: Text(category.catName ?? 'No Name'),
                    );
                  }).toList(),
                );
              }
            },
          ),
          // Product List
          Expanded(
            child: FutureBuilder<List<Products>>(
              future: productsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  print("Error loading products: ${snapshot.error}");
                  return Center(child: Text('Error loading products'));
                } else {
                  products = snapshot.data!;
                  if (selectedCategory == null) filteredProducts = products;
                  return ListView.builder(
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return ListTile(
                        leading: product.partImage != null
                            ? Image.network(product.partImage!, width: 50, height: 50)
                            : Icon(Icons.image_not_supported, size: 50),
                        title: Text(product.partsName ?? 'No name'),
                        subtitle: Text('Rating: ${product.productRating ?? 'N/A'}'),
                        trailing: Wrap(
                          children: [
                            Icon(Icons.star, color: Colors.yellow,size: 20.0,),
                            Icon(Icons.star, color: Colors.grey,size: 20.0,),Icon(Icons.star, color: Colors.grey,size: 20.0,),Icon(Icons.star, color: Colors.grey,size: 20.0,),
                            Icon(Icons.star_border, color: Colors.grey,size: 20.0,),
                          ],),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailsScreen(product: product),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
