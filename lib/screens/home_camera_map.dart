import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_app/screens/daftar_plant.dart';
import 'package:plant_app/screens/kamera/camera_page.dart';
import 'package:plant_app/screens/kamera/helper/storage_helper.dart';
import 'package:plant_app/screens/map/map_page.dart';

const kPrimaryColor = Color(0xFF0C9869);

class HomeCameraMap extends StatefulWidget {
  const HomeCameraMap({super.key});

  @override
  State<HomeCameraMap> createState() => _HomeCameraMapState();
}

class _HomeCameraMapState extends State<HomeCameraMap> {
  final _formKey = GlobalKey<FormState>();
  File? _imageFile;
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _jenisController = TextEditingController();

  String? alamatDipilih;

  @override
  void dispose() {
    _namaController.dispose();
    _jenisController.dispose();
    super.dispose();
  }

  Future<void> _requestPermissions() async {
    await Permission.camera.request();
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();
  }

  Future<void> _takePicture() async {
    await _requestPermissions();
    final File? result = await Navigator.push<File?>(
      context,
      MaterialPageRoute(builder: (_) => const CameraPage()),
    );
    if (result != null) {
      final saved = await StorageHelper.saveImage(result, 'camera');
      setState(() => _imageFile = saved);
      ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Disimpan: ${saved.path}')));
    }
  }

  Future<void> _pickFromGallery() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final saved = await StorageHelper.saveImage(File(picked.path), 'gallery');
      setState(() => _imageFile = saved);
      ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Disalin: ${saved.path}')));
    }
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Data Tumbuhan'),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        backgroundColor: kPrimaryColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.camera, color: Colors.lightBlueAccent,),
                      label: const Text('Ambil Foto', style: TextStyle(color: Colors.white),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      onPressed: _takePicture,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.folder, color: Colors.lightBlueAccent,),
                      label: Text('Galeri', style: TextStyle(color: Colors.white),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      onPressed: _pickFromGallery,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              if (_imageFile != null)
                Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        _imageFile!,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Disimpan di:\n${_imageFile!.path}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12)),
                    const SizedBox(height: 8),
                    OutlinedButton.icon(
                      icon: Icon(Icons.delete, color: Colors.red),
                      label: Text('Hapus Gambar', style: TextStyle(color: Colors.red)),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () async {
                        await _imageFile?.delete();
                        setState(() => _imageFile = null);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Gambar dihapus')),
                        );
                      },
                    ),
                  ],
                )
              else
                const Text('Belum ada gambar diambil/dipilih.', style: TextStyle(fontStyle: FontStyle.italic)),
              SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Text(
                        'Biodata Tumbuhan',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    const Text('Nama Tumbuhan'),
                    TextFormField(
                      controller: _namaController,
                      decoration: InputDecoration(
                        hintText: 'Masukkan Nama Tumbuhan',
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: kPrimaryColor, width: 2),
                        ),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) =>
                        value == null || value.isEmpty ? 'Nama tidak boleh kosong' : null,
                    ),
                    const SizedBox(height: 16),
                    const Text('Jenis Tumbuhan'),
                    TextFormField(
                      controller: _jenisController,
                      decoration: InputDecoration(
                        hintText: 'Masukkan Jenis Tumbuhan',
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: kPrimaryColor, width: 2),
                        ),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) =>
                        value == null || value.isEmpty ? 'Jenis tidak boleh kosong' : null,
                    ),
                    const SizedBox(height: 20),
                    const Text('🗺️ Pilih Lokasi Tumbuhan', style: TextStyle(fontWeight: FontWeight.bold)),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.map, color: Colors.lightBlueAccent,),
                      label: const Text('Peta', style: TextStyle(color: Colors.white),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MapPage()),
                        );
                        if (result != null) {
                          setState(() => alamatDipilih = result);
                        }
                      },
                    ),
                    if (alamatDipilih != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text('Lokasi: $alamatDipilih',
                          style: const TextStyle(color: kPrimaryColor),
                        ),
                      ),
                    const SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_imageFile == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Silakan ambil atau pilih gambar terlebih dahulu')),
                            );
                            return;
                          }
                          if (_formKey.currentState!.validate()) {
                            if (alamatDipilih == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Pilih lokasi terlebih dahulu')),
                              );
                              return;
                            }
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DaftarPlant(
                                  nama: _namaController.text,
                                  jenis: _jenisController.text,
                                  lokasi: alamatDipilih!,
                                  image: _imageFile,
                                ),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'Simpan',
                          style: TextStyle(color: Colors.white),
                        ),
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