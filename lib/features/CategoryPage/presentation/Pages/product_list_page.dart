import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/features/Auth/presentation/widget/screenbackground.dart';
import 'package:glitchxscndprjt/features/CategoryPage/presentation/Bloc/product_bloc.dart';
import 'package:glitchxscndprjt/features/CategoryPage/presentation/Bloc/product_event.dart';
import 'package:glitchxscndprjt/features/CategoryPage/presentation/Bloc/product_state.dart';
import 'package:glitchxscndprjt/features/CategoryPage/presentation/widget/product_card.dart';

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
      appBar: AppBar(title: Text('Products - ${widget.category}')),
      body: ScreenBackGround(
        widget: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            print("Current ProductBloc state: $state");
            if (state is ProductLoading) {
              return Center(child: CupertinoActivityIndicator(radius: 20));
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
