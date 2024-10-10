import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TicketPage extends StatelessWidget {
  final String selectedSeats; 
  final double totalPrice;     
  final DateTime selectedTime;
  final String orderNumber; 

  const TicketPage({
    Key? key,
    required this.selectedSeats,
    required this.totalPrice,
    required this.selectedTime,
    required this.orderNumber,
  }) : super(key: key);

  Future<void> saveTicket() async {
    final ticketData = {
      'selectedSeats': selectedSeats,
      'totalPrice': totalPrice,
      'selectedTime': selectedTime,
      'orderNumber': orderNumber, 
      'createdAt': FieldValue.serverTimestamp(), 
    };

    try {
      await FirebaseFirestore.instance.collection('tickets').add(ticketData);
      print("Ticket saved successfully");
    } catch (e) {
      print("Failed to save ticket: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Thank you for purchasing your movie ticket with us. We hope you enjoy your movie experience.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // Ticket details container
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF2C2C2E),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTicketDetailRow("Avengers", "${selectedTime.toLocal()}"),
                  _buildTicketDetailRow("Order", orderNumber),
                  _buildTicketDetailRow("Tickets", "3"), 
                  _buildTicketDetailRow("Seating", selectedSeats),
                  const SizedBox(height: 20),
                  // Display the barcode image
                  Container(
                    height: 100,
                    child: Center(
                    child: Image.network(
                      'https://www.mavachvietnam.com/wp-content/uploads/2014/08/-barcode_32896.jpg',
                      fit: BoxFit.contain,
                    ),
                  ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Return button
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);  
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text("Return"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTicketDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
