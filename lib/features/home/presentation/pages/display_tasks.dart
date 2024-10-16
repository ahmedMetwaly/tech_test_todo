import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/constants/values_manager.dart';
import 'package:todo/core/widgets/show_dialogs.dart';

import '../../bloc/home_bloc.dart';
import '../../bloc/home_states.dart';

class Tasks extends StatelessWidget {
  const Tasks({super.key});
  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);

    return BlocBuilder<AppCubit, AppCubitStates>(
      builder: (context, state) => ListView.separated(
        padding: const EdgeInsets.all(PaddingManager.pMainPadding),
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(PaddingManager.pInternalPadding),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(SizeManager.borderRadius),
                color: Theme.of(context).colorScheme.onPrimary),
            child: Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  trailing: Checkbox(
                      value: cubit.taskList[index].state == "notChecked"
                          ? false
                          : true,
                      onChanged: (value) {
                        cubit.updateData(
                            id: cubit.taskList[index].id!,
                            field: "state",
                            data: cubit.taskList[index].state == "notChecked"
                                ? "checked"
                                : "notChecked");
                      }),
                  title: Text(
                    cubit.taskList[index].taskTitle!,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                              Theme.of(context).colorScheme.onSecondary),
                        ),
                        onPressed: () {
                          TextEditingController controller =
                              TextEditingController(
                                  text: cubit.taskList[index].taskTitle!);
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Edit Task'),
                                      SizedBox(height: 10),
                                      Divider(),
                                    ],
                                  ),
                                  content: TextFormField(
                                    controller: controller,
                                    decoration: const InputDecoration(
                                      label: Text("Task title"),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Required field*";
                                      }
                                      return null;
                                    },
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        cubit
                                            .updateData(
                                                id: cubit.taskList[index].id!,
                                                field: "title",
                                                data: controller.text)
                                            .then((_) =>
                                                Navigator.of(context).pop());
                                      },
                                      child: const Text('Save'),
                                    )
                                  ],
                                );
                              });
                        },
                        child: const Text("Edit"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextButton(
                        style: ButtonStyle(
                          side: WidgetStateProperty.all(
                            BorderSide(
                                style: BorderStyle.solid,
                                color: Theme.of(context).colorScheme.error),
                          ),
                          backgroundColor: WidgetStateProperty.all(
                              Theme.of(context).colorScheme.onError),
                        ),
                        onPressed: () {
                          showAlertDialog(context,
                              title: "Delete",
                              body: "Are you sure to delete this task?",
                              function: () {
                          //  print("deleted task");
                            cubit.deleteData(id: cubit.taskList[index].id!);
                          });
                        },
                        child: const Text("Delete"),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
        separatorBuilder: (context, index) =>
            const SizedBox(height: SizeManager.sSpace),
        itemCount: cubit.taskList.length,
      ),
    );
  }
}
