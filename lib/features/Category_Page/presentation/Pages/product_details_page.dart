import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/Core/screenbackground.dart';
import 'package:glitchxscndprjt/features/Category_Page/presentation/Bloc/product_bloc.dart';
import 'package:glitchxscndprjt/features/Category_Page/presentation/Bloc/product_event.dart';
import 'package:glitchxscndprjt/features/Category_Page/presentation/Bloc/product_state.dart';
import 'package:glitchxscndprjt/features/Category_Page/presentation/widget/product_details_card.dart';

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
    final screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductDetailsLoaded) {
              return Text(
                state.product.name,
                style: TextStyle(color: Colors.white),
              );
            } else if (state is ProductError) {
              return Text("Error");
            } else {
              return Text("Loading...");
            }
          },
        ),
      ),
      body: ScreenBackGround(
        alignment: Alignment.center,
        widget: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ProductDetailsLoaded) {
              final product = state.product;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ProductDetailsPageCard(product: product),
              );
            } else if (state is ProductError) {
              return Center(child: Text(state.message));
            }
            return SizedBox.shrink();
          },
        ),
        screenHeight: screen.height,
        screenWidth: screen.width,
      ),
    );
  }
}
