import 'package:flutter/material.dart';

class FilterButtons extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterChanged;

  const FilterButtons({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            _buildSegmentedButton('7 Tage', true),
            _buildSegmentedButton('30 Tage', false),
            _buildSegmentedButton('365 Tage', false),
          ],
        ),
      ),
    );
  }

  Widget _buildSegmentedButton(String filter, bool isFirst) {
    bool isSelected = selectedFilter == filter;
    
    return Expanded(
      child: GestureDetector(
        onTap: () => onFilterChanged(filter),
        child: Container(
          height: 50,
          margin: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: isSelected ? Color(0xFF007AFF) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              filter,
              style: TextStyle(
                color: isSelected ? Colors.white : Color(0xFF007AFF),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}