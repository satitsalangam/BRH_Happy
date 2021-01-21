import 'package:bloc/bloc.dart';
import 'package:brhhappy/happy_countercheckin/hod/page/intro_page.dart';


enum NavigationEvents {
  
  MyHodIntroPageClickedEvent,
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  @override
  NavigationStates get initialState => IntroPage();

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.MyHodIntroPageClickedEvent:
        yield IntroPage();
        break;
      
    }
  }
}
