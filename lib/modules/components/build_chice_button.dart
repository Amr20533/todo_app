import 'package:flutter/material.dart';
import 'package:todo_app/shared/themes.dart';

class ChoiceButton extends StatelessWidget {
   ChoiceButton({Key? key,required this.text,required this.color,required this.onTap,this.cancel = false}) : super(key: key);
  final VoidCallback onTap;
  final String text;
  final Color color;
  bool cancel;
  @override
  Widget build(BuildContext context) {
      return GestureDetector(
        onTap: onTap,
        child: Container(alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.height *0.06,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
            border: cancel?Border.all(color: Colors.grey,width: 1):null
          ),
          child: Text(text,style:subHeadingStyle.copyWith(color: cancel ? Colors.black:Colors.white)),
        ),
      );
    }
}
