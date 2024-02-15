import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List<String> selectedProfiles = [];
  List<String> selectedCities = [];
  String selectedDuration = '';

  List<String> profiles = ['Data Science Intern', 'Administration Intern', 'Android App Development Intern'];
  List<String> cities = ['Lucknow', 'Delhi', 'Gurgaon'];
  List<String> durations = ['1 Month', '2 Months', '3 Months'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
      ),
      body: ListView(
        padding: EdgeInsets.all(24),
        children: [
          Text(
            'Profile of Internship',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Column(
            children: profiles
                .map((profile) => CheckboxListTile(
              title: Text(profile),
              value: selectedProfiles.contains(profile),
              onChanged: (bool? value) {
                setState(() {
                  if (value!) {
                    selectedProfiles.add(profile);
                  } else {
                    selectedProfiles.remove(profile);
                  }
                });
              },
            ))
                .toList(),
          ),
          SizedBox(height: 24),
          Divider(),
          Text(
            'City of Internship',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Column(
            children: cities
                .map((city) => CheckboxListTile(
              title: Text(city),
              value: selectedCities.contains(city),
              onChanged: (bool? value) {
                setState(() {
                  if (value!) {
                    selectedCities.add(city);
                  } else {
                    selectedCities.remove(city);
                  }
                });
              },
            ))
                .toList(),
          ),
          SizedBox(height: 24),
          Divider(),
          Text(
            'Duration of Internship',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 16),
          DropdownButton<String>(
            value: selectedDuration.isEmpty ? null : selectedDuration,
            hint: Text('Select Duration'),
            onChanged: (newValue) {
              setState(() {
                selectedDuration = newValue!;
              });
            },
            items: durations
                .map<DropdownMenuItem<String>>(
                  (duration) => DropdownMenuItem<String>(
                value: duration,
                child: Text(duration),
              ),
            )
                .toList(),
          ),
          SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              // Pass selected filters back to the previous screen
              Navigator.pop(context, {
                'selectedProfiles': selectedProfiles,
                'selectedCities': selectedCities,
                'selectedDuration': selectedDuration,
              });
            },
            child: Text('Apply Filters'),
          ),
        ],
      ),
    );
  }
}
