import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CustomDashboardCard extends StatelessWidget {
  final String icon;
  final String? title;
  final String text;
  final VoidCallback onTap;

  const CustomDashboardCard({
    Key? key,
    required this.icon,
    this.title,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: Get.width * 0.42,
      decoration: BoxDecoration(
        color: const Color(0xff0C8A7B),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title!,
                  style: TextStyle(
                    fontSize: 17.5,
                    fontWeight: FontWeight.w500,
                    color: Color(0xffFFFFFF),
                  ),
                ),
                const Divider(
                  thickness: 0.86,
                  color: Color(0xff149B8B),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                        color: Color(0xffF8F8F8),
                      ),
                    ),
                    SvgPicture.asset(
                      icon,
                      height: 30,
                      width: 30,
                      color: const Color(0xffFFFFFF),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
