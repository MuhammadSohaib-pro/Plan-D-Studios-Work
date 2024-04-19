import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomFilterChip1 extends StatelessWidget {
  final String label;
  final bool selected;
  final ValueChanged<bool>? onSelected;

  CustomFilterChip1({
    Key? key,
    required this.label,
    this.selected = false,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: FilterChip(
        showCheckmark: false,
        labelPadding: EdgeInsets.symmetric(horizontal: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        selected: selected,
        onSelected: onSelected,
        label: Text(label),
        labelStyle: TextStyle(
          fontWeight: FontWeight.w300,
          color: selected ? Colors.white : const Color(0xff6A6A6A),
        ),
        selectedColor: Get.theme.primaryColor,
        backgroundColor: Colors.white,
      ),
    );
  }
}

class CustomChoiceChip1 extends StatelessWidget {
  final String label;
  final bool selected;
  final ValueChanged<bool>? onSelected;

  CustomChoiceChip1({
    Key? key,
    required this.label,
    this.selected = false,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: ChoiceChip(
        labelPadding: EdgeInsets.symmetric(horizontal: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        selected: selected,
        onSelected: onSelected,
        label: Text(label),
        labelStyle: TextStyle(
          fontWeight: FontWeight.w300,
          color: selected ? Colors.white : const Color(0xff6A6A6A),
        ),
        selectedColor: Get.theme.primaryColor,
        backgroundColor: Colors.white,
      ),
    );
  }
}

class CustomFilterChip2 extends StatelessWidget {
  final String label;
  final bool selected;
  final ValueChanged<bool>? onSelected;

  CustomFilterChip2({
    Key? key,
    required this.label,
    this.selected = false,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: FilterChip(
        showCheckmark: false,
        labelPadding: EdgeInsets.symmetric(horizontal: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        selected: selected,
        onSelected: onSelected,
        label: Text(label),
        labelStyle: TextStyle(
          fontWeight: FontWeight.w500,
          color: selected ? Colors.white : const Color(0xff6A6A6A),
          fontSize: 12,
        ),
        selectedColor: Get.theme.primaryColor,
        backgroundColor: Colors.white,
      ),
    );
  }
}