// presentation/widgets/filter_sort_popup.dart
import 'package:flutter/material.dart';

class FilterSortPopup extends StatefulWidget {
  @override
  _FilterSortPopupState createState() => _FilterSortPopupState();
}

class _FilterSortPopupState extends State<FilterSortPopup> {
  String selectedCategory = 'All';
  String selectedSort = 'Name';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Filter & Sort'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButton<String>(
            value: selectedCategory,
            items:
                ['All', 'Action', 'Adventure', 'RPG', 'Sports']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
            onChanged: (value) => setState(() => selectedCategory = value!),
          ),
          DropdownButton<String>(
            value: selectedSort,
            items:
                ['Name', 'Price']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
            onChanged: (value) => setState(() => selectedSort = value!),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed:
              () => Navigator.of(
                context,
              ).pop({'category': selectedCategory, 'sortBy': selectedSort}),
          child: Text('Apply'),
        ),
      ],
    );
  }
}
