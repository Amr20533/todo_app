import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/shared/themes.dart';

class TaskTile extends StatelessWidget {
  final dynamic task;
   const TaskTile(this.task,{Key? key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin:const EdgeInsets.only(top:10 ),
      child: Container(
        padding:const EdgeInsets.all(16),
        width: double.infinity,
        //  width: SizeConfig.screenWidth * 0.78,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: _getTaskClr(int.parse(task['color'])),
        ),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task['title']??"",
                  style: GoogleFonts.lato(
                    textStyle:const TextStyle(
                        fontSize: 16,
                       // fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      color: Colors.grey[200],
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      "${task['startTime']} - ${task['endTime']}",
                      style: GoogleFonts.lato(
                        textStyle:
                        TextStyle(fontSize: 13, color: Colors.grey[100]),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  task['note']??"",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(fontSize: 15, color: Colors.grey[100]),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin:const EdgeInsets.symmetric(horizontal: 10),
            height: 60,
            width: MediaQuery.of(context).size.width * 0.003,
            color: Colors.grey[200]!.withOpacity(0.7),
          ),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              int.parse(task['isCompleted']) == 1 ? "DONE" : "TODO",
              style: GoogleFonts.lato(
                textStyle:const TextStyle(
                    fontSize: 10,
                   // fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ]),
      ),
    );
  }
_getTaskClr(number){
    switch(number){
      case 0:
        return bluishClr;
      case 1:
        return pinkClr;
      case 2:
        return yellowClr;
      default:
        return bluishClr;
    }
}
}