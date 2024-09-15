import 'package:flutter/material.dart';

import 'destinationpage.dart';
import 'main.dart';
import 'tripplanner.dart';

void main() {
  runApp(TravelApp());
}

class TravelApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Track the selected index for bottom navigation

  // List of widgets for each bottom navigation tab
  final List<Widget> _pages = [
    HomePageContent(), // The content of your HomePage
    TripPlannerPage(), // Trip Planner page
    MainPage(),
  ];

  // This function is called when a bottom navigation tab is tapped
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: _pages[_selectedIndex], // Display the selected page content
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        // Set the current selected index
        onTap: _onItemTapped,
        // Call when a tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Trip Planner',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
        ],
        selectedItemColor: Colors.blue,
        // Color for selected item
        unselectedItemColor: Colors.grey, // Color for unselected items
      ),
    );
  }
}

// HomePage Content (Separation of concerns for clean structure)
class HomePageContent extends StatelessWidget {
  final List<Map<String, String>> popularDestinations = [
    {
      'name': 'Skardu',
      'image': 'assets/images/1200px-Shangrila_resort_skardu.jpg'
    },
    {
      'name': 'Neelum Valley',
      'image': 'assets/images/Neeulm_Valley_AJK_(Arang_Kel).jpg'
    },
    {'name': 'Naran', 'image': 'assets/images/naran-is-a-small-town.jpg'},
    {
      'name': 'Hunza Valley',
      'image': 'assets/images/HUNZA-BLOG-PIC-1-1024x768.webp'
    },
    {'name': 'Fairy Meadows', 'image': 'assets/images/5ddb799b370e9.jpg'},
    {
      'name': 'Babusar Top',
      'image':
          'assets/images/babusar-top-travel-guide-height-temperature-details.webp'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),

              // Promotion Section
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                height: 300,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    promoCard('Summer Sale', 'assets/images/neelum-valley.jpg'),
                    promoCard('Winter Escape', 'assets/images/Nathiagali.jpg'),
                    promoCard('Luxury Deals', 'assets/images/mountain.jpg'),
                  ],
                ),
              ),

              // Popular Destinations Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Popular Destinations',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors
                        .black, // Ensure the text is visible on background
                  ),
                ),
              ),
              SizedBox(height: 10),

              // Grid for Popular Destinations
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  // Prevents scrolling within the grid
                  shrinkWrap: true,
                  // Allows the grid to take the size of its content
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns in the grid
                    crossAxisSpacing: 10.0, // Spacing between columns
                    mainAxisSpacing: 10.0, // Spacing between rows
                    childAspectRatio: 1 / 1, // Aspect ratio for the grid items
                  ),
                  itemCount: popularDestinations.length,
                  itemBuilder: (context, index) {
                    return destinationCard(
                      context, // Pass context to destinationCard
                      popularDestinations[index]['name']!,
                      popularDestinations[index]['image']!,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Promo Card Widget
  Widget promoCard(String title, String imagePath) {
    return Container(
      width: 300,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0.6),
              Colors.black.withOpacity(0.1)
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // Destination Card Widget
  Widget destinationCard(
      BuildContext context, String destinationName, String imagePath) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DestinationPage(
              destinationName: destinationName,
              destinationImage: imagePath,
              description:
                  'Beautiful Place $destinationName', // Add a real description here
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.6),
                Colors.black.withOpacity(0.1)
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              destinationName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
