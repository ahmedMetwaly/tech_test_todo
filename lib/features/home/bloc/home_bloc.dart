import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/features/home/bloc/home_states.dart';
import 'package:todo/features/splash_screen/models/task_model.dart';

late Database database;

class AppCubit extends Cubit<AppCubitStates> {
  AppCubit() : super(InitialAppCubitState());

  static AppCubit get(context) => BlocProvider.of(context);
  List<TaskModel> taskList = [];
  IconData icon = Icons.add_task_rounded;
  bool isOpened = true;
  void closedBottomSheet() {
    isOpened = true;
    icon = Icons.add_task_rounded;
    emit(CloseBottomSheet());
  }

  void openedBottmSheet() {
    isOpened = false;
    icon = Icons.add;
    emit(OpenBottomSheet());
  }

//dataBase
  void createDataBase() {
    openDatabase(
      'toDo.db',
      version: 1,
      onCreate: (database, version) {
        //  print('database is created');
        database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, state Text)')
            .then(
          (value) {
            //  print('Table is created');
          },
        ).catchError(
          (error) {
            //   print('while creating Table this error happened ${error}');
          },
        );
      },
      onOpen: (database) {
        //print('data base is opened');
        getData(database);
      },
    ).then((value) {
      database = value;

      emit(DataBaseIsCreated());
    });
  }

  insertToDataBase({
    required String taskTitle,
  }) async {
    await database.transaction(
      (txn) => txn
          .rawInsert(
        'INSERT INTO tasks(title, state) VALUES("$taskTitle", "notChecked")',
      )
          .then(
        (value) {
        //  print('$value is inserted sucssefully ');
          emit(InsertedToDataBase());
          getData(database).then((value) {
          //  print(value);
            emit(DataIsgitten());
          });
        },
      ).catchError(
        (error) {
          //print('$error created when inserrting a row in');
        },
      ),
    );
  }

  getData(Database db) async {
    await db.rawQuery('SELECT * FROM tasks').then((value) {
      taskList = value.map((task) => TaskModel.fromJson(task)).toList();

//      print('dataBase is gitten');

  //    print('taskList = $taskList');
      //print('doneList = $doneList');
      //print('archivedList = $archivedList');

      emit(DataIsgitten());
    });
  }

  getSpecificTask(int id) {
    return database
        .rawQuery('SELECT * FROM tasks WHERE id = ? ', [id]).then((value) {
      emit(GetSpecificTask());
      //print(value);
    });
  }

  Future updateData({required String field, required String data, required int id}) async{
   await database.rawUpdate(
        'UPDATE tasks SET $field = ? WHERE id = ?', [data, id]).then((value) {
      // print('data is updated');
      emit(UpdatedData());
      getData(database);
    });
  }

  Future deleteData({required int id}) async{
    await database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      //print('$value is deleted');
      emit(Delted());
      getData(database);
    });
  }
}
