import 'dart:convert';

class TitleOptions {
  bool show;
  String text;
  String textColor;
  String backgroundColor;
  String leftButtonType;
  String leftButtonColor;
  String rightButtonType;
  String rightButtonColor;

  TitleOptions(
    this.show,
    this.text,
    this.textColor,
    this.backgroundColor,
    this.leftButtonType,
    this.leftButtonColor,
    this.rightButtonType,
    this.rightButtonColor,
  );

  TitleOptions.fromJson(Map<String, dynamic> data)
      : show = data['show'] ?? true,
        text = data['text'] ?? '아임포트 테스트',
        textColor = data['textColor'] ?? '#ffffff',
        backgroundColor = data['backgroundColor'] ?? '#344e81',
        leftButtonType = data['leftButtonType'] ?? 'back',
        leftButtonColor = data['leftButtonColor'],
        rightButtonType = data['rightButtonType'] ?? 'close',
        rightButtonColor = data['rightButtonColor'];

  Map<String, dynamic> toJson() {
    Map<String, dynamic> options = {
      'show': show.toString(),
      'text': text,
      'textColor': textColor,
      'backgroundColor': backgroundColor,
      'leftButtonType': leftButtonType,
      'leftButtonColor': leftButtonColor ?? textColor,
      'rightButtonType': rightButtonType,
      'rightButtonColor': rightButtonColor ?? textColor,
    };

    return options;
  }
}
