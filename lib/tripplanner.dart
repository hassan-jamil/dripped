import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.black87),
        ),
      ),
      home: TripPlannerPage(),
    );
  }
}

class TripPlannerPage extends StatefulWidget {
  @override
  _TripPlannerPageState createState() => _TripPlannerPageState();
}

class _TripPlannerPageState extends State<TripPlannerPage> {
  final List<Map<String, dynamic>> _itineraries = [];
  final TextEditingController _dayController = TextEditingController();
  final TextEditingController _activityController = TextEditingController();

  void _addItinerary() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Itinerary',
              style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _dayController,
                decoration: InputDecoration(
                  labelText: 'Date',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              TextField(
                controller: _activityController,
                decoration: InputDecoration(
                  labelText: 'Activity',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.place),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                final day = _dayController.text;
                final activity = _activityController.text;
                if (day.isNotEmpty && activity.isNotEmpty) {
                  setState(() {
                    _itineraries.add({'day': day, 'activity': activity});
                  });
                  _dayController.clear();
                  _activityController.clear();
                }
                Navigator.pop(context);
              },
              child: Text('Add', style: TextStyle(color: Colors.blue)),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trip Planner'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addItinerary,
            tooltip: 'Add Itinerary',
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/f8f2e1ad9e7aacb1dc787796e8d6d8d3.jpg',
              // Replace with your image path
              fit: BoxFit.cover,
            ),
          ),
          // Foreground Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _itineraries.isEmpty
                ? Center(
                    child: Text(
                      'No added yet!',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  )
                : ListView.builder(
                    itemCount: _itineraries.length,
                    itemBuilder: (context, index) {
                      final itinerary = _itineraries[index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        elevation: 5,
                        child: ListTile(
                          contentPadding: EdgeInsets.all(16),
                          title: Text(
                            'Date ${itinerary['day']}: ${itinerary['activity']}',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                _itineraries.removeAt(index);
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
