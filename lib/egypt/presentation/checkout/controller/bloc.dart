import 'dart:developer';

import '/app/common/widget.dart';
import '/app/resources/color_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../../../app/constant/egypt_api_constant.dart';
import '../../../../app/services/dio_helper/egypt_dio_helper.dart';
import '../../layout/controller/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../presentation/checkout/controller/states.dart';

class EgyptCheckoutBloc extends Cubit<EgyptCheckoutStates> {
  EgyptCheckoutBloc() : super(CheckoutInitState());
  static EgyptCheckoutBloc get(context) => BlocProvider.of(context);
  List<Map> products = [];
  void productsInCart(List<Map> cart) {
    for (var element in cart) {
      Map product = {};

      product["product_id"] = element["product_id"];
      product["quantity"] = element["quantity"];
      products.add(product);
    }
  }

  Future<void> checkout({
    required BuildContext context,
    required String fullName,
    required String email,
    required String phone,
    required String countryName,
    required String city,
    required String stateName,
    required String area,
    required String building,
    required String apartment,
    required String postalCode,
  }) async {
    emit(CheckoutLoadingState());
    try {
      final response = await EgyptDioHelper.postData(
        path: EgyptApiConstant.createNewOrderPath,
        data: {
          "fullname": fullName,
          "email": email,
          "phone": phone,
          "country": countryName,
          "city": city,
          "state": stateName,
          "area": area,
          "building": building,
          "apartment": apartment,
          "postal_code": postalCode,
          "items": products,
        },
      );

      if (response.statusCode == 200) {
        log(response.data.toString());
        SharedWidget.toast(
          message: response.data['message'].toString(),
          backgroundColor: ColorManager.green,
        );
        if (context.mounted) {
          for (var element in EgyptCheckoutBloc.get(context).products) {
            EgyptLayoutBloc.get(context)
                .deleteFromDataBase(id: element["product_id"]);
          }
        }
        emit(CheckoutSuccessState());
      } else {
        log(response.data.toString());
        SharedWidget.toast(
          message: response.data['message'].toString(),
          backgroundColor: ColorManager.error,
        );
        emit(CheckoutErrorState());
      }
    } on DioException catch (e) {
      log(e.response?.data['message'].toString() ?? 'Error');
      SharedWidget.toast(
        message: e.response?.data['message'].toString() ?? 'Error',
        backgroundColor: ColorManager.error,
      );
      emit(CheckoutErrorState());
    }
  }
}
