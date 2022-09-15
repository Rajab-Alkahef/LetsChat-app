import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class customButton extends StatelessWidget {
  customButton({required this.textButton, this.onTap});
  String textButton;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        width: double.infinity,
        height: 45,
        child: Center(
            child: Text(
          textButton,
          style: TextStyle(
            fontSize: 18,
            color: Color(0xff232156),
          ),
        )),
      ),
    );
  }
}
