import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:jlfastcred_core/jlfastcred_core.dart';

class DocumentBoxWidget extends StatefulWidget {
  const DocumentBoxWidget({
    super.key,
    required this.icon,
    required this.label,
    this.onFileSelected,
    this.allowedExtensions,
    // required this.uploaded,,
    // required this.totalFiles,
    // this.onTap,
  });

  final Widget icon;
  final Function(File)? onFileSelected;
  final String label;
  final List<String>? allowedExtensions;

  @override
  State<DocumentBoxWidget> createState() => _DocumentBoxWidgetState();
}

class _DocumentBoxWidgetState extends State<DocumentBoxWidget> {
  File? _selectedFile;

  Future<void> _onTap() async {
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
    return Expanded(
      child: InkWell(
        onTap: _onTap,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: _selectedFile != null
                ? JlfastcredTheme.lightOrangeColor
                : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: JlfastcredTheme.blueColor),
          ),
          child: Column(
            children: [
              Expanded(child: widget.icon),
              Text(
                widget.label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: JlfastcredTheme.blueColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
