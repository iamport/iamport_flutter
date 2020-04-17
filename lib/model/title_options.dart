import 'dart:convert';

class TitleOptions {
  bool show;
  String text;
  String textColor;
  String backgroundColor;

  TitleOptions(
    this.show,
    this.text,
    this.textColor,
    this.backgroundColor,
  );

  TitleOptions.fromJson(Map<String, dynamic> data)
      : show = data['show'] ?? true,
        text = data['text'],
        textColor = data['textColor'],
        backgroundColor = data['backgroundColor'];

  String toJsonString() {
    Map<String, dynamic> jsonData = {};

    if (show) {
      jsonData['text'] = text ?? '아임포트 테스트';
      jsonData['textColor'] = textColor ?? '#ffffff';
      jsonData['backgroundColor'] = backgroundColor ?? '#344e81';
    }

    return jsonEncode(jsonData);
  }
}
