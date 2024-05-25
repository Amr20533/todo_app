import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/modules/Drawer/navigation_drawer.dart';
import 'package:todo_app/shared/themes.dart';
import 'package:todo_app/shared/todo_cubit.dart';
import 'package:todo_app/shared/todo_states.dart';


class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit,TodoStates>(
      listener: (context,state){},
      builder: (context,state){
        TodoCubit cubit = TodoCubit.get(context);
        return Scaffold(
          drawer:const NavigationDrawingWidget(),
          // appBar:_buildAppBar(context) ,
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.items,
            onTap: (index)=>cubit.changeIndex(index),
            currentIndex: cubit.currentIndex,
            // showSelectedLabels: false,
            // showUnselectedLabels: false,
            selectedItemColor: primaryColor,
          ),
        );
      },
    );
  }
  _buildAppBar(BuildContext context){
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: Builder(builder: (context)=>GestureDetector(
        onTap: ()=>Scaffold.of(context).openDrawer(),
        child: Container(
          margin:const EdgeInsets.only(top: 7.0,left: 12),
          height: 25,width: 25,
          decoration:const BoxDecoration(
              color:Colors.white,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(
                color: Colors.black12,
                offset: Offset(0,3),
                blurRadius: 0,
              )]
          ),
          child: SvgPicture.asset('assets/icons/menu.svg',color: primaryColor),
        ),
      ),),

      title: Text(DateFormat.yMMMMd().format(TodoCubit.get(context).selectedDate),style: titleStyle.copyWith(color: Colors.black)),

      //  leading: IconButton(
      //   onPressed: (){
      //     TodoCubit.get(context).appMode();
      //   },
      //   icon:Icon(TodoCubit.get(context).fabIcon),
      // ),
      // actions:const[
      //   Icon(Icons.person,size: 20),
      //   SizedBox(width:20),
      // ],
    );
  }

}
