import 'package:flutter/services.dart' show rootBundle;
import 'package:glitchxscndprjt/features/Order_page/Data/Models/order_model.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/widget/build_textrfield.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:typed_data';

Future<Uint8List> generateInvoicePdf(
  OrderModel order,
  int totalQuantity,
) async {
  final fontData = await rootBundle.load("Assets/fonts/NotoSans-Regular.ttf");
  final ttf = pw.Font.ttf(fontData);

  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'GlitchX',
              style: pw.TextStyle(
                font: ttf,
                fontSize: 30,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Text('Order ID: ${order.id}', style: pw.TextStyle(font: ttf)),
            pw.Text(
              'Order Date: ${DateFormat.yMMMMd().format(order.orderAt)}',
              style: pw.TextStyle(font: ttf),
            ),
            pw.SizedBox(height: 20),

            pw.Text(
              'Shipping Address:',
              style: pw.TextStyle(font: ttf, fontWeight: pw.FontWeight.bold),
            ),
            pw.Text(
              formatAddress(order.address),
              style: pw.TextStyle(font: ttf),
            ),

            pw.SizedBox(height: 20),
            pw.Text(
              'Ordered Items:',
              style: pw.TextStyle(font: ttf, fontWeight: pw.FontWeight.bold),
            ),

            ...order.items.map(
              (item) => pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    '${item.name} (x${item.quantity})',
                    style: pw.TextStyle(font: ttf),
                  ),
                  pw.Text(
                    '₹ ${item.price.toStringAsFixed(2)}',
                    style: pw.TextStyle(font: ttf),
                  ),
                ],
              ),
            ),

            pw.Divider(),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  'Total Quantity:',
                  style: pw.TextStyle(
                    font: ttf,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text('$totalQuantity', style: pw.TextStyle(font: ttf)),
              ],
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  'Total Amount:',
                  style: pw.TextStyle(
                    font: ttf,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  '₹ ${order.totalAmount.toStringAsFixed(2)}',
                  style: pw.TextStyle(font: ttf),
                ),
              ],
            ),
          ],
        );
      },
    ),
  );

  return pdf.save();
}
