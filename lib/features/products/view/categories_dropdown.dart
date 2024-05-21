import 'package:flutter/material.dart';

class CategoryDropdown extends StatelessWidget {
  final List<String?> items;
  final String? initialValue;
  final void Function(String?)? onChanged;

  const CategoryDropdown({
    super.key,
    required this.items,
    this.initialValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String?>(
      isExpanded: true,
      underline: const SizedBox(),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      alignment: Alignment.center,
      items: items.map((item) {
        return DropdownMenuItem<String?>(
          value: item,
          child: Text(item ?? ''),
        );
      }).toList(),
      value: initialValue,
      onChanged: onChanged,
    );
  }
}
