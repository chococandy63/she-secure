import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';


import 'package:speech_to_text/speech_to_text.dart' as stt;

class VoiceRecognitionScreen extends StatefulWidget {
  @override
  _VoiceRecognitionScreenState createState() => _VoiceRecognitionScreenState();
}

class _VoiceRecognitionScreenState extends State<VoiceRecognitionScreen> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = "";

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _startListening() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );

      if (available) {
        setState(() => _isListening = true);

        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            if (_text.toLowerCase().contains('help')) {
              String message = 'Help! Emergency situation detected.';
List<String> recipents = ["+918273208429","+918126639850"];
              _sendSMS(message, recipents);
            }
          }),
        );
      }
    }
  }

 void _sendSMS(String message, List<String> recipients) async {
  try {
    String _result = await sendSMS(message: message, recipients: recipients);
    print(_result);
  } catch (error) {
    print('Error sending SMS: $error');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voice Recognition'),
      ),
      body: Column(
        children: [
          Text(_text),
          ElevatedButton(
            onPressed:
             _startListening,
            child: Text(_isListening ? 'Stop Listening' : 'Start Listening'),
          ),
        ],
      ),
    );
  }
}







