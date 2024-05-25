import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/modules/components/round_button.dart';
import 'package:todo_app/shared/themes.dart';
import 'package:todo_app/shared/todo_cubit.dart';
import 'package:todo_app/shared/todo_states.dart';

class TaskBar extends StatelessWidget {
  const TaskBar({required this.onTap,super.key});
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
      return BlocConsumer<TodoCubit,TodoStates>(
          listener: (context,state){},
          builder: (context,state){
            TodoCubit cubit = TodoCubit.get(context);
            return Container(
              height: 60,
              margin:const EdgeInsets.only(top:12,left:20,right:20),
              child: Row(
                children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Color',style: titleStyle,),
                      const Spacer(),
                      Wrap(
                        children: List<Widget>.generate(3,
                                (int index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: GestureDetector(
                                  onTap: (){
                                    cubit.colorSelect(index);
                                  },
                                  child: CircleAvatar(
                                    radius: 14,
                                    backgroundColor:index == 0 ? primaryColor : index == 1 ? pinkClr:yellowClr,
                                    child: cubit.selectedColor == index?const Icon(Icons.done,color:white):Container(),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                  const Spacer(),
                  RoundButton(
                      pressed: onTap,
                      label: 'Create Task',
                  ),
                ],
              ),
            );
          },
      );
    }

  }
