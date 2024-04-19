import 'package:camera/camera.dart';
import 'package:pod_player/pod_player.dart';

import '../../libraries.dart';

class WatchVideoViewModel extends GetxController {
  late final PodPlayerController controller;
  CameraController photocontroller =
      CameraController(GlobalVariables.camera[1], ResolutionPreset.medium);
  @override
  void onInit() {
    super.onInit();
    showvideo();
    initCamera();
  }

  Future initCamera() async {
    try {
      await photocontroller.initialize().then((_) {
        if (!this.isClosed) return;
      });
    } on CameraException catch (e) {
      debugPrint("camera error $e");
    }
  }

  // String extractyoutubeVideo(String youtubeLink) {
  //   List<String> parts = youtubeLink.split('=');
  //   if (parts.length > 1) {
  //     return parts.last;
  //   } else {
  //     return 'Invalid YouTube Link';
  //   }
  // }

  String extractvimeoVideo(String vimeoLink) {
    List<String> parts = vimeoLink.split('/');
    if (parts.length > 1) {
      return parts.last;
    } else {
      return 'Invalid Vimeo Link';
    }
  }

  bool isYouTubeLink(String url) {
    RegExp youtubeRegex = RegExp(
      r'^https?://(?:www\.)?youtube\.com/watch\?v=|youtu\.be/',
      caseSensitive: false,
    );
    return youtubeRegex.hasMatch(url);
  }

  bool isVimeoLink(String url) {
    RegExp vimeoRegex = RegExp(
      r'^https?://(?:www\.)?vimeo\.com/',
      caseSensitive: false,
    );
    return vimeoRegex.hasMatch(url);
  }

  void showvideo() {
    if (isYouTubeLink(GlobalVariables.datamodel.videoUrl)) {
      controller = PodPlayerController(
          playVideoFrom:
              PlayVideoFrom.youtube(GlobalVariables.datamodel.videoUrl))
        ..initialise();
    } else if (isVimeoLink(GlobalVariables.datamodel.videoUrl)) {
      controller = PodPlayerController(
          playVideoFrom: PlayVideoFrom.vimeo(
              extractvimeoVideo(GlobalVariables.datamodel.videoUrl)))
        ..initialise();
    }
  }

//   @override
//   void onInit() {
//     // controller = WebViewController()
//     //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
//     //   ..setBackgroundColor(const Color(0x00000000))
//     //   ..setNavigationDelegate(
//     //     NavigationDelegate(
//     //       onProgress: (int progress) {},
//     //       onPageStarted: (String url) {},
//     //       onPageFinished: (String url) {},
//     //       onWebResourceError: (WebResourceError error) {},
//     //       onNavigationRequest: (NavigationRequest request) {
//     //         if (request.url.startsWith('https://www.youtube.com/')) {
//     //           return NavigationDecision.prevent;
//     //         }
//     //         return NavigationDecision.navigate;
//     //       },
//     //     ),
//     //   )
//     //   ..clearCache()
//     //   ..loadRequest(Uri.parse('https://flutter.dev'));
//     super.onInit();
//   }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
