import 'dart:math';
import '../../models/productsModel.dart';
import 'package:vania/vania.dart';

class ProductController extends Controller {
  Future<Response> getProductController(Request request) async {
    final products = await Product().query().get();
    return Response.json({'message': products});
  }

  Future<Response> createProductController(Request request) async {
    final prodName = request.input('prodName');
    final prodDesc = request.input('prodDesc');
    final prodPrice = request.input('prodPrice');
    final vendId = request.input('vendId'); 

    // Generate random prod_id between 1 and 20
    final prodID = Random().nextInt(20) + 1;

    final result = await Product().query().insert({
      'prod_id': prodID, 
      'prod_name': prodName,
      'prod_desc': prodDesc,
      'prod_price': prodPrice,
      'vend_id': vendId, 
      'created_at': DateTime.now(), 
      'updated_at': DateTime.now()
    });
    return Response.json({'message': result});
  }

  Future<Response> updateProductController(Request request, int prodID) async {
    final Map<String, dynamic> updateData = {};

    final inputFields = [
      ['prod_name', request.input('prodName')],
      ['prod_desc', request.input('prodDesc')],
      ['prod_price', request.input('prodPrice')],
      ['vend_id', request.input('vendId')],
      ['updated_at', DateTime.now()] 
    ];

    for (var input in inputFields) {
      final fieldName = input[0];
      final fieldValue = input[1];

      if (fieldValue != null) {
        updateData[fieldName] = fieldValue;
      }
    }

    final result = await Product()
        .query()
        .where('prod_id', '=', int) 
        .update(updateData);
    return Response.json({'message': result});
  }

  Future<Response> deleteProductController(Request request, int prodID) async {
    final result = await Product()
        .query()
        .where('prod_id', '=', int) 
        .delete();
    return Response.json({'message': result});
  }
}

final ProductController productController = ProductController();
