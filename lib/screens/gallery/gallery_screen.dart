import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:brain_buddy/widgets/main_screen_com.dart';
import 'package:brain_buddy/config/app_color.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final List<File> _images = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _images.add(File(pickedFile.path));
      });
    }
  }

  void _deleteImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  void _updateImage(int index) async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _images[index] = File(pickedFile.path);
      });
    }
  }

  void _showOptions(int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.delete, color: Color.fromARGB(255, 211, 26, 13)),
            title: const Text('Delete Image'),
            onTap: () {
              Navigator.pop(context);
              _deleteImage(index);
            },
          ),
          ListTile(
            leading: const Icon(Icons.update, color: Color.fromARGB(255, 13, 91, 155)),
            title: const Text('Update Image'),
            onTap: () {
              Navigator.pop(context);
              _updateImage(index);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainScreenCom(
      children: [
        const SizedBox(height: 20),
        _buildPickButtons(),
        const SizedBox(height: 20),
        _buildGalleryGrid(),
      ],
    );
  }

  Widget _buildPickButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildActionButton(Icons.camera_alt, "Camera" , () => _pickImage(ImageSource.camera),),
        _buildActionButton(Icons.photo, "Gallery", () => _pickImage(ImageSource.gallery)),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label, VoidCallback onTap) {
    return Column(
      children: [
        Ink(
          decoration: const ShapeDecoration(
            color: AppColors.secondary,
            shape: CircleBorder(),
          ),
          child: IconButton(
            icon: Icon(icon, color: Colors.white),
            iconSize: 32,
            onPressed: onTap,
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.w400)),
      ],
    );
  }

  Widget _buildGalleryGrid() {
    if (_images.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.only(top: 50),
          child: Text("No images yet!", style: TextStyle(color: AppColors.primary, fontSize: 18, fontWeight: FontWeight.w600,) ),
        ),
      );
    } else {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.7,
        child: GridView.builder(
          padding: const EdgeInsets.all(8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: _images.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onLongPress: () => _showOptions(index),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  _images[index],
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
