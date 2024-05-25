abstract class TodoStates{}
class TodoInitState extends TodoStates{}
class TodoGetDbLoadingState extends TodoStates{}
class TodoCreateDbState extends TodoStates{}
class TodoInsertToDbState extends TodoStates{}
class TodoGetDataState extends TodoStates{}
class TodoUpdateDbState extends TodoStates{}
class TodoUpdateItemState extends TodoStates{}
class TodoDeleteDbState extends TodoStates{}
class TodoToggleNavBarState extends TodoStates{}
class TodoToggleRemindState extends TodoStates{}
class TodoToggleRepeatState extends TodoStates{}
class TodoToggleColorState extends TodoStates{}

class TodoPickDataState extends TodoStates{}
class TodoSelectEndTimeState extends TodoStates{}
class TodoSelectStartTimeState extends TodoStates{}
class TodoSelectDateState extends TodoStates{}

class TodoAppModeState extends TodoStates{}
