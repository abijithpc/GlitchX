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
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screen.width * 0.05,
                ),
              );
            } else if (state is ProductError) {
              return Text("Error", style: TextStyle(color: Colors.red));
            } else {
              return Text(
                "Loading...",
                style: TextStyle(color: Colors.white70),
              );
            }
          },
        ),
      ),
      body: ScreenBackGround(
        alignment: Alignment.center,
        screenHeight: screen.height,
        screenWidth: screen.width,
        widget: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductDetailsLoaded) {
              return Padding(
                padding: EdgeInsets.all(screen.width * 0.04),
                child: ProductDetailsPageCard(product: state.product),
              );
            } else if (state is ProductError) {
              return Center(
                child: Text(
                  state.message,
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
