import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/Core/constant.dart';
import 'package:glitchxscndprjt/Core/screenbackground.dart';
import 'package:glitchxscndprjt/features/Category_Page/presentation/Bloc/product_bloc.dart';
import 'package:glitchxscndprjt/features/Category_Page/presentation/Bloc/product_event.dart';
import 'package:glitchxscndprjt/features/Category_Page/presentation/Bloc/product_state.dart';
import 'package:glitchxscndprjt/features/Category_Page/presentation/widget/product_card.dart';

class ProductListPage extends StatefulWidget {
  final String category;
  const ProductListPage({super.key, required this.category});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(
      LoadProductByCategoryEvent(widget.category),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category, style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: ScreenBackGround(
        alignment: Alignment.center,
        widget: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return buildShimmerLoading();
            } else if (state is ProductLoaded) {
              final products = state.products;

              if (products.isEmpty) {
                return Center(
                  child: Text(
                    'No products available',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                );
              }

              return ProductCard(products: products);
            } else if (state is ProductError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
        screenHeight: screen.height,
        screenWidth: screen.width,
      ),
    );
  }
}
