import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kiosk/helper/theme_helper.dart';

class CustomTile1 extends StatelessWidget {
  const CustomTile1({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.padding,
    this.ontap,
    required this.enabled,
    this.icon,
  });
  final String title;
  final String imageUrl;
  final EdgeInsetsGeometry padding;
  final VoidCallback? ontap;
  final bool enabled;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 80,
          width: double.infinity,
          decoration: BoxDecoration(
            // color: Colors.amber,
            borderRadius: BorderRadius.circular(10),
            color: ThemeColors.grey4,
          ),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: ontap,
                  child: SizedBox(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(17.0),
                          child: SvgPicture.asset(
                            imageUrl,
                            height: 46,
                            width: 46,
                            color: enabled
                                ? ThemeColors.primaryColor
                                : ThemeColors.grey2,
                          ),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: enabled
                                  ? ThemeColors.primaryColor
                                  : ThemeColors.grey2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Expanded(child: SizedBox()),
              icon ?? Padding(padding: EdgeInsets.all(0)),
              SizedBox(width: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTile2 extends StatelessWidget {
  const CustomTile2({
    super.key,
    required this.imageUrl,
    this.ontap,
    this.icon,
    required this.title,
  });
  final String imageUrl;
  final String title;
  final VoidCallback? ontap;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 43,
        width: double.infinity,
        color: ThemeColors.grey3,
        child: Row(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 5, bottom: 6, left: 16, right: 7),
              child: SvgPicture.asset(
                imageUrl,
                height: 32,
                width: 32,
              ),
            ),
            // SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: ThemeColors.primaryColor,
              ),
            ),
            Expanded(child: SizedBox()),
            icon ?? Padding(padding: EdgeInsets.all(0))
          ],
        ),
      ),
    );
  }
}
