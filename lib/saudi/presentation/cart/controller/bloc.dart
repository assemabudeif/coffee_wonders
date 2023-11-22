import 'package:flutter_bloc/flutter_bloc.dart';
import 'states.dart';

class CartBloc extends Cubit<CartStates> {
  CartBloc() : super(CartInitState());
  static CartBloc get(context) => BlocProvider.of(context);
  int incrementProductCounter({required int quantity}) {
    ++quantity;

    return quantity;
  }

  int decrementProductCounter({required int quantity}) {
    --quantity;
    if (quantity < 1) {
      return 1;
    } else {
      return quantity;
    }
  }

  List<Map<String, int>> productsListInCart = [];

  double totalPrice({required List cart}) {
    double total = 0.0;
    for (var element in cart) {
      double productPrice = 0.0;
      productPrice = element["quantity"] * element["price"];
      total = total + productPrice;
    }
    return total;
  }
}
