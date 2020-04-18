import 'package:bloc/bloc.dart' show Bloc, BlocDelegate, Transition;

import 'app/app_bloc.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    print('-------------------------------------------------');
    print('Error');
    print('-------------------------------------------------');
    super.onError(bloc, error, stacktrace);
    print(error);
    if (bloc is AppBloc) {
      print(bloc.statements);
    }
  }
}
