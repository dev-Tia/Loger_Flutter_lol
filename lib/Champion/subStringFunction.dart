class SubString {
  subStringFunction(String text) {
    var startIndex = 0;
    var endIndex = 0;
    var start = '<';
    var end = '>';
    var subStringText = '';
    while (text.contains(start)) {
      startIndex = text.indexOf(start);
      endIndex = text.indexOf(end, startIndex + start.length);
      subStringText = text.substring(startIndex + start.length, endIndex);
      text = text.replaceAll('<br>', '\n');

      text = text.replaceAll('<' + subStringText + '>', '');
    }
    return text;
  }
}
