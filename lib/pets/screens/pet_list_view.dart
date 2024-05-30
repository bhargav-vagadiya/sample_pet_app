import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';
import 'package:sample_pet_app/pets/controllers/pet_list_controller.dart';
import 'package:sample_pet_app/pets/screens/update_pet.dart';

class PetListView extends StatelessWidget {
  const PetListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        title: Text("Pets"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<PetListController>(
          init: PetListController(),
          builder: (controller) => controller.pets != null &&
                  controller.pets!.isNotEmpty
              ? ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () async {
                          Get.to(() => UpdatePet(
                                petId: controller.pets![index].id!,
                              ))?.then(
                            (value) {
                              controller.getPet();
                            },
                          );
                        },
                        overlayColor:
                            WidgetStatePropertyAll(Colors.transparent),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Name: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Expanded(
                                        child: Text(
                                      controller.pets?[index].name ?? "",
                                      overflow: TextOverflow.ellipsis,
                                    )),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Category: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Expanded(
                                        child: Text(
                                      controller.pets?[index].category?.name ??
                                          "",
                                      overflow: TextOverflow.ellipsis,
                                    )),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Status: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Expanded(
                                        child: Text(
                                      controller.pets?[index].status?.value ??
                                          "",
                                      overflow: TextOverflow.ellipsis,
                                    )),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Tags: ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Expanded(
                                        child: Text(
                                      controller.pets?[index].tags!
                                              .map(
                                                (e) => e.name,
                                              )
                                              .join(" , ") ??
                                          "",
                                      overflow: TextOverflow.ellipsis,
                                    )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: controller.pets!.length,
                )
              : controller.pets == null
                  ? Center(
                      child: Text("No pets"),
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
        ),
      ),
    );
  }
}
