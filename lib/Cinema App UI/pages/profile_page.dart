import 'package:flutter/material.dart';
import 'package:flutter_ui_design/login_page.dart'; // Ensure the correct path to your login page

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: const Color(0xFF202020), // Dark background to match image
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.red),
            onPressed: () {
              // Add settings button functionality if needed
            },
          )
        ],
      ),
      body: Container(
        color: const Color(0xFF202020), // Dark background color
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile image and greeting
              const CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage('https://example.com/your_profile_image.jpg'), // Use a real image URL
              ),
              const SizedBox(height: 10),
              const Text(
                'Hi! User',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),

              // "My tickets", "My credit cards", "History" buttons
              _buildProfileOption(
                context,
                icon: Icons.local_activity,
                label: 'My tickets',
                onTap: () {
                  // Add navigation to My Tickets
                },
              ),
              _buildProfileOption(
                context,
                icon: Icons.credit_card,
                label: 'My credit cards',
                onTap: () {
                  // Add navigation to Credit Cards
                },
              ),
              _buildProfileOption(
                context,
                icon: Icons.history,
                label: 'History',
                onTap: () {
                  // Add navigation to History
                },
              ),
              const SizedBox(height: 30),

              // Change city, About us text options
              _buildTextOption(
                icon: Icons.location_city,
                label: 'Changes city',
                onTap: () {
                  // Add functionality for changing city
                },
              ),
              _buildTextOption(
                icon: Icons.info_outline,
                label: 'About us',
                onTap: () {
                  // Add navigation to About Us
                },
              ),

              const Spacer(),

              // Logout button
              ElevatedButton.icon(
                onPressed: () {
                  // Log out and navigate to login page
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const CustomLoginPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                icon: const Icon(Icons.logout, color: Colors.white),
                label: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget for building profile option buttons
  Widget _buildProfileOption(BuildContext context, {required IconData icon, required String label, required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A), // Dark gray button background
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, color: Colors.white),
                  const SizedBox(width: 10),
                  Text(
                    label,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget for text options like "Changes city", "About us"
  Widget _buildTextOption({required IconData icon, required String label, required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon, color: Colors.red),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
