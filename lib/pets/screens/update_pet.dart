import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petstore_api/api.dart';
import 'package:sample_pet_app/pets/controllers/pet_view_controller.dart';

class UpdatePet extends StatefulWidget {
  const UpdatePet({Key? key, required this.petId}) : super(key: key);

  final int petId;

  @override
  State<UpdatePet> createState() => _UpdatePetState();
}

class _UpdatePetState extends State<UpdatePet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Update Pet'), // Title reflects the new name
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: GetBuilder<PetViewController>(
          init: PetViewController(petId: widget.petId),
          builder: (controller) {
            return Container(
              color: Colors.indigo.withOpacity(0.2),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: controller.nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    TextField(
                      controller: controller.categoryController,
                      decoration: InputDecoration(
                        labelText: 'Category',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    TextField(
                      controller: controller.statusController,
                      decoration: InputDecoration(
                        labelText: 'Status',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Tags:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: controller.pet?.tags
                                .map((tag) =>
                                    _buildTagButton(tag.name ?? "", controller))
                                .toList() ??
                            [],
                      ),
                    ),
                    TextButton(
                        onPressed: () => _showAddTagDialog(controller),
                        child: Text("+ Add tags")),
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () async {
                        await controller.updatePet(
                          controller.pet!.copyWith(
                              name: controller.nameController.text,
                              category: Category(
                                  name: controller.categoryController.text),
                              status: PetStatusEnum.fromJson(
                                  controller.statusController.text)),
                        );
                        Get.close(1);
                      },
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget _buildTagButton(String tag, PetViewController controller) {
    return Flexible(
      // Flexible allows remaining space for text
      child: Text(
        tag,
        style: TextStyle(
          fontSize: 14.0,
          color: Colors.grey[800], // Adjust text color as needed
        ),
      ),
    );
  }

  void _showAddTagDialog(PetViewController controller) {
    final _tagController = TextEditingController();
    Get.dialog(
      AlertDialog(
        title: const Text('Add Tag'),
        content: TextField(
          controller: _tagController,
          decoration: InputDecoration(
            hintText: 'Enter Tag',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              controller.pet!.tags.add(Tag(name: _tagController.text));
              controller.update();

              Get.back();
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  // Widget _buildTagButton(String tag, PetViewController controller) {
  //   return TextButton(
  //     onPressed: () {
  //       setState(() {
  //         if (!controller.selectedTags.contains(tag)) {
  //           controller.selectedTags.add(tag);
  //           controller.update();
  //         } else {
  //           controller.selectedTags.remove(tag);
  //           controller.update();
  //         }
  //       });
  //     },
  //     child: Text(tag),
  //     style: TextButton.styleFrom(
  //       foregroundColor: Colors.blue,
  //       padding: const EdgeInsets.symmetric(horizontal: 8.0),
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(10.0),
  //         side: BorderSide(color: Colors.blueAccent),
  //       ),
  //     ),
  //   );
  // }
}
