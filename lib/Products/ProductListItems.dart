import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_assignment/Products/ProductListItemsScreen.dart';
import 'product_model.dart';

class ProductListItems extends StatefulWidget {
  const ProductListItems({super.key});

  @override
  State<ProductListItems> createState() => _ProductListItemsState();
}

class _ProductListItemsState extends State<ProductListItems> {
  List<ProductModel> products = [];

  Future<void> loadProducts() async {
    final String jsonString = await rootBundle.loadString(
      'assets/products.json',
    );
    final List data = json.decode(jsonString);

    setState(() {
      products = data.map((e) => ProductModel.fromJson(e)).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: products.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: Image.asset(
                      product.image,
                      width: 60,
                      fit: BoxFit.cover,
                    ),

                    /*  Image.network(
                      product.image,
                      width: 60,
                      fit: BoxFit.cover,
                    ),*/
                    title: Text(product.title),
                    subtitle: Text('₹ ${product.price}'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductDetailScreen(product: product),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
