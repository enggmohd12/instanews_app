import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

Future<File> convertURLtoFile(String strURL) async {
  final uri = Uri.parse(strURL);
  final http.Response responseData = await http.get(uri);
  Uint8List uint8list = responseData.bodyBytes;
  var buffer = uint8list.buffer;
  ByteData byteData = ByteData.view(buffer);
  var tempDir = await getTemporaryDirectory();
  File file = File('${tempDir.path}/img');

  // Check if the file exists and delete it
  if (await file.exists()) {
    await file.delete();
  }

  // Create the new file with the data
  file = await file.writeAsBytes(buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  return file;
}
