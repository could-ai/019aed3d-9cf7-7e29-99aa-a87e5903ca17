import 'package:flutter/material.dart';

class AvatarScreen extends StatelessWidget {
  const AvatarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Avatar'),
        actions: [
          IconButton(icon: const Icon(Icons.history), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          // Avatar Preview Area
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF2B2D31), Color(0xFF191B1D)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Simple Blocky Avatar Representation using Containers
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // Body
                      Container(
                        width: 100,
                        height: 120,
                        color: Colors.blue[700],
                      ),
                      // Head
                      Positioned(
                        top: -50,
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFE0BD), // Skin tone
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(width: 8, height: 8, color: Colors.black), // Eye
                                Container(width: 8, height: 8, color: Colors.black), // Eye
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Left Arm
                      Positioned(
                        left: -35,
                        top: 0,
                        child: Container(
                          width: 30,
                          height: 100,
                          color: const Color(0xFFFFE0BD),
                        ),
                      ),
                      // Right Arm
                      Positioned(
                        right: -35,
                        top: 0,
                        child: Container(
                          width: 30,
                          height: 100,
                          color: const Color(0xFFFFE0BD),
                        ),
                      ),
                      // Left Leg
                      Positioned(
                        bottom: -100,
                        left: 15,
                        child: Container(
                          width: 30,
                          height: 100,
                          color: Colors.green[800],
                        ),
                      ),
                      // Right Leg
                      Positioned(
                        bottom: -100,
                        right: 15,
                        child: Container(
                          width: 30,
                          height: 100,
                          color: Colors.green[800],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 120), // Spacing for legs
                ],
              ),
            ),
          ),
          // Customization Options
          Expanded(
            flex: 2,
            child: Container(
              color: const Color(0xFF232527),
              child: ListView(
                children: [
                  _buildOptionTile(Icons.checkroom, 'Clothing'),
                  _buildOptionTile(Icons.face, 'Body'),
                  _buildOptionTile(Icons.animation, 'Animations'),
                  _buildOptionTile(Icons.shopping_bag, 'Shop'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionTile(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: () {},
    );
  }
}
