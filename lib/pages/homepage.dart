
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Row(
            children: [
              Text(
                'SheSecure',
                style: GoogleFonts.mansalva(
                  fontSize: 32,
                ),
              )
            ],
          ),
          elevation:
              defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
          backgroundColor: const Color.fromARGB(255, 167, 76, 106)),
      body: const Center(child: Text("SheSEcure")),
      
      drawer:NavBar(),
    )
    );
  }
}