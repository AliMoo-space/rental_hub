class EndPoints {
  static const String baseUrl = "https://rentalplatform.runasp.net";
  static const String aiBaseUrl =
      "https://remunerative-alita-nonfluent.ngrok-free.dev";
  static const String aichatEndpoint = "/chat";
  static const String chatConversationsEndpoint = '/api/Chat/conversations';
  static String chatMessagesEndpoint(int conversationId) =>
      '/api/Chat/messages/$conversationId';
  static String chatReportMessageEndpoint(int messageId) =>
      '/api/Chat/report/$messageId';
  static const String chatHubEndpoint = '/chatHub';
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
  static const String userDashboardSubscriptionEndpoint =
      "/api/UserDashboard/subscription";
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
  // Community endpoints
  static const String communityRequests = '/api/Community/requests';
  static String communityRequestById(int id) => '$communityRequests/$id';
  static const String communityOffers = '/api/Community/offers';
  static const String communityMyRequests = '/api/Community/my-requests';
  static const String communityMyOffers = '/api/Community/my-offers';
  static const String communityMyRequestsOffers =
      '/api/Community/my-requests/offers';
  static String communityOfferAction(int offerId, String action) =>
      '/api/Community/offers/$offerId/$action';

  // Product endpoints
  static const String productCommission = '/api/Product/settings/commission';
  static const String myProducts = '/api/Product/my-products';
  static String deleteProduct(int id) => '/api/Product/$id';
  static String suspendProduct(int id) => '/api/Product/$id/suspend';
  static String activateProduct(int id) => '/api/Product/$id/activate';
  static const String ownerStats = '/api/Product/stats/owner';
  static String productUserList(String userId) => '/api/Product/user/$userId';
  static String productTransactions(int productId) =>
      '/api/Product/$productId/transactions';
  static String productRentalRequests(int productId) =>
      '/api/Product/$productId/rental-requests';
  static String productStats(int productId) => '/api/Product/$productId/stats';
}
