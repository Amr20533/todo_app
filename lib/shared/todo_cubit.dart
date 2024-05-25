import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/layout/new_task_screen.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/modules/archived_screen.dart';
import 'package:todo_app/modules/done_screen.dart';
import 'package:todo_app/shared/themes.dart';
import 'package:todo_app/shared/todo_states.dart';

class TodoCubit extends Cubit<TodoStates>{
  TodoCubit():super(TodoInitState());
  static TodoCubit get(context) =>BlocProvider.of(context);
  static const String tableName = "tasks";
  final TextEditingController titleController = TextEditingController();

  final TextEditingController noteController = TextEditingController();

  final TextEditingController dateController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  int currentIndex = 0;
  String startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String endTime = "9:30 PM";
  int selectReminder = 5;
  List<int> remindList = [5,10,15,20];
  String selectRepeat = "None";
  int? selectedColor;
  // DateTime selectDate = DateTime.now();
  DateTime selectedDate = DateTime.now();
  List<String> repeatList = ["None","Daily","Weekly","Monthly"];
  bool dark = false;
  IconData fabIcon = Icons.nightlight_round;
  String fabText = 'Dark Mode';
  Color color = darkGreyClr;
  Color btnColor = Colors.white;
  Color drawerIcon = bluishClr;
  List<Widget> screens =const [
     NewTaskScreen(),
     DoneScreen(),
     ArchivedScreen(),
  ];
 List<BottomNavigationBarItem> items = const[
    BottomNavigationBarItem(icon:Icon(Icons.home),label: 'Home'),
    BottomNavigationBarItem(icon:Icon(Icons.done),label: 'Done'),
    BottomNavigationBarItem(icon:Icon(Icons.archive),label: 'Archived'),
  ];
  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];
  void appMode(){
    dark = !dark;
    fabIcon = dark ? Icons.brightness_4_outlined:Icons.nightlight_round;
    fabText = dark ? 'Light Mode' : 'Dark Mode';
    color = dark ? darkGreyClr : Colors.white;
    drawerIcon = dark ? Colors.white : bluishClr;
    btnColor = dark ? Colors.white : Colors.black ;
    emit(TodoAppModeState());
  }
  void changeIndex(int index) {
    currentIndex = index;
    emit(TodoToggleNavBarState());
  }
  void remindSelect(String? value) {
    selectReminder = int.parse(value!);
    emit(TodoToggleRemindState());
  }
  void dateSelect(DateTime? date) {
    selectedDate = date!;
    emit(TodoSelectDateState());
  }
  void repeatSelect(String? value) {
    selectRepeat = value!;
    emit(TodoToggleRepeatState());
  }
  void colorSelect(int? index) {
    selectedColor = index!;
    emit(TodoToggleColorState());
  }
  Database? _database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        database.execute(
            '''CREATE TABLE $tableName (id INTEGER PRIMARY KEY,
             title TEXT, note STRING, startTime TEXT,
             endTime TEXT,date TEXT,remind TEXT,repeat TEXT,
              color TEXT,isCompleted TEXT, status TEXT)''')
            .then((value) {
        }).catchError((error) {
          print('Error When Creating Table ${error.toString()}');
        });
      },
      onOpen: (database)
      {
        getDataFromDatabase(database);
        print('database opened');
      },
    ).then((value) {
      _database = value;
      emit(TodoCreateDbState());
    });
  }
  insertIntoDb(Task? task) async {
    await _database!.transaction((txn) async{
      txn.insert(tableName, task!.toMap()).then((value) {
        print('$value inserted successfully-->');
        titleController.clear();
        noteController.clear();
        getDataFromDatabase(_database);
        emit(TodoInsertToDbState());
      }).catchError((error) {
        print('Error When Inserting New Record ${error.toString()}');
      });

      return null;
    });
  }
  //getting data from database in all screens
   void getDataFromDatabase(database)async{
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
   database.rawQuery('SELECT * FROM $tableName').then((value) {
     for(var element in value){
       if(element['status'] == 'new'){
         newTasks.add(element);
       }else if(element['status'] == 'archived'){
         archivedTasks.add(element);
       }else{
         doneTasks.add(element);
       }


     }
     print(newTasks.length);
     print('got data from database successfully...');
    emit(TodoGetDataState());
   });
  }
  // updating item status and add it to done or archive screen
   updateData({required String status,required int id})async{
     newTasks = [];
     doneTasks = [];
     archivedTasks = [];
    return await _database!.rawUpdate(
    'UPDATE $tableName SET status = ? WHERE id = ?', [status,id]).then((value){
      print('$value updated successfully, $value added to $status list');
      getDataFromDatabase(_database);
      emit(TodoUpdateDbState());
    });
  }
  // updating item current status name into done from to-do status
   updateItemData({required int id})async{
     newTasks = [];
     doneTasks = [];
     archivedTasks = [];
    return await _database!.rawUpdate(
    'UPDATE $tableName SET isCompleted = ? WHERE id = ?', [1,id]).then((value){
      print('$value updated successfully, $value added to done list');
      getDataFromDatabase(_database);
      emit(TodoUpdateItemState());
    });
  }

  Future<void> deleteData(int? id)async{
      await _database!.rawDelete('DELETE From $tableName WHERE id = ? ',[id]).then((value){
        getDataFromDatabase(_database);
        emit(TodoDeleteDbState());
      });
  }
  getDateFromUser(BuildContext context)async{
    DateTime? pickedDate = await showDatePicker(context: context,
        initialDate:DateTime.now(),
        firstDate:DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 5));
    if(pickedDate != null){
      selectedDate = pickedDate;
      dateController.text = DateFormat.yMMMd().format(selectedDate).toString();
    }else{
      print('something went wrong!');
    }
  }
  getTimeFromUser(BuildContext context,{required bool isStartTime})async{
    var pickedTime = await _showTimePicker(context);
    String formattedTime = pickedTime!.format(context);
    if(isStartTime == true){
        startTime = formattedTime;
        emit(TodoSelectStartTimeState());
    }else if(isStartTime == false){
        endTime = formattedTime;
        emit(TodoSelectEndTimeState());
    }
  }
  _showTimePicker(context){
    return showTimePicker(context: context,
      initialEntryMode: TimePickerEntryMode.input,
      // _startTime split into --> 10:30 AM
      initialTime: TimeOfDay(hour:int.parse(startTime.split(":")[0]),
        minute: int.parse(startTime.split(":")[1].split(" ")[0]),),
    );
  }
}