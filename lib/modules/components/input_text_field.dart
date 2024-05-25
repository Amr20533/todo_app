import 'package:flutter/material.dart';
import 'package:todo_app/shared/themes.dart';
class InputTextField extends StatelessWidget {
  const InputTextField({this.controller,this.widget,required this.title,required this.hint,Key? key}) : super(key: key);
  final String title,hint;
  final TextEditingController? controller;
  final Widget? widget;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.only(top:16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: titleStyle,),
          Container(
              height: 52,
              margin: const EdgeInsets.only(top:8.0),
              padding:const EdgeInsets.only(left:14),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.grey,width: 1.0
                  ),
                  borderRadius: BorderRadius.circular(12)
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      autofocus: false,
                      readOnly: widget == null?false:true,
                      controller: controller,
                      cursorColor: Colors.grey[600],
                      style: subTitleStyle,
                      decoration: InputDecoration(
                          hintText: hint,
                          hintStyle: subTitleStyle,
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(width:0,color:Colors.transparent),
                          )
                      ),
                    ),
                  ),
                  if (widget==null) Container() else Container(child: widget,)
                ],
              )
          ),
        ],
      ),
    );
  }
}
