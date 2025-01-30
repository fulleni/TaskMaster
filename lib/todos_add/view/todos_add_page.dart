import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_repository/todos_repository.dart';
import 'package:taskmaster/l10n/l10n.dart';
import '../bloc/todos_add_bloc.dart';

class TodosAddPage extends StatelessWidget {
  const TodosAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodosAddBloc(
        todosRepository: context.read<TodosRepository>(),
      ),
      child: const TodosAddView(),
    );
  }
}

class TodosAddView extends StatelessWidget {
  const TodosAddView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodosAddBloc, TodosAddState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == TodosAddStatus.success,
      listener: (context, state) {
        Navigator.of(context).pop();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.addTodo),
          actions: [
            BlocBuilder<TodosAddBloc, TodosAddState>(
              buildWhen: (previous, current) =>
                  previous.isValid != current.isValid,
              builder: (context, state) {
                return IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: state.isValid
                      ? () {
                          context
                              .read<TodosAddBloc>()
                              .add(const TodosAddSubmitted());
                        }
                      : null,
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _TitleField(),
              const SizedBox(height: 16),
              _DescriptionField(),
            ],
          ),
        ),
      ),
    );
  }
}

class _TitleField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosAddBloc, TodosAddState>(
      buildWhen: (previous, current) => previous.title != current.title,
      builder: (context, state) {
        final textColor = Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black;
        return TextField(
          key: const Key('todosAddView_title_textField'),
          onChanged: (value) {
            context.read<TodosAddBloc>().add(TodosAddTitleChanged(value));
          },
          style: TextStyle(
            color: textColor,
            fontSize: 18,
          ),
          decoration: InputDecoration(
            labelText: context.l10n.title,
            border: OutlineInputBorder(),
            errorText: state.isDirty && state.title.isEmpty 
                ? context.l10n.titleCannotBeEmpty 
                : null,
            helperText: context.l10n.required,
          ),
        );
      },
    );
  }
}

class _DescriptionField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosAddBloc, TodosAddState>(
      buildWhen: (previous, current) =>
          previous.description != current.description,
      builder: (context, state) {
        final textColor = Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black;
        return TextField(
          key: const Key('todosAddView_description_textField'),
          onChanged: (value) {
            context.read<TodosAddBloc>().add(TodosAddDescriptionChanged(value));
          },
          style: TextStyle(color: textColor),
          decoration: InputDecoration(
            labelText: context.l10n.description,
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        );
      },
    );
  }
}
