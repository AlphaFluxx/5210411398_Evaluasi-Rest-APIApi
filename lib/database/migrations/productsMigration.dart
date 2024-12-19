import 'package:vania/vania.dart';

class Products extends Migration {
  @override
  Future<void> up() async {
    super.up();
    await createTableNotExists('products', () {
      string('prod_id', length: 10);
      char('vend_id', length: 5);
      string('prod_name', length: 50);
      integer('prod_price', length: 11);
      text('prod_desc');
      timeStamps();
    });
  }

  @override
  Future<void> down() async {
    super.down();
    await dropIfExists('products');
  }
}
