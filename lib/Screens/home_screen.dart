import 'package:flutter/material.dart';
import 'package:internshala/Model/post_model.dart';

import '../Api Service/api_service.dart';
import 'filter_screen.dart';

class HomeScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        centerTitle: true,
        flexibleSpace: Center(
          child: FilterButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FilterScreen()),
              );
            },
          ),
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 100),
            child: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(),
                );
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 100),
            child: IconButton(
              icon: Icon(Icons.save),
              onPressed: () {},
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 100),
            child: IconButton(
              icon: Icon(Icons.message),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: FutureBuilder<PostModel>(
        future: ApiService.fetchPostModel(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final postModel = snapshot.data!;
            return ListView.builder(
              itemCount: postModel.internshipIds.length,
              itemBuilder: (context, index) {
                final internshipId = postModel.internshipIds[index];
                final internMeta =
                    postModel.internshipsMeta[internshipId.toString()];
                return ListTile(
                  title: Text(
                    internMeta?.title ?? 'Title not available',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Company: ${internMeta?.companyName ?? 'Company name not available'}'),
                      Text(
                          'Location: ${internMeta?.locations.map((e) => e?.locationName).join(", ") ?? 'Location not available'}'),
                      Text(
                          'Start Date: ${internMeta?.startDate ?? 'Start date not available'}'),
                      Text(
                          'Duration: ${internMeta?.duration ?? 'Duration not available'}'),
                      Text(
                          'Stipend: ${internMeta?.stipend?.salary ?? 'Stipend not available'}'),
                      Text(
                          'Posted On: ${internMeta?.postedOn ?? 'Posted on date not available'}'),
                      // Add more elements here
                      Text(
                          'Employment Type: ${internMeta?.employmentType ?? 'Employment type not available'}'),
                      Text(
                          'Premium: ${internMeta?.isPremium ?? 'Premium status not available'}'),
                      Text(
                          'Premium Internship: ${internMeta?.isPremiumInternship ?? 'Premium internship status not available'}'),
                      // Add more elements as needed
                      Text(
                          'Application Status: ${internMeta?.applicationStatusMessage?.message ?? 'Application status not available'}'),
                      Text(
                          'Job Title: ${internMeta?.jobTitle ?? 'Job title not available'}'),
                      Text(
                          'Work From Home: ${internMeta?.workFromHome ?? 'Work from home status not available'}'),
                      // Add more elements as needed
                      Text(
                          'Segment: ${internMeta?.segment ?? 'Segment not available'}'),
                      Text(
                          'Segment Label Value: ${internMeta?.segmentLabelValue ?? 'Segment label value not available'}'),
                      // Add more elements as needed
                      Text(
                          'Company URL: ${internMeta?.companyUrl ?? 'Company URL not available'}'),
                      Text(
                          'Employer Name: ${internMeta?.employerName ?? 'Employer name not available'}'),
                      Text('Type: ${internMeta?.type ?? 'Type not available'}'),
                      // Add more elements as needed
                    ],
                  ),
                  // Customize ListTile with other properties as needed
                );
              },
            );
          }
        },
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final VoidCallback onPressed;

  const FilterButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50),
      width: 120,
      height: 50,
      child: FloatingActionButton.extended(
        onPressed: onPressed,
        label: Text(
          'Filter',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        icon: Icon(Icons.filter_list),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Implement suggestions UI based on search query
    return Container();
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implement search results UI based on search query
    return Container();
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }
}
