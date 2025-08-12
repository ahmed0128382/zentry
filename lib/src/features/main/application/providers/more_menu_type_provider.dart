import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/shared/enums/menu_types.dart';

/// Provider to hold the selected [MoreMenuType]
final moreMenuTypeProvider = StateProvider<MoreMenuType>((ref) {
  return MoreMenuType.quarterCircleFab;
});
