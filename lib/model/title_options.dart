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
        text = data['text'] ?? '아임포트 테스트',
        textColor = data['textColor'] ?? '#ffffff',
        backgroundColor = data['backgroundColor'] ?? '#344e81';

  Map<String, dynamic> toJson() {
    return {
      'show': show.toString(),
      'text': text,
      'textColor': textColor,
      'backgroundColor': backgroundColor,
    };
  }
}
