import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:brain_buddy/widgets/main_screen_com.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainScreenCom(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildActionButton(Icons.camera_alt, "Camera", () => _pickImage(ImageSource.camera)),
              _buildActionButton(Icons.photo, "Gallery", () => _pickImage(ImageSource.gallery)),
            ],
          ),
          const SizedBox(height: 20),
          // Use Flexible instead of Expanded
          Flexible(
            child: _images.isEmpty
                ? const Center(
                    child: Text(
                      "📷 No images yet!\nStart capturing memories.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : GridView.builder(
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
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            _images[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, VoidCallback onTap) {
    return Column(
      children: [
        Ink(
          decoration: const ShapeDecoration(
            color: Colors.pinkAccent,
            shape: CircleBorder(),
          ),
          child: IconButton(
            icon: Icon(icon, color: Colors.white),
            iconSize: 32,
            onPressed: onTap,
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.pinkAccent)),
      ],
    );
  }

  void _showOptions(int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.delete, color: Colors.red),
            title: const Text('Delete Image'),
            onTap: () {
              Navigator.pop(context);
              _deleteImage(index);
            },
          ),
          ListTile(
            leading: const Icon(Icons.update, color: Colors.blue),
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
}
