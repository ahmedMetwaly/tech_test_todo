import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/home_bloc.dart';
import '../../bloc/home_states.dart';
import '../widgets/fab.dart';
import 'display_tasks.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();
    var formKey = GlobalKey<FormState>();
    TextEditingController taskTitle = TextEditingController();

    return BlocProvider(
      create: (context) => AppCubit()..createDataBase(),
      child: BlocBuilder<AppCubit, AppCubitStates>(
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(title: const Text("Tasks")),
            floatingActionButton: FAB(cubit: cubit, scaffoldKey: scaffoldKey, formKey: formKey, taskTitle: taskTitle),
            body: const Tasks(),
          );
        },
      ),
    );
  }
}
