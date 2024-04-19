import 'package:flutter/material.dart';

class CustomSocialButton extends StatelessWidget {
  const CustomSocialButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.imgPath,
  }) : super(key: key);
  final VoidCallback onPressed;
  final String text;
  final String imgPath;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 55.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
            color: const Color(0xffFFFFFF),
            //color: Colors.amber
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: AssetImage(imgPath),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: const TextStyle(

                fontSize: 16,
                color: Color(0xff101817),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
