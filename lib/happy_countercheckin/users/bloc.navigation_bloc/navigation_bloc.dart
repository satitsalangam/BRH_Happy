import 'package:bloc/bloc.dart';
import 'package:brhhappy/happy_countercheckin/users/CheckIN/userCounterCheckIn.dart';
import 'package:brhhappy/happy_countercheckin/users/historyCheckin/userHistory.dart';
import 'package:brhhappy/happy_countercheckin/users/userProfile/userProfileCCIN.dart';

enum NavigationEvents {
  MyProfileClickedEvent,
  MyHistoryClickedEvent,
  MyCounterCheckINClickedEvent,
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  @override
  NavigationStates get initialState => MyUserProfileCCIN();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.MyProfileClickedEvent:
        yield MyUserProfileCCIN();
        break;
      case NavigationEvents.MyHistoryClickedEvent:
        yield UserHistoryCheckList();
        break;
      case NavigationEvents.MyCounterCheckINClickedEvent:
        yield UserCheackIn();
        break;
    }
  }
}
