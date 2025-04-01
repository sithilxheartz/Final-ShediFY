import 'package:firebase_auth_tutorials/product_details_page.dart';
import 'package:firebase_auth_tutorials/product_service.dart';
import 'package:firebase_auth_tutorials/utils/colors.dart';
import 'package:flutter/material.dart';

class ProductMenuPage extends StatelessWidget {
  const ProductMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.store, size: 40, color: iconColor),
                    SizedBox(width: 5),
                    Text(
                      "ShediFY Oil Mart",
                      style: TextStyle(
                        color: iconColor,
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  "Your Oil Needs, Expertly Met. Explore our curated product range, order tracking, and personalized account access.",
                  style: TextStyle(color: Colors.black54, fontSize: 13),
                ),
                SizedBox(height: 10),
                Text(
                  "Our Products,",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  "Click product to view details & purchase.",
                  style: TextStyle(color: Colors.black54, fontSize: 13),
                ),
                SizedBox(height: 5),
                // todo - start from here
                StreamBuilder(
                  stream: ProductService().products,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height / 5,
                          ),
                          child: Column(
                            children: [
                              Image.asset("assets/course.png", width: 200),
                              Text("No Products are available."),
                            ],
                          ),
                        ),
                      );
                    } else {
                      final products = snapshot.data!;

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return Card(
                            elevation: 0,
                            color: iconSubColor,
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              title: Row(
                                children: [
                                  Icon(Icons.oil_barrel_rounded),
                                  SizedBox(width: 5),
                                  Text(
                                    product.name,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 3),
                                  Text(
                                    product.brand,
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 13,
                                    ),
                                  ),
                                  SizedBox(height: 3),
                                  Text(
                                    "Price: ${product.price}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => ProductDetailsPage(
                                          product: product,
                                        ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
