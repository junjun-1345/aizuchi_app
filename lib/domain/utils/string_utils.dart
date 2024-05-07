extension StringExtensions on String {
  String get camelToSnakeCase {
    StringBuffer result = StringBuffer();
    for (int i = 0; i < length; i++) {
      String char = this[i];
      if (char == char.toUpperCase()) {
        result.write('_');
        result.write(char.toLowerCase());
      } else {
        result.write(char);
      }
    }
    return result.toString();
  }
}
