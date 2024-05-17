// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Search for restaurants or foods`
  String get search_for_restaurants_or_foods {
    return Intl.message(
      'Search for restaurants or foods',
      name: 'search_for_restaurants_or_foods',
      desc: '',
      args: [],
    );
  }

  /// `Top Restaurants`
  String get top_restaurants {
    return Intl.message(
      'Top Restaurants',
      name: 'top_restaurants',
      desc: '',
      args: [],
    );
  }

  /// `Ordered by Nearby first`
  String get ordered_by_nearby_first {
    return Intl.message(
      'Ordered by Nearby first',
      name: 'ordered_by_nearby_first',
      desc: '',
      args: [],
    );
  }

  /// `Trending This Week`
  String get trending_this_week {
    return Intl.message(
      'Trending This Week',
      name: 'trending_this_week',
      desc: '',
      args: [],
    );
  }

  /// `Double click on the food to add it to the cart`
  String get double_click_on_the_food_to_add_it_to_the {
    return Intl.message(
      'Double click on the food to add it to the cart',
      name: 'double_click_on_the_food_to_add_it_to_the',
      desc: '',
      args: [],
    );
  }

  /// `Food Categories`
  String get food_categories {
    return Intl.message(
      'Food Categories',
      name: 'food_categories',
      desc: '',
      args: [],
    );
  }

  /// `Most Popular`
  String get most_popular {
    return Intl.message(
      'Most Popular',
      name: 'most_popular',
      desc: '',
      args: [],
    );
  }

  /// `Recent Reviews`
  String get recent_reviews {
    return Intl.message(
      'Recent Reviews',
      name: 'recent_reviews',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get verify {
    return Intl.message(
      'Verify',
      name: 'verify',
      desc: '',
      args: [],
    );
  }

  /// `Select your preferred languages`
  String get select_your_preferred_languages {
    return Intl.message(
      'Select your preferred languages',
      name: 'select_your_preferred_languages',
      desc: '',
      args: [],
    );
  }

  /// `Order Id`
  String get order_id {
    return Intl.message(
      'Order Id',
      name: 'order_id',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message(
      'Category',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `Checkout`
  String get checkout {
    return Intl.message(
      'Checkout',
      name: 'checkout',
      desc: '',
      args: [],
    );
  }

  /// `Payment Mode`
  String get payment_mode {
    return Intl.message(
      'Payment Mode',
      name: 'payment_mode',
      desc: '',
      args: [],
    );
  }

  /// `Select your preferred payment mode`
  String get select_your_preferred_payment_mode {
    return Intl.message(
      'Select your preferred payment mode',
      name: 'select_your_preferred_payment_mode',
      desc: '',
      args: [],
    );
  }

  /// `Or Checkout With`
  String get or_checkout_with {
    return Intl.message(
      'Or Checkout With',
      name: 'or_checkout_with',
      desc: '',
      args: [],
    );
  }

  /// `Subtotal`
  String get subtotal {
    return Intl.message(
      'Subtotal',
      name: 'subtotal',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Payment`
  String get confirm_payment {
    return Intl.message(
      'Confirm Payment',
      name: 'confirm_payment',
      desc: '',
      args: [],
    );
  }

  /// `Menu`
  String get menu {
    return Intl.message(
      'Menu',
      name: 'menu',
      desc: '',
      args: [],
    );
  }

  /// `Information`
  String get information {
    return Intl.message(
      'Information',
      name: 'information',
      desc: '',
      args: [],
    );
  }

  /// `Featured Foods`
  String get featured_foods {
    return Intl.message(
      'Featured Foods',
      name: 'featured_foods',
      desc: '',
      args: [],
    );
  }

  /// `What They Say ?`
  String get what_they_say {
    return Intl.message(
      'What They Say ?',
      name: 'what_they_say',
      desc: '',
      args: [],
    );
  }

  /// `Favorite Foods`
  String get favorite_foods {
    return Intl.message(
      'Favorite Foods',
      name: 'favorite_foods',
      desc: '',
      args: [],
    );
  }

  /// `g`
  String get g {
    return Intl.message(
      'g',
      name: 'g',
      desc: '',
      args: [],
    );
  }

  /// `Extras`
  String get extras {
    return Intl.message(
      'Extras',
      name: 'extras',
      desc: '',
      args: [],
    );
  }

  /// `Select extras to add them on the food`
  String get select_extras_to_add_them_on_the_food {
    return Intl.message(
      'Select extras to add them on the food',
      name: 'select_extras_to_add_them_on_the_food',
      desc: '',
      args: [],
    );
  }

  /// `Ingredients`
  String get ingredients {
    return Intl.message(
      'Ingredients',
      name: 'ingredients',
      desc: '',
      args: [],
    );
  }

  /// `Nutrition`
  String get nutrition {
    return Intl.message(
      'Nutrition',
      name: 'nutrition',
      desc: '',
      args: [],
    );
  }

  /// `Reviews`
  String get reviews {
    return Intl.message(
      'Reviews',
      name: 'reviews',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get quantity {
    return Intl.message(
      'Quantity',
      name: 'quantity',
      desc: '',
      args: [],
    );
  }

  /// `Add to Cart`
  String get add_to_cart {
    return Intl.message(
      'Add to Cart',
      name: 'add_to_cart',
      desc: '',
      args: [],
    );
  }

  /// `Faq`
  String get faq {
    return Intl.message(
      'Faq',
      name: 'faq',
      desc: '',
      args: [],
    );
  }

  /// `Help & Supports`
  String get help_supports {
    return Intl.message(
      'Help & Supports',
      name: 'help_supports',
      desc: '',
      args: [],
    );
  }

  /// `App Language`
  String get app_language {
    return Intl.message(
      'App Language',
      name: 'app_language',
      desc: '',
      args: [],
    );
  }

  /// `I forgot password`
  String get i_forgot_password {
    return Intl.message(
      'I forgot password',
      name: 'i_forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `I don't have an account`
  String get i_dont_have_an_account {
    return Intl.message(
      'I don\'t have an account',
      name: 'i_dont_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Maps Explorer`
  String get maps_explorer {
    return Intl.message(
      'Maps Explorer',
      name: 'maps_explorer',
      desc: '',
      args: [],
    );
  }

  /// `All Menu`
  String get all_menu {
    return Intl.message(
      'All Menu',
      name: 'all_menu',
      desc: '',
      args: [],
    );
  }

  /// `Long-press on the food to add supplements`
  String get longpress_on_the_food_to_add_supplements {
    return Intl.message(
      'Long-press on the food to add supplements',
      name: 'longpress_on_the_food_to_add_supplements',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Confirmation`
  String get confirmation {
    return Intl.message(
      'Confirmation',
      name: 'confirmation',
      desc: '',
      args: [],
    );
  }

  /// `Your order has been successfully submitted!`
  String get your_order_has_been_successfully_submitted {
    return Intl.message(
      'Your order has been successfully submitted!',
      name: 'your_order_has_been_successfully_submitted',
      desc: '',
      args: [],
    );
  }

  /// `TAX`
  String get tax {
    return Intl.message(
      'TAX',
      name: 'tax',
      desc: '',
      args: [],
    );
  }

  /// `My Orders`
  String get my_orders {
    return Intl.message(
      'My Orders',
      name: 'my_orders',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get favorites {
    return Intl.message(
      'Favorites',
      name: 'favorites',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Payment Options`
  String get payment_options {
    return Intl.message(
      'Payment Options',
      name: 'payment_options',
      desc: '',
      args: [],
    );
  }

  /// `Cash on delivery`
  String get cash_on_delivery {
    return Intl.message(
      'Cash on delivery',
      name: 'cash_on_delivery',
      desc: '',
      args: [],
    );
  }

  /// `PayPal Payment`
  String get paypal_payment {
    return Intl.message(
      'PayPal Payment',
      name: 'paypal_payment',
      desc: '',
      args: [],
    );
  }

  /// `Recent Orders`
  String get recent_orders {
    return Intl.message(
      'Recent Orders',
      name: 'recent_orders',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Profile Settings`
  String get profile_settings {
    return Intl.message(
      'Profile Settings',
      name: 'profile_settings',
      desc: '',
      args: [],
    );
  }

  /// `Full name`
  String get full_name {
    return Intl.message(
      'Full name',
      name: 'full_name',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Payments Settings`
  String get payments_settings {
    return Intl.message(
      'Payments Settings',
      name: 'payments_settings',
      desc: '',
      args: [],
    );
  }

  /// `Default Credit Card`
  String get default_credit_card {
    return Intl.message(
      'Default Credit Card',
      name: 'default_credit_card',
      desc: '',
      args: [],
    );
  }

  /// `App Settings`
  String get app_settings {
    return Intl.message(
      'App Settings',
      name: 'app_settings',
      desc: '',
      args: [],
    );
  }

  /// `Languages`
  String get languages {
    return Intl.message(
      'Languages',
      name: 'languages',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Help & Support`
  String get help_support {
    return Intl.message(
      'Help & Support',
      name: 'help_support',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Let's Start with register!`
  String get lets_start_with_register {
    return Intl.message(
      'Let\'s Start with register!',
      name: 'lets_start_with_register',
      desc: '',
      args: [],
    );
  }

  /// `Should be more than 3 letters`
  String get should_be_more_than_3_letters {
    return Intl.message(
      'Should be more than 3 letters',
      name: 'should_be_more_than_3_letters',
      desc: '',
      args: [],
    );
  }

  /// `John Doe`
  String get john_doe {
    return Intl.message(
      'John Doe',
      name: 'john_doe',
      desc: '',
      args: [],
    );
  }

  /// `Should be a valid email`
  String get should_be_a_valid_email {
    return Intl.message(
      'Should be a valid email',
      name: 'should_be_a_valid_email',
      desc: '',
      args: [],
    );
  }

  /// `Should be more than 6 letters`
  String get should_be_more_than_6_letters {
    return Intl.message(
      'Should be more than 6 letters',
      name: 'should_be_more_than_6_letters',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `I have account? Back to login`
  String get i_have_account_back_to_login {
    return Intl.message(
      'I have account? Back to login',
      name: 'i_have_account_back_to_login',
      desc: '',
      args: [],
    );
  }

  /// `Multi-Restaurants`
  String get multi_restaurants {
    return Intl.message(
      'Multi-Restaurants',
      name: 'multi_restaurants',
      desc: '',
      args: [],
    );
  }

  /// `Tracking Order`
  String get tracking_order {
    return Intl.message(
      'Tracking Order',
      name: 'tracking_order',
      desc: '',
      args: [],
    );
  }

  /// `Discover & Explorer`
  String get discover__explorer {
    return Intl.message(
      'Discover & Explorer',
      name: 'discover__explorer',
      desc: '',
      args: [],
    );
  }

  /// `You can discover restaurants & fastfood arround you and choose you best meal after few minutes we prepare and delivere it for you`
  String get you_can_discover_restaurants {
    return Intl.message(
      'You can discover restaurants & fastfood arround you and choose you best meal after few minutes we prepare and delivere it for you',
      name: 'you_can_discover_restaurants',
      desc: '',
      args: [],
    );
  }

  /// `Reset Cart?`
  String get reset_cart {
    return Intl.message(
      'Reset Cart?',
      name: 'reset_cart',
      desc: '',
      args: [],
    );
  }

  /// `Cart`
  String get cart {
    return Intl.message(
      'Cart',
      name: 'cart',
      desc: '',
      args: [],
    );
  }

  /// `Shopping Cart`
  String get shopping_cart {
    return Intl.message(
      'Shopping Cart',
      name: 'shopping_cart',
      desc: '',
      args: [],
    );
  }

  /// `Verify your quantity and click checkout`
  String get verify_your_quantity_and_click_checkout {
    return Intl.message(
      'Verify your quantity and click checkout',
      name: 'verify_your_quantity_and_click_checkout',
      desc: '',
      args: [],
    );
  }

  /// `Let's Start with Login!`
  String get lets_start_with_login {
    return Intl.message(
      'Let\'s Start with Login!',
      name: 'lets_start_with_login',
      desc: '',
      args: [],
    );
  }

  /// `Should be more than 3 characters`
  String get should_be_more_than_3_characters {
    return Intl.message(
      'Should be more than 3 characters',
      name: 'should_be_more_than_3_characters',
      desc: '',
      args: [],
    );
  }

  /// `You must add foods of the same restaurants choose one restaurants only!`
  String get you_must_add_foods_of_the_same_restaurants_choose_one {
    return Intl.message(
      'You must add foods of the same restaurants choose one restaurants only!',
      name: 'you_must_add_foods_of_the_same_restaurants_choose_one',
      desc: '',
      args: [],
    );
  }

  /// `Reset your cart and order meals form this restaurant`
  String get reset_your_cart_and_order_meals_form_this_restaurant {
    return Intl.message(
      'Reset your cart and order meals form this restaurant',
      name: 'reset_your_cart_and_order_meals_form_this_restaurant',
      desc: '',
      args: [],
    );
  }

  /// `Keep your old meals of this restaurant`
  String get keep_your_old_meals_of_this_restaurant {
    return Intl.message(
      'Keep your old meals of this restaurant',
      name: 'keep_your_old_meals_of_this_restaurant',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get reset {
    return Intl.message(
      'Reset',
      name: 'reset',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Application Preferences`
  String get application_preferences {
    return Intl.message(
      'Application Preferences',
      name: 'application_preferences',
      desc: '',
      args: [],
    );
  }

  /// `Help & Support`
  String get help__support {
    return Intl.message(
      'Help & Support',
      name: 'help__support',
      desc: '',
      args: [],
    );
  }

  /// `Light Mode`
  String get light_mode {
    return Intl.message(
      'Light Mode',
      name: 'light_mode',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get dark_mode {
    return Intl.message(
      'Dark Mode',
      name: 'dark_mode',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get log_out {
    return Intl.message(
      'Logout',
      name: 'log_out',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get version {
    return Intl.message(
      'Version',
      name: 'version',
      desc: '',
      args: [],
    );
  }

  /// `You don't have any item in your cart`
  String get dont_have_any_item_in_your_cart {
    return Intl.message(
      'You don\'t have any item in your cart',
      name: 'dont_have_any_item_in_your_cart',
      desc: '',
      args: [],
    );
  }

  /// `Start Exploring`
  String get start_exploring {
    return Intl.message(
      'Start Exploring',
      name: 'start_exploring',
      desc: '',
      args: [],
    );
  }

  /// `You don't have any new notifications`
  String get dont_have_any_item_in_the_notification_list {
    return Intl.message(
      'You don\'t have any new notifications',
      name: 'dont_have_any_item_in_the_notification_list',
      desc: '',
      args: [],
    );
  }

  /// `Payment Settings`
  String get payment_settings {
    return Intl.message(
      'Payment Settings',
      name: 'payment_settings',
      desc: '',
      args: [],
    );
  }

  /// `Not a valid number`
  String get not_a_valid_number {
    return Intl.message(
      'Not a valid number',
      name: 'not_a_valid_number',
      desc: '',
      args: [],
    );
  }

  /// `Not a valid date`
  String get not_a_valid_date {
    return Intl.message(
      'Not a valid date',
      name: 'not_a_valid_date',
      desc: '',
      args: [],
    );
  }

  /// `Not a valid CVC`
  String get not_a_valid_cvc {
    return Intl.message(
      'Not a valid CVC',
      name: 'not_a_valid_cvc',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Not a valid full name`
  String get not_a_valid_full_name {
    return Intl.message(
      'Not a valid full name',
      name: 'not_a_valid_full_name',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get email_address {
    return Intl.message(
      'Email Address',
      name: 'email_address',
      desc: '',
      args: [],
    );
  }

  /// `Not a valid email`
  String get not_a_valid_email {
    return Intl.message(
      'Not a valid email',
      name: 'not_a_valid_email',
      desc: '',
      args: [],
    );
  }

  /// `Not a valid phone`
  String get not_a_valid_phone {
    return Intl.message(
      'Not a valid phone',
      name: 'not_a_valid_phone',
      desc: '',
      args: [],
    );
  }

  /// `Not a valid address`
  String get not_a_valid_address {
    return Intl.message(
      'Not a valid address',
      name: 'not_a_valid_address',
      desc: '',
      args: [],
    );
  }

  /// `Not a valid biography`
  String get not_a_valid_biography {
    return Intl.message(
      'Not a valid biography',
      name: 'not_a_valid_biography',
      desc: '',
      args: [],
    );
  }

  /// `Your biography`
  String get your_biography {
    return Intl.message(
      'Your biography',
      name: 'your_biography',
      desc: '',
      args: [],
    );
  }

  /// `Your Address`
  String get your_address {
    return Intl.message(
      'Your Address',
      name: 'your_address',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Recents Search`
  String get recents_search {
    return Intl.message(
      'Recents Search',
      name: 'recents_search',
      desc: '',
      args: [],
    );
  }

  /// `Verify your internet connection`
  String get verify_your_internet_connection {
    return Intl.message(
      'Verify your internet connection',
      name: 'verify_your_internet_connection',
      desc: '',
      args: [],
    );
  }

  /// `Carts refreshed successfully`
  String get carts_refreshed_successfully {
    return Intl.message(
      'Carts refreshed successfully',
      name: 'carts_refreshed_successfully',
      desc: '',
      args: [],
    );
  }

  /// `The {foodname} was removed from your cart`
  String the_food_was_removed_from_your_cart(Object foodname) {
    return Intl.message(
      'The $foodname was removed from your cart',
      name: 'the_food_was_removed_from_your_cart',
      desc: '',
      args: [foodname],
    );
  }

  /// `Category refreshed successfully`
  String get category_refreshed_successfully {
    return Intl.message(
      'Category refreshed successfully',
      name: 'category_refreshed_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Notifications refreshed successfully`
  String get notifications_refreshed_successfully {
    return Intl.message(
      'Notifications refreshed successfully',
      name: 'notifications_refreshed_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Order refreshed successfully`
  String get order_refreshed_successfully {
    return Intl.message(
      'Order refreshed successfully',
      name: 'order_refreshed_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Orders refreshed successfully`
  String get orders_refreshed_successfully {
    return Intl.message(
      'Orders refreshed successfully',
      name: 'orders_refreshed_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Restaurant refreshed successfully`
  String get restaurant_refreshed_successfully {
    return Intl.message(
      'Restaurant refreshed successfully',
      name: 'restaurant_refreshed_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Profile settings updated successfully`
  String get profile_settings_updated_successfully {
    return Intl.message(
      'Profile settings updated successfully',
      name: 'profile_settings_updated_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Payment settings updated successfully`
  String get payment_settings_updated_successfully {
    return Intl.message(
      'Payment settings updated successfully',
      name: 'payment_settings_updated_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Tracking refreshed successfully`
  String get tracking_refreshed_successfully {
    return Intl.message(
      'Tracking refreshed successfully',
      name: 'tracking_refreshed_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcome {
    return Intl.message(
      'Welcome',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Wrong email or password`
  String get wrong_email_or_password {
    return Intl.message(
      'Wrong email or password',
      name: 'wrong_email_or_password',
      desc: '',
      args: [],
    );
  }

  /// `Addresses refreshed successfully`
  String get addresses_refreshed_successfully {
    return Intl.message(
      'Addresses refreshed successfully',
      name: 'addresses_refreshed_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Addresses`
  String get delivery_addresses {
    return Intl.message(
      'Delivery Addresses',
      name: 'delivery_addresses',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `New Address added successfully`
  String get new_address_added_successfully {
    return Intl.message(
      'New Address added successfully',
      name: 'new_address_added_successfully',
      desc: '',
      args: [],
    );
  }

  /// `The address updated successfully`
  String get the_address_updated_successfully {
    return Intl.message(
      'The address updated successfully',
      name: 'the_address_updated_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Long press to edit item, swipe item to delete it`
  String get long_press_to_edit_item_swipe_item_to_delete_it {
    return Intl.message(
      'Long press to edit item, swipe item to delete it',
      name: 'long_press_to_edit_item_swipe_item_to_delete_it',
      desc: '',
      args: [],
    );
  }

  /// `Add Delivery Address`
  String get add_delivery_address {
    return Intl.message(
      'Add Delivery Address',
      name: 'add_delivery_address',
      desc: '',
      args: [],
    );
  }

  /// `Home Address`
  String get home_address {
    return Intl.message(
      'Home Address',
      name: 'home_address',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `12 Street, City 21663, Country`
  String get hint_full_address {
    return Intl.message(
      '12 Street, City 21663, Country',
      name: 'hint_full_address',
      desc: '',
      args: [],
    );
  }

  /// `Full Address`
  String get full_address {
    return Intl.message(
      'Full Address',
      name: 'full_address',
      desc: '',
      args: [],
    );
  }

  /// `Email to reset password`
  String get email_to_reset_password {
    return Intl.message(
      'Email to reset password',
      name: 'email_to_reset_password',
      desc: '',
      args: [],
    );
  }

  /// `Send link`
  String get send_password_reset_link {
    return Intl.message(
      'Send link',
      name: 'send_password_reset_link',
      desc: '',
      args: [],
    );
  }

  /// `I remember my password return to login`
  String get i_remember_my_password_return_to_login {
    return Intl.message(
      'I remember my password return to login',
      name: 'i_remember_my_password_return_to_login',
      desc: '',
      args: [],
    );
  }

  /// `Your reset link has been sent to your email`
  String get your_reset_link_has_been_sent_to_your_email {
    return Intl.message(
      'Your reset link has been sent to your email',
      name: 'your_reset_link_has_been_sent_to_your_email',
      desc: '',
      args: [],
    );
  }

  /// `Error! Verify email settings`
  String get error_verify_email_settings {
    return Intl.message(
      'Error! Verify email settings',
      name: 'error_verify_email_settings',
      desc: '',
      args: [],
    );
  }

  /// `Guest`
  String get guest {
    return Intl.message(
      'Guest',
      name: 'guest',
      desc: '',
      args: [],
    );
  }

  /// `You must sign-in to access to this section`
  String get you_must_signin_to_access_to_this_section {
    return Intl.message(
      'You must sign-in to access to this section',
      name: 'you_must_signin_to_access_to_this_section',
      desc: '',
      args: [],
    );
  }

  /// `Tell us about this restaurant`
  String get tell_us_about_this_restaurant {
    return Intl.message(
      'Tell us about this restaurant',
      name: 'tell_us_about_this_restaurant',
      desc: '',
      args: [],
    );
  }

  /// `How would you rate this restaurant ?`
  String get how_would_you_rate_this_restaurant_ {
    return Intl.message(
      'How would you rate this restaurant ?',
      name: 'how_would_you_rate_this_restaurant_',
      desc: '',
      args: [],
    );
  }

  /// `Tell us about this food`
  String get tell_us_about_this_food {
    return Intl.message(
      'Tell us about this food',
      name: 'tell_us_about_this_food',
      desc: '',
      args: [],
    );
  }

  /// `The restaurant has been rated successfully`
  String get the_restaurant_has_been_rated_successfully {
    return Intl.message(
      'The restaurant has been rated successfully',
      name: 'the_restaurant_has_been_rated_successfully',
      desc: '',
      args: [],
    );
  }

  /// `The food has been rated successfully`
  String get the_food_has_been_rated_successfully {
    return Intl.message(
      'The food has been rated successfully',
      name: 'the_food_has_been_rated_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Reviews refreshed successfully!`
  String get reviews_refreshed_successfully {
    return Intl.message(
      'Reviews refreshed successfully!',
      name: 'reviews_refreshed_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Fee`
  String get delivery_fee {
    return Intl.message(
      'Delivery Fee',
      name: 'delivery_fee',
      desc: '',
      args: [],
    );
  }

  /// `Order status changed`
  String get order_status_changed {
    return Intl.message(
      'Order status changed',
      name: 'order_status_changed',
      desc: '',
      args: [],
    );
  }

  /// `New order from client`
  String get new_order_from_client {
    return Intl.message(
      'New order from client',
      name: 'new_order_from_client',
      desc: '',
      args: [],
    );
  }

  /// `Shopping`
  String get shopping {
    return Intl.message(
      'Shopping',
      name: 'shopping',
      desc: '',
      args: [],
    );
  }

  /// `Delivery or Pickup`
  String get delivery_or_pickup {
    return Intl.message(
      'Delivery or Pickup',
      name: 'delivery_or_pickup',
      desc: '',
      args: [],
    );
  }

  /// `Payment card updated successfully`
  String get payment_card_updated_successfully {
    return Intl.message(
      'Payment card updated successfully',
      name: 'payment_card_updated_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Deliverable`
  String get deliverable {
    return Intl.message(
      'Deliverable',
      name: 'deliverable',
      desc: '',
      args: [],
    );
  }

  /// `Not Deliverable`
  String get not_deliverable {
    return Intl.message(
      'Not Deliverable',
      name: 'not_deliverable',
      desc: '',
      args: [],
    );
  }

  /// `Items`
  String get items {
    return Intl.message(
      'Items',
      name: 'items',
      desc: '',
      args: [],
    );
  }

  /// `Delivery`
  String get delivery {
    return Intl.message(
      'Delivery',
      name: 'delivery',
      desc: '',
      args: [],
    );
  }

  /// `Pickup`
  String get pickup {
    return Intl.message(
      'Pickup',
      name: 'pickup',
      desc: '',
      args: [],
    );
  }

  /// `Closed`
  String get closed {
    return Intl.message(
      'Closed',
      name: 'closed',
      desc: '',
      args: [],
    );
  }

  /// `Open`
  String get open {
    return Intl.message(
      'Open',
      name: 'open',
      desc: '',
      args: [],
    );
  }

  /// `Km`
  String get km {
    return Intl.message(
      'Km',
      name: 'km',
      desc: '',
      args: [],
    );
  }

  /// `mi`
  String get mi {
    return Intl.message(
      'mi',
      name: 'mi',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Address`
  String get delivery_address {
    return Intl.message(
      'Delivery Address',
      name: 'delivery_address',
      desc: '',
      args: [],
    );
  }

  /// `Current location`
  String get current_location {
    return Intl.message(
      'Current location',
      name: 'current_location',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Address removed successfully`
  String get delivery_address_removed_successfully {
    return Intl.message(
      'Delivery Address removed successfully',
      name: 'delivery_address_removed_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Add new delivery address`
  String get add_new_delivery_address {
    return Intl.message(
      'Add new delivery address',
      name: 'add_new_delivery_address',
      desc: '',
      args: [],
    );
  }

  /// `Restaurants near to your current location`
  String get restaurants_near_to_your_current_location {
    return Intl.message(
      'Restaurants near to your current location',
      name: 'restaurants_near_to_your_current_location',
      desc: '',
      args: [],
    );
  }

  /// `Restaurants near to`
  String get restaurants_near_to {
    return Intl.message(
      'Restaurants near to',
      name: 'restaurants_near_to',
      desc: '',
      args: [],
    );
  }

  /// `Near to`
  String get near_to {
    return Intl.message(
      'Near to',
      name: 'near_to',
      desc: '',
      args: [],
    );
  }

  /// `Near to your current location`
  String get near_to_your_current_location {
    return Intl.message(
      'Near to your current location',
      name: 'near_to_your_current_location',
      desc: '',
      args: [],
    );
  }

  /// `Pickup your food from the restaurant`
  String get pickup_your_food_from_the_restaurant {
    return Intl.message(
      'Pickup your food from the restaurant',
      name: 'pickup_your_food_from_the_restaurant',
      desc: '',
      args: [],
    );
  }

  /// `Confirm your delivery address`
  String get confirm_your_delivery_address {
    return Intl.message(
      'Confirm your delivery address',
      name: 'confirm_your_delivery_address',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get filter {
    return Intl.message(
      'Filter',
      name: 'filter',
      desc: '',
      args: [],
    );
  }

  /// `Clear`
  String get clear {
    return Intl.message(
      'Clear',
      name: 'clear',
      desc: '',
      args: [],
    );
  }

  /// `Apply Filters`
  String get apply_filters {
    return Intl.message(
      'Apply Filters',
      name: 'apply_filters',
      desc: '',
      args: [],
    );
  }

  /// `Opened Restaurants`
  String get opened_restaurants {
    return Intl.message(
      'Opened Restaurants',
      name: 'opened_restaurants',
      desc: '',
      args: [],
    );
  }

  /// `Fields`
  String get fields {
    return Intl.message(
      'Fields',
      name: 'fields',
      desc: '',
      args: [],
    );
  }

  /// `This food was added to cart`
  String get this_food_was_added_to_cart {
    return Intl.message(
      'This food was added to cart',
      name: 'this_food_was_added_to_cart',
      desc: '',
      args: [],
    );
  }

  /// `Foods result`
  String get foods_result {
    return Intl.message(
      'Foods result',
      name: 'foods_result',
      desc: '',
      args: [],
    );
  }

  /// `Foods Results`
  String get foods_results {
    return Intl.message(
      'Foods Results',
      name: 'foods_results',
      desc: '',
      args: [],
    );
  }

  /// `Restaurants Results`
  String get restaurants_results {
    return Intl.message(
      'Restaurants Results',
      name: 'restaurants_results',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `This restaurant is closed !`
  String get this_restaurant_is_closed_ {
    return Intl.message(
      'This restaurant is closed !',
      name: 'this_restaurant_is_closed_',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get unknown {
    return Intl.message(
      'Unknown',
      name: 'unknown',
      desc: '',
      args: [],
    );
  }

  /// `How would you rate this restaurant ?`
  String get how_would_you_rate_this_restaurant {
    return Intl.message(
      'How would you rate this restaurant ?',
      name: 'how_would_you_rate_this_restaurant',
      desc: '',
      args: [],
    );
  }

  /// `Click on the stars below to leave comments`
  String get click_on_the_stars_below_to_leave_comments {
    return Intl.message(
      'Click on the stars below to leave comments',
      name: 'click_on_the_stars_below_to_leave_comments',
      desc: '',
      args: [],
    );
  }

  /// `Click to confirm your address and pay or Long press to edit your address`
  String get click_to_confirm_your_address_and_pay_or_long_press {
    return Intl.message(
      'Click to confirm your address and pay or Long press to edit your address',
      name: 'click_to_confirm_your_address_and_pay_or_long_press',
      desc: '',
      args: [],
    );
  }

  /// `Visa Card`
  String get visa_card {
    return Intl.message(
      'Visa Card',
      name: 'visa_card',
      desc: '',
      args: [],
    );
  }

  /// `MasterCard`
  String get mastercard {
    return Intl.message(
      'MasterCard',
      name: 'mastercard',
      desc: '',
      args: [],
    );
  }

  /// `PayPal`
  String get paypal {
    return Intl.message(
      'PayPal',
      name: 'paypal',
      desc: '',
      args: [],
    );
  }

  /// `Pay on Pickup`
  String get pay_on_pickup {
    return Intl.message(
      'Pay on Pickup',
      name: 'pay_on_pickup',
      desc: '',
      args: [],
    );
  }

  /// `Click to pay with your Visa Card`
  String get click_to_pay_with_your_visa_card {
    return Intl.message(
      'Click to pay with your Visa Card',
      name: 'click_to_pay_with_your_visa_card',
      desc: '',
      args: [],
    );
  }

  /// `Click to pay with your MasterCard`
  String get click_to_pay_with_your_mastercard {
    return Intl.message(
      'Click to pay with your MasterCard',
      name: 'click_to_pay_with_your_mastercard',
      desc: '',
      args: [],
    );
  }

  /// `Click to pay with your PayPal account`
  String get click_to_pay_with_your_paypal_account {
    return Intl.message(
      'Click to pay with your PayPal account',
      name: 'click_to_pay_with_your_paypal_account',
      desc: '',
      args: [],
    );
  }

  /// `Click to pay cash on delivery`
  String get click_to_pay_cash_on_delivery {
    return Intl.message(
      'Click to pay cash on delivery',
      name: 'click_to_pay_cash_on_delivery',
      desc: '',
      args: [],
    );
  }

  /// `Click to pay on pickup`
  String get click_to_pay_on_pickup {
    return Intl.message(
      'Click to pay on pickup',
      name: 'click_to_pay_on_pickup',
      desc: '',
      args: [],
    );
  }

  /// `This email account exists`
  String get this_email_account_exists {
    return Intl.message(
      'This email account exists',
      name: 'this_email_account_exists',
      desc: '',
      args: [],
    );
  }

  /// `This account not exist`
  String get this_account_not_exist {
    return Intl.message(
      'This account not exist',
      name: 'this_account_not_exist',
      desc: '',
      args: [],
    );
  }

  /// `CARD NUMBER`
  String get card_number {
    return Intl.message(
      'CARD NUMBER',
      name: 'card_number',
      desc: '',
      args: [],
    );
  }

  /// `EXPIRY DATE`
  String get expiry_date {
    return Intl.message(
      'EXPIRY DATE',
      name: 'expiry_date',
      desc: '',
      args: [],
    );
  }

  /// `CVV`
  String get cvv {
    return Intl.message(
      'CVV',
      name: 'cvv',
      desc: '',
      args: [],
    );
  }

  /// `Your credit card not valid`
  String get your_credit_card_not_valid {
    return Intl.message(
      'Your credit card not valid',
      name: 'your_credit_card_not_valid',
      desc: '',
      args: [],
    );
  }

  /// `Number`
  String get number {
    return Intl.message(
      'Number',
      name: 'number',
      desc: '',
      args: [],
    );
  }

  /// `Exp Date`
  String get exp_date {
    return Intl.message(
      'Exp Date',
      name: 'exp_date',
      desc: '',
      args: [],
    );
  }

  /// `CVC`
  String get cvc {
    return Intl.message(
      'CVC',
      name: 'cvc',
      desc: '',
      args: [],
    );
  }

  /// `Cuisines`
  String get cuisines {
    return Intl.message(
      'Cuisines',
      name: 'cuisines',
      desc: '',
      args: [],
    );
  }

  /// `Favorites refreshed successfully`
  String get favorites_refreshed_successfully {
    return Intl.message(
      'Favorites refreshed successfully',
      name: 'favorites_refreshed_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Complete your profile details to continue`
  String get completeYourProfileDetailsToContinue {
    return Intl.message(
      'Complete your profile details to continue',
      name: 'completeYourProfileDetailsToContinue',
      desc: '',
      args: [],
    );
  }

  /// `Faqs refreshed successfully`
  String get faqsRefreshedSuccessfully {
    return Intl.message(
      'Faqs refreshed successfully',
      name: 'faqsRefreshedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `This food was added to favorite`
  String get thisFoodWasAddedToFavorite {
    return Intl.message(
      'This food was added to favorite',
      name: 'thisFoodWasAddedToFavorite',
      desc: '',
      args: [],
    );
  }

  /// `This food was removed from favorites`
  String get thisFoodWasRemovedFromFavorites {
    return Intl.message(
      'This food was removed from favorites',
      name: 'thisFoodWasRemovedFromFavorites',
      desc: '',
      args: [],
    );
  }

  /// `Food refreshed successfully`
  String get foodRefreshedSuccessfully {
    return Intl.message(
      'Food refreshed successfully',
      name: 'foodRefreshedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Delivery address outside the delivery range of this restaurants.`
  String get deliveryAddressOutsideTheDeliveryRangeOfThisRestaurants {
    return Intl.message(
      'Delivery address outside the delivery range of this restaurants.',
      name: 'deliveryAddressOutsideTheDeliveryRangeOfThisRestaurants',
      desc: '',
      args: [],
    );
  }

  /// `This restaurant not support delivery method.`
  String get thisRestaurantNotSupportDeliveryMethod {
    return Intl.message(
      'This restaurant not support delivery method.',
      name: 'thisRestaurantNotSupportDeliveryMethod',
      desc: '',
      args: [],
    );
  }

  /// `One or more foods in your cart not deliverable.`
  String get oneOrMoreFoodsInYourCartNotDeliverable {
    return Intl.message(
      'One or more foods in your cart not deliverable.',
      name: 'oneOrMoreFoodsInYourCartNotDeliverable',
      desc: '',
      args: [],
    );
  }

  /// `Delivery method not allowed!`
  String get deliveryMethodNotAllowed {
    return Intl.message(
      'Delivery method not allowed!',
      name: 'deliveryMethodNotAllowed',
      desc: '',
      args: [],
    );
  }

  /// `View Details`
  String get viewDetails {
    return Intl.message(
      'View Details',
      name: 'viewDetails',
      desc: '',
      args: [],
    );
  }

  /// `You don't  have any order`
  String get youDontHaveAnyOrder {
    return Intl.message(
      'You don\'t  have any order',
      name: 'youDontHaveAnyOrder',
      desc: '',
      args: [],
    );
  }

  /// `Order Details`
  String get orderDetails {
    return Intl.message(
      'Order Details',
      name: 'orderDetails',
      desc: '',
      args: [],
    );
  }

  /// `Order`
  String get order {
    return Intl.message(
      'Order',
      name: 'order',
      desc: '',
      args: [],
    );
  }

  /// `Details`
  String get details {
    return Intl.message(
      'Details',
      name: 'details',
      desc: '',
      args: [],
    );
  }

  /// `Canceled`
  String get canceled {
    return Intl.message(
      'Canceled',
      name: 'canceled',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Order`
  String get cancelOrder {
    return Intl.message(
      'Cancel Order',
      name: 'cancelOrder',
      desc: '',
      args: [],
    );
  }

  /// `View`
  String get view {
    return Intl.message(
      'View',
      name: 'view',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to cancel this order?`
  String get areYouSureYouWantToCancelThisOrder {
    return Intl.message(
      'Are you sure you want to cancel this order?',
      name: 'areYouSureYouWantToCancelThisOrder',
      desc: '',
      args: [],
    );
  }

  /// `Order: #{id} has been canceled`
  String orderThisorderidHasBeenCanceled(Object id) {
    return Intl.message(
      'Order: #$id has been canceled',
      name: 'orderThisorderidHasBeenCanceled',
      desc: '',
      args: [id],
    );
  }

  /// `Click on the food to get more details about it`
  String get clickOnTheFoodToGetMoreDetailsAboutIt {
    return Intl.message(
      'Click on the food to get more details about it',
      name: 'clickOnTheFoodToGetMoreDetailsAboutIt',
      desc: '',
      args: [],
    );
  }

  /// `RazorPay Payment`
  String get razorpayPayment {
    return Intl.message(
      'RazorPay Payment',
      name: 'razorpayPayment',
      desc: '',
      args: [],
    );
  }

  /// `RazorPay`
  String get razorpay {
    return Intl.message(
      'RazorPay',
      name: 'razorpay',
      desc: '',
      args: [],
    );
  }

  /// `Click to pay with RazorPay method`
  String get clickToPayWithRazorpayMethod {
    return Intl.message(
      'Click to pay with RazorPay method',
      name: 'clickToPayWithRazorpayMethod',
      desc: '',
      args: [],
    );
  }

  /// `Tap again to leave`
  String get tapAgainToLeave {
    return Intl.message(
      'Tap again to leave',
      name: 'tapAgainToLeave',
      desc: '',
      args: [],
    );
  }

  /// `Valid Coupon`
  String get validCouponCode {
    return Intl.message(
      'Valid Coupon',
      name: 'validCouponCode',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Coupon`
  String get invalidCouponCode {
    return Intl.message(
      'Invalid Coupon',
      name: 'invalidCouponCode',
      desc: '',
      args: [],
    );
  }

  /// `Have Coupon Code?`
  String get haveCouponCode {
    return Intl.message(
      'Have Coupon Code?',
      name: 'haveCouponCode',
      desc: '',
      args: [],
    );
  }

  /// `Messages`
  String get messages {
    return Intl.message(
      'Messages',
      name: 'messages',
      desc: '',
      args: [],
    );
  }

  /// `You don't have any conversations`
  String get youDontHaveAnyConversations {
    return Intl.message(
      'You don\'t have any conversations',
      name: 'youDontHaveAnyConversations',
      desc: '',
      args: [],
    );
  }

  /// `New message from`
  String get newMessageFrom {
    return Intl.message(
      'New message from',
      name: 'newMessageFrom',
      desc: '',
      args: [],
    );
  }

  /// `For more details, please chat with our managers`
  String get forMoreDetailsPleaseChatWithOurManagers {
    return Intl.message(
      'For more details, please chat with our managers',
      name: 'forMoreDetailsPleaseChatWithOurManagers',
      desc: '',
      args: [],
    );
  }

  /// `Sign-In to chat with our managers`
  String get signinToChatWithOurManagers {
    return Intl.message(
      'Sign-In to chat with our managers',
      name: 'signinToChatWithOurManagers',
      desc: '',
      args: [],
    );
  }

  /// `Type to start chat`
  String get typeToStartChat {
    return Intl.message(
      'Type to start chat',
      name: 'typeToStartChat',
      desc: '',
      args: [],
    );
  }

  /// `Make it default`
  String get makeItDefault {
    return Intl.message(
      'Make it default',
      name: 'makeItDefault',
      desc: '',
      args: [],
    );
  }

  /// `Not valid address`
  String get notValidAddress {
    return Intl.message(
      'Not valid address',
      name: 'notValidAddress',
      desc: '',
      args: [],
    );
  }

  /// `Swipe left the notification to delete or read / unread it`
  String get swipeLeftTheNotificationToDeleteOrReadUnreadIt {
    return Intl.message(
      'Swipe left the notification to delete or read / unread it',
      name: 'swipeLeftTheNotificationToDeleteOrReadUnreadIt',
      desc: '',
      args: [],
    );
  }

  /// `This notification has marked as unread`
  String get thisNotificationHasMarkedAsUnread {
    return Intl.message(
      'This notification has marked as unread',
      name: 'thisNotificationHasMarkedAsUnread',
      desc: '',
      args: [],
    );
  }

  /// `Notification was removed`
  String get notificationWasRemoved {
    return Intl.message(
      'Notification was removed',
      name: 'notificationWasRemoved',
      desc: '',
      args: [],
    );
  }

  /// `This notification has marked as read`
  String get thisNotificationHasMarkedAsRead {
    return Intl.message(
      'This notification has marked as read',
      name: 'thisNotificationHasMarkedAsRead',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Try Again`
  String get tryAgain {
    return Intl.message(
      'Try Again',
      name: 'tryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to Logout?`
  String get areYouSureToLogout {
    return Intl.message(
      'Are you sure to Logout?',
      name: 'areYouSureToLogout',
      desc: '',
      args: [],
    );
  }

  /// `Please Wait`
  String get please_wait {
    return Intl.message(
      'Please Wait',
      name: 'please_wait',
      desc: '',
      args: [],
    );
  }

  /// `Properties`
  String get properties {
    return Intl.message(
      'Properties',
      name: 'properties',
      desc: '',
      args: [],
    );
  }

  /// `Documents`
  String get documents {
    return Intl.message(
      'Documents',
      name: 'documents',
      desc: '',
      args: [],
    );
  }

  /// `found`
  String get found {
    return Intl.message(
      'found',
      name: 'found',
      desc: '',
      args: [],
    );
  }

  /// `Notifications Deleted Successfully`
  String get notifications_deleted_successfully {
    return Intl.message(
      'Notifications Deleted Successfully',
      name: 'notifications_deleted_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Error Deleting Notification`
  String get error_deleting_notification {
    return Intl.message(
      'Error Deleting Notification',
      name: 'error_deleting_notification',
      desc: '',
      args: [],
    );
  }

  /// `Error Deleting Notifications`
  String get error_deleting_notifications {
    return Intl.message(
      'Error Deleting Notifications',
      name: 'error_deleting_notifications',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Your Password?`
  String get forgot_your_password {
    return Intl.message(
      'Forgot Your Password?',
      name: 'forgot_your_password',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to `
  String get welcome_to {
    return Intl.message(
      'Welcome to ',
      name: 'welcome_to',
      desc: '',
      args: [],
    );
  }

  /// `Scan a QR Code`
  String get scan_code {
    return Intl.message(
      'Scan a QR Code',
      name: 'scan_code',
      desc: '',
      args: [],
    );
  }

  /// `brings all important property related documents into one easy-to-access portal`
  String
      get brings_all_important_property_related_documents_into_one_easy_to_access_portal {
    return Intl.message(
      'brings all important property related documents into one easy-to-access portal',
      name:
          'brings_all_important_property_related_documents_into_one_easy_to_access_portal',
      desc: '',
      args: [],
    );
  }

  /// `Tenants, Please contact your Landlord for Login Details`
  String get tenants_please_contact_your_landlord_for_login_details {
    return Intl.message(
      'Tenants, Please contact your Landlord for Login Details',
      name: 'tenants_please_contact_your_landlord_for_login_details',
      desc: '',
      args: [],
    );
  }

  /// `Contractors, Please contact the Management of your Organization for Login Details`
  String
      get contractors_please_contact_the_management_of_your_organization_for_login_details {
    return Intl.message(
      'Contractors, Please contact the Management of your Organization for Login Details',
      name:
          'contractors_please_contact_the_management_of_your_organization_for_login_details',
      desc: '',
      args: [],
    );
  }

  /// `For our public website, please visit`
  String get for_our_public_website_please_visit {
    return Intl.message(
      'For our public website, please visit',
      name: 'for_our_public_website_please_visit',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message(
      'Back',
      name: 'back',
      desc: '',
      args: [],
    );
  }

  /// `Front`
  String get front {
    return Intl.message(
      'Front',
      name: 'front',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to delete the Notification?`
  String get doYouWantToDeleteTheNotification {
    return Intl.message(
      'Do you want to delete the Notification?',
      name: 'doYouWantToDeleteTheNotification',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to delete the selected Notifications?`
  String get doYouWantToDeleteTheSelectedNotifications {
    return Intl.message(
      'Do you want to delete the selected Notifications?',
      name: 'doYouWantToDeleteTheSelectedNotifications',
      desc: '',
      args: [],
    );
  }

  /// `The server is unresponsive or busy. Please try again later`
  String get serverError {
    return Intl.message(
      'The server is unresponsive or busy. Please try again later',
      name: 'serverError',
      desc: '',
      args: [],
    );
  }

  /// `Logged in Successfully`
  String get successfulSignIn {
    return Intl.message(
      'Logged in Successfully',
      name: 'successfulSignIn',
      desc: '',
      args: [],
    );
  }

  /// `Please select notifications to delete`
  String get pleaseSelectNotificationsToDelete {
    return Intl.message(
      'Please select notifications to delete',
      name: 'pleaseSelectNotificationsToDelete',
      desc: '',
      args: [],
    );
  }

  /// `App Version`
  String get appVersion {
    return Intl.message(
      'App Version',
      name: 'appVersion',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Acceptable Use Policy`
  String get acceptableUsePolicy {
    return Intl.message(
      'Acceptable Use Policy',
      name: 'acceptableUsePolicy',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Property`
  String get property {
    return Intl.message(
      'Property',
      name: 'property',
      desc: '',
      args: [],
    );
  }

  /// `Property Type`
  String get propertyType {
    return Intl.message(
      'Property Type',
      name: 'propertyType',
      desc: '',
      args: [],
    );
  }

  /// `Date Added`
  String get dateAdded {
    return Intl.message(
      'Date Added',
      name: 'dateAdded',
      desc: '',
      args: [],
    );
  }

  /// `Register Number`
  String get registerNumber {
    return Intl.message(
      'Register Number',
      name: 'registerNumber',
      desc: '',
      args: [],
    );
  }

  /// `Passwords must be at least 10 characters`
  String get passwordLengthConstraint {
    return Intl.message(
      'Passwords must be at least 10 characters',
      name: 'passwordLengthConstraint',
      desc: '',
      args: [],
    );
  }

  /// `Passwords must have at least a digit, a special-character and an upper-case letter`
  String get passwordCharacterConstraint {
    return Intl.message(
      'Passwords must have at least a digit, a special-character and an upper-case letter',
      name: 'passwordCharacterConstraint',
      desc: '',
      args: [],
    );
  }

  /// `Company Name`
  String get companyName {
    return Intl.message(
      'Company Name',
      name: 'companyName',
      desc: '',
      args: [],
    );
  }

  /// `Company Details`
  String get companyDetails {
    return Intl.message(
      'Company Details',
      name: 'companyDetails',
      desc: '',
      args: [],
    );
  }

  /// `Please Select a Property Type`
  String get please_select_a_property_type {
    return Intl.message(
      'Please Select a Property Type',
      name: 'please_select_a_property_type',
      desc: '',
      args: [],
    );
  }

  /// `Please Select a Property`
  String get please_select_a_property {
    return Intl.message(
      'Please Select a Property',
      name: 'please_select_a_property',
      desc: '',
      args: [],
    );
  }

  /// `Please Select a Common Area`
  String get please_select_a_common_area {
    return Intl.message(
      'Please Select a Common Area',
      name: 'please_select_a_common_area',
      desc: '',
      args: [],
    );
  }

  /// `Please Select a Document Type`
  String get please_select_a_document_type {
    return Intl.message(
      'Please Select a Document Type',
      name: 'please_select_a_document_type',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a Valid Company Name`
  String get please_enter_a_valid_company_name {
    return Intl.message(
      'Please enter a Valid Company Name',
      name: 'please_enter_a_valid_company_name',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Description`
  String get please_enter_description {
    return Intl.message(
      'Please Enter Description',
      name: 'please_enter_description',
      desc: '',
      args: [],
    );
  }

  /// `Company Phone`
  String get companyPhone {
    return Intl.message(
      'Company Phone',
      name: 'companyPhone',
      desc: '',
      args: [],
    );
  }

  /// `Sectors`
  String get sectors {
    return Intl.message(
      'Sectors',
      name: 'sectors',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter a Valid Date`
  String get please_enter_a_valid_date {
    return Intl.message(
      'Please Enter a Valid Date',
      name: 'please_enter_a_valid_date',
      desc: '',
      args: [],
    );
  }

  /// `Company`
  String get company {
    return Intl.message(
      'Company',
      name: 'company',
      desc: '',
      args: [],
    );
  }

  /// `No FAQs Found`
  String get emptyFAQ {
    return Intl.message(
      'No FAQs Found',
      name: 'emptyFAQ',
      desc: '',
      args: [],
    );
  }

  /// `View Property`
  String get viewProperty {
    return Intl.message(
      'View Property',
      name: 'viewProperty',
      desc: '',
      args: [],
    );
  }

  /// `You are running out of Storage`
  String get outOfSpace {
    return Intl.message(
      'You are running out of Storage',
      name: 'outOfSpace',
      desc: '',
      args: [],
    );
  }

  /// `No Properties Found`
  String get emptyProperty {
    return Intl.message(
      'No Properties Found',
      name: 'emptyProperty',
      desc: '',
      args: [],
    );
  }

  /// `Select a Document Type`
  String get select_a_document_type {
    return Intl.message(
      'Select a Document Type',
      name: 'select_a_document_type',
      desc: '',
      args: [],
    );
  }

  /// `Document Name`
  String get documentName {
    return Intl.message(
      'Document Name',
      name: 'documentName',
      desc: '',
      args: [],
    );
  }

  /// `year`
  String get year {
    return Intl.message(
      'year',
      name: 'year',
      desc: '',
      args: [],
    );
  }

  /// `years`
  String get years {
    return Intl.message(
      'years',
      name: 'years',
      desc: '',
      args: [],
    );
  }

  /// `Register Your Account`
  String get registerYourAccount {
    return Intl.message(
      'Register Your Account',
      name: 'registerYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirm_password {
    return Intl.message(
      'Confirm Password',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Add For Another User`
  String get add_for_another_user {
    return Intl.message(
      'Add For Another User',
      name: 'add_for_another_user',
      desc: '',
      args: [],
    );
  }

  /// `Back to Home`
  String get back_to_home {
    return Intl.message(
      'Back to Home',
      name: 'back_to_home',
      desc: '',
      args: [],
    );
  }

  /// `Finish`
  String get finish {
    return Intl.message(
      'Finish',
      name: 'finish',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get first_name {
    return Intl.message(
      'First Name',
      name: 'first_name',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get last_name {
    return Intl.message(
      'Last Name',
      name: 'last_name',
      desc: '',
      args: [],
    );
  }

  /// `Purchase some to add more`
  String get buy_to_add_more {
    return Intl.message(
      'Purchase some to add more',
      name: 'buy_to_add_more',
      desc: '',
      args: [],
    );
  }

  /// `To purchase, login to your account through web`
  String get login_to_web_to_buy {
    return Intl.message(
      'To purchase, login to your account through web',
      name: 'login_to_web_to_buy',
      desc: '',
      args: [],
    );
  }

  /// `You have`
  String get you_have {
    return Intl.message(
      'You have',
      name: 'you_have',
      desc: '',
      args: [],
    );
  }

  /// `document spaces available`
  String get spaces_available {
    return Intl.message(
      'document spaces available',
      name: 'spaces_available',
      desc: '',
      args: [],
    );
  }

  /// `Lookup`
  String get look_up {
    return Intl.message(
      'Lookup',
      name: 'look_up',
      desc: '',
      args: [],
    );
  }

  /// `No Common Areas Found`
  String get emptyCommonArea {
    return Intl.message(
      'No Common Areas Found',
      name: 'emptyCommonArea',
      desc: '',
      args: [],
    );
  }

  /// `Thank You`
  String get thank_you {
    return Intl.message(
      'Thank You',
      name: 'thank_you',
      desc: '',
      args: [],
    );
  }

  /// `Your new document and details are uploaded successfully to`
  String get document_upload_success {
    return Intl.message(
      'Your new document and details are uploaded successfully to',
      name: 'document_upload_success',
      desc: '',
      args: [],
    );
  }

  /// `The document`
  String get the_document {
    return Intl.message(
      'The document',
      name: 'the_document',
      desc: '',
      args: [],
    );
  }

  /// `is now stored against the property `
  String get is_now_stored_against_the_property {
    return Intl.message(
      'is now stored against the property ',
      name: 'is_now_stored_against_the_property',
      desc: '',
      args: [],
    );
  }

  /// `and you will receive an email or a notification in app one month before the expiration date you set of`
  String get you_will_get_expiry_notification {
    return Intl.message(
      'and you will receive an email or a notification in app one month before the expiration date you set of',
      name: 'you_will_get_expiry_notification',
      desc: '',
      args: [],
    );
  }

  /// `If any of those details need an update, you can do the same in the Edit Document Screen.`
  String get go_to_edit_document_to_update {
    return Intl.message(
      'If any of those details need an update, you can do the same in the Edit Document Screen.',
      name: 'go_to_edit_document_to_update',
      desc: '',
      args: [],
    );
  }

  /// `Completion`
  String get completion {
    return Intl.message(
      'Completion',
      name: 'completion',
      desc: '',
      args: [],
    );
  }

  /// `QR Installation Date`
  String get qr_installation_date {
    return Intl.message(
      'QR Installation Date',
      name: 'qr_installation_date',
      desc: '',
      args: [],
    );
  }

  /// `Pin/Zip/Postal Code`
  String get pincode {
    return Intl.message(
      'Pin/Zip/Postal Code',
      name: 'pincode',
      desc: '',
      args: [],
    );
  }

  /// `Common Areas`
  String get commonAreas {
    return Intl.message(
      'Common Areas',
      name: 'commonAreas',
      desc: '',
      args: [],
    );
  }

  /// `Select an Address`
  String get select_an_address {
    return Intl.message(
      'Select an Address',
      name: 'select_an_address',
      desc: '',
      args: [],
    );
  }

  /// `Edit this Property`
  String get edit_this_property {
    return Intl.message(
      'Edit this Property',
      name: 'edit_this_property',
      desc: '',
      args: [],
    );
  }

  /// `QR Code Added On`
  String get qr_code_added_on {
    return Intl.message(
      'QR Code Added On',
      name: 'qr_code_added_on',
      desc: '',
      args: [],
    );
  }

  /// `Electrical`
  String get electrical {
    return Intl.message(
      'Electrical',
      name: 'electrical',
      desc: '',
      args: [],
    );
  }

  /// `Compliance`
  String get compliance {
    return Intl.message(
      'Compliance',
      name: 'compliance',
      desc: '',
      args: [],
    );
  }

  /// `Gas Safe`
  String get gas_safe {
    return Intl.message(
      'Gas Safe',
      name: 'gas_safe',
      desc: '',
      args: [],
    );
  }

  /// `Construction`
  String get construction {
    return Intl.message(
      'Construction',
      name: 'construction',
      desc: '',
      args: [],
    );
  }

  /// `FENSA`
  String get fensa {
    return Intl.message(
      'FENSA',
      name: 'fensa',
      desc: '',
      args: [],
    );
  }

  /// `Other`
  String get other {
    return Intl.message(
      'Other',
      name: 'other',
      desc: '',
      args: [],
    );
  }

  /// `No Documents Found`
  String get emptyDocument {
    return Intl.message(
      'No Documents Found',
      name: 'emptyDocument',
      desc: '',
      args: [],
    );
  }

  /// `Tap`
  String get tap {
    return Intl.message(
      'Tap',
      name: 'tap',
      desc: '',
      args: [],
    );
  }

  /// `Would you like to add a new common area?`
  String get do_you_want_to_add_a_new_common_area {
    return Intl.message(
      'Would you like to add a new common area?',
      name: 'do_you_want_to_add_a_new_common_area',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to Add a document to this Common Area?`
  String get do_you_want_to_add_a_new_document_to_this_common_area {
    return Intl.message(
      'Do you want to Add a document to this Common Area?',
      name: 'do_you_want_to_add_a_new_document_to_this_common_area',
      desc: '',
      args: [],
    );
  }

  /// `Purchase More Storage`
  String get buy_more_storage {
    return Intl.message(
      'Purchase More Storage',
      name: 'buy_more_storage',
      desc: '',
      args: [],
    );
  }

  /// `to add more`
  String get to_add_more {
    return Intl.message(
      'to add more',
      name: 'to_add_more',
      desc: '',
      args: [],
    );
  }

  /// `Common Area`
  String get common_area {
    return Intl.message(
      'Common Area',
      name: 'common_area',
      desc: '',
      args: [],
    );
  }

  /// `Options`
  String get options {
    return Intl.message(
      'Options',
      name: 'options',
      desc: '',
      args: [],
    );
  }

  /// `Choose Image`
  String get choose_image {
    return Intl.message(
      'Choose Image',
      name: 'choose_image',
      desc: '',
      args: [],
    );
  }

  /// `View Document`
  String get viewDocument {
    return Intl.message(
      'View Document',
      name: 'viewDocument',
      desc: '',
      args: [],
    );
  }

  /// `Document Type`
  String get document_type {
    return Intl.message(
      'Document Type',
      name: 'document_type',
      desc: '',
      args: [],
    );
  }

  /// `Edit Document`
  String get edit_document {
    return Intl.message(
      'Edit Document',
      name: 'edit_document',
      desc: '',
      args: [],
    );
  }

  /// `Select a Property`
  String get select_a_property {
    return Intl.message(
      'Select a Property',
      name: 'select_a_property',
      desc: '',
      args: [],
    );
  }

  /// `Select a Common Area Type`
  String get select_a_common_area_type {
    return Intl.message(
      'Select a Common Area Type',
      name: 'select_a_common_area_type',
      desc: '',
      args: [],
    );
  }

  /// `Please Request Access to this property from your Admin`
  String get request_access_from_admin {
    return Intl.message(
      'Please Request Access to this property from your Admin',
      name: 'request_access_from_admin',
      desc: '',
      args: [],
    );
  }

  /// `Authentication Error`
  String get authentication_error {
    return Intl.message(
      'Authentication Error',
      name: 'authentication_error',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'fr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
