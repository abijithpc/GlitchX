import 'package:flutter/material.dart';
import 'package:glitchxscndprjt/Core/screenbackground.dart';
import 'package:glitchxscndprjt/features/Order_page/Data/Models/order_model.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/widget/invoice_download.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/widget/order_details.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';

class OrderDetailsPage extends StatelessWidget {
  final OrderModel order;

  const OrderDetailsPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context);

    final totalQuantity = order.items.fold<int>(
      0,
      (sum, item) => sum + item.quantity,
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Order Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey[900],
      ),
      backgroundColor: Colors.black,
      body: ScreenBackGround(
        widget: Padding(
          padding: const EdgeInsets.all(16),
          child: Order_details(order, totalQuantity, formatAddress),
        ),
        screenHeight: screen.size.height,
        screenWidth: screen.size.width,
        alignment: Alignment.topCenter,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final pdfBytes = await generateInvoicePdf(order, totalQuantity);
          await Printing.sharePdf(
            bytes: pdfBytes,
            filename: 'invoice_${order.id}.pdf',
          );
        },
        child: Icon(Icons.download),
      ),
    );
  }
}
