import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeech extends StatefulWidget {
  final String desc;
  final String lang;
  TextToSpeech(this.desc, this.lang);
  @override
  State<StatefulWidget> createState() {
    return TextTospeechState(desc, lang);
  }
}

enum TtsState { playing, stopped }

class TextTospeechState extends State<TextToSpeech> {
  FlutterTts _flutterTts = FlutterTts();
  final String desc;
  final String lang;
  TtsState ttsState = TtsState.stopped;
  static final Map<String, String> _languageMap = {
    'en': "en-US",
    'zh': "zh-CN",
    "ar": "ar-SA",
    "cs": "cs-CZ",
    "da": "da-DK",
    "de": "de-DE",
    "el": "el-GR",
    "es": "es-ES",
    "fi": "fi-FI",
    "fr": "fr-CA",
    "he": "he-IL",
    "hi": "hi-IN",
    "hu": "hu-HU",
    "id": "id-ID",
    "it": "it-IT",
    "ja": "ja-JP",
    "ko": "ko-KR",
    "nl": "nl-BE",
    "no": "no-NO",
    "pl": "pl-PL",
    "pt": "pt-BR",
    "ro": "ro-RO",
    "ru": "ru-RU",
    "sk": "sk-SK",
    "sv": "sv-SE",
    "th": "th-TH",
    "tr": "tr-TR",
  };
  TextTospeechState(this.desc, this.lang);
  initState() {
    super.initState();
  }

  Future _speak(String desc, String lang) async {
    await _flutterTts.setLanguage('fr-CA');
    var result = await _flutterTts.speak(desc);
    if (result == 1) setState(() => ttsState = TtsState.playing);
  }

  Future _stop() async {
    var result = await _flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  void _soundControl() {
    if (ttsState == TtsState.stopped)
      _speak(this.desc, _languageMap[this.lang]);

    if (ttsState == TtsState.playing) _stop();
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: IconButton(
        icon: Icon(Icons.headset),
        iconSize: 30.0,
        onPressed: () {
          _soundControl();
        },
      ),
    );
  }
}
