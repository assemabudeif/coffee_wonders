import '../../../data/models/egypt_country_model.dart';
import '/app/constant/saudi_api_constant.dart';
import '/app/services/dio_helper/saudi_dio_helper.dart';
import '/app/services/shared_prefrences/cache_helper.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'states.dart';

class EgyptConfirmationBloc extends Cubit<EgyptConfirmationStates> {
  EgyptConfirmationBloc() : super(ConfirmationInitState());
  static EgyptConfirmationBloc get(context) => BlocProvider.of(context);

  EgyptCountryModel countryModel = EgyptCountryModel();
  void getCountries() {
    emit(CountryLoadingState());
    SaudiDioHelper.getData(
            path: SaudiApiConstant.countryPath,
            token: CacheHelper.getData(key: SharedKey.token))
        .then((value) {
      countryModel = EgyptCountryModel.fromJson(value.data);
      for (var element in countryModel.data) {
        countryName.add(element.name);
      }

      emit(CountrySuccessState());
    }).catchError((error) {
      emit(CountryErrorState());
    });
  }

  EgyptCountryModel stateModel = EgyptCountryModel();
  void getStates({required int id}) {
    emit(StateLoadingState());
    SaudiDioHelper.getData(
            path: SaudiApiConstant.statePath(id: id),
            token: CacheHelper.getData(key: SharedKey.token))
        .then((value) {
      stateModel = EgyptCountryModel.fromJson(value.data);
      for (var element in stateModel.data) {
        stateName.add(element.name);
      }

      emit(StateSuccessState());
    }).catchError((error) {
      emit(StateErrorState());
    });
  }

  List<String> countryName = [];
  List<String> stateName = [];
  String? countryValue;
  void changeCountryDropDownItem({required String value}) {
    countryValue = value;
    getCountryId(countryValue!);
    emit(ChangeDropDownCountryValueState());
  }

  int? stateId;
  String? stateValue;
  void changeStateDropDownItem({required String value}) {
    stateValue = value;
    for (var element in stateModel.data) {
      if (stateValue == element.name) {
        stateId = element.id;
      }
    }
    emit(ChangeDropDownStateValueState());
  }

  int? countryId;
  int? getCountryId(String countryName) {
    for (var element in countryModel.data) {
      if (countryName == element.name) {
        countryId = element.id;
      }
    }
    getStates(id: countryId!);
    emit(GetCountryIdState());
    return countryId;
  }
}
