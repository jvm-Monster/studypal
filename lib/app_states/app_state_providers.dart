import 'package:flutter_riverpod/flutter_riverpod.dart';
 
import 'package:studypal/models/task.dart';

final studyPalThemeProvider = StateProvider<bool?>((ref) => null);
final counterProvider = StateProvider<int>((ref) => 0);
final addedListProvider = StateProvider<List<Task>>((ref) => []);
