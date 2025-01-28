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
        Navigator.of(context).pop(state.todo);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Todo'),
          actions: [
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                context.read<TodosAddBloc>().add(const TodosAddSubmitted());
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
        return TextField(
          key: const Key('todosAddView_title_textField'),
          onChanged: (value) {
            context.read<TodosAddBloc>().add(TodosAddTitleChanged(value));
          },
          decoration: const InputDecoration(
            labelText: 'Title',
            border: OutlineInputBorder(),
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
        return TextField(
          key: const Key('todosAddView_description_textField'),
          onChanged: (value) {
            context.read<TodosAddBloc>().add(TodosAddDescriptionChanged(value));
          },
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
