import 'dart:io';
import 'package:hivemind_app/providers/hives.provider.dart';
import 'package:flutter/material.dart';
import 'package:hivemind_app/widgets/general/FilledBtn.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AnalysisTab extends StatefulWidget {
  const AnalysisTab({super.key});

  @override
  State<AnalysisTab> createState() => _AnalysisTabState();
}

class _AnalysisTabState extends State<AnalysisTab> {
  File? _selectedImage;
  String? result;
  bool isLoading = false;

  Future _pickImageFromGallery({required hiveId, required apiaryId}) async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImage = File(returnedImage!.path);
    });
    try {
      setState(() {
        isLoading = true;
        result = null;
      });
      final response = await Provider.of<Hives>(context, listen: false).predict(
          imagePath: returnedImage!.path, hiveId: hiveId, apiaryId: apiaryId);
      setState(() {
        isLoading = false;
        result = response;
      });
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Add Apiary failed: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arg =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    String hiveId = arg?["hiveId"];
    String apiaryId = arg?["apiaryId"];
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          spacing: 24,
          children: [
            Text(
              "AI will analyze uploaded media for pests detection.",
              style: Theme.of(context).textTheme.labelMedium,
              textAlign: TextAlign.center,
            ),
            FilledBtn(
              text: "Upload Image",
              onPress: () {
                _pickImageFromGallery(hiveId: hiveId, apiaryId: apiaryId);
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
