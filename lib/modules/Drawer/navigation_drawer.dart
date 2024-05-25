import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/shared/themes.dart';
import 'package:todo_app/shared/todo_cubit.dart';
enum NavigationItem{
  header,
  peoplePage,
  workFlow,
  appMode,
  favorite,
  settings,
  plugins
}
class NavigationDrawingWidget extends StatelessWidget {
  const NavigationDrawingWidget({super.key});


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
          color:primaryColor,
          child:ListView(
            padding:const EdgeInsets.all(20.0),
            children: [
              Column(
                children: [
                  // buildHeader(
                  //   context,
                  //   item:NavigationItem.header,
                  //   name:'Salma Yasser',
                  //   email:'prettySalma@gamil.com',
                  //   urlImage:'assets/girl3.jpg',
                  // ),
                  const SizedBox(height:24.0),
                  BuildMenuItem(
                    context,
                    item:NavigationItem.peoplePage,
                    text:'People',
                    icon:Icons.people,
                  ),
                  const SizedBox(height:24.0),
                  BuildMenuItem(
                    context,
                    onTap: (){
                      TodoCubit.get(context).appMode();
                      Scaffold.of(context).closeDrawer();
                    },
                    item:NavigationItem.appMode,
                    text: TodoCubit.get(context).fabText,
                    icon:TodoCubit.get(context).fabIcon,
                  ),
                  const SizedBox(height:24.0),
                  BuildMenuItem(
                    context,
                    item:NavigationItem.favorite,
                    text:'favorite',
                    icon:Icons.favorite,
                  ),
                  const SizedBox(height:24.0),
                  BuildMenuItem(
                    context,
                    item:NavigationItem.workFlow,
                    text:'WorkFlow',
                    icon:Icons.web_asset,
                  ),
                  const SizedBox(height:24.0),
                  Divider(color:Colors.white70),
                  BuildMenuItem(
                    context,
                    item:NavigationItem.settings,
                    text:'Settings',
                    icon:Icons.settings,
                  ),
                  const SizedBox(height:24.0),
                  BuildMenuItem(
                    context,
                    item:NavigationItem.plugins,
                    text:'Plugins',
                    icon:Icons.account_tree_outlined,
                  ),

                ],
              )
            ],
          )
      ),
    );
  }

  BuildMenuItem(BuildContext context, {VoidCallback? onTap,required NavigationItem item, required String text, required IconData icon}) {
    return InkWell(
      onTap: onTap,
      child:Material(
        color:Colors.transparent,
        child: ListTile(
          selected: true,
          selectedColor: pinkClr,
          title: Text(text,style:const TextStyle(color: Colors.white,fontSize: 18),),
          leading: Icon(icon,color: Colors.white,size: 30),),
        ),
    );
  }
}
/*
import 'package:fickfick/flashCards/NavigationDrawing.dart';
import 'package:flutter/material.dart';


* */
//
// void selectItem(BuildContext context,NavigationItem item){
//   final provider=Provider.of<NavigationProvider>(context,listen:false);
//   provider.setNavigationItem(item);
// }
// ndkVersion 25.1.8937393