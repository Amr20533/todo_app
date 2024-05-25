import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RiveAsset {
  RiveAsset(this.src,{required this.title,required this.artBoard,required this.stateMachineName,this.input});
  final String artBoard, stateMachineName, title, src;
  late SMIBool? input;

  set setInput(SMIBool status){
    input = status;
  }
}
List<RiveAsset> buttonNews = [
  RiveAsset('assets/rocket.riv',title: 'Chat',artBoard: 'CHAT',stateMachineName: 'CHAT_Interactivity',),
  RiveAsset('assets/little_machine.riv',title: 'Search',artBoard: 'SEARCH',stateMachineName: 'SEARCH_Interactivity',),
  RiveAsset('assets/off_road_car.riv',title: 'Timer',artBoard: 'TIMER',stateMachineName: 'TIMER_Interactivity',),
  RiveAsset('assets/teeny_tiny.riv',title: 'Notifications',artBoard: 'BELL',stateMachineName: 'BELL_Interactivity',),
  RiveAsset('assets/vehicles.riv',title: 'Profile',artBoard: 'USER',stateMachineName: 'USER_Interactivity',),
];

List<RiveAsset> sideMenus = [
  RiveAsset('assets/rocket.riv',title: 'Chat',artBoard: 'ROCKET',stateMachineName: 'CHAT_Interactivity',),
  RiveAsset('assets/little_machine.riv',title: 'Search',artBoard: 'little_machine',stateMachineName: 'SEARCH_Interactivity',),
  RiveAsset('assets/off_road_car.riv',title: 'Timer',artBoard: 'TIMER',stateMachineName: 'TIMER_Interactivity',),
  RiveAsset('assets/teeny_tiny.riv',title: 'Notifications',artBoard: 'BELL',stateMachineName: 'BELL_Interactivity',),
  RiveAsset('assets/vehicles.riv',title: 'Profile',artBoard: 'USER',stateMachineName: 'USER_Interactivity',),
];
