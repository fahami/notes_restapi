import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:notes_restapi/core/theme/color_theme.dart';
import 'package:notes_restapi/core/util/debouncer.dart';
import 'package:notes_restapi/features/auth/domain/entities/user.dart';
import 'package:notes_restapi/features/todo/presentation/bloc/todo_bloc.dart';

class SearchBar extends StatelessWidget {
  SearchBar({Key? key}) : super(key: key);

  final TextEditingController _searchController = TextEditingController();
  final Debouncer _debouncer = Debouncer(milliseconds: 500);
  var box = Hive.box<User>('user');

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: TextField(
        controller: _searchController,
        enableSuggestions: true,
        decoration: InputDecoration(
          hintText: "Cari catatanmu...",
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(200),
            borderSide: BorderSide(color: ThemeColor.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(200),
            borderSide: BorderSide(color: ThemeColor.grey),
          ),
        ),
        onChanged: (query) {
          if (query.length > 3) {
            _debouncer.run(
              () => context.read<TodoBloc>().add(SearchTodoEvent(query)),
            );
          } else {
            _debouncer.run(
              () =>
                  context.read<TodoBloc>().add(GetTodosEvent(box.get('user')!)),
            );
          }
        },
      ),
    );
  }
}
