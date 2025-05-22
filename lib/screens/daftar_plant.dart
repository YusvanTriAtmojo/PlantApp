import 'dart:io';
import 'package:flutter/material.dart';

class DaftarPlant extends StatelessWidget {
  final String nama;
  final String jenis;
  final String lokasi;
  final File? image;

  const DaftarPlant({
    super.key,
    required this.nama,
    required this.jenis,
    required this.lokasi,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Tumbuhan'), titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        backgroundColor:  Color(0xFF0C9869),
        iconTheme: IconThemeData(color: Colors.white), 
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20),
          height: 380,
          width: size.width * 0.8,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 10),
                blurRadius: 50,
                color: Color(0xFF0C9869).withAlpha(59),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (image != null)
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Image.file(
                    image!,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nama.toUpperCase(),
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Jenis Tanaman: $jenis',
                      style: textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      lokasi.toUpperCase(),
                      style: textTheme.bodyMedium?.copyWith(
                        color: Color(0xFF0C9869),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
