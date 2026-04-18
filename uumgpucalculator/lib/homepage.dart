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
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: Text('UUM GPU Calculator', 
        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.yellowAccent)),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),

              Text(
                "Dynamic Performance Tracker",
                style: GoogleFonts.robotoSlab(
                  fontSize: 22, 
                  fontWeight: FontWeight.bold,
                  color: Colors.black, 
                ),
              ),

              const Divider(height: 60),

              // INPUT 
              for (int i = 0; i < gradeControllers.length; i++)
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: _buildSubjectRow(
                    "Subject ${i + 1}" ,
                    gradeControllers[i], 
                    creditControllers[i],
                  ),
                ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _addNewSubject,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color.fromARGB(255, 146, 87, 87),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text('Add Another Subject'),
              ),

              const SizedBox(height: 20),
              
              ElevatedButton(
                onPressed: calculateTotalGPA,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[700],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text('Calculate GPA'),
              ),

              const Divider(height: 60, thickness: 2),

              // OUTPUT
              Text(
                "Overall GPA: ${totalGPA.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.teal[900]),
              ),
              const SizedBox(height: 10),
              Text(
                "Status: $status",
                style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
              ),

            ]
          )
        )
      )
    );
  }
}



