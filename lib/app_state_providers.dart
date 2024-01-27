import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'models/study.dart';

final getPlanListProvider = StateProvider<List<Plan>>((ref) => []);