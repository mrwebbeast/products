class AppConfig {
  ///1) APP Configurations...
  static const String appName = "MrWebBeast";
  static const String appVersion = "1.0";
  static const String packageName = "app.developer.mrwebbeast";

  ///2) APP Store & Download Urls..
  static const String playStoreUrl = "https://play.google.com/store/apps/details?id=$packageName";
  static const String appStoreUrl = "https://apps.apple.com/us/app/emuvv/id6462873844";
  static const String deeplinkUrl = "https://mrwebbeast.page.link/downlaod";

  ///3) Contact Details...
  static const String contactEmail = "mrwebbeast@gmail.com";
  static const String contactNumber = "+91 7559721016";

  ///4) Notification Channel Id...
  static const String chanelName = "MrWebBeast";

  ///5) Local Database Configurations..
  static const String databaseName = "database";

  ///6) API Configurations..
  static const bool isProductionMode = true;

  static String get domainName =>
      isProductionMode == true ? ApiConfig.productionDomain : ApiConfig.developmentDomain;
}

class ApiConfig {
  ///2) API Configurations..

  static const productionDomain = "https://dummyjson.com/"; // Production.
  static const developmentDomain = "https://dummyjson.com/"; // Development.

  static const String apiVersion = "api/v1/";

  ///2.1) API BaseUrl..
  static final String baseUrl = "${AppConfig.domainName}$apiVersion";

  ///2.5) Third Party Api Configurations ...
  static const String mapsBaseUrl = "https://maps.googleapis.com/maps/api";
  static const dummyJsonBaseUrl = "https://dummyjson.com/";

  static final String privacyPolicyUrl = "${baseUrl}privacy-policy";
  static final String aboutUsUrl = "${baseUrl}about-us";
  static final String contactUsUrl = "${baseUrl}contact-us";
  static final String supportUrl = "${baseUrl}support";
  static final String termsAndConditionsUrl = "${baseUrl}terms-conditions";

  ///1) APP CMS..
  static const String products = "products";
}
