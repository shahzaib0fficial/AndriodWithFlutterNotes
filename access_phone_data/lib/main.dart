import 'dart:typed_data';

import 'package:access_phone_data/CameraScreen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

late List<CameraDescription> _cameras;

Future<void> main() async {
  _cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  List<AssetEntity> images = [];

  Future<void> loadImages() async {
    final PermissionState permission = await PhotoManager.requestPermissionExtend();
    if (permission != PermissionState.authorized) {
      // Handle the case where permission is denied
      return;
    }
    else{
      final List<AssetPathEntity> result = await PhotoManager.getAssetPathList(type: RequestType.image, filterOption: FilterOptionGroup(onlyLivePhotos: true));
      final List<AssetEntity> allImages = await result[0].getAssetListPaged(page: 0, size: 80);

      for (var item in allImages) {
        final image = await AssetEntity.fromId(item.id);
        setState(() {
          images.add(image!);
        });
      }

      // setState(() {
      //   images = allImages;
      //   // print("HERE $images");
      // });
    }
  }

  @override
  void initState() {
    super.initState();
    loadImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        backgroundColor: Colors.yellow,
      ),
      body: images.isNotEmpty
        ?
      GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,),
        itemCount: images.length,
        itemBuilder: (context, index) {
          final asset = images[index];
          // return Text("${asset}");
          return FutureBuilder<Uint8List?>(
            future: asset.thumbnailData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error loading image'));
              } else if (snapshot.hasData && snapshot.data != null) {
                return Image.memory(snapshot.data!);
              } else {
                return Center(child: Text('Image not found'));
              }
            },
          );
        },
      )
          :
      Text("Nothing to show"),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CameraApp(cameras: _cameras),
            ),
          );
        },
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}
