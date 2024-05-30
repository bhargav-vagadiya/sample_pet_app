import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:sample_pet_app/pets/screens/pet_list_view.dart';
// import 'package:sample_pet_app/api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PetListView(),
    );
  }
}
