import 'dart:math';

import '../../models/productsNotesModel.dart';
import 'package:vania/vania.dart';

class ProductNoteController extends Controller {
  Future<Response> getProductNoteController(Request request) async {
    final productNotes = await Productnote().query().get();
    return Response.json({'message': productNotes});
  }

  Future<Response> createProductNoteController(Request request) async {
    final prodId = request.input('prodId');
    final noteDate = request.input('noteDate');
    final noteText = request.input('noteText');

    final randomID = (Random().nextInt(90000) + 10000).toString();

    final result = await Productnote().query().insert({
      'note_id': randomID,
      'prod_id': prodId,
      'note_date': noteDate,
      'note_text': noteText
    });

    return Response.json({'message': result});
  }

  Future<Response> updateProductNoteController(Request request, noteID) async {
    final Map<String, dynamic> updateData = {};

    final inputFields = [
      ['prod_id', request.input('prodID')],
      ['note_date', request.input('noteDate')],
      ['note_text', request.input('noteText')],
    ];

    for (var input in inputFields) {
      final fieldName = input[0];
      final fieldValue = input[1];

      if (fieldValue != null) {
        updateData[fieldName] = fieldValue;
      }
    }

    final result = await Productnote()
        .query()
        .where('prod_id', '=', noteID)
        .update(updateData);
    return Response.json({'message': result});
  }

  Future<Response> deleteProductNoteController(Request request, noteID) async {
    final result =
        await Productnote().query().where('prod_id', '=', noteID).delete();
    return Response.json({'message': result});
  }
}
