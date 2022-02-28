import 'package:flutter/material.dart';
import 'package:key_test_project/common/app_colors.dart';
import 'package:key_test_project/places/domain/entities/booking_entity.dart';

class BookingCard extends StatelessWidget {
  final BookingEntity booking;

  const BookingCard({
    Key? key,
    required this.booking,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime bookingDate =
        DateTime.fromMillisecondsSinceEpoch(booking.timestamp);
    DateTime today = DateTime.now();
    String dateOrTime = today.difference(bookingDate).inDays == 0
        ? '${bookingDate.hour}:${bookingDate.minute}'
        : '${bookingDate.day}.${bookingDate.month}.${bookingDate.year}';
    return Container(
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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                FloatingActionButton.small(
                  backgroundColor: AppColors.refreshBookingBtn,
                  onPressed: () {},
                  child: const Icon(
                    Icons.refresh,
                    color: AppColors.mainBackground,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  '#${booking.id}',
                  style: const TextStyle(
                    color: AppColors.officeCardText,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Text(
                    dateOrTime,
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      color: AppColors.officeCardText,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                '${booking.place.office.name} #${booking.place.office.id}',
                style: const TextStyle(
                  color: AppColors.officeCardText,
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Место:  ${booking.place.number}',
                style: const TextStyle(
                  color: AppColors.officeCardText,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
