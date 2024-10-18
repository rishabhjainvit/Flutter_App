import 'package:flutter/material.dart';
import 'program_list_screen.dart'; 
import 'program_details_screen.dart'; 
import 'audio_player_screen.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Programs App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => ProgramListScreen(),
        '/details': (context) => ProgramDetailsScreen(programId: 'sampleId'), // Pass required arguments here
        '/audio': (context) => AudioPlayerScreen(audioUrl: 'sampleUrl'), // Pass required arguments here
      },
    );
  }
}
