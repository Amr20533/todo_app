import 'package:flutter/material.dart';
import 'package:todo_app/shared/themes.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({required this.label,required this.pressed,this.size = 14,Key? key}) : super(key: key);
  final Function()? pressed;
  final String label;
  final double size;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pressed,
      child: Container(alignment: Alignment.center,
          width: 100,height: 60,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child:Text(label,style:TextStyle(color: Colors.white,fontSize: size),)
      ),
    );
  }
}
