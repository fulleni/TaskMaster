import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_repository/todos_repository.dart';
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
          title: const Text('Add Todo'),
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
            labelText: 'Title',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
            fillColor: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[800]
                : Colors.grey[100],
            labelStyle: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white70
                  : Colors.black54,
            ),
            errorText: state.title.isEmpty ? 'Title cannot be empty' : null,
            helperText: 'Required',
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
          decoration: const InputDecoration(
            labelText: 'Description',
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
        );
      },
    );
  }
}
