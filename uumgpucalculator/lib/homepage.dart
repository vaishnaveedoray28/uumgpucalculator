import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:google_fonts/google_fonts.dart';

class GPAHome extends StatefulWidget {
  const GPAHome({super.key});

  @override
  State<GPAHome> createState() => _GPAHomeState();
}

class _GPAHomeState extends State<GPAHome> {
  final player = AudioPlayer();
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
                await player.play(AssetSource('audio/welcome.mp3'));
              }, 
              child: Text('Play Welcome Audio', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),),
            ),
          ],
        ),
      ),
    );
  }
}



