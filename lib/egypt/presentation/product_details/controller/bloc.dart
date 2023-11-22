import 'package:flutter_bloc/flutter_bloc.dart';

import 'states.dart';

class EgyptProductDetailsBloc extends Cubit<EgyptProductDetailsStates> {
  EgyptProductDetailsBloc() : super(ProductDetailsInitState());
  static EgyptProductDetailsBloc get(context) => BlocProvider.of(context);

  int counter = 1;
  int incrementProductCounter() {
    ++counter;

    return counter;
  }

  int decrementProductCounter() {
    --counter;
    if (counter < 1) {
      counter = 1;
    }
    return counter;
  }
}
