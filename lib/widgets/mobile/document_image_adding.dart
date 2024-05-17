import 'dart:io';
import '../../helpers/helper.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:image_picker/image_picker.dart';

class DocumentImageFormWidget extends StatefulWidget {
  const DocumentImageFormWidget({Key? key}) : super(key: key);

  @override
  DocumentImageFormWidgetState createState() => DocumentImageFormWidgetState();
}

class DocumentImageFormWidgetState extends StateMVC<DocumentImageFormWidget> {
  Helper get hp => Helper.of(context);
  ImagePicker picker = ImagePicker();
  List<XFile> imagesList = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: (imagesList.isEmpty)
            ? Image.asset('${assetImagePath}logo.png',
                fit: BoxFit.contain,
                width: double.infinity,
                errorBuilder: errorBuilder,
                // frameBuilder: hp.getFrameBuilder,
                height: 150)
            : Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black26)),
                height: imagesList.length * 250,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext ctx, int index) {
                    //  return bulkImageshandling(index,imagesList);
                    return Image.file(File(imagesList[index].path),
                        width: 350, height: 250, fit: BoxFit.contain);
                  },
                  itemCount: imagesList.length,
                ),
              ),
        onTap: () async {
          // _show(context);
        });
  }
}
