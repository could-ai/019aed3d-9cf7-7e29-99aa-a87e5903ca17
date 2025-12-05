import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class GamePlayerScreen extends StatefulWidget {
  final String gameTitle;

  const GamePlayerScreen({super.key, required this.gameTitle});

  @override
  State<GamePlayerScreen> createState() => _GamePlayerScreenState();
}

class _GamePlayerScreenState extends State<GamePlayerScreen> {
  // Game State
  bool isPlaying = false;
  double playerY = 0;
  double time = 0;
  double height = 0;
  double initialHeight = 0;
  bool isJumping = false;
  
  // Obstacle State
  double obstacleX = 2; // Starts off screen (1 is right edge, -1 is left edge)
  int score = 0;
  Timer? gameLoopTimer;

  void startGame() {
    setState(() {
      isPlaying = true;
      score = 0;
      obstacleX = 2;
      playerY = 0;
      time = 0;
      height = 0;
      initialHeight = 0;
    });

    gameLoopTimer = Timer.periodic(const Duration(milliseconds: 20), (timer) {
      setState(() {
        // Move Obstacle
        obstacleX -= 0.02;
        if (obstacleX < -2) {
          obstacleX = 2;
          score++;
        }

        // Jump Physics
        if (isJumping) {
          time += 0.02;
          height = -4.9 * time * time + 3.5 * time; // Physics formula
          playerY = initialHeight - height;

          // Check if landed
          if (playerY > 0) {
            isJumping = false;
            playerY = 0;
            time = 0;
          }
        }

        // Collision Detection
        // Player X is roughly -0.5. Obstacle is at obstacleX.
        // If obstacle is near player AND player is on ground (y > -0.2 roughly)
        if (obstacleX < -0.3 && obstacleX > -0.7 && playerY > -0.2) {
          gameOver();
        }
      });
    });
  }

  void jump() {
    if (!isJumping) {
      isJumping = true;
      initialHeight = playerY;
      time = 0;
    }
  }

  void gameOver() {
    gameLoopTimer?.cancel();
    setState(() {
      isPlaying = false;
    });
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF232527),
        title: const Text('OOF!', style: TextStyle(color: Colors.white)),
        content: Text('Game Over. Score: $score', style: const TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              startGame();
            },
            child: const Text('Try Again', style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Exit game screen
            },
            child: const Text('Leave Game', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    gameLoopTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[300], // Sky color
      body: Stack(
        children: [
          // Background / Sky
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue, Colors.lightBlueAccent],
                ),
              ),
            ),
          ),
          
          // Ground
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.2,
              color: Colors.green[700],
            ),
          ),

          // Player (Roblox Noob Style)
          AnimatedContainer(
            duration: const Duration(milliseconds: 0),
            alignment: Alignment( -0.5, playerY + 0.6), // Adjust Y to sit on ground
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.yellow,
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: const Center(
                child: Text(":)", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ),

          // Obstacle
          AnimatedContainer(
            duration: const Duration(milliseconds: 0),
            alignment: Alignment(obstacleX, 0.6), // Ground level
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),

          // UI Overlay
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      widget.gameTitle,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Score: $score',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ),

          // Start Screen Overlay
          if (!isPlaying)
            Container(
              color: Colors.black87,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.play_circle_fill, size: 80, color: Colors.green),
                    const SizedBox(height: 20),
                    Text(
                      'Welcome to ${widget.gameTitle}',
                      style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Tap to Jump over the red blocks!',
                      style: const TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      ),
                      onPressed: startGame,
                      child: const Text('PLAY', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ),
            
          // Jump Control (Invisible touch area)
          if (isPlaying)
            GestureDetector(
              onTap: jump,
              child: Container(
                color: Colors.transparent,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
        ],
      ),
    );
  }
}
