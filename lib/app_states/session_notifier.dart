import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:studypal/memory/database/session_database_helper.dart';
import 'package:studypal/models/session.dart';
part 'session_notifier.g.dart';
@riverpod
class SessionNotifiier extends _$SessionNotifiier{

 @override
  Future<List<Session>> build() async {
    return SessionDatabaseHelper.getAllSessions();
  }

  createSession(Session session){
    SessionDatabaseHelper.createNewSession(session);
    updateState();
  }

  updateState()async{
    final turnDataIntoAsyncValue = await SessionDatabaseHelper.getAllSessions();
    state = AsyncData(turnDataIntoAsyncValue);
  }
}

