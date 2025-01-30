import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_repository/todos_repository.dart';
import 'package:taskmaster/l10n/l10n.dart';
import '../bloc/todos_edit_bloc.dart';

/// {@template todos_edit_page}
/// A page for editing a todo.
/// {@endtemplate}
class TodosEditPage extends StatelessWidget {
  /// {@macro todos_edit_page}
  const TodosEditPage({
    super.key,
    required this.todo,
  });

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodosEditBloc(
        todosRepository: context.read<TodosRepository>(),
      )..add(TodosEditLoadTodo(todo)),
      child: const TodosEditView(),
    );
  }
}

class TodosEditView extends StatelessWidget {
  const TodosEditView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodosEditBloc, TodosEditState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == TodosEditStatus.success) {
          Navigator.of(context).pop(state.todo);
        } else if (state.status == TodosEditStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(context.l10n.failedToSaveTodo)),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.editTodo),
          actions: [
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                context.read<TodosEditBloc>().add(TodosEditSubmitted());
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

class _TitleField extends StatefulWidget {
  @override
  State<_TitleField> createState() => _TitleFieldState();
}

class _TitleFieldState extends State<_TitleField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosEditBloc, TodosEditState>(
      builder: (context, state) {
        _controller.text = state.title;
        _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length),
        );

        final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
        final textColor = isDarkTheme ? Colors.white : Colors.black;

        return TextFormField(
          key: const Key('todosEditView_title_textFormField'),
          controller: _controller,
          decoration: InputDecoration(
            labelText: context.l10n.title,
            border: OutlineInputBorder(),
          ),
          style: TextStyle(color: textColor),
          onChanged: (value) {
            context.read<TodosEditBloc>().add(TodosEditTitleChanged(value));
          },
        );
      },
    );
  }
}

class _DescriptionField extends StatefulWidget {
  @override
  State<_DescriptionField> createState() => _DescriptionFieldState();
}

class _DescriptionFieldState extends State<_DescriptionField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosEditBloc, TodosEditState>(
      builder: (context, state) {
        _controller.text = state.description;
        _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length),
        );

        final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
        final textColor = isDarkTheme ? Colors.white : Colors.black;

        return TextFormField(
          key: const Key('todosEditView_description_textFormField'),
          controller: _controller,
          decoration: InputDecoration(
            labelText: context.l10n.description,
            border: OutlineInputBorder(),
          ),
          maxLines: 3,
          style: TextStyle(color: textColor),
          onChanged: (value) {
            context
                .read<TodosEditBloc>()
                .add(TodosEditDescriptionChanged(value));
          },
        );
      },
    );
  }
}
