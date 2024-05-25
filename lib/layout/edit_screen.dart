import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/modules/components/input_text_field.dart';
import 'package:todo_app/shared/todo_cubit.dart';
import 'package:todo_app/shared/todo_states.dart';

class EditScreen extends StatelessWidget {
  EditScreen({Key? key}) : super(key: key);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  String title = '';
  String note = '';
  // String date = '';

  // final title = T
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<TodoCubit,TodoStates>(
        listener: (context,state){
          if(state is TodoGetDataState){
            _getData(context);
          }
          // TodoCubit.get(context).getDataFromDatabase(database);
        },
        builder: (context,state){
          TodoCubit cubit = TodoCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('Edit Screen'),
            ),
            body: SafeArea(
              child:Form(
                key:formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        InputTextField(
                          controller:titleController,
                          title: 'Title',
                          hint: title,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
    },
    );
  }
  _getData(BuildContext context){
    var list = TodoCubit.get(context).newTasks;
    for(int index = 0; index < list.length;index ++){
       title = TodoCubit.get(context).newTasks[0]['title'];
       note = TodoCubit.get(context).newTasks[index]['note'];
      var remind = TodoCubit.get(context).newTasks[index]['remind'];
      var repeat = TodoCubit.get(context).newTasks[index]['repeat'];
      var date = TodoCubit.get(context).newTasks[index]['date'];
    }
  }
}








// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   DBStudentManager dbManager = DBStudentManager();
//   final _nameController = TextEditingController();
//   final _courseController = TextEditingController();
//   final formKey = GlobalKey<FormState>();
//   StudentModel? student;
//   List<StudentModel>? list;
//   @override
//   void initState()=> super.initState();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Courses'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: ListView(
//           children: [
//             Form(key: formKey,
//                 child:Column(
//                   children: [
//                     TextFormField(
//                       controller: _nameController,
//                       decoration:const InputDecoration(
//                         label: Text('Name'),
//                         border: OutlineInputBorder(),
//                       ),
//                       validator:(String? value){
//                         if(value == null || value.trim().isEmpty){
//                           return 'required';
//                           }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 10.0,),
//                     TextFormField(
//                       controller: _courseController,
//                       decoration:const InputDecoration(
//                         label: Text('Course'),
//                         border: OutlineInputBorder(),
//                       ),
//                       validator:(String? value){
//                         if(value == null || value.trim().isEmpty){
//                           return 'required';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 10.0,),
//                     ClipRRect(
//                         borderRadius: BorderRadius.circular(12.0),
//                         child: MaterialButton(onPressed: (){
//                           _submittedStudent(context);
//                       },
//                         color: Colors.lightBlue,
//                         child:const Text('confirm',style: TextStyle(color: Colors.white),),
//                       ),
//                     ),
//                   ],
//                 ) )
//           ],
//         ),
//       )
//     );
//   }
//   _submittedStudent(BuildContext context){
//     if(formKey.currentState!.validate()){
//       // do something
//       if(student == null){
//         StudentModel st = StudentModel(name: _nameController.text, course: _courseController.text);
//         dbManager.insertIntoDB(student).then((id)=>{
//             _nameController.clear(),
//             _courseController.clear(),
//              print('student added into db $id')}
//         );
//       }
//     }
//   }
// }
