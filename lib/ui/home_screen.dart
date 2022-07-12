import 'dart:io';

import 'package:dat_ocr/common/Constants.dart';
import 'package:dat_ocr/common/TypePick.dart';
import 'package:dat_ocr/ui/widget/widget_text_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../common/custom_grid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen> {
  List<XFile> imageFile = [];
  final ImagePicker _picker = ImagePicker();
  final List<TypePick> listTypePick = [];
  final listType = Constants().listData;

  @override
  void initState() {
    for (var type in listType.keys) {
      listTypePick.add(TypePick(type, false));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        // appBar: AppBar(
        //   backgroundColor: Colors.blue,
        //   title: const Text(
        //     "HomeScreen",
        //     textAlign: TextAlign.center,
        //   ),
        // ),
        body: SafeArea(
          top: true,
          bottom: true,
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              children: <Widget>[
                Container(
                    padding: const EdgeInsets.all(8),
                    child: const Text(
                      "Danh sách ảnh",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.orange,
                          fontWeight: FontWeight.bold),
                    ),
                    // decoration:  BoxDecoration(color: Colors.blueGrey[900]),
                    width: double.infinity),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) =>
                          _imageBuilder(context, index),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: imageFile.length + 1),
                ),
                Container(
                    padding: const EdgeInsets.all(8),
                    child: const Text(
                      "Chọn loại tài liệu",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.orange,
                          fontWeight: FontWeight.bold),
                    ),
                    // decoration:  BoxDecoration(color: Colors.blueGrey[900]),
                    width: double.infinity),
                Container(
                  padding: const EdgeInsets.all(16),
                  child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) =>
                          _typeBuilder(context, index),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                              crossAxisCount: 4,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              height: 48),
                      itemCount: listTypePick.length),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                    padding: const EdgeInsets.all(8),
                    child: const Text(
                      "Dữ liệu đọc",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.orange,
                          fontWeight: FontWeight.bold),
                    ),
                    // decoration:  BoxDecoration(color: Colors.blueGrey[900]),
                    width: double.infinity),
                _buildDataField(),
                FractionallySizedBox(
                  widthFactor: 0.9,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.orange)),
                    onPressed: () => _sendClick(),
                    child: const Text("Gửi xử lý"),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  ImageProvider _getImage(XFile? file) {
    if (file == null) {
      return const NetworkImage(
          'https://www.toponseek.com/blogs/wp-content/uploads/2019/06/toi-uu-hinh-anh-optimize-image-4-1200x900.jpg');
    } else {
      return FileImage(File(file.path));
    }
  }

//********************** IMAGE PICKER
  Future imageSelector(BuildContext context, String pickerType) async {
    switch (pickerType) {
      case "gallery":

        /// GALLERY IMAGE PICKER
        final result = await _picker.pickMultiImage(imageQuality: 90);
        if (result != null) {
          imageFile.addAll(result);
        }
        break;

      case "camera": // CAMERA CAPTURE CODE
        final file = await _picker.pickImage(
            source: ImageSource.camera, imageQuality: 90);
        if (file != null) {
          imageFile.add(file);
        }

        break;
    }

    if (imageFile != null) {
      setState(() {
        debugPrint("SELECTED IMAGE PICK   $imageFile");
      });
    } else {
      print("You have not taken image");
    }
  }

  void updateTypeSelected(int index) {
    for (var i = 0; i < listTypePick.length; i++) {
      listTypePick[i].isSelected = index == i;
    }
    setState(() {
      listTypePick;
    });
  }

// Image picker
  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Wrap(
            children: <Widget>[
              ListTile(
                  title: const Text('Lấy từ thư viện ảnh'),
                  onTap: () => {
                        imageSelector(context, "gallery"),
                        Navigator.pop(context),
                      }),
              ListTile(
                title: const Text('Chụp ảnh'),
                onTap: () =>
                    {imageSelector(context, "camera"), Navigator.pop(context)},
              ),
            ],
          );
        });
  }

  Widget _imageBuilder(BuildContext context, int index) {
    final isImage = index < imageFile.length;
    return Stack(
      fit: StackFit.expand,
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          child: isImage
              ? Image(
                  image: _getImage(imageFile[index]),
                  fit: BoxFit.fill,
                  colorBlendMode: BlendMode.darken)
              : InkWell(
                  onTap: () => _settingModalBottomSheet(context),
                  child: Container(
                    color: Colors.blueGrey[900],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Thêm ảnh",
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(Icons.add, size: 36, color: Colors.orange),
                      ],
                    ),
                  ),
                ),
        ),
        isImage
            ? InkWell(
                onTap: () {
                  _removeImage(index);
                },
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    height: 16,
                    width: 16,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.red),
                    child: const Icon(
                      Icons.close,
                      size: 16,
                    ),
                  ),
                ),
              )
            : const SizedBox(
                height: 0,
                width: 0,
              )
      ],
    );
  }

  _sendClick() {}

  Widget _typeBuilder(BuildContext context, int index) {
    final data = listTypePick[index];
    return Padding(
      padding: const EdgeInsets.all(4),
      child: InkWell(
        onTap: () {
          updateTypeSelected(index);
        },
        child: Material(
            elevation: 5,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                data.typeName,
                style: TextStyle(
                    color: data.isSelected ? Colors.white : Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                side: BorderSide(color: Colors.grey, width: 0.5)),
            color: data.isSelected ? Colors.orange : Colors.black),
      ),
    );
  }

  void _removeImage(int index) {
    setState(() {
      imageFile.removeAt(index);
      setState(() {
        debugPrint("SELECTED IMAGE PICK   $imageFile");
      });
    });
  }

  Widget _buildDataField() {
    final itemSelected = listTypePick.firstWhere((element) {
      return element.isSelected;
    }, orElse: () => TypePick("", false));
    if (itemSelected.isSelected) {
      final listData = listType[itemSelected.typeName];
      if (listData?.isNotEmpty == true) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final title = listData?[index] ?? '';
            return CustomTextField(title: title, value: '');
          },
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: listData?.length,
        );
      }
    }
    return const SizedBox(width: 0);
  }
}
