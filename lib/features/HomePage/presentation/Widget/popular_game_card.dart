import 'package:flutter/material.dart';

class PopularGameCard extends StatefulWidget {
  const PopularGameCard({super.key});

  @override
  State<PopularGameCard> createState() => _PopularGameCardState();
}

class _PopularGameCardState extends State<PopularGameCard> {
  final List<Map<String, String>> product = [
    {
      'name': 'Super Adventure Game',
      'image': 'Assets/SplashPhotos/hitman-phone-gs8ads5iebuthds5.jpg',
      'price': '\$49.99',
      'description': 'An epic adventure with immersive gameplay.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Popular Games",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "More",
                style: TextStyle(color: Colors.blueAccent, fontSize: 16),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children:
                product.map((productData) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: ProductCard(
                      name: productData['name']!,
                      image: productData['image']!,
                      price: productData['price']!,
                      description: productData['description']!,
                    ),
                  );
                }).toList(),
          ),
        ),
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  final String name;
  final String image;
  final String price;
  final String description;

  const ProductCard({
    super.key,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap:
          () => Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (_) => ProductDetailsPage(
                    name: name,
                    image: image,
                    price: price,
                    description: description,
                  ),
            ),
          ),
      child: Container(
        width: screenWidth * 0.5,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(
                image,
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    price,
                    style: TextStyle(
                      color: Colors.green[700],
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductDetailsPage extends StatelessWidget {
  final String name;
  final String image;
  final String price;
  final String description;

  const ProductDetailsPage({
    super.key,
    required this.name,
    required this.image,
    required this.price,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(name, style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                image,
                width: double.infinity,
                height: screen.height * 0.3,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            Text(
              name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Text(
              price,
              style: TextStyle(color: Colors.green[700], fontSize: 20),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Description',
                style: TextStyle(fontSize: 18, color: Colors.black87),
              ),
            ),
            SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Buying $name')));
                },
                child: Text("Buy Now"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
