import 'package:flutter/material.dart';

class PayloadScreen extends StatelessWidget {
  const PayloadScreen(this.payload,{Key? key}) : super(key: key);
  final String payload;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
            color: Colors.deepPurple.withOpacity(0.6),
            borderRadius: BorderRadius.circular(16.0),

          ),
          child: Text(payload,style:const TextStyle(color: Colors.white,fontSize: 18.0,fontWeight: FontWeight.w600),),
        ),
      ),
    );
  }
}
