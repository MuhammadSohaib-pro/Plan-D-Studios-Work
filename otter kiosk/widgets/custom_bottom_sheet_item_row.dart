import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kiosk/helper/theme_helper.dart';

class BottomSheetItemRow extends StatelessWidget {
  final String title;
  final String imageUrl;
  final Widget? tickIcon;
  final double height;
  final double width;
  final GestureTapCallback? onTap;

  const BottomSheetItemRow({
    Key? key,
    required this.title,
    required this.imageUrl,
    this.onTap,
    this.height = 28,
    this.width = 28,
    this.tickIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 5, top: 8, bottom: 8),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: SvgPicture.asset(
                imageUrl,
                color: ThemeColors.grey1,
                height: height,
                width: width,
              ),
            ),
            SizedBox(width: 13),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            Expanded(child: SizedBox()),
            tickIcon ?? SizedBox(),
          ],
        ),
      ),
    );
  }
}
