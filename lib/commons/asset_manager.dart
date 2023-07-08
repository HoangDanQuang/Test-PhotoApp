class AssetManager {
  const AssetManager._();

  static const String _PREFIX = 'assets';
  static const String _IMG_PNG_PATH = '$_PREFIX/images/png';
  static const String _IMG_JPEG_PATH = '$_PREFIX/images/jpeg';
  static const String _IMG_SVG_PATH = '$_PREFIX/images/svg';

  static String _getImgPng(String name) {
    List<String> split = name.split('.');
    assert(split.last.toLowerCase() == 'png');

    return '$_IMG_PNG_PATH/$name';
  }

  static String _getImgJpeg(String name) {
    List<String> split = name.split('.');
    assert(split.last.toLowerCase() == 'jpg' ||
        split.last.toLowerCase() == 'jpeg');
    return '$_IMG_JPEG_PATH/$name';
  }

  static String _getImgSvg(String name) {
    List<String> split = name.split('.');
    assert(split.last.toLowerCase() == 'svg');
    return '$_IMG_SVG_PATH/$name';
  }



  static String get icGoogle => _getImgSvg('ic_google.svg');

  static String get icGooglePhoto => _getImgPng('ic_google_photo.png');


}