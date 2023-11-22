import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import '/app/resources/strings_manager.dart';
import '../../../model/product_model.dart';
import '../../brands/view/brands_screen.dart';
import '../../home/view/home_screen.dart';
import '../../../presentation/layout/controller/states.dart';

class LayoutBloc extends Cubit<LayoutStates> {
  LayoutBloc() : super(LayoutInitState());
  static LayoutBloc get(context) => BlocProvider.of(context);
  int index = 0;
  List<String> appBarTitle = [
    AppStrings.coffeeWonders,
    AppStrings.brands.tr(),
  ];
  List<Widget> screens = [
    const HomeScreen(),
    const BrandsScreen(),
  ];
  void changeBottomNavBar(int currentIndex) {
    index = currentIndex;
    emit(ChangeBottomNavigationBarState());
  }

  List<ProductDataModel> productsList = [];

// Database
  late Database database;
  List<Map> cart = [];

  void createDataBase() {
    openDatabase(
      "saudi_cart.db",
      version: 1,
      onCreate: (database, version) {
        database.execute(
            "create TABLE cart (id integer primary key , title text ,image text , price double ,quantity int ,categoryName)");
      },
      onOpen: (database) {
        this.database = database;
        getDataFromDataBase(database);
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
              "insert into cart (id , title , image , price , quantity, categoryName) VALUES('$id','$title','$image', '$price' , '$quantity' ,'$categoryName') ")
          .then((value) {
        emit(InsertIntoDataBaseState());
        getDataFromDataBase(database);
      });
    });
  }

  void getDataFromDataBase(database) {
    cart = [];
    database.rawQuery("select * from cart").then((value) {
      value.forEach((element) {
        cart.add(element);
      });

      emit(GetDataFromDataBaseState());
    });
  }

  void upDateDataBase({
    required int id,
    required int quantity,
  }) {
    database.rawUpdate("""UPDATE cart 
SET quantity = ?
WHERE id = ?""", [quantity, id]).then(
      (value) {
        emit(UpDateDatainDataBaseState());
        getDataFromDataBase(database);
      },
    );
  }

  void deleteFromDataBase({
    required int id,
  }) {
    database.rawDelete('DELETE FROM cart WHERE id = ?', [id]).then((value) {
      emit(DeleteDatainDataBaseState());
      getDataFromDataBase(database);
    });
  }
}
