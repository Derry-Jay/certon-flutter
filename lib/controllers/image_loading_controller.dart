import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ImageLoadingController extends ControllerMVC {
  ImagePicker picker = ImagePicker();
  List<XFile> imagesList = [];
}
