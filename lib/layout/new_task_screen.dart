import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/layout/edit_screen.dart';
import 'package:todo_app/layout/task_screen.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/modules/components/add_task_screen.dart';
import 'package:todo_app/modules/components/build_chice_button.dart';
import 'package:todo_app/modules/components/round_button.dart';
import 'package:todo_app/modules/components/task_tile.dart';
import 'package:todo_app/services/notification_services.dart';
import 'package:todo_app/shared/themes.dart';
import 'package:todo_app/shared/todo_cubit.dart';
import 'package:todo_app/shared/todo_states.dart';

class NewTaskScreen extends StatelessWidget {
   const NewTaskScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit,TodoStates>(
        builder: (context,state){
          var task = TodoCubit.get(context).newTasks;
          TodoCubit cubit = TodoCubit.get(context);
          return SafeArea(
            child: Stack(
              // alignment: Alignment.topLeft,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 25.0,),
                      Row(
                        children: [
                          Builder(builder: (context)=>GestureDetector(
                            onTap: () => Scaffold.of(context).openDrawer(),
                            child: Container(
                              margin:const EdgeInsets.only(top: 7.0,left: 12),
                              height: 40,width: 40,
                              decoration: BoxDecoration(
                                  color:TodoCubit.get(context).btnColor,
                                  shape: BoxShape.circle,
                                  boxShadow: const[
                                    BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(0,3),
                                    blurRadius: 17,
                                  )]
                              ),
                              child: SvgPicture.asset('assets/icons/menu.svg',color: TodoCubit.get(context).drawerIcon),
                            ),
                          ),),
                          const SizedBox(width: 15.0,),
                          Text(DateFormat.yMMMMd().format(TodoCubit.get(context).selectedDate),style: titleStyle.copyWith(color: TodoCubit.get(context).color)),
                        ],
                      ),
                      _addTaskBar(context,cubit.selectedDate),
                      addDatePicker(context),
                      _myTasks(context)
                    ],
                ),

              ],
            ),
          );

          /*_showTasks(){
            return Expanded(
              child:ListView.builder(
                    itemCount:_taskController.taskList.length,
                    itemBuilder: (_, index) {
                      print('task length --> \n');
                      print(TodoCubit.get(context).newTasks.length);
                      // Task task = _taskController.taskList[index];
                      // print(task.toJson());
                      if(task.repeat == 'Daily'){
                        DateTime date = DateFormat.jm().parse(task.startTime.toString());
                        var myTime = DateFormat('HH:mm').format(date);
                        print("myTime: $myTime");
                        // notificationHelper.scheduledNotification(
                        //   int.parse(myTime.toString().split(":")[0]),
                        //   int.parse(myTime.toString().split(":")[1]),);

                        return AnimationConfiguration.staggeredList(
                            position: index,
                            child:SlideAnimation(
                              child:FadeInAnimation(
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                       // _showBottomSheet(context,task);
                                      },
                                      child: TaskTile(task,
                                      ),
                                    )
                                  ],
                                ),
                              ) ,
                            )
                        );

                      }
                      if(task.date == DateFormat.yMd().format(TodoCubit.get(context).selectedDate)){
                        return AnimationConfiguration.staggeredList(
                            position: index,
                            child:SlideAnimation(
                              child:FadeInAnimation(
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        // _showBottomSheet(context,task);
                                      },
                                      child: TaskTile(task,
                                      ),
                                    )
                                  ],
                                ),
                              ) ,
                            )
                        );

                      }else{
                        return Container(child: Text('HH'),);
                      }
                    }
                    ));
              }*/
          // _showBottomSheet(BuildContext context,Task task){
          //   Scaffold.of(context).bottomSheet(
          //       Container(
          //         padding: const EdgeInsets.only(top:4),
          //         height:task.isCompleted==1?MediaQuery.of(context).size.height * 0.24:MediaQuery.of(context).size.height * 0.32,
          //         color: darkGreyClr,
          //         child: Column(
          //           children: [
          //             Container(
          //               height: 6,width: 120,
          //               decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.circular(10),
          //                 color:Colors.green[600],
          //
          //               ),
          //             ),
          //             const Spacer(),
          //             task.isCompleted ==1?Container():_bottomSheetButton(
          //                 context,
          //                 label:"Task Completed",
          //                 onTap:(){
          //                   // _taskController.taskCompletedMark(task.id!);
          //                   // Get.back();
          //                 },
          //                 clr:primaryColor
          //             ),
          //             _bottomSheetButton(
          //               context,
          //               label:"Delete Task ",
          //               onTap:(){
          //                 // _taskController.delete(task);
          //                 // Get.back();
          //               },
          //               clr:Colors.red[300]!,
          //             ),
          //             const SizedBox(height:20),
          //             _bottomSheetButton(
          //               context,
          //               label:"Close ",
          //               onTap:(){
          //                 // Get.back();
          //               },
          //               isClosed: true,
          //               clr:Colors.red[300]!,
          //             ),
          //             const SizedBox(height:10),
          //           ],
          //         ),
          //       )
          //   );
          // }
          // _bottomSheetButton(BuildContext context,{required String label,required Function()? onTap,required Color clr ,bool isClosed = false}){
          //   return GestureDetector(
          //     onTap: onTap,
          //     child:Container(
          //         margin:const EdgeInsets.symmetric(vertical: 4),
          //         height:55,
          //         width: MediaQuery.of(context).size.width * 0.9,
          //         decoration: BoxDecoration(
          //           color: isClosed == true?Colors.grey[600]!:clr,
          //           border: Border.all(width: 2,
          //               color: isClosed == true?Colors.transparent:clr),
          //           borderRadius: BorderRadius.circular(20),
          //         ),
          //         child:Text(label,style:isClosed?titleStyle.copyWith(color:Colors.white): subTitleStyle,)
          //
          //     ),
          //   );
          // }
        },
        listener: (context,state){

        });
  }
  addDatePicker(context){
    return Container(
      // width: 60,height: 160,
        margin:const EdgeInsets.only(top:20,left: 20),
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(10),
        ),
        child: DatePicker(
          DateTime.now(), height: 100,width: 80,
          initialSelectedDate: DateTime.now(),
          selectionColor: primaryColor,
          selectedTextColor: Colors.white,
          dateTextStyle: GoogleFonts.lato(
              textStyle:const TextStyle(
                  fontSize: 20,fontWeight:FontWeight.w600,
                  color: Colors.grey
              )),
          dayTextStyle: GoogleFonts.lato(
              textStyle:const TextStyle(
                  fontSize: 16,fontWeight:FontWeight.w600,
                  color: Colors.grey
              )),
          monthTextStyle: GoogleFonts.lato(
            textStyle:const TextStyle(
                fontSize: 14,fontWeight:FontWeight.w600,
                color: Colors.grey
            ),
          ),
          onDateChange: (date){
            TodoCubit.get(context).dateSelect(date);

          },
        )
    );

  }
  _addTaskBar(context,date){
    return Container(
      height: 70,
      margin:const EdgeInsets.only(top:12,left:20,right:20),
      child: Row(
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Text('Today',style:headingStyle),
            ],
          ),
          const Spacer(),
          RoundButton(
              label: '+ Add Task',
              pressed: ()async {
                await Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddTask()));
                // _taskController.getTasks();

              } ),
        ],
      ),
    );
  }
  _myTasks(context){
    return Expanded(
      child:TodoCubit.get(context).newTasks.isNotEmpty?ListView.builder(
        shrinkWrap: true,
            physics:const BouncingScrollPhysics(),
            itemCount:TodoCubit.get(context).newTasks.length,
            itemBuilder: (context, index) {
              if(TodoCubit
                  .get(context)
                  .newTasks[index]['repeat'] == TodoCubit
                  .get(context).repeatList[1]){
                DateTime date = DateFormat.jm().parse(TodoCubit
                    .get(context).startTime.toString());
                var myTime = DateFormat('HH:mm').format(date);
                print("myTime: $myTime");
                NotificationHelper.scheduledNotification(
                  int.parse(myTime.toString().split(":")[0]),
                  int.parse(myTime.toString().split(":")[1]),
                  Task(
                    date: TodoCubit.get(context).newTasks[index]['date'],
                    startTime: TodoCubit.get(context).newTasks[index]['startTime'],
                    endTime: TodoCubit.get(context).newTasks[index]['endTime'],
                    repeat: TodoCubit.get(context).newTasks[index]['repeat'],
                    remind: TodoCubit.get(context).newTasks[index]['remind'],
                    color: TodoCubit.get(context).newTasks[index]['color'],
                    status: TodoCubit.get(context).newTasks[index]['status'],
                    title: TodoCubit.get(context).newTasks[index]['title'],
                    note: TodoCubit.get(context).newTasks[index]['status'],
                    isCompleted: TodoCubit.get(context).newTasks[index]['isCompleted'],
                    id: TodoCubit.get(context).newTasks[index]['id'],
                  )
                );

                return AnimationConfiguration.staggeredList(
                    position: index,
                    child:SlideAnimation(
                      child:FadeInAnimation(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: (){
                                _showBottomSheet(context,TodoCubit.get(context).newTasks[index]);
                              },
                              child: TaskTile(TodoCubit
                                  .get(context)
                                  .newTasks[index],
                              ),
                            )
                          ],
                        ),
                      ) ,
                    )
                );

              }else if (TodoCubit
                  .get(context)
                  .newTasks[index]['date'] == DateFormat.yMd().format(TodoCubit
                  .get(context)
                  .selectedDate)) {
                return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                      child: FadeInAnimation(
                        child: GestureDetector(
                          onTap: () {
                            _showBottomSheet(context,TodoCubit.get(context).newTasks[index]);
                          },
                         onLongPress:(){
                           Navigator.push(context, MaterialPageRoute(builder: (context) => EditScreen()));
                         },
                          child: TaskTile(TodoCubit
                              .get(context)
                              .newTasks[index],
                          )
                        ),
                      ),
                    )
                );
              }
              else  if(TodoCubit
                  .get(context)
                  .newTasks[index]['repeat'] == 'None'){
                return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                      child: FadeInAnimation(
                        child: GestureDetector(
                            onTap: () {
                              _showBottomSheet(context,TodoCubit.get(context).newTasks[index]);
                            },
                            onLongPress: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => EditScreen())),
                            child: TaskTile(TodoCubit
                                .get(context)
                                .newTasks[index],
                            )
                        ),
                      ),
                    )
                );
              }
              else{
                return Container();
              }

            }
            ):Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.menu,size: 130,color: Colors.grey[300],),
          Text('No tasks yet, please add some tasks!',style: subHeadingStyle.copyWith(color: Colors.grey[400]),),
        ],),),
    );
  }

  _showBottomSheet(context,map){
      Scaffold.of(context).showBottomSheet((context) => Container(
        padding:const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        height: MediaQuery.of(context).size.height * 0.3,width:double.infinity,
        // color: Colors.grey[300],
        decoration: BoxDecoration(
          borderRadius:const BorderRadius.only(topLeft: Radius.circular(16.0),topRight: Radius.circular(16.0)),
          color:TodoCubit.get(context).btnColor,
          boxShadow: const [
            BoxShadow(
              offset: Offset(4,0),
              color: Colors.black12,
              blurRadius: 30
            )
          ]
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              // margin: const EdgeInsets.only(top: 15.0),
              width: 55,height: 4.0,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(children: [
                  Expanded(
                    child: ChoiceButton(text:'Archived',color: Colors.green[300]!,onTap: (){
                      TodoCubit.get(context).updateData(status:'archived',id:map['id'],);
                      Navigator.pop(context);
                    }),),
                    const SizedBox(width: 10.0,),
                    Expanded(
                      child: ChoiceButton(text:'Done',color:const Color(0xFF4e5ae8),onTap: (){
                        TodoCubit.get(context).updateData(status:'done',id:map['id'],);
                        TodoCubit.get(context).updateItemData(id:map['id'],);
                        Navigator.pop(context);
                      }),),
                ],),
                ChoiceButton(text:'Delete',color: Colors.redAccent.withOpacity(0.6),onTap: (){
                  TodoCubit.get(context).deleteData(map['id'],);
                  Navigator.pop(context);
                }),
                ChoiceButton(text:'Cancel',cancel: true,color: Colors.white,onTap: (){
                  Navigator.pop(context);
                })
              ],
            ),
          ],
        ),
      ));
  }
// _myTasks(){
  //   return Expanded(
  //     child: Obx(() {
  //       return _taskController.taskList.isNotEmpty? ListView.builder(
  //           itemCount:_taskController.taskList.length,
  //           itemBuilder: (_, index) {
  //             print('task Length ---> ${_taskController.taskList.length}');
  //             Task task = _taskController.taskList[index];
  //             print(task.toJson());
  //             // if(task.repeat == 'Daily'){
  //             //   DateTime date = DateFormat.jm().parse(task.startTime.toString());
  //             //   var myTime = DateFormat('HH:mm').format(date);
  //             //   print("myTime: $myTime");
  //             //   notificationHelper.scheduledNotification(
  //             //     int.parse(myTime.toString().split(":")[0]),
  //             //     int.parse(myTime.toString().split(":")[1]),);
  //             //
  //             //   return AnimationConfiguration.staggeredList(
  //             //       position: index,
  //             //       child:SlideAnimation(
  //             //         child:FadeInAnimation(
  //             //           child: Row(
  //             //             children: [
  //             //               GestureDetector(
  //             //                 onTap: (){
  //             //                   _showBottomSheet(context,task);
  //             //                 },
  //             //                 child: TaskTile(task,
  //             //                 ),
  //             //               )
  //             //             ],
  //             //           ),
  //             //         ) ,
  //             //       )
  //             //   );
  //             //
  //             // }
  //             // if(task.date == DateFormat.yMd().format(_selectDate)){
  //             return AnimationConfiguration.staggeredList(
  //                 position: index,
  //                 child:SlideAnimation(
  //                   child:FadeInAnimation(
  //                     child: Row(
  //                       children: [
  //                         GestureDetector(
  //                           onTap: (){
  //                             // _showBottomSheet(context,task);
  //                           },
  //                           child: TaskTile(task,
  //                           ),
  //                         )
  //                       ],
  //                     ),
  //                   ) ,
  //                 )
  //             );
  //
  //
  //
  //
  //           }): Container();
  //     }),
  //   );
  // }
}
