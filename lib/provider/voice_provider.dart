import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';

class VoiceProvider with ChangeNotifier {
  final stt.SpeechToText _speech = stt.SpeechToText();
  final FlutterTts _tts = FlutterTts();

  bool _isListening = false;
  String _spokenText = '';
  bool _speechAvailable = false;

  bool get isListening => _isListening;
  String get spokenText => _spokenText;

  Future<void> startListening(BuildContext context, Function(String) onResult) async {
    _speechAvailable = await _speech.initialize(
      onStatus: (status) {
        if (status == 'done' || status == 'notListening') {
          stopListening();
        }
      },
      onError: (error) {
        print('Speech recognition error: $error');
        stopListening();
        _showSnackBar(context, "Speech recognition error: ${error.errorMsg}");
      },
    );

    if (!_speechAvailable) {
      _showSnackBar(context, "Speech recognition not available on this device.");
      return;
    }

    _spokenText = '';
    _isListening = true;
    notifyListeners();

    _speech.listen(
      onResult: (result) {
        if (result.finalResult) {
          _spokenText = result.recognizedWords;
          onResult(_spokenText);
          notifyListeners();
        }
      },
      listenMode: stt.ListenMode.confirmation,
      pauseFor: const Duration(seconds: 2),
      partialResults: false,
      cancelOnError: true,
    );
  }

  void stopListening() {
    if (_speech.isListening) {
      _speech.stop();
    }
    _isListening = false;
    notifyListeners();
  }
  Future<void> speak(BuildContext context, String text, String languageCode) async {
    try {
      var result = await _tts.setLanguage(languageCode);
      if (result == null || result == 1) {
        // This likely means unsupported language
        _showSnackBar(context, "Language '$languageCode' might not be supported for speech.");
        return;
      }

      await _tts.setSpeechRate(0.5);
      await _tts.speak(text);
    } catch (e) {
      print("TTS error: $e");
      _showSnackBar(context, "An error occurred while trying to speak.");
    }
  }
  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
      ),
    );
  }
}
