import 'package:flutter/material.dart';
import 'dart:convert'; // For base64 encoding and decoding
import 'dart:typed_data'; // For Uint8List
import 'package:flutter/services.dart' show rootBundle; // For loading assets

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Base64 Image from File'),
        ),
        body: Center(
          // child: Text('Simple text'),
          child: FutureBuilder(
            future: loadBase64Image(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                Uint8List bytes = snapshot.data as Uint8List;
                return Image.memory(bytes);
              } else {
                return Text('No image found');
              }
            },
          ),
        ),
      ),
    );
  }

  Future<Uint8List> loadBase64Image() async {
    try {
      // Load the text file containing the Base64 string
      String base64String = await rootBundle.loadString('../assets/gg.txt');

      
      // Decode the Base64 string to bytes
      Uint8List bytes = base64Decode(base64String);
      
      return bytes;
    } catch (e) {
      throw Exception("Error loading image: $e");
    }
  }
}
