import 'package:chat/src/models/user.dart';
import 'package:chat/src/services/user/user_service_impl.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers.dart';
import 'package:rethink_db_ns/rethink_db_ns.dart';

void main(){
  RethinkDb r = RethinkDb();
  late Connection connection;
  // UserService sut;
  late UserService sut;

  setUp(() async {
    connection = await r.connect(host: "127.0.0.1", port:28015);
    await createDb(connection);
    sut = UserService(r, connection);
  });

  tearDown(() async{
    await cleanDb(r, connection);
  });

  test('creates a new user doc in database', () async {
    final newUser = User(
      username: 'test',
      photoUrl: 'url',
      active: true,
      lastseen: DateTime.now(),
    );
    final userWithId = await sut.connect(newUser);
    expect(userWithId.id, isNotEmpty);
  });

  test('get online user', () async {
    final newUser = User(
      username: 'test',
      photoUrl: 'url',
      active: true,
      lastseen: DateTime.now(),
    );
    await sut.connect(newUser);
    final users = await sut.online();
    expect(users.length, 1);
  });
}