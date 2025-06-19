// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:glitchxscndprjt/Core/screenbackground.dart';
// import 'package:glitchxscndprjt/features/CategoryPage/presentation/Bloc/product_bloc.dart';
// import 'package:glitchxscndprjt/features/CategoryPage/presentation/Bloc/product_event.dart';
// import 'package:glitchxscndprjt/features/CategoryPage/presentation/Bloc/product_state.dart';

// class SortingFilterPage extends StatelessWidget {
//   final String category;
//   const SortingFilterPage({super.key, required this.category});

//   @override
//   Widget build(BuildContext context) {
//     // Get screen size for responsiveness
//     final double screenWidth = MediaQuery.of(context).size.width;
//     final double screenHeight = MediaQuery.of(context).size.height;

//     return BlocBuilder<ProductBloc, ProductState>(
//       builder: (context, state) {
//         // Default values
//         String selectedSort = "Price (Low to High)";
//         String selectedCategory = category;
//         String selectedAvailability = "All Availability";
//         String selectedRating = "All Ratings";
//         double minPrice = 0.0;
//         double maxPrice = 1000.0;

//         // Update values if state is ProductSortedAndFiltered
//         if (state is ProductSortedAndFiltered) {
//           selectedSort = state.selectedSort;
//           selectedAvailability = state.selectedAvailability;
//           selectedRating = state.selectedRating;
//           minPrice = state.minPrice;
//           maxPrice = state.maxPrice;
//         }

//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15),
//           ),
//           title: Text(
//             "Sort and Filter Products",
//             style: Theme.of(context).textTheme.titleLarge?.copyWith(
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           content: SingleChildScrollView(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Sorting Section
//                   Text(
//                     "Sort By",
//                     style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   buildRadioOption(context, "Price Low to High", selectedSort, (
//                     value,
//                   ) {
//                     context.read<ProductBloc>().add(
//                       SortAndFIlterProducts(
//                         sortOption: value!,
//                         category: selectedCategory,
//                         availability: selectedAvailability,
//                         minPrice: minPrice,
//                         maxPrice: maxPrice,
//                         rating: selectedRating,
//                       ),
//                     );
//                   }),
//                   buildRadioOption(context, "Price High to Low", selectedSort, (
//                     value,
//                   ) {
//                     context.read<ProductBloc>().add(
//                       SortAndFIlterProducts(
//                         sortOption: value!,
//                         category: selectedCategory,
//                         availability: selectedAvailability,
//                         minPrice: minPrice,
//                         maxPrice: maxPrice,
//                         rating: selectedRating,
//                       ),
//                     );
//                   }),
//                   buildRadioOption(context, "Name (A-Z)", selectedSort, (
//                     value,
//                   ) {
//                     context.read<ProductBloc>().add(
//                       SortAndFIlterProducts(
//                         sortOption: value!,
//                         category: selectedCategory,
//                         availability: selectedAvailability,
//                         minPrice: minPrice,
//                         maxPrice: maxPrice,
//                         rating: selectedRating,
//                       ),
//                     );
//                   }),
//                   buildRadioOption(context, "Name (Z-A)", selectedSort, (
//                     value,
//                   ) {
//                     context.read<ProductBloc>().add(
//                       SortAndFIlterProducts(
//                         sortOption: value!,
//                         category: selectedCategory,
//                         availability: selectedAvailability,
//                         minPrice: minPrice,
//                         maxPrice: maxPrice,
//                         rating: selectedRating,
//                       ),
//                     );
//                   }),
//                   buildRadioOption(
//                     context,
//                     "Rating (High to Low)",
//                     selectedSort,
//                     (value) {
//                       context.read<ProductBloc>().add(
//                         SortAndFIlterProducts(
//                           sortOption: value!,
//                           category: selectedCategory,
//                           availability: selectedAvailability,
//                           minPrice: minPrice,
//                           maxPrice: maxPrice,
//                           rating: selectedRating,
//                         ),
//                       );
//                     },
//                   ),
//                   buildRadioOption(
//                     context,
//                     "Rating (Low to High)",
//                     selectedSort,
//                     (value) {
//                       context.read<ProductBloc>().add(
//                         SortAndFIlterProducts(
//                           sortOption: value!,
//                           category: selectedCategory,
//                           availability: selectedAvailability,
//                           minPrice: minPrice,
//                           maxPrice: maxPrice,
//                           rating: selectedRating,
//                         ),
//                       );
//                     },
//                   ),

//                   const SizedBox(height: 20),
//                   // Filter Section
//                   Text(
//                     "Filter By",
//                     style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   buildRadioOption(
//                     context,
//                     "Availability (In Stock)",
//                     selectedAvailability,
//                     (value) {
//                       context.read<ProductBloc>().add(
//                         SortAndFIlterProducts(
//                           sortOption: selectedSort,
//                           category: selectedCategory,
//                           availability: value!,
//                           minPrice: minPrice,
//                           maxPrice: maxPrice,
//                           rating: selectedRating,
//                         ),
//                       );
//                     },
//                   ),
//                   buildRadioOption(
//                     context,
//                     "Availability (Out of Stock)",
//                     selectedAvailability,
//                     (value) {
//                       context.read<ProductBloc>().add(
//                         SortAndFIlterProducts(
//                           sortOption: selectedSort,
//                           category: selectedCategory,
//                           availability: value!,
//                           minPrice: minPrice,
//                           maxPrice: maxPrice,
//                           rating: selectedRating,
//                         ),
//                       );
//                     },
//                   ),
//                   buildRadioOption(context, "Rating (1 to 5)", selectedRating, (
//                     value,
//                   ) {
//                     context.read<ProductBloc>().add(
//                       SortAndFIlterProducts(
//                         sortOption: selectedSort,
//                         category: selectedCategory,
//                         availability: selectedAvailability,
//                         minPrice: minPrice,
//                         maxPrice: maxPrice,
//                         rating: value!,
//                       ),
//                     );
//                   }),

//                   const SizedBox(height: 20),
//                   // Price Range Section
//                   Text(
//                     "Price Range",
//                     style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   RangeSlider(
//                     min: 0,
//                     max: 10000,
//                     divisions: 100,
//                     values: RangeValues(minPrice, maxPrice),
//                     labels: RangeLabels(
//                       '\₹ ${minPrice.toStringAsFixed(0)}',
//                       '\₹ ${maxPrice.toStringAsFixed(0)}',
//                     ),
//                     onChanged: (RangeValues values) {
//                       context.read<ProductBloc>().add(
//                         SortAndFIlterProducts(
//                           sortOption: selectedSort,
//                           category: selectedCategory,
//                           availability: selectedAvailability,
//                           minPrice: values.start,
//                           maxPrice: values.end,
//                           rating: selectedRating,
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text(
//                 "Apply",
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Theme.of(context).primaryColor,
//                 ),
//               ),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text(
//                 "Cancel",
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.red,
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Widget buildRadioOption(
//     BuildContext context,
//     String title,
//     String groupValue,
//     Function(String?) onChanged,
//   ) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: ListTile(
//         contentPadding: EdgeInsets.zero,
//         title: Text(
//           title,
//           style: Theme.of(
//             context,
//           ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
//         ),
//         leading: Radio<String>(
//           value: title,
//           groupValue: groupValue,
//           onChanged: onChanged,
//           activeColor: Theme.of(context).primaryColor,
//         ),
//       ),
//     );
//   }
// }
