import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/core/application/providers/app_palette_provider.dart';
import 'widgets/search_header.dart';
import 'widgets/search_input.dart';
import 'widgets/search_empty_state.dart';

class SearchView extends ConsumerWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = ref.watch(appPaletteProvider);
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(color: palette.background),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchHeader(),
                SizedBox(height: 16),
                SearchInput(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                SearchEmptyState(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
