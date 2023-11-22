// import 'dart:developer';
//
// import 'package:sqflite/sqflite.dart';
//
// class DBHelper {
//   static final DBHelper instance = DBHelper._internal();
//   // factory DBHelper() => instance;
//   DBHelper._internal();
//   late Database database;
//   List<Map> cart = [];
//
//   Future<void> createDataBase() async {
//     await openDatabase(
//       "cart.db",
//       version: 1,
//       onCreate: (database, version) {
//         database.execute(
//             "create TABLE cart (id integer primary key , title text ,image text , price double ,quantity int ,categoryName)");
//       },
//       onOpen: (database) {
//         getDataFromDataBase(database);
//       },
//     ).then((value) {
//       database = value;
//       log('database created');
//       // emit(CreateDataBaseState());
//     });
//   }
//
//   insertDataBase({
//     required int id,
//     required String title,
//     required String image,
//     required double price,
//     required int quantity,
//     required String categoryName,
//   }) async {
//     await database.transaction((txn) async {
//       return txn
//           .rawInsert(
//               "insert into cart (id , title , image , price , quantity, categoryName) VALUES('$id','$title','$image', '$price' , '$quantity' ,'$categoryName') ")
//           .then((value) {
//         // emit(InsertIntoDataBaseState());
//         getDataFromDataBase(database);
//       });
//     });
//   }
//
//   Future<void> getDataFromDataBase(database) async {
//     cart = [];
//     await database.rawQuery("select * from cart").then((value) {
//       value.forEach((element) {
//         cart.add(element);
//       });
//
//       // emit(GetDataFromDataBaseState());
//     });
//   }
//
//   Future<void> upDateDataBase({
//     required int id,
//     required int quantity,
//   }) async {
//     database!.rawUpdate("""UPDATE cart
// SET quantity = ?
// WHERE id = ?""", [quantity, id]).then(
//       (value) {
//         // emit(UpDateDatainDataBaseState());
//         getDataFromDataBase(database);
//       },
//     );
//   }
//
//   Future<void> deleteFromDataBase({
//     required int id,
//   }) async {
//     database!.rawDelete('DELETE FROM cart WHERE id = ?', [id]).then((value) {
//       // emit(DeleteDatainDataBaseState());
//       getDataFromDataBase(database);
//     });
//   }
// }
