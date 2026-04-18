import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:google_fonts/google_fonts.dart';

class GPAHome extends StatefulWidget {
  const GPAHome({super.key});

  @override
  State<GPAHome> createState() => _GPAHomeState();
}

class _GPAHomeState extends State<GPAHome> {

  List<TextEditingController> gradeControllers = [TextEditingController()];
  List<TextEditingController> creditControllers = [TextEditingController()];
  
  double totalGPA = 0.0;
  String status = "Add subjects to begin";

  final AudioPlayer _audioPlayer = AudioPlayer();

  void _addNewSubject() {
    setState(() {
      gradeControllers.add(TextEditingController());
      creditControllers.add(TextEditingController());
    });
  }

  void calculateTotalGPA() {
    double totalPoints = 0.0;
    double totalCredits = 0.0;

    for (int i = 0; i < gradeControllers.length; i++) {
      double g = double.tryParse(gradeControllers[i].text) ?? 0.0;
      double c = double.tryParse(creditControllers[i].text) ?? 0.0;
      totalPoints += (g * c);
      totalCredits += c;
    }

    setState(() {
      if (totalCredits > 0) {
        totalGPA = totalPoints / totalCredits;
        if (totalGPA >= 3.75) {
          status = "Excellent (Dean's List)";
        } else if (totalGPA >= 2.0) {
          status = "Good Standing";
        } else {
          status = "Needs Improvement";
        }
      } else {
        totalGPA = 0.0;
        status = "Please enter valid credits";
      }
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('UUM GPU Calculator', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to UUM GPU Calculator', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),),
            const SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () async {
                await _audioPlayer.play(AssetSource('audio/welcome.mp3'));
              }, 
              child: Text('Play Welcome Audio', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),),
            ),
          ],
        ),
      ),
    );
  }
}



