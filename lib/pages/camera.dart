import 'package:camera/camera.dart';
import 'package:video_player/video_player.dart';

List<CameraDescription> cameras;

Future<void> initializeCamera() async {
  cameras = await availableCameras();
  final CameraController controller = CameraController(
    cameras[0], // Use the first available camera
    ResolutionPreset.medium, // Choose a resolution preset
  );

  await controller.initialize();
}

void startRecording(CameraController controller) async {
  if (!controller.value.isRecordingVideo) {
    final String filePath = '<YOUR_VIDEO_FILE_PATH>'; // Set your desired file path
    await controller.startVideoRecording(filePath);
  }
}

void stopRecording(CameraController controller) async {
  if (controller.value.isRecordingVideo) {
    await controller.stopVideoRecording();
  }
}

// Create a widget to display the live camera feed:
class CameraPreviewWidget extends StatelessWidget {
  final CameraController controller;

  const CameraPreviewWidget({required this.controller});

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }

    return AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: CameraPreview(controller),
    );
  }
}

// Add a VideoPlayerController to play the recorded video:
VideoPlayerController? _videoController;

void playVideo(String videoFilePath) {
  _videoController = VideoPlayerController.file(File(videoFilePath))
    ..initialize().then((_) {
      _videoController!.play();
    });
}

void disposeVideoController() {
  _videoController?.dispose();
  _videoController = null;
}

class MyVideoCaptureApp extends StatefulWidget {
  @override
  _MyVideoCaptureAppState createState() => _MyVideoCaptureAppState();
}

// UI
class _MyVideoCaptureAppState extends State<MyVideoCaptureApp> {
  late CameraController _controller;

  @override
  void initState() {
    super.initState();
    initializeCamera().then((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return Container();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Video Capture'),
      ),
      body: Column(
        children: [
          Expanded(
            child: CameraPreviewWidget(controller: _controller),
          ),
          ElevatedButton(
            onPressed: () {
              if (_controller.value.isRecordingVideo) {
                stopRecording(_controller);
              } else {
                startRecording(_controller);
              }
            },
            child: Text(
              _controller.value.isRecordingVideo ? 'Stop Recording' : 'Start Recording',
            ),
          ),
        ],
      ),
    );
  }
}