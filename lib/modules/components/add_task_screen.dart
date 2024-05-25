import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/modules/components/build_task_bar.dart';
import 'package:todo_app/modules/components/input_text_field.dart';
import 'package:todo_app/services/notification_services.dart';
import 'package:todo_app/shared/themes.dart';
import 'package:todo_app/shared/todo_cubit.dart';
import 'package:todo_app/shared/todo_states.dart';

class AddTask extends StatelessWidget {

  const AddTask({Key? key}):super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit,TodoStates>(
      listener: (context,state){
        if(state is TodoInsertToDbState){
          Navigator.of(context).pop(true);
        }
      },
      builder: (context,state){
        TodoCubit cubit = TodoCubit.get(context);
      return Scaffold(
          appBar:_buildAppBar(context),
          body:Container(
            padding:const EdgeInsets.only(left: 20,right: 20),
            child:SingleChildScrollView(
              child: Form(
                key:cubit.formKey,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Add Task',style:headingStyle),
                    InputTextField(
                      title: "Title",
                      controller:cubit.titleController,
                      hint: 'Enter title here',
                    ),
                    InputTextField(
                      title: "Note",
                      controller:cubit.noteController,
                      hint: 'Enter note here',
                    ),
                    InputTextField(
                      title: "Date",
                      controller:cubit.dateController,
                      hint: DateFormat.yMMMd().format(DateTime.now()).toString(),
                      widget: IconButton(
                          icon:const Icon(Icons.calendar_today_outlined,color: Colors.grey,),
                          onPressed:(){
                            cubit.getDateFromUser(context);
                          }
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(child: InputTextField(
                          title: "Start Time",
                          hint: cubit.startTime,
                          widget: IconButton(
                              icon:const Icon(Icons.watch_later_outlined,color: Colors.grey,),
                              onPressed:(){
                                cubit.getTimeFromUser(context,isStartTime: true);
                              }
                          ),
                        ),),
                        Expanded(child: InputTextField(
                          title: "End Time",
                          hint: cubit.endTime,
                          widget: IconButton(
                              icon:const Icon(Icons.watch_later_outlined,color: Colors.grey,),
                              onPressed:(){
                                cubit.getTimeFromUser(context,isStartTime: false);
                              }
                          ),
                        ),),
                      ],
                    ),
                    // ************ Reminder ****************
                    // items requires a list which we must return so we put it into map to be able to access
                    //one value at a time which we pass an int value and getting them at a string
                    // as dropDown items has a string values so when the users select a value as a string
                    //then we return a drop down menu contains a string values so we getting the value and save it in our list [remindList]
                    InputTextField(
                        title: "Remind",
                        hint: "${cubit.selectReminder} minutes early",
                        widget: DropdownButton(
                          icon:const Icon(Icons.keyboard_arrow_down,color: Colors.grey,),
                          iconSize: 32,elevation: 4,
                          style: subTitleStyle.copyWith(color: cubit.color),
                          items: cubit.remindList.map<DropdownMenuItem<String>>((int? value){
                            return DropdownMenuItem<String>(
                              value: value.toString(),
                              child: Text(value.toString(),style: TextStyle(color: cubit.color)),
                            );
                          }).toList(),
                          underline: Container(height: 0,),
                          onChanged: (String? value) {
                            cubit.remindSelect(value);
                          },
                        )
                    ),
                    InputTextField(
                      title: "Repeat",
                      hint: cubit.selectRepeat,
                      widget: DropdownButton(
                        icon:const Icon(Icons.keyboard_arrow_down,),
                        iconSize: 32,elevation: 4,
                        style: subTitleStyle.copyWith(color: cubit.color),
                        items: cubit.repeatList.map<DropdownMenuItem<String>>((String? value) {
                          return DropdownMenuItem(
                              value: value,
                              child:Text(value!,style: TextStyle(color: cubit.color)));
                        }).toList(),
                        underline: Container(height:0),
                        onChanged: (String? value){
                          cubit.repeatSelect(value);
                        },
                      ),
                    ),
                    TaskBar(onTap: (){
                      if(cubit.formKey.currentState!.validate()){
                        // add to database

                        var value =cubit.insertIntoDb(Task(
                          title: cubit.titleController.text,
                          note: cubit.noteController.text,
                          color: cubit.selectedColor,
                          isCompleted: 0,
                          startTime: cubit.startTime,
                          endTime: cubit.endTime,
                          date: cubit.endTime,
                          status: "new",
                          remind: cubit.selectReminder,
                          repeat: cubit.selectRepeat,
                        ));
                        print('$value inserted to database successfully!');
                        NotificationHelper.scheduledNotification(8,5,value);
                        // Get.toNamed(RouteHelper.getInitial());
                        }
                    },
                  //       if(cubit.titleController.text.isNotEmpty && cubit.noteController.text.isNotEmpty ){
                  //       // add to database
                  //
                  //       var value =cubit.insertIntoDb(Task(
                  //         title: cubit.titleController.text,
                  //         note: cubit.noteController.text,
                  //         color: cubit.selectedColor,
                  //         isCompleted: 0,
                  //         startTime: cubit.startTime,
                  //         endTime: cubit.endTime,
                  //         date: cubit.endTime,
                  //         status: "new",
                  //         remind: cubit.selectReminder,
                  //         repeat: cubit.selectRepeat,
                  //       ));
                  //       print('$value inserted to database successfully!');
                  //       // Get.toNamed(RouteHelper.getInitial());
                  //       }else if(cubit.titleController.text.isEmpty || cubit.noteController.text.isEmpty){
                  //         print('required!');
                  //       //      Get.snackbar("Required", "All Fields are required!",
                  // //        snackPosition: SnackPosition.BOTTOM,
                  // //        backgroundColor:Get.isDarkMode? Colors.black:Colors.white,
                  // //        icon:const Icon(Icons.warning_amber_rounded,color: Colors.red,),
                  // //      );
                  //                     }
                  //   },

                    )
                  ],
                ),
              ),
            ) ,
          )
      );
      },
    );
  }

  _buildAppBar(BuildContext context){
    return AppBar(
      elevation: 0,
      backgroundColor:Colors.transparent,
      leading: BackButton(
        onPressed: ()=>Navigator.pop(context),
      ),
      actions:const [
        Icon(Icons.person,size: 20,),
         SizedBox(width:20),
      ],
    );
  }



//  _addTaskToDB()async{
//    int value =  await taskController.addTask(
//        task:Task(
//          // id:,
//          note: noteController.text,
//          title: titleController.text,
//          date: DateFormat.yMd().format(_selectedDate),
//          startTime: _startTime,
//          endTime: _endTime,
//          repeat: _selectRepeat,
//          remind: _selectReminder,
//          color: _selectedColor,
//          isCompleted: 0,
//        )
//    );
//    print("My id is $value");
//  }
}
