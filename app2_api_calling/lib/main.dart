import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';


Future<KidsTube> fetchAlbum() async {

  final headers = {
    'authorizationToken': 'Api-Key-Value',
    'category': 'Value',
    'Content-Type': 'application/json',
  };

  final response = await http.get(
      Uri.parse('Write-URL-Here'),
      headers: headers
  );

  if (response.statusCode == 200) {
    return KidsTube.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    // List<dynamic> jsonResponse = jsonDecode(response.body);
    // return jsonResponse.map((data) => Album.fromJson(data)).toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load data');
  }
}

class BestOf {
  final String videoId;
  final String title;
  final String thumbnail;

  const BestOf({
    required this.videoId,
    required this.title,
    required this.thumbnail
  });

  factory BestOf.fromJson(Map<String,dynamic> json){
    return BestOf(
        videoId: json['videoId'] as String,
        title: json['title'] as String,
        thumbnail: json['thumbnail'] as String,
    );
  }
}

class KidsTube {
  final bool isSearchFeatureFree;
  final bool isChannelsFree;
  final bool videoFree;
  final int time;
  final List<BestOf> bestOf;

  const KidsTube({
    required this.isSearchFeatureFree,
    required this.isChannelsFree,
    required this.videoFree,
    required this.time,
    required this.bestOf,
  });

  factory KidsTube.fromJson(Map<String, dynamic> json) {
    return KidsTube(
        isSearchFeatureFree: json['isSearchFeatureFree'] as bool,
        isChannelsFree: json['isChannelsFree'] as bool,
        videoFree: json['videoFree'] as bool,
        time: json['time'] as int,
        bestOf: (json['bestOf'] as List<dynamic>)
            .map((item) => BestOf.fromJson(item as Map<String, dynamic>))
            .toList(),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Api Calling & Video'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late Future<KidsTube> futureKidsTube;

  // late VideoPlayerController _controller;
  // late Future<void> _initializeVideoPlayerFuture;

  // bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    futureKidsTube = fetchAlbum();

    // _controller = VideoPlayerController.networkUrl(
    //   Uri.parse(
    //       'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'
    //   ),
    // );
    //
    // _initializeVideoPlayerFuture = _controller.initialize();
    //
    // _controller.setLooping(false);
    //
    // _controller.addListener((){
    //   if (_controller.value.isCompleted) {
    //     setState(() {
    //       // print("Status: ${_controller.value}");
    //       _isPlaying = false;
    //     });
    //   }
    // }
    // );
  }

  // @override
  // void dispose() {
  //   // Ensure disposing of the VideoPlayerController to free up resources.
  //   _controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      // body:Center(
      //   child: GestureDetector(
      //     onTap: (){},
      //     child: Stack(
      //       children: [
      //         FutureBuilder(
      //             future: _initializeVideoPlayerFuture,
      //             builder: (context, snapShot){
      //               if(snapShot.connectionState == ConnectionState.done){
      //                 return AspectRatio(aspectRatio: _controller.value.aspectRatio,child: VideoPlayer(_controller));
      //               }
      //               else{
      //                 return const Center(
      //                   child: CircularProgressIndicator(),
      //                 );
      //               }
      //             }
      //         ),
      //         Positioned(
      //           bottom: 0,
      //           left: 0,
      //           right: 0,
      //           child: AnimatedOpacity(
      //             opacity: 1.0,
      //             duration: const Duration(milliseconds: 300),
      //             child: IconButton(
      //                 onPressed: (){
      //                   setState(() {
      //                     if(_controller.value.isPlaying){
      //                       _isPlaying = false;
      //                       _controller.pause();
      //                     }
      //                     else{
      //                       _isPlaying = true;
      //                       _controller.play();
      //                     }
      //                   });
      //                 },
      //                 icon: Icon(
      //                   _isPlaying? Icons.pause: Icons.play_arrow,
      //                   color: const Color(0xFFFFFFFF),
      //                 )
      //             ),
      //           ),
      //         )
      //       ],
      //     )
      //   ),
      // ),
      body: Center(
        child: FutureBuilder(
            future: futureKidsTube,
            builder: (context,snapShot){
              if (snapShot.hasData){
                KidsTube apiData = snapShot.data!;
                return Column(
                  children: <Widget>[
                    Text('Search Feature Free: ${apiData.isSearchFeatureFree}'),
                    Text('Channel Feature Free: ${apiData.isChannelsFree}'),
                    Text('Video Feature Free: ${apiData.videoFree}'),
                    Text('Time Free: ${apiData.time}'),
                    Expanded(
                        child: ListView.builder(
                          itemCount: apiData.bestOf.length,
                          itemBuilder: (context,index){
                            BestOf bestOfItem = apiData.bestOf[index];
                            return InkWell(
                              onTap: (){
                                print("item clicked");
                              },
                              child: Row(
                                children: <Widget>[
                                  Image.network(
                                    bestOfItem.thumbnail,
                                    width: 100,
                                    height: 100,
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                          bestOfItem.title,
                                          maxLines: 2
                                      ),
                                    ],
                                  ),
                                  ),
                                  const SizedBox(width: 12)
                                ],
                                // leading: Image.network(bestOfItem.thumbnail),
                                // title: Text('Title: ${bestOfItem.title}'),
                                // subtitle: Text("video Id: ${bestOfItem.videoId}"),
                              ),
                            );
                          }
                        )
                    )
                  ],
                );
              }
              else if(snapShot.hasError){
                return Text('${snapShot.error}');
              }
              return const CircularProgressIndicator();
            }
        )
      )
    );
  }
}
