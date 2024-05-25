class Task{
  int? id;
  String? title;
  String? status;
  String? note;
  String? date;
  String? startTime;
  String? endTime;
  int? remind;
  String? repeat;
  int? color;
  int? isCompleted;

  Task({this.color,this.title,this.startTime,this.id,this.date,this.endTime,this.isCompleted,this.note,this.remind,this.repeat,this.status});

  Task.fromJson(Map<String,dynamic> json){
    id = json['id'];
    title = json['title'];
    note = json['note'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    remind = json['remind'];
    repeat = json['repeat'];
    color = json['color'];
    isCompleted = json['isCompleted'];
    status = json['status'];

  }
  Map<String,dynamic> toMap(){
    final Map<String,dynamic> data = <String,dynamic>{};
    data['id']=id;
    data['title'] = title;
    data['note'] = note;
    data['isCompleted'] = isCompleted;
    data['date'] = date;
    data['startTime'] = startTime;
    data['endTime']= endTime;
    data['color'] = color;
    data['remind'] = remind;
    data['repeat'] = repeat;
    data['status'] = status;
    return data;
  }
}