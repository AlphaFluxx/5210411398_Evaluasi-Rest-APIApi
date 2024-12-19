import 'dart:math';
import '../../models/vendorModel.dart';
import 'package:vania/vania.dart';

class VendorController extends Controller {
  Future<Response> getVendorController(Request request) async {
    final vendors = await Vendor().query().get();
    return Response.json({'message': vendors});
  }

  Future<Response> createVendorController(Request request) async {
    final vendorName = request.input('vendorName');
    final vendorAddress = request.input('vendorAddress');
    final vendorZip = request.input('vendorZip');
    final vendorCountry = request.input('vendorCountry');

    final randomID = (Random().nextInt(20) + 1).toString().padLeft(5, '0'); 
    final result = await Vendor().query().insert({
      'vend_id': randomID,
      'vend_name': vendorName,
      'vend_address': vendorAddress,
      'vend_zip': vendorZip,
      'vend_country': vendorCountry,
      'created_at': DateTime.now(),
      'updated_at': DateTime.now() 
    });
    return Response.json({'message': 'Vendor has been added successfully', 'data': result});
  }

  Future<Response> updateVendorController(Request request, int vendID) async {
    final Map<String, dynamic> updateData = {};

    final inputFields = [
      ['vend_name', request.input('vendorName')],
      ['vend_address', request.input('vendorAddress')],
      ['vend_zip', request.input('vendorZip')],
      ['vend_country', request.input('vendorCountry')],
      ['updated_at', DateTime.now()]
    ];

    for (var input in inputFields) {
      final fieldName = input[0];
      final fieldValue = input[1];

      if (fieldValue != null) {
        updateData[fieldName] = fieldValue;
      }
    }

    final result = await Vendor()
        .query()
        .where('vend_id', '=', vendID)
        .update(updateData);
    return Response.json({'message': 'Vendor has been updated successfully', 'data': result});
  }

  Future<Response> deleteVendorController(Request request, int vendID) async {
    final result = await Vendor()
        .query()
        .where('vend_id', '=', vendID)
        .delete();
    return Response.json({'message': 'Vendor has been deleted successfully', 'data': result});
  }
}

final VendorController vendorController = VendorController();
