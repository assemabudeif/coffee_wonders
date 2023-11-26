import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import '../../../data/products/models/egypt_product_model.dart';
import '../../categories/egypt_categories_screen.dart';
import '/app/resources/strings_manager.dart';
import '../../brands/view/egypt_brands_screen.dart';
import '../../../presentation/layout/controller/states.dart';
import '../../home/view/egypt_home_screen.dart';

class EgyptLayoutBloc extends Cubit<EgyptLayoutStates> {
  EgyptLayoutBloc() : super(LayoutInitState());
  static EgyptLayoutBloc get(context) => BlocProvider.of(context);
  int index = 0;
  List<String> appBarTitle = [
    AppStrings.coffeeWonders,
    AppStrings.categories.tr(),
    // AppStrings.brands.tr(),
  ];
  List<Widget> screens = [
    EgyptHomeScreen(),
    const EgyptCategoriesScreen(),
    // const EgyptBrandsScreen(),
  ];
  void changeBottomNavBar(int currentIndex) {
    index = currentIndex;
    emit(ChangeBottomNavigationBarState());
  }

  List<EgyptProductDataModel> productsList = [];

// Database
  late Database database;
  List<Map> cart = [];

  void createDataBase() {
    openDatabase(
      "egypt_cart.db",
      version: 1,
      onCreate: (database, version) {
        database.execute(
            "create TABLE cart (product_id integer primary key , title text ,image text , price double ,quantity int ,categoryName)");
      },
      onOpen: (database) {
        this.database = database;
        getDataFromDataBase(
            // database
            );
      },
    ).then((value) {
      database = value;
      emit(CreateDataBaseState());
    });
  }

  insertDataBase({
    required int id,
    required String title,
    required String image,
    required double price,
    required int quantity,
    required String categoryName,
  }) async {
    await database.transaction((txn) async {
      return txn
          .rawInsert(
              "insert into cart (product_id , title , image , price , quantity, categoryName) VALUES('$id','$title','$image', '$price' , '$quantity' ,'$categoryName') ")
          .then((value) {
        emit(EgyptInsertIntoDataBaseState());
        getDataFromDataBase(
            // database
            );
      });
    });
  }

  void getDataFromDataBase() async {
    // emit(GetDataFromDataBaseLoadingState());

    cart = [];
    await database.rawQuery("select * from cart").then((value) {
      for (var element in value) {
        cart.add(element);
      }

      emit(GetDataFromDataBaseSuccessState());
    }).catchError((error) {
      emit(GetDataFromDataBaseErrorState());
    });
  }

  void upDateDataBase({
    required int id,
    required int quantity,
  }) {
    database.rawUpdate("""UPDATE cart 
SET quantity = ?
WHERE product_id = ?""", [quantity, id]).then(
      (value) {
        emit(UpDateDatainDataBaseState());
        getDataFromDataBase(
            // database
            );
      },
    );
  }

  void deleteFromDataBase({
    required int id,
  }) {
    database
        .rawDelete('DELETE FROM cart WHERE product_id = ?', [id]).then((value) {
      emit(DeleteDatainDataBaseState());
      getDataFromDataBase(
          // database
          );
    });
  }
}
