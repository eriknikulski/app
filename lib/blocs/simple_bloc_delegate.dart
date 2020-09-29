import 'package:bloc/bloc.dart' show Bloc, BlocObserver, Cubit, Transition;

import 'app/app_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
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
  void onError(Cubit cubit, Object error, StackTrace stacktrace) {
    print('-------------------------------------------------');
    print('Error');
    print('-------------------------------------------------');
    super.onError(cubit, error, stacktrace);
    print(error);
    if (cubit is AppBloc) {
      print(cubit.statements);
    }
  }
}
