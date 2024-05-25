import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:todo_app/modules/components/build_chice_button.dart';
import 'package:todo_app/modules/components/task_tile.dart';
import 'package:todo_app/shared/themes.dart';
import 'package:todo_app/shared/todo_cubit.dart';
import 'package:todo_app/shared/todo_states.dart';

class DoneScreen extends StatelessWidget {
  const DoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit,TodoStates>(
        builder: (context,state){
          return  Column(
            children: [
              Expanded(
                child:TodoCubit.get(context).doneTasks.isNotEmpty?ListView.builder(
                    physics:const BouncingScrollPhysics(),
                    itemCount:TodoCubit.get(context).doneTasks.length,
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredList(
                          position: index,
                          child: SlideAnimation(
                            child: FadeInAnimation(
                              child: GestureDetector(
                                  onTap: () {
                                    _showBottomSheet(context,TodoCubit.get(context).doneTasks[index]);
                                  },
                                  child: TaskTile(TodoCubit
                                      .get(context)
                                      .doneTasks[index],
                                  )
                              ),
                            ),
                          )
                      );


                    }
                ):Center(child: Column(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.menu,size: 130,color: Colors.grey[300],),
                    Text('No tasks yet, please add some tasks!',style: subHeadingStyle.copyWith(color: Colors.grey[400]),),
                  ],),),
              ),
            ],
          );
        }, listener: (context,state){});
  }
  _showBottomSheet(context,map){
    Scaffold.of(context).showBottomSheet((context) => Container(
        padding:const EdgeInsets.symmetric(vertical: 10),
        height: MediaQuery.of(context).size.height * 0.3,width:double.infinity,
        decoration: BoxDecoration(
            // color: darkHeaderClr.withOpacity(0.06),
          color: Colors.grey[200],
              borderRadius: const BorderRadius.only(topRight: Radius.circular(16),topLeft: Radius.circular(16)),
            ),
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            ChoiceButton(text:'Archived',color: Colors.green[300]!,onTap: (){
          TodoCubit.get(context).updateData(status:'archived',id:map['id'],);
          Navigator.pop(context);
        }),
            ChoiceButton(text:'Delete',color: Colors.redAccent.withOpacity(0.6),onTap: (){
              TodoCubit.get(context).deleteData(map['id'],);
              Navigator.pop(context);
        }),
            ChoiceButton(text:'Cancel',cancel: true,color: Colors.transparent,onTap: (){
          Navigator.pop(context);
        })
            ])
    ));
  }

}
