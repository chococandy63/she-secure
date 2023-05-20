import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

stt.SpeechToText speech = stt.SpeechToText();
void initializeSpeechRecognition() async {
  bool available = await speech.initialize();
  if (available) {
    // Speech recognition is available, you can start listening for speech

  } else {
    // Speech recognition is not available on the device
    // Handle the case where speech recognition is not supported
  }
}

void startListening() async {
  bool isListening = await speech.listen(
    onResult: (result) {
      if (result.finalResult) {
        String recognizedText = result.recognizedWords.toLowerCase();
        if (recognizedText.contains('help')) {
          // The phrase "help" was recognized
          // Perform an action or display a message indicating help is needed
          print('Help is needed!');
        }
      }
    },
  );

  if (isListening) {
    // Speech recognition has started
  } else {
    // Speech recognition failed to start
    // Handle the case where speech recognition fails to start
  }
}

void stopListening() {
  speech.stop();
}