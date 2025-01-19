import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hivemind_app/widgets/general/FilledBtn.dart';
import 'package:image_picker/image_picker.dart';

class AnalysisTab extends StatefulWidget {
  const AnalysisTab({super.key});

  @override
  State<AnalysisTab> createState() => _AnalysisTabState();
}

class _AnalysisTabState extends State<AnalysisTab> {
  File? _selectedImage;
  String? result;
  bool isLoading = false;

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImage = File(returnedImage!.path);
    });
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse("http://192.168.0.100:5000/upload"));
      request.files
          .add(await http.MultipartFile.fromPath('image', returnedImage!.path));
      setState(() {
        isLoading = true;
        result = null;
      });
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        print("Image uploaded successfully!");
        setState(() {
          isLoading = false;
          result = responseBody;
        });
      } else {
        print("Image upload failed: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          spacing: 24,
          children: [
            Text(
              "AI will analyze uploaded media for pests or unusual activity.",
              style: Theme.of(context).textTheme.labelMedium,
              textAlign: TextAlign.center,
            ),
            FilledBtn(
              text: "Upload Image",
              onPress: () {
                _pickImageFromGallery();
              },
              icon: Icon(Icons.add_photo_alternate_outlined),
            ),
            _selectedImage != null
                ? SizedBox(
                    height: 200,
                    child: Image.file(
                      _selectedImage!,
                      fit: BoxFit.contain,
                    ),
                  )
                : Text("Please select an image."),
            isLoading ? CircularProgressIndicator() : SizedBox.shrink(),
            result != null
                ? Card(
                    color: Theme.of(context).cardColor,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        spacing: 10,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.smart_toy_outlined),
                          Text("AI Response: ${result!.trim()}",
                              style: Theme.of(context).textTheme.labelMedium),
                        ],
                      ),
                    ),
                  )
                : SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
