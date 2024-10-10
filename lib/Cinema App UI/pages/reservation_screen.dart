import 'package:flutter/material.dart';
import 'package:flutter_ui_design/Cinema%20App%20UI/consts.dart';
import 'package:intl/intl.dart';
import '../Widget/seat_status.dart';
import '../models/seats_model.dart';
import 'ticket_page.dart'; // Đảm bảo đường dẫn này đúng với vị trí file của bạn

class ReservationScreen extends StatefulWidget {
  const ReservationScreen({super.key});

  @override
  State<ReservationScreen> createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  final items = List<DateTime>.generate(15, (index) {
    return DateTime.utc(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    ).add(Duration(days: index));
  });

  DateTime selectedTime = DateTime.now();
  List<String> selectedSeats = [];

  @override
  void initState() {
    super.initState();
    // Set default selected time to the first available time in the list
    selectedTime = DateTime.utc(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      int.parse(availableTime[0].split(':')[0]),
      int.parse(availableTime[0].split(':')[1]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: const Text(
          "Select Seats",
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          welcomeBorder(context), // Sử dụng hàm đã định nghĩa
          const SizedBox(height: 20),
          // for movie seat
          Column(
            children: [
              ...List.generate(
                numRow.length,
                (colIndex) {
                  int numCol =
                      colIndex == 0 || colIndex == numRow.length - 1 ? 6 : 8;
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: colIndex == numRow.length - 1 ? 0 : 10,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ...List.generate(numCol, (rowIndex) {
                          String seatNum = '${numRow[colIndex]}${rowIndex + 1}';
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (selectedSeats.contains(seatNum)) {
                                  selectedSeats.remove(seatNum);
                                } else if (!reservedSeats.contains(seatNum)) {
                                  selectedSeats.add(seatNum);
                                }
                              });
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              margin: EdgeInsets.only(
                                  right:
                                      rowIndex == (numCol / 2) - 1 ? 30 : 10),
                              decoration: BoxDecoration(
                                color: reservedSeats.contains(seatNum)
                                    ? Colors.white
                                    : selectedSeats.contains(seatNum)
                                        ? buttonColor
                                        : grey,
                                borderRadius: BorderRadius.circular(7.5),
                              ),
                            ),
                          );
                        })
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 30),
          const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SeatStatus(
                color: grey,
                status: 'Available',
              ),
              SizedBox(width: 10),
              SeatStatus(
                color: buttonColor,
                status: 'Selected',
              ),
              SizedBox(width: 10),
              SeatStatus(
                color: Colors.white,
                status: 'Reserved',
              ),
            ],
          ),
          const Spacer(),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 35),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(50),
              ),
            ),
            child: Column(
              children: [
                const Text(
                  'Select Date and Time',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 35),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...List.generate(
                        items.length,
                        (index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedSeats.clear(); // Clear previous selections
                              selectedTime = items[index]; // Update selected date
                            });
                          },
                          child: Container(
                            margin: index == 0
                                ? const EdgeInsets.only(left: 20, right: 20)
                                : const EdgeInsets.only(right: 20),
                            padding: const EdgeInsets.fromLTRB(8, 12, 8, 8),
                            decoration: BoxDecoration(
                              color: DateFormat('d/M/y').format(selectedTime) ==
                                      DateFormat('d/M/y').format(items[index])
                                  ? buttonColor
                                  : grey,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  DateFormat('MMM').format(items[index]),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: DateFormat('d/M/y')
                                                .format(selectedTime) ==
                                            DateFormat('d/M/y')
                                                .format(items[index])
                                        ? Colors.white
                                        : Colors.transparent,
                                  ),
                                  child: Text(
                                    DateFormat('dd').format(items[index]),
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: DateFormat('d/M/y')
                                                  .format(selectedTime) ==
                                              DateFormat('d/M/y')
                                                  .format(items[index])
                                          ? appBackgroundColor
                                          : Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 35),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...List.generate(
                        availableTime.length,
                        (index) => GestureDetector(
                          onTap: () {
                            setState(
                              () {
                                selectedSeats.clear(); // Clear previous selections
                                selectedTime = DateTime.utc(
                                  selectedTime.year,
                                  selectedTime.month,
                                  selectedTime.day,
                                  int.parse(availableTime[index].split(':')[0]),
                                  int.parse(availableTime[index].split(':')[1]),
                                );
                              },
                            );
                          },
                          child: Container(
                            margin: index == 0
                                ? const EdgeInsets.only(left: 20, right: 20)
                                : const EdgeInsets.only(right: 20),
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: grey,
                              border: Border.all(
                                  width: 2,
                                  color: DateFormat('HH:mm')
                                              .format(selectedTime)
                                              .toString() ==
                                          availableTime[index]
                                      ? buttonColor
                                      : Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              availableTime[index],
                              style: TextStyle(
                                fontSize: 14,
                                color: DateFormat('HH:mm')
                                            .format(selectedTime)
                                            .toString() ==
                                        availableTime[index]
                                    ? buttonColor
                                    : Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Total Price',
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '\$${selectedSeats.length * 20}.00',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(width: 30),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (selectedSeats.isNotEmpty) {
// Somewhere in reservation_screen.dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => TicketPage(
      selectedSeats: 'B1, C1, C2', // or use dynamic data
      totalPrice: 30.00,           // or use dynamic data
      selectedTime: DateTime.now(),// or use the actual selected time
      orderNumber: 'QW1E0RTY',     // or use your actual order number
    ),
  ),
);

                            }
                          },
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: buttonColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Center(
                              child: Text(
                                'Continue',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget welcomeBorder(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.6,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Text(
        'Welcome to the Cinema App',
        style: TextStyle(color: Colors.white, fontSize: 15),
        textAlign: TextAlign.center,
      ),
    );
  }
}