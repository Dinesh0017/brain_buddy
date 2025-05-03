import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:brain_buddy/widgets/main_screen_com.dart';
import 'package:brain_buddy/config/app_color.dart';
import 'package:brain_buddy/models/note_model.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final List<Note> _notes = [];
  final ImagePicker _picker = ImagePicker();

  void _addOrEditNote({Note? existingNote, int? index}) async {
    String? noteText = existingNote?.text;
    File? noteImage = existingNote?.image;
    final TextEditingController _controller = TextEditingController(
      text: noteText,
    );

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.background.withOpacity(0.9),
          title: Text(
            existingNote != null ? 'Edit Note' : 'Add Note',
            style: const TextStyle(color: AppColors.primary),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _controller,
                  maxLines: 3,
                  cursorColor: AppColors.primary,
                  decoration: const InputDecoration(
                    hintText: "Enter note text",
                    hintStyle: TextStyle(color: Colors.grey),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primary),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primary,
                        width: 2,
                      ),
                    ),
                  ),
                  style: const TextStyle(color: AppColors.primary),
                ),
                const SizedBox(height: 10),
                if (noteImage != null)
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(noteImage!),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.red),
                        onPressed: () {
                          setState(() => noteImage = null);
                          Navigator.pop(context);
                          _addOrEditNote(
                            existingNote: existingNote,
                            index: index,
                          );
                        },
                      ),
                    ],
                  )
                else
                  ElevatedButton.icon(
                    onPressed: () async {
                      final XFile? pickedFile = await _picker.pickImage(
                        source: ImageSource.gallery,
                      );
                      if (pickedFile != null) {
                        noteImage = File(pickedFile.path);
                      }
                    },
                    icon: const Icon(Icons.image, color: AppColors.primary),
                    label: const Text(
                      "Add Image",
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                noteText = _controller.text.trim();
                Navigator.pop(context);
              },
              child: const Text(
                'Save',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );

    if ((noteText != null && noteText!.isNotEmpty) || noteImage != null) {
      setState(() {
        if (existingNote != null && index != null) {
          _notes[index] = Note(
            text: noteText,
            image: noteImage,
            isImportant: existingNote.isImportant,
          );
        } else {
          _notes.add(Note(text: noteText, image: noteImage));
        }
      });
    }
  }

  void _deleteNote(int index) {
    setState(() {
      _notes.removeAt(index);
    });
  }

  void _toggleImportant(int index) {
    setState(() {
      _notes[index].isImportant = !_notes[index].isImportant;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MainScreenCom(
          children: [
            const SizedBox(height: 20),
            ..._notes
                .asMap()
                .entries
                .map((entry) => _buildNoteCard(entry.key, entry.value))
                .toList(),
            const SizedBox(height: 100),
          ],
        ),
        _buildAddNoteButton(() => _addOrEditNote()),
      ],
    );
  }

  Widget _buildAddNoteButton(VoidCallback onTap) {
    return Positioned(
      bottom: 120,
      right: 30,
      child: FloatingActionButton(
        onPressed: onTap,
        backgroundColor: AppColors.secondary,
        child: const Icon(Icons.add, size: 30, color: Colors.white),
      ),
    );
  }

  Widget _buildNoteCard(int index, Note note) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.secondary.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (note.text != null && note.text!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(right: 18),
                  child: Text(
                    note.text!,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 16,
                    ),
                  ),
                ),
              if (note.image != null) ...[
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(note.image!),
                ),
              ],
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: AppColors.primary),
                    onPressed:
                        () => _addOrEditNote(existingNote: note, index: index),
                  ),
                  const SizedBox(width: 3),
                  IconButton(
                    icon: const Icon(Icons.delete, color: AppColors.primary),
                    onPressed: () => _deleteNote(index),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: -15,
            right: -15,
            child: IconButton(
              icon: Icon(
                note.isImportant ? Icons.star : Icons.star_border_outlined,
                color: note.isImportant ? Colors.amber : Colors.white,
              ),
              onPressed: () => _toggleImportant(index),
              splashRadius: 5,
            ),
          ),
        ],
      ),
    );
  }
}
