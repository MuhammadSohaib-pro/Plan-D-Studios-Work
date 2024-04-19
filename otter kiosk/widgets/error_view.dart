import 'package:flutter/material.dart';

class showError extends StatelessWidget {
  final Function() ontap;
  const showError({required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 40,
        width: 80,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15))),
            onPressed: ontap,
            child: Icon(Icons.refresh)),
      ),
    );
  }
}
