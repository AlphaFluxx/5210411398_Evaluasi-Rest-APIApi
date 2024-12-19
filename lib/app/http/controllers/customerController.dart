import 'dart:math';
import '../../models/customerModel.dart';
import 'package:vania/vania.dart';

class CustomerController extends Controller {
  Future<Response> getAllCustomer(Request request) async {
    final customers = await Customer().query().get();
    return Response.json({'message': customers});
  }

  Future<Response> createCustomer(Request request) async {
    try {
      final custName = request.input('custName');
      final custAddress = request.input('custAddress');
      final custCity = request.input('custCity');
      final custState = request.input('custState');
      final custZip = request.input('custZip');
      final custCountry = request.input('custCountry');
      final custTelp = request.input('custTelp');

      if (custName == null || custAddress == null || custCity == null) {
        return Response.json({'error': 'Missing required fields'});
      }

      final randomID = (Random().nextInt(90000) + 10000).toString();

      final result = await Customer().query().insert({
        'cust_id': randomID,
        'cust_name': custName,
        'cust_address': custAddress,
        'cust_city': custCity,
        'cust_state': custState,
        'cust_zip': custZip,
        'cust_country': custCountry,
        'cust_telp': custTelp
      });

      return Response.json({
        'message': 'Customer created',
        'customer_id': randomID,
        'result': result
      });
    } catch (e) {
      return Response.json({'error': e.toString()});
    }
  }

  Future<Response> updateCustomer(Request request, id) async {
    try {
      final Map<String, dynamic> updateData = {};

      final inputFields = [
        ['cust_name', request.input('custName')],
        ['cust_address', request.input('custAddress')],
        ['cust_city', request.input('custCity')],
        ['cust_state', request.input('custState')],
        ['cust_zip', request.input('custZip')],
        ['cust_country', request.input('custCountry')],
        ['cust_telp', request.input('custTelp')],
      ];

      for (var input in inputFields) {
        final fieldName = input[0];
        final fieldValue = input[1];

        if (fieldValue != null) {
          updateData[fieldName] = fieldValue;
        }
      }

      final result =
          await Customer().query().where('cust_id', '=', id).update(updateData);
      return Response.json({'message': 'Customer updated', 'result': result});
    } catch (e) {
      return Response.json({'error': e.toString()});
    }
  }

  Future<Response> deleteCustomer(Request request, id) async {
    try {
      final result =
          await Customer().query().where('cust_id', '=', id).delete();
      return Response.json({'message': 'Customer deleted', 'result': result});
    } catch (e) {
      return Response.json({'error': e.toString()});
    }
  }
}
