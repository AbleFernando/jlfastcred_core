import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class FileSelector extends StatefulWidget {
  final Function(File)? onFileSelected;
  final List<String>? allowedExtensions;
  final String buttonText;

  const FileSelector({
    Key? key,
    this.onFileSelected,
    this.allowedExtensions,
    this.buttonText = 'Selecionar Arquivo',
  }) : super(key: key);

  @override
  State<FileSelector> createState() => _FileSelectorState();
}

class _FileSelectorState extends State<FileSelector> {
  File? _selectedFile;

  Future<void> _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: widget.allowedExtensions,
    );

    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
      if (widget.onFileSelected != null) {
        widget.onFileSelected!(_selectedFile!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _selectFile,
      child: Container(
        color: Colors.grey[300],
        width: 150,
        height: 150,
        child: _selectedFile != null
            ? _buildPreviewWidget()
            : Center(child: Text(widget.buttonText)),
      ),
    );
  }

  Widget _buildPreviewWidget() {
    if (widget.allowedExtensions != null &&
            widget.allowedExtensions!.contains('jpg') &&
            widget.allowedExtensions!.contains('jpeg') &&
            widget.allowedExtensions!.contains('png') &&
            _selectedFile!.path.toLowerCase().endsWith('.jpg') ||
        _selectedFile!.path.toLowerCase().endsWith('.jpeg') ||
        _selectedFile!.path.toLowerCase().endsWith('.png')) {
      return Image.file(
        _selectedFile!,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      );
    } else if (widget.allowedExtensions != null &&
        widget.allowedExtensions!.contains('pdf') &&
        _selectedFile!.path.toLowerCase().endsWith('.pdf')) {
      return Image.asset(
        'assets/folder.png',
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      );
    } else {
      return const Center(child: Text('Preview não suportado'));
    }
  }
}
