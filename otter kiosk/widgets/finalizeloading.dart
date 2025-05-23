import 'package:flutter/material.dart';

class FinalLoaderView extends StatelessWidget {
  const FinalLoaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      // color: Colors.black12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadiusDirectional.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'We,re finalizing your document',
            style: TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }
}
