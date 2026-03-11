import 'package:get/get.dart';

import '../../presentation/contacts/controllers/safe_contacts_controller.dart';

class ContactsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SafeContactsController>(() => SafeContactsController());
  }
}
