class AppRoutes {
  static const String splashScreen = '/splashScreen';
  static const String introScreen = '/introScreen';
  static const String animatedAuthToggle = '/animatedAuthToggle';
  static const String forgotPasswordScreen = '/forgotPasswordScreen';
  static const String otpVerificationScreen = '/otpVerificationScreen';
  static const String resetPasswordScreen = '/resetPasswordScreen';
  static const String authSuccessScreen = '/authSuccessScreen';
  static const String mainScreen = '/mainScreen';
  static const String homeScreen = '/homeScreen';
  static const String communityScreen = '/communityScreen';
  static const String createCommunityRequestScreen =
      '/createCommunityRequestScreen';
  static const String favoritesScreen = '/favoritesScreen';
  static const String dealsScreen = '/dealsScreen';
  static const String notificationsScreen = '/notificationsScreen';
  static const String walletScreen = '/walletScreen';
  static const String addListingScreen = '/addListingScreen';
  static const String productDetailsScreen = '/productDetailsScreen';
  static const String productDetailsPath = '/product-details';

  static String productDetailsLocation(int id) => '$productDetailsPath/$id';

  static Map<String, String> productDetailsPathParameters(int id) => {
    'id': id.toString(),
  };

  static const String bookingFlowScreen = '/bookingFlowScreen';
  static const String userProfileScreen = '/userprofileScreen';
  static const String settingsScreen = '/settingsScreen';
  static const String aiChatScreen = '/AiChatScreen';
  static const String conversationsScreen = '/conversationsScreen';
  static const String chatScreen = '/chatScreen';
  static const String subscriptionScreen = '/subscriptionScreen';
  static const String communityRequestDetailsScreen =
      '/communityRequestDetailsScreen';
  static const String communityRequestDetailsPath =
      '/community-request-details';

  static String communityRequestDetailsLocation(int id) =>
      '$communityRequestDetailsPath/$id';

  static const String searchScreen = '/searchScreen';
  static const String productReviewsScreen = '/productReviewsScreen';
  static const String myOrdersScreen = '/myOrdersScreen';
  static const String myListingsOrdersScreen = '/myListingsOrdersScreen';
  static const String productReviewsPath = '/product-reviews';

  static String productReviewsLocation(int productId) =>
      '$productReviewsPath/$productId';

  static const String orderDetailScreen = '/orderDetailScreen';
  static const String orderDetailPath = '/order-detail';

  static String orderDetailLocation(int id) => '$orderDetailPath/$id';

  static const String myProductsScreen = '/myProductsScreen';
  static const String ownerStatsScreen = '/ownerStatsScreen';
  static const String productTransactionsScreen = '/productTransactionsScreen';
  static const String productRentalRequestsScreen =
      '/productRentalRequestsScreen';
  static const String productStatsScreen = '/productStatsScreen';

  static String productTransactionsLocation(int productId) =>
      '$productTransactionsScreen/$productId';
  static String productRentalRequestsLocation(int productId) =>
      '$productRentalRequestsScreen/$productId';
  static String productStatsLocation(int productId) =>
      '$productStatsScreen/$productId';
}
