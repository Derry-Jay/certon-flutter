import 'dart:io';
import 'helper.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class Utils {
  Future<Document> createPDF(List<XFile> images) async {
    Document pdf = Document();
    List<File> imageFiles = <File>[];
    Widget pageBuilder(Context context) {
      Widget getPic(File e) {
        final image = MemoryImage(e.readAsBytesSync());
        log(getImageDimensions(image));
        return Image(image, dpi: image.dpi
            // ,
            // width: image.width?.toDouble(),
            // height: image.height?.toDouble()
            );
      }

      return GridView(
          crossAxisCount: 3,
          // padding: imageFiles.length < 10 ? EdgeInsets.zero : const EdgeInsets.symmetric(horizontal: 8),
          children: imageFiles.map<Widget>(getPic).toList(),
          childAspectRatio: 1.5625);
    }

    for (XFile image in images) {
      imageFiles.add(File(image.path));
    }
    log(imageFiles);
    pdf.addPage(Page(pageFormat: PdfPageFormat.a4, build: pageBuilder));
    log(await pdf.save());
    return pdf;
  }

  Future<File> savePDF(Document pdf) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/filename.pdf');
      final bf = await file.writeAsBytes(await pdf.save());
      log(bf.path);
      return bf;
    } catch (e) {
      sendAppLog(e);
      return File('filename.pdf');
    }
  }

  List<double> getImageDimensions(ImageProvider image) {
    return <double>[
      image.height?.toDouble() ?? 0.0,
      image.width?.toDouble() ?? 0.0
    ];
  }
}
