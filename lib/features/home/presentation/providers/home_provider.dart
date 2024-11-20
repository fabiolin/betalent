import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'states/home_notifier.dart';
import 'states/home_state.dart';

final homeStateNotifier =
    AutoDisposeStateNotifierProvider<HomeNotifier, HomeState>(
        (ref) => HomeNotifier());
