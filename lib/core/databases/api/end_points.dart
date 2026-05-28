class EndPoints {
  static const String baseUrl = "http://rentalplatform.runasp.net";
  static const String aiBaseUrl =
      "https://remunerative-alita-nonfluent.ngrok-free.dev";
  static const String chatEndpoint = "/chat";
  static const String loginEndpoint = "/api/Account/login";
  static const String registerEndpoint = "/api/Account/register";
  static const String forgotPasswordEndpoint = "/api/auth/forgot-password";
  static const String validateOtpEndpoint = "/api/auth/validate-otp";
  static const String categoriesEndpoint = "/api/Categories";
  static const String productsEndpoint = "/api/Product";
  static const String productReviewsEndpoint = "/api/ProductReview";
  static const String favoritesEndpoint = "/api/Favorite";
  static const String subscriptionEndpoint = "/api/Subscription";
  static const String subscriptionSubscribeEndpoint =
      "/api/UserSubscription/subscribe";
  static const String subscriptionActiveEndpoint =
      "/api/UserSubscription/active";
  static const String walletBalanceEndpoint = "/api/Wallet/balance";
  static const String walletTransactionsEndpoint = "/api/Wallet/transactions";
  static const String walletDepositEndpoint = "/api/Wallet/deposit";
  static const String walletWithdrawRequestEndpoint =
      "/api/Wallet/withdraw/request";
  static const String walletWithdrawRequestsEndpoint =
      "/api/Wallet/withdraw/requests";
  static const String userProfileEndpoint = "/api/UserProfile";
  static const String userProfileUploadImageEndpoint =
      "/api/UserProfile/upload-image";
  static const String userProfileChangePasswordEndpoint =
      "/api/UserProfile/change-password";
}
