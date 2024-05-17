import 'models/document.dart';
import 'web_pages/login_page.dart';
import 'package:flutter/material.dart';
import 'models/route_argument.dart';
import 'web_pages/web_home_page.dart';
import 'mobile_screens/settings.dart';
import 'mobile_screens/add_tenant.dart';
import 'web_pages/other_data_page.dart';
import 'mobile_screens/faq_screen.dart';
import 'widgets/route_error_screen.dart';
import 'mobile_screens/home_screen.dart';
import 'mobile_screens/login_screen.dart';
import 'mobile_screens/about_screen.dart';
import 'mobile_screens/profile_screen.dart';
import 'mobile_screens/register_screen.dart';
import 'mobile_screens/properties_screen.dart';
import 'mobile_screens/access_list_screen.dart';
import 'mobile_screens/get_started_screen.dart';
import 'mobile_screens/add_property_screen.dart';
import 'mobile_screens/profile_edit_screen.dart';
import 'mobile_screens/add_landlord_screen.dart';
import 'mobile_screens/add_property_success.dart';
import 'mobile_screens/all_documents_screen.dart';
import 'mobile_screens/edit_property_screen.dart';
import 'mobile_screens/notifications_screen.dart';
import 'mobile_screens/edit_document_screen.dart';
import 'mobile_screens/access_request_sucess.dart';
import 'mobile_screens/access_granted_screen.dart';
import 'mobile_screens/add_other_user_screen.dart';
import 'mobile_screens/single_property_screen.dart';
import 'mobile_screens/added_property_details.dart';
import 'mobile_screens/forgot_password_screen.dart';
import 'mobile_screens/property_details_screen.dart';
import 'mobile_screens/document_details_screen.dart';
import 'mobile_screens/own_property_scan_screen.dart';
import 'mobile_screens/add_property_others_success.dart';
import 'mobile_screens/notification_details_screen.dart';
import 'mobile_screens/add_and_edit_document_screen.dart';
import 'mobile_screens/contractor_properties_screen.dart';
import 'mobile_screens/add_landlordproperty_success.dart';
import 'mobile_screens/request_access_screen_scanpage.dart';
import 'mobile_screens/contractor_complete_installation_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    Widget pageBuilder(BuildContext context) {
      final args = settings.arguments;
      switch (settings.name) {
        case '/mobile_login':
          return const LoginScreen();
        case '/mobile_home':
          return const HomeScreen();
        case '/properties':
          return const PropertiesScreen();
        case '/property_details':
          return PropertyDetailsScreen(rar: args as RouteArgument);
        case '/added_property_details':
          return AddedPropertyDetails(rar: args as RouteArgument);
        case '/add_property':
          return AddPropertyScreen(rar: args as RouteArgument);
        case '/request_access_scanpage':
          return RequestAccessScanPageScreen(rar: args as RouteArgument);
        case '/add_property_success':
          return AddPropertySuccess(rar: args as RouteArgument);
        case '/all_documents':
          return const AllDocumentsScreen();
        case '/profile_edit':
          return ProfileEditScreen(rar: args as RouteArgument);
        case '/profile':
          return const ProfileScreen();
        case '/edit_property':
          return EditPropertyScreen(rar: args as RouteArgument);
        case '/notification_details':
          return NotificationDetailsScreen(reqaccid: args as RouteArgument);
        case '/forgot_password':
          return const ForgotPasswordScreen();
        case '/contractor_properties':
          return const ContractorPropertiesScreen();
        case '/own_property':
          return OwnPropertyScanScreen(rar: args as RouteArgument);
        case '/mobile_about':
          return const AboutScreen();
        case '/settings':
          return const SettingScreen();
        case '/add_other_user':
          return AddOtherUserScreen(rar: args as RouteArgument);
        case '/document_details':
          return DocumentDetailsScreen(rar: args as RouteArgument);
        case '/web_home':
          return const WebHomePage();
        case '/web_other_data':
          return OtherDataPage(title: args as String);
        case '/help':
          return const FAQScreen();
        case '/web_login':
          return const LoginPage();
        case '/register_contractor':
          return ContractorCompleteInstallationScreen(
              rar: args as RouteArgument);
        case '/register':
          return const SignUpScreen();
        case '/notifications':
          return NotificationsScreen(rar: args as RouteArgument);
        case '/add_or_edit_document':
          return AddAndEditDocumentScreen(document: args as Document?);
        case '/edit_document_screen':
          return EditDocumentScreen(document: args as Document?);
        case '/access_granted_screen':
          return AccessGrantedScreen(rar: args as RouteArgument);
        case '/get_started':
          return GetStartedScreen(flag: args as bool);
        case '/access_request_success':
          return AccessRequestSuccess(rar: args as RouteArgument);
        case '/single_property_view':
          return SinglePropertyScreen(rar: args as RouteArgument);
        case '/add_landlord':
          return AddLandlordUserScreen(rar: args as RouteArgument);
        case '/add_property_other_success':
          return AddPropertyOtherSuccess(rar: args as RouteArgument);
        case '/add_tenant':
          return AddTenantScreen(rar: args as RouteArgument);
        case '/add_landlord_success':
          return AddPropertyLandlordSuccess(rar: args as RouteArgument);
        case '/access_list_screen':
          return AccessListScreen(rar: args as RouteArgument);
        default:
          return const RouteErrorScreen(flag: false);
      }
    }

    return MaterialPageRoute(builder: pageBuilder, settings: settings);
  }
}
