import 'dart:math';

import '../../models/orderitemModel.dart';
import 'package:vania/vania.dart';

class OrderItemController extends Controller {
  Future<Response> getOrderItemController(Request request) async {
    final orderItems = await Orderitem().query().get();
    return Response.json({'message': orderItems});
  }

  Future<Response> createOrderItemController(Request request) async {
    final orderNum = request.input('orderNum');
    final prodId = request.input('prodId');
    final quantity = request.input('quantity');
    final size = request.input('size');

    final randomID = (Random().nextInt(20) + 1);

    final result = await Orderitem().query().insert({
      'order_item': randomID,
      'order_num': orderNum,
      'prod_id': prodId,
      'quantity': quantity,
      'size': size
    });
    return Response.json({'message': result});
  }

  Future<Response> updateorderItemController(Request request, orderItem) async {
    final Map<String, dynamic> updateData = {};

    final inputFields = [
      ['order_num', request.input('orderNum')],
      ['prod_id', request.input('prodId')],
      ['quantity', request.input('quantity')],
      ['size', request.input('size')],
    ];

    for (var input in inputFields) {
      final fieldName = input[0];
      final fieldValue = input[1];

      if (fieldValue != null) {
        updateData[fieldName] = fieldValue;
      }
    }

    final result = await Orderitem()
        .query()
        .where('order_item', '=', orderItem)
        .update(updateData);
    return Response.json({'message': result});
  }

  Future<Response> deleteOrderItemController(Request request, orderItem) async {
    final result =
        await Orderitem().query().where('order_item', '=', orderItem).delete();
    return Response.json({'message': result});
  }
}
