import 'dart:developer';

import 'package:get/get.dart';
import 'package:petstore_api/api.dart';

class PetListController extends GetxController {
  List<Pet>? pets = [];

  getPet() async {
    pets = await PetApi().findPetsByStatus(status: "available");
    pets?.sort(
      (a, b) => a.id!.compareTo(b.id!),
    );
    update();
  }

  @override
  void onInit() {
    try {
      getPet();
    } catch (e) {
      pets = null;
    }
    super.onInit();
  }

  @override
  void onClose() {
    try {
      pets?.clear();
    } catch (e) {
      log(e.toString());
    }
    super.onClose();
  }
}
