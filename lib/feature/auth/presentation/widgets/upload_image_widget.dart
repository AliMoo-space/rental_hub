import 'dart:io';

import 'package:flutter/material.dart';

class UploadImageWidget extends StatelessWidget {
  final File? imageFile;
  final String? errorText;
  final VoidCallback onTap;

  const UploadImageWidget({
    super.key,
    required this.imageFile,
    required this.onTap,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                color: errorText != null ? Colors.red : Colors.grey,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                const Icon(Icons.upload),
                const SizedBox(width: 10),

                Expanded(
                  child: Text(
                    imageFile == null
                        ? 'Upload Image'
                        : imageFile!.path.split('/').last,
                  ),
                ),
              ],
            ),
          ),
        ),

        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(errorText!, style: const TextStyle(color: Colors.red)),
          ),
      ],
    );
  }
}
