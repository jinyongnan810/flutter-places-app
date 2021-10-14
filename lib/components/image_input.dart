import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  const ImageInput({Key? key}) : super(key: key);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;
  ImagePicker _imagePicker = ImagePicker();

  Future<void> _pickImage() async {
    XFile? image =
        await _imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);
    if (image != null) {
      print('file path: ${image.path}');
      setState(() {
        _storedImage = File(image.path);
      });
      final appDir = await syspaths.getApplicationDocumentsDirectory();
      final fileName = path.basename(image.path);
      final filePath = '${appDir.path}/$fileName';
      final savedImage = await image.saveTo(filePath);
      print('file saved to: $filePath');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
              border:
                  Border.all(width: 1, color: Theme.of(context).accentColor),
              borderRadius: BorderRadius.all(Radius.circular(5))),
          alignment: Alignment.center,
          child: _storedImage == null
              ? Text('No Image')
              : Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
            child: TextButton.icon(
          onPressed: () {
            _pickImage();
          },
          label: Text('Take Picture'),
          icon: Icon(Icons.camera),
        ))
      ],
    );
  }
}
