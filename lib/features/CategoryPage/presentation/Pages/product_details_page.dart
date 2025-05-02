import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/features/CategoryPage/presentation/Bloc/product_bloc.dart';
import 'package:glitchxscndprjt/features/CategoryPage/presentation/Bloc/product_event.dart';
import 'package:glitchxscndprjt/features/CategoryPage/presentation/Bloc/product_state.dart';

class ProductDetailsPage extends StatefulWidget {
  final String productId;

  const ProductDetailsPage({super.key, required this.productId});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  void initState() {
    super.initState();
    // Fetch product details using the productId passed to the page
    context.read<ProductBloc>().add(FetchProductDetails(widget.productId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProductDetailsLoaded) {
            final product = state.product;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Image.network(product.imageUrl),
                  SizedBox(height: 12),
                  Text(
                    product.name,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(product.description),
                  Text("Category: ${product.category}"),
                  Text("Disk Count: ${product.diskCount}"),
                  Text("Price: ₹${product.price}"),
                  Text("Stock: ${product.stock}"),
                  Text("Release Date: ${product.releaseDate.toLocal()}"),
                  Text("Min Specs: ${product.minSpecs}"),
                  Text("Rec Specs: ${product.recSpecs}"),
                ],
              ),
            );
          } else if (state is ProductError) {
            return Center(child: Text(state.message));
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
