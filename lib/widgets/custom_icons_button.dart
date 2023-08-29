

import 'package:flutter/material.dart';
import 'package:marvel_app/helpers/consts.dart';

class CustomIconButton extends StatefulWidget {
  const CustomIconButton({super.key, required this.asset, required this.color, required this.onPressed});
final String asset ; 
final Color color ; 
final Function onPressed ;
  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            decoration:  BoxDecoration(
              border: Border.all(color: primaryColor.withOpacity(0.3)  ) , 
              borderRadius: BorderRadius.circular(10)
            ),
            child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(widget.asset , width: 24  , height: 24, ),
          )),
        ],
      ),
    );
  }
}