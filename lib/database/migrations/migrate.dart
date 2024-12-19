import 'dart:io';
import 'package:vania/vania.dart';
import 'create_users_table.dart';
import 'customersMigration.dart';
import 'ordersMigration.dart';
import 'orderitemsMigration.dart';
import 'productsMigration.dart';
import 'productsnotesMigration.dart';
import 'vendorsMigration.dart';
import 'create_todos_table.dart';
import 'create_personal_acces_token.dart';

void main(List<String> args) async {
  await MigrationConnection().setup();
  if (args.isNotEmpty && args.first.toLowerCase() == "migrate:fresh") {
    await Migrate().dropTables();
  } else {
    await Migrate().registry();
  }
  await MigrationConnection().closeConnection();
  exit(0);
}

class Migrate {
  registry() async {
    await CreateUserTable().up();
    await Customers().up();
    await Orders().up();
    await Orderitems().up();
    await Products().up();
    await Productnotes().up();
    await Vendors().up();
    await CreateTodosTable().up();
    await CreatePersonalAccessTokensTable().up();
  }

  dropTables() async {
    await CreateTodosTable().down();
    await Vendors().down();
    await Productnotes().down();
    await Products().down();
    await Orderitems().down();
    await Orders().down();
    await Customers().down();
    await CreateUserTable().down();
    await CreatePersonalAccessTokensTable().down();
  }
}
