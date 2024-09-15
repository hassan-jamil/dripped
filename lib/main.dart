import 'dart:async';

import 'package:flutter/material.dart';

import 'loginpage.dart';
import 'sighup.dart';

void main() {
  runApp(TravelApp());
}

class TravelApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
      // Set SplashScreen as the initial page
      routes: {
        '/BoardingPage': (context) => BoardingPage(),
        // Define the route for BoardingPage
        '/MainPage': (context) => MainPage(),
        // Define the route for MainPage
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller and animation
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();

    // Navigate to the boarding screen after a delay
    Timer(Duration(seconds: 4), () {
      Navigator.of(context).pushReplacementNamed('/BoardingPage');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Image.asset(
            'assets/images/applogo.png',
            width: 200,
            height: 200,
          ),
        ),
      ),
    );
  }
}

class BoardingPage extends StatefulWidget {
  @override
  _BoardingPageState createState() => _BoardingPageState();
}

class _BoardingPageState extends State<BoardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      final page = _pageController.page?.round() ?? 0;
      if (_currentPage != page) {
        setState(() {
          _currentPage = page;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNextPressed() {
    if (_currentPage == 2) {
      // Navigate to the MainPage when "Get Started" is pressed
      Navigator.pushReplacementNamed(context, '/MainPage');
    } else {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: [
              _buildPage(
                title: 'Explore the World',
                description: '',
                imagePath:
                    'assets/images/1200px-Shangrila_resort_skardu.jpg', // Replace with your image path
              ),
              _buildPage(
                title: 'Easy Booking',
                description: '',
                imagePath:
                    'assets/images/Neeulm_Valley_AJK_(Arang_Kel).jpg', // Replace with your image path
              ),
              _buildPage(
                title: 'Stay Organized',
                description: '',
                imagePath:
                    'assets/images/premium_photo-1664547606209-fb31ec979c85.jpg', // Replace with your image path
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      // Skip to MainPage directly
                      Navigator.pushReplacementNamed(context, '/MainPage');
                    },
                    child: Text('Skip', style: TextStyle(color: Colors.blue)),
                  ),
                  TextButton(
                    onPressed: _onNextPressed,
                    child: Text(
                      _currentPage == 2 ? 'Get Started' : 'Next',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage({
    required String title,
    required String description,
    required String imagePath,
  }) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(height: 24),
          Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          Text(
            description,
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/premium_photo-1664547606209-fb31ec979c85.jpg'),
            // Background image
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 80.0,
        ), // Padding around buttons
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200, // Set button width
              height: 50, // Set button height
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          LoginPage(), // Navigate to LoginPage
                    ),
                  );
                },
                child: Text('Login'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white70, // Button background color
                  textStyle: TextStyle(fontSize: 18), // Button text style
                ),
              ),
            ),
            SizedBox(height: 30), // Space between buttons
            Container(
              width: 200, // Set button width
              height: 50, // Set button height
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SignUpPage(), // Navigate to SignUpPage
                    ),
                  );
                },
                child: Text('Signup'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white70, // Button background color
                  textStyle: TextStyle(fontSize: 18), // Button text style
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
