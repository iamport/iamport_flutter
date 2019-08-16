class IamportIntent {
  String url;
  String scheme;
  String package;  
  String appUrl;

  IamportIntent(String url) {
    this.url = url;
  
    setScheme();
    setPackage();
  }

  setScheme() {
    Pattern patternForScheme = r'(?<=scheme=)(.*)(?=;package)';
    RegExp regex = new RegExp(patternForScheme);
    this.scheme = regex.stringMatch(url);
    print(this.scheme);
  }

  setPackage() {
    Pattern patternForPackage = r'(?<=package=)(.*)(?=;)';
    RegExp regex = new RegExp(patternForPackage);
    this.package = regex.stringMatch(url);
    print(this.package);
  }

  getData() {
    return this.url.substring(7);
  }

  getAppUrl() {
    Uri parsedUrl = Uri.parse(url); 
    String query = parsedUrl.query;
    return '$scheme://smartpay?$query';
  }

  getMarketUrl() {
    return 'https://play.google.com/store/apps/details?id=$package';
  }

  String getScheme() {
    return scheme;
  }

  String getPackage() {
    return package;
  }
}