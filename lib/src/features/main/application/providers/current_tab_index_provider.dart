// current_tab_index_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/main/domain/entities/main_view_page_index.dart';

/// Provider.family to get current tab index based on route location string
final currentTabIndexProvider = Provider.family<int, String>((ref, location) {
  final currentPage = MainViewPageIndexExtension.fromRoute(location);
  return currentPage.index;
});
