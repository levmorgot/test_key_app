import 'package:flutter/material.dart';
import 'package:key_test_project/offices/domain/entities/office_entity.dart';
import 'package:key_test_project/places/presentation/widgets/places_list_widget.dart';

class PlacesPage extends StatelessWidget {
  final OfficeEntity office;

  const PlacesPage(
      {Key? key, required this.office})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('#${office.id} ${office.name}'),
        centerTitle: true,
      ),
      body: PlacesList(officeId: office.id),
    );
  }
}
