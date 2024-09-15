import 'package:flutter/material.dart';

class DestinationPage extends StatelessWidget {
  final String destinationName;
  final String destinationImage;
  final String description;

  DestinationPage({
    required this.destinationName,
    required this.destinationImage,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(destinationName),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Destination Image
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(destinationImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 16),
          // Destination Name
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              destinationName,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 8),
          // Description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
          ),
          SizedBox(height: 16),
          // Key Attractions
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Key Attractions',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: ListView(
              children: [
                attractionCard('Beautiful Views'),
                attractionCard('Historic Sites'),
                attractionCard('Local Cuisine'),
                // Add more attractions as needed
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Attraction Card Widget
  Widget attractionCard(String attractionName) {
    return ListTile(
      leading: Icon(Icons.star, color: Colors.yellow),
      title: Text(attractionName),
    );
  }
}
