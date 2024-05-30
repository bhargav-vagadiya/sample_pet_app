import 'package:flutter/material.dart' show TextEditingController;
import 'package:get/get.dart';
import 'package:petstore_api/api.dart';
import 'package:sample_pet_app/pets/controllers/pet_list_controller.dart';

class PetViewController extends GetxController {
  Pet? pet;
  final int petId;
  final nameController = TextEditingController();
  final categoryController = TextEditingController();
  final statusController = TextEditingController();
  final selectedTags = <String>[];
  bool _isLoading = true;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  PetViewController({required this.petId});

  Future<void> getPet({bool showLoading = true}) async {
    if (showLoading) isLoading = true;
    try {
      pet = await PetApi().getPetById(petId);
      nameController.text = pet!.name;
      categoryController.text = pet!.category!.name!;
      statusController.text = pet!.status!.toJson();
      update();
    } finally {
      isLoading = false;
    }
  }

  Future<void> updatePet(Pet pet) async {
    try {
      await PetApi().updatePet(pet);
    } finally {
      try {
        Get.snackbar("Pet updated", "Pet updated successfully");
      } catch (e) {
        // TODO
      }
    }
  }

  @override
  void onInit() {
    getPet();
    super.onInit();
  }
}
