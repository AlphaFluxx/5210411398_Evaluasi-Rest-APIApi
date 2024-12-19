import 'dart:math';

import '../../models/orderModel.dart';
import 'package:vania/vania.dart';

class OrderController extends Controller {
  Future<Response> getOrderController(Request request) async {
    final orders = await Order().query().get();
    return Response.json({'message': orders});
  }

  Future<Response> createOrderController(Request request) async {
    final orderDate = request.input('orderDate');
    final custId = request.input('custId');

    final randomID = (Random().nextInt(20) + 1);
    final result = await Order().query().insert(
        {'order_num': randomID, 'order_date': orderDate, 'cust_id': custId});
    return Response.json({'message': result});
  }

  Future<Response> updateOrderController(Request request, orderNum) async {
    final Map<String, dynamic> updateData = {};

    final inputFields = [
      ['order_date', request.input('orderDate')],
      ['cust_id', request.input('custId')],
    ];

    for (var input in inputFields) {
      final fieldName = input[0];
      final fieldValue = input[1];

      if (fieldValue != null) {
        updateData[fieldName] = fieldValue;
      }
    }

    final result = await Order()
        .query()
        .where('order_num', '=', orderNum)
        .update(updateData);
    return Response.json({'message': result});
  }

  Future<Response> deleteOrderController(Request request, orderNum) async {
    final result =
        await Order().query().where('order_num', '=', orderNum).delete();
    return Response.json({'message': result});
  }
}
