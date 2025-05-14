import 'package:rethink_db_ns/rethink_db_ns.dart';

Future<void> createDb(Connection connection) async {
  final r = RethinkDb();

  // 创建 test 数据库（如果不存在）
  final dbs = await r.dbList().run(connection);
  if (!dbs.contains('test')) {
    await r.dbCreate('test').run(connection);
  }

  // 创建 users 表（如果不存在）
  final tables = await r.db('test').tableList().run(connection);
  if (!tables.contains('users')) {
    await r.db('test').tableCreate('users').run(connection);
  }
}

Future<void> cleanDb(RethinkDb r, Connection connection) async {
  await r.db('test').table('users').delete().run(connection);
}