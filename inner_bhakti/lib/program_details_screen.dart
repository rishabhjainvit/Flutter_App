import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProgramDetailsScreen extends StatelessWidget {
  final String programId;

  const ProgramDetailsScreen({Key? key, required this.programId}) : super(key: key);

  Future<Map<String, dynamic>> fetchProgramDetails() async {
    try {
      var response = await http.get(Uri.parse('http://localhost:3000/programs/$programId'));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load program details');
      }
    } catch (e) {
      throw Exception('Error fetching program details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Program Details')),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchProgramDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No data found.'));
          }

          var program = snapshot.data!;
          if (!program.containsKey('details') || program['details'] == null) {
            return const Center(child: Text('No program details available.'));
          }

          return ListView.builder(
            itemCount: program['details'].length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(program['details'][index].toString()),
              );
            },
          );
        },
      ),
    );
  }
}
