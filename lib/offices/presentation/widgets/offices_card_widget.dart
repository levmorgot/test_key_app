import 'package:flutter/material.dart';
import 'package:key_test_project/common/app_colors.dart';
import 'package:key_test_project/offices/domain/entities/office_entity.dart';
import 'package:key_test_project/places/presentation/pages/places_screen.dart';

class OfficeCard extends StatelessWidget {
  final OfficeEntity office;

  const OfficeCard({
    Key? key,
    required this.office,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => PlacesPage(
              office: office,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            '${office.name} #${office.id}',
            style: const TextStyle(
              color: AppColors.officeCardText,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
