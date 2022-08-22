// import 'package:chewie/chewie.dart';
// import 'package:video_player/video_player.dart';
// import 'package:flutter/material.dart';

// class _ChewieDemoState extends State<ChewieDemo> {
//   late TargetPlatform _platform;
//   late VideoPlayerController _videoPlayerController1;
//   late VideoPlayerController _videoPlayerController2;
//   late ChewieController _chewieController;
//   late ChewieController _chewieController2;
//   void initState() {
//     super.initState();
//     _videoPlayerController1 = VideoPlayerController.network(
//         'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
//     _videoPlayerController2 = VideoPlayerController.network(
//         'https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4');

//     _chewieController = ChewieController(
//       videoPlayerController: _videoPlayerController1,
//       aspectRatio: 4 / 3,
//       autoPlay: true,
//       looping: false,
//     );

//     _chewieController2 = ChewieController(
//       videoPlayerController: _videoPlayerController2,
//       aspectRatio: 4 / 3,
//       autoPlay: true,
//       looping: false,
//     );
//   }
// }
