import 'package:flutter/material.dart';
import 'package:todo/core/utils/media_query_utils.dart';

import '../../bloc/home_bloc.dart';

class FAB extends StatelessWidget {
  const FAB({
    super.key,
    required this.cubit,
    required this.scaffoldKey,
    required this.formKey,
    required this.taskTitle,
  });

  final AppCubit cubit;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState> formKey;
  final TextEditingController taskTitle;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(
        cubit.icon,
      ),
      onPressed: () {
        if (cubit.isOpened) {
          scaffoldKey.currentState!
              .showBottomSheet(
                (context) {
                  return Container(
                    padding: const EdgeInsets.all(20),
                    height: MediaQueryUtils.getHeightPercentage(context, 0.3),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onPrimary,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(15),
                      ),
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Add new task",style: Theme.of(context).textTheme.headlineSmall),
                          const Divider(),
                          TextFormField(
                            controller: taskTitle,
                            decoration: const InputDecoration(
                              labelText: 'Task Title',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Required field*";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
              .closed
              .then(
                (value) {
                  cubit.closedBottomSheet();
                },
              );
          cubit.openedBottmSheet();
        } else {
          if (formKey.currentState!.validate()) {
            cubit.insertToDataBase(
              taskTitle: taskTitle.text,
            );
            cubit.closedBottomSheet();
            Navigator.pop(context);
          }
        }
      },
    );
  }
}
