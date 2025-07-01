import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/features/Cart_Page/Data/Models/cart_model.dart';
import 'package:glitchxscndprjt/features/Cart_Page/presentation/Bloc/cart_bloc.dart';
import 'package:glitchxscndprjt/features/Cart_Page/presentation/Bloc/cart_event.dart';
import 'package:glitchxscndprjt/features/Cart_Page/presentation/Pages/cartpage.dart';
import 'package:glitchxscndprjt/features/Category_Page/Domain/Models/product_model.dart';
import 'package:glitchxscndprjt/features/Category_Page/presentation/widget/showquantity_dialog.dart';
import 'package:glitchxscndprjt/features/Order_page/Data/Models/order_model.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Pages/order_summary_page.dart';

class ProductDetailsPageCard extends StatefulWidget {
  final ProductModel product;

  const ProductDetailsPageCard({super.key, required this.product});

  @override
  State<ProductDetailsPageCard> createState() => _ProductDetailsPageCardState();
}

class _ProductDetailsPageCardState extends State<ProductDetailsPageCard> {
  int currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final width = screen.width;
    final height = screen.height;

    final List<String> imageList = _getImageList(widget.product.imageUrls);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 700;
        final fontSize = (width * 0.045).clamp(14.0, 22.0);
        final spacing = (width * 0.03).clamp(8.0, 20.0);
        final tileSpacing = (height * 0.01).clamp(6.0, 16.0);

        return Center(
          child: Container(
            width: isWide ? 800 : double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: spacing,
              vertical: spacing,
            ),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Carousel
                        CarouselSlider(
                          options: CarouselOptions(
                            height: isWide ? height * 0.45 : height * 0.3,
                            autoPlay: true,
                            enlargeCenterPage: true,
                            onPageChanged: (index, _) {
                              setState(() => currentImageIndex = index);
                            },
                          ),
                          items:
                              imageList.map((url) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child:
                                      url.isNotEmpty
                                          ? Image.network(
                                            url,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (_, __, ___) =>
                                                    _imagePlaceholder(),
                                            loadingBuilder: (
                                              _,
                                              child,
                                              progress,
                                            ) {
                                              if (progress == null)
                                                return child;
                                              return Center(
                                                child: CircularProgressIndicator(
                                                  value:
                                                      progress.expectedTotalBytes !=
                                                              null
                                                          ? progress
                                                                  .cumulativeBytesLoaded /
                                                              progress
                                                                  .expectedTotalBytes!
                                                          : null,
                                                ),
                                              );
                                            },
                                          )
                                          : _imagePlaceholder(),
                                );
                              }).toList(),
                        ),

                        SizedBox(height: tileSpacing * 2),

                        // Name
                        Center(
                          child: Text(
                            widget.product.name,
                            style: TextStyle(
                              fontSize: fontSize + 4,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        SizedBox(height: tileSpacing),

                        // Category & Price
                        Row(
                          children: [
                            Expanded(
                              child: _buildInfoTile(
                                icon: Icons.category,
                                label: "Category",
                                value: widget.product.category,
                                fontSize: fontSize,
                              ),
                            ),
                            SizedBox(width: spacing),
                            Expanded(
                              child: _buildInfoTile(
                                icon: Icons.attach_money,
                                label: "Price",
                                value: "₹${widget.product.price}",
                                textColor: Colors.green,
                                fontSize: fontSize,
                              ),
                            ),
                          ],
                        ),

                        _buildInfoTile(
                          icon: Icons.description,
                          label: "Description",
                          value: widget.product.description,
                          fontSize: fontSize,
                        ),

                        Row(
                          children: [
                            Expanded(
                              child: _buildInfoTile(
                                icon: Icons.album,
                                label: "Disk Count",
                                value: widget.product.diskCount.toString(),
                                fontSize: fontSize,
                              ),
                            ),
                            SizedBox(width: spacing),
                            Expanded(
                              child: _buildInfoTile(
                                icon: Icons.inventory,
                                label: "Stock",
                                value: "${widget.product.stock} in stock",
                                textColor:
                                    widget.product.stock > 0
                                        ? Colors.green
                                        : Colors.red,
                                fontSize: fontSize,
                              ),
                            ),
                          ],
                        ),

                        _buildInfoTile(
                          icon: Icons.calendar_today,
                          label: "Release Date",
                          value:
                              widget.product.releaseDate
                                  .toLocal()
                                  .toString()
                                  .split(' ')[0],
                          fontSize: fontSize,
                        ),

                        _buildInfoTile(
                          icon: Icons.settings_input_component,
                          label: "Minimum Specs",
                          value: widget.product.minSpecs,
                          fontSize: fontSize,
                        ),
                        _buildInfoTile(
                          icon: Icons.settings,
                          label: "Recommended Specs",
                          value: widget.product.recSpecs,
                          fontSize: fontSize,
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: spacing),

                Row(
                  children: [
                    _buildButton(
                      color: Colors.green,
                      icon: Icons.shopping_cart_outlined,
                      label: "Add to Cart",
                      fontSize: fontSize,
                      onPressed: () => _handleCart(context),
                    ),
                    SizedBox(width: spacing),
                    _buildButton(
                      color: Colors.blue,
                      icon: Icons.payment,
                      label: "Buy Now",
                      fontSize: fontSize,
                      onPressed: () => _handleBuyNow(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String label,
    required String value,
    Color? textColor,
    required double fontSize,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(80),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: fontSize + 2),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label.toUpperCase(),
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w600,
                    fontSize: fontSize - 2,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    color: textColor ?? Colors.white.withAlpha(230),
                    fontSize: fontSize,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required Color color,
    required IconData icon,
    required String label,
    required double fontSize,
    required VoidCallback onPressed,
  }) {
    return Expanded(
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: fontSize + 2),
        label: Text(label, style: TextStyle(fontSize: fontSize)),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.symmetric(vertical: fontSize * 0.8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      color: Colors.grey[300],
      child: const Center(
        child: Icon(Icons.image_not_supported, size: 60, color: Colors.grey),
      ),
    );
  }

  List<String> _getImageList(dynamic imageUrl) {
    if (imageUrl is List<String>) return imageUrl;
    if (imageUrl is String && imageUrl.isNotEmpty) return [imageUrl];
    return [];
  }

  void _handleCart(BuildContext context) {
    showQuantityDialog(context, (quantity) {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final cartItem = CartModel(
        userId: user.uid,
        productId: widget.product.id!,
        name: widget.product.name,
        price: widget.product.price,
        quantity: quantity,
        imageUrl: widget.product.imageUrls.first,
        category: widget.product.category,
      );

      context.read<CartBloc>().add(AddProductToCartEvent(cartItem));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Text(
                "Item added Successfully",
                style: TextStyle(color: Colors.white),
              ),
              const Spacer(),
              GestureDetector(
                onTap:
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => CartPage()),
                    ),
                child: Text(
                  "Go To Cart",
                  style: TextStyle(color: Colors.yellow[700]),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      );
    });
  }

  void _handleBuyNow(BuildContext context) {
    showQuantityDialog(context, (quantity) {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final price = widget.product.price * quantity;
      double shippingFee = price < 100 ? 100 : (price > 1000 ? 0 : 40);
      final grandTotal = price + shippingFee;

      final cartItem = CartModel(
        userId: user.uid,
        productId: widget.product.id!,
        name: widget.product.name,
        price: widget.product.price,
        quantity: quantity,
        imageUrl: widget.product.imageUrls.first,
        category: widget.product.category,
      );

      final orderItem = OrderItem(
        productId: widget.product.id!,
        name: widget.product.name,
        price: widget.product.price,
        quantity: quantity,
        imageUrl: widget.product.imageUrls.first,
      );

      final order = OrderModel(
        id: UniqueKey().toString(),
        userId: user.uid,
        items: [orderItem],
        totalAmount: price,
        status: 'Pending',
        orderAt: DateTime.now(),
        address: {},
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (_) => OrderSummaryPage(
                order: [order],
                cartItems: [cartItem],
                totalItems: quantity,
                shippingFee: shippingFee,
                grandTotal: grandTotal,
                isFromCart: false,
              ),
        ),
      );
    });
  }
}
