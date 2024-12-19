import '../app/http/controllers/customerController.dart';
import 'package:vania/vania.dart';
import '../app/http/controllers/home_controller.dart';
import '../app/http/middleware/authenticate.dart';
import '../app/http/middleware/home_middleware.dart';
import '../app/http/middleware/error_response_middleware.dart';
import '../app/http/controllers/auth_controller.dart';
import '../app/http/controllers/usercontroller.dart';
import '../app/http/controllers/todo_controller.dart';
import '../app/http/controllers/productsController.dart';
import '../app/http/controllers/orderitemController.dart';
import '../app/http/controllers/orderController.dart';
import '../app/http/controllers/vendorController.dart';
import '../app/http/controllers/productsNotesController.dart';

class ApiRoute implements Route {
  @override
  void register() {
    // Base RoutePrefix

    // Home
    Router.get("/home", homeController.index);

    // Hello World
    Router.get("/hello-world", () {
      return Response.html('Hello World');
    }).middleware([HomeMiddleware()]);

    // Return error code 400
    Router.get('wrong-request', () {
      return Response.json({'message': 'Hi wrong request'});
    }).middleware([ErrorResponseMiddleware()]);

    // Return Authenticated user data
    Router.get("/user", (Request request) {
      return Response.json(Auth().user());
    }).middleware([AuthenticateMiddleware()]);

    // Customers
    Router.get("/customer", CustomerController().getAllCustomer);
    Router.post("/customer/create", (Request request) async {
      await CustomerController().createCustomer(request);
      return Response.json({'message': 'Customer telah ditambahkan'});
    });
    Router.put("/customer/update/{id}", (Request request, String id) async {
      await CustomerController().updateCustomer(request, id);
      return Response.json({'message': 'Customer telah diperbarui'});
    });
    Router.delete("/customer/delete/{id}", (Request request, String id) async {
      await CustomerController().deleteCustomer(request, id);
      return Response.json({'message': 'Customer telah dihapus'});
    });

    // Orders
    Router.get("/orders", OrderController().getOrderController);
    Router.post("/orders/create", (Request request) async {
      await OrderController().createOrderController(request);
      return Response.json({'message': 'Order telah ditambahkan'});
    });
    Router.put("/orders/update/{orderNum}",
        (Request request, int orderNum) async {
      await OrderController().updateOrderController(request, orderNum);
      return Response.json({'message': 'Order telah diperbarui'});
    });
    Router.delete("/orders/delete/{orderNum}",
        (Request request, int orderNum) async {
      await OrderController().deleteOrderController(request, orderNum);
      return Response.json({'message': 'Order telah dihapus'});
    });

    // OrderItems
    Router.get("/orderitems", OrderItemController().getOrderItemController);
    Router.post("/orderitems/create", (Request request) async {
      await OrderItemController().createOrderItemController(request);
      return Response.json({'message': 'Order item telah ditambahkan'});
    });
    Router.put("/orderitems/update/{orderItem}",
        (Request request, int orderItem) async {
      await OrderItemController().updateorderItemController(request, orderItem);
      return Response.json({'message': 'Order item telah diperbarui'});
    });
    Router.delete("/orderitems/delete/{orderItem}",
        (Request request, int orderItem) async {
      await OrderItemController().deleteOrderItemController(request, orderItem);
      return Response.json({'message': 'Order item telah dihapus'});
    });

    // Products
    Router.get("/products", ProductController().getProductController);
    Router.post("/products/create", (Request request) async {
      await ProductController().createProductController(request);
      return Response.json({'message': 'Produk telah ditambahkan'});
    });
    Router.put("/products/update/{prodID}",
        (Request request, int prodID) async {
      await ProductController().updateProductController(request, prodID);
      return Response.json({'message': 'Produk telah diperbarui'});
    });
    Router.delete("/products/delete/{prodID}",
        (Request request, int prodID) async {
      await ProductController().deleteProductController(request, prodID);
      return Response.json({'message': 'Produk telah dihapus'});
    });

    // ProductNotes
    Router.get(
        "/productnotes", ProductNoteController().getProductNoteController);
    Router.post("/productnotes/create", (Request request) async {
      await ProductNoteController().createProductNoteController(request);
      return Response.json({'message': 'Product note telah ditambahkan'});
    });
    Router.put("/productnotes/update/{noteID}",
        (Request request, int noteID) async {
      await ProductNoteController()
          .updateProductNoteController(request, noteID);
      return Response.json({'message': 'Product note telah diperbarui'});
    });
    Router.delete("/productnotes/delete/{noteID}",
        (Request request, int noteID) async {
      await ProductNoteController()
          .deleteProductNoteController(request, noteID);
      return Response.json({'message': 'Product note telah dihapus'});
    });

    // Vendors
    Router.get("/vendors", VendorController().getVendorController);
    Router.post("/vendors/create", (Request request) async {
      await VendorController().createVendorController(request);
      return Response.json({'message': 'Vendor telah ditambahkan'});
    });
    Router.put("/vendors/update/{vendID}",
        (Request request, int vendID) async {
      await VendorController().updateVendorController(request, vendID);
      return Response.json({'message': 'Vendor telah diperbarui'});
    });
    Router.delete("/vendors/delete/{vendID}",
        (Request request, int vendID) async {
      await VendorController().deleteVendorController(request, vendID);
      return Response.json({'message': 'Vendor telah dihapus'});
    });

    // Auth
    Router.group(() {
      Router.post('register', authController.register);
      Router.post('login', authController.login);
    }, prefix: 'auth');

    // User
    Router.group(() {
      Router.patch('update-password', userController.updatePassword);
      Router.get('', userController.index);
    }, prefix: 'user', middleware: [AuthenticateMiddleware()]);

    // Todo
    Router.group(() {
      Router.post('todo', todoController.store);
    }, prefix: 'todo', middleware: [AuthenticateMiddleware()]);
  }
}
