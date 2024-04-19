import 'package:flutter/material.dart';

class CustomElevatedBtn extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double width;
  final double height;
  final Widget child;
  final double? radius;
  final BorderSide? side;
  final EdgeInsetsGeometry? padding;
  final MaterialTapTargetSize? tapTargetSize;
  final OutlinedBorder? shape;

  const CustomElevatedBtn({
    Key? key,
    this.side,
    this.width = double.infinity,
    this.height = 47,
    this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    required this.child,
    this.radius,
    this.padding,
    this.tapTargetSize,
    this.shape,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        tapTargetSize: tapTargetSize,
        padding: padding,
        side: side,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        minimumSize: Size(width, height),
        shape: (radius == null)
            ? shape
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius!),
              ),
      ),
      child: child,
    );
  }
}

class CustomTextBtn extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double width;
  final double height;
  final Widget child;
  final double? radius;
  final EdgeInsetsGeometry? padding;
  final MaterialTapTargetSize? tapTargetSize;
  final BorderSide? side;
  final OutlinedBorder? shape;

  const CustomTextBtn({
    Key? key,
    this.width = double.infinity,
    this.height = 47,
    this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    required this.child,
    this.radius,
    this.padding,
    this.tapTargetSize,
    this.side,
    this.shape,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: padding,
        tapTargetSize: tapTargetSize,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        minimumSize: Size(width, height),
        side: side,
        shape: (radius == null)
            ? shape
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius!),
              ),
      ),
      child: child,
    );
  }
}

class CustomTextBtn2 extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Size? minimumSize;
  final Widget child;
  final double? radius;
  final EdgeInsetsGeometry? padding;
  final MaterialTapTargetSize? tapTargetSize;
  final BorderSide? side;
  final OutlinedBorder? shape;

  const CustomTextBtn2({
    Key? key,
    this.minimumSize,
    this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    required this.child,
    this.radius,
    this.padding,
    this.tapTargetSize,
    this.side,
    this.shape,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: padding,
        tapTargetSize: tapTargetSize,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        minimumSize: minimumSize,
        side: side,
        shape: (radius == null)
            ? shape
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius!),
              ),
      ),
      child: child,
    );
  }
}

class CustomButton8 extends StatelessWidget {
  final String text;
  final Color? textColor;
  final Color? backgroundColor;
  final VoidCallback onPressed;

  const CustomButton8({
    super.key,
    required this.text,
    this.backgroundColor,
    required this.onPressed,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55.0,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.0),
          ),
          backgroundColor: backgroundColor,
          disabledBackgroundColor: Colors.grey[300],
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: textColor ?? Color(0xffFFFFFF),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class CustomTextBtn3 extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double height;
  final double width;
  final Widget child;
  final double radius;

  CustomTextBtn3({
    Key? key,
    this.width = double.infinity,
    this.height = 52,
    this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    required this.child,
    this.radius = 14,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        minimumSize: Size(width, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      child: child,
    );
  }
}

Widget numberButtons2({
  required String number,
  required VoidCallback? onPressed,
  required Color backgroundColor,
  required Color textColor,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: const Size.square(60),
        padding: const EdgeInsets.all(0),
        backgroundColor: backgroundColor,
        alignment: Alignment.center,
        elevation: 0.5,
      ),
      child: Text(
        number,
        style: TextStyle(
          height: 1,
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    ),
  );
}
