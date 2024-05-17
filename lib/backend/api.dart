import 'dart:async';
import 'dart:io';
import 'dart:convert';
// import 'package:flutter_native_image/flutter_native_image.dart';
import '../models/faq.dart';
import '../models/user.dart';
import '../models/reply.dart';
import 'package:http/http.dart';
import '../helpers/helper.dart';
import '../models/property.dart';
import '../models/faq_base.dart';
import '../models/document.dart';
import '../models/misc_data.dart';
import '../models/user_base.dart';
import '../models/accesslist.dart';
import '../models/read_request.dart';
import '../models/property_base.dart';
import '../models/document_base.dart';
import '../models/document_type.dart';
import '../models/property_type.dart';
import 'package:flutter/material.dart';
import '../models/pin_code_result.dart';
import '../models/user_notification.dart';
import '../models/property_type_base.dart';
import '../models/document_type_base.dart';
import '../models/pin_code_result_base.dart';
import '../models/user_notification_base.dart';
import 'package:image_picker/image_picker.dart';
import '../models/contractor_property_base.dart';
import 'package:shared_preferences/shared_preferences.dart';

StreamController<List<Property>> propertyController =
    StreamController<List<Property>>.broadcast();
StreamController<List<Document>> documentController =
    StreamController<List<Document>>.broadcast();
final sharedPrefs = SharedPreferences.getInstance();
ValueNotifier<int> remainingSpace = ValueNotifier<int>(-1),
    totalDocsCount = ValueNotifier<int>(-1),
    notificationCount = ValueNotifier<int>(-1);
ValueNotifier<User> currentUser = ValueNotifier(User.emptyUser);
ValueNotifier<Property> props = ValueNotifier(Property.emptyProperty);
ValueNotifier<Document> docs = ValueNotifier(Document.emptyDocument);
ValueNotifier<UserNotification> notifier =
    ValueNotifier(UserNotification.emptyNotification);
ValueNotifier<PinCodeResult> location =
    ValueNotifier(PinCodeResult.emptyResult);

void setUser() async {
  final prefs = await sharedPrefs;
  const key = 'User';
  if (prefs.containsKey(key)) {
    final uss = prefs.getString(key) ?? '';
    final user = User.fromMap(json.decode(uss));
    currentUser.value = user;
    user.onChange();
  }
}

class API {
  late String baseURL;
  final ApiMode mode;
  API(this.mode) {
    baseURL = gc?.getValue<String>(mode.name) ?? '';
  }
  void getNotificationCount() async {
    try {
      final client = Client();
      final url = Uri.parse('${baseURL}get_notification_count');
      final response = await client.post(url, body: currentUser.value.map);
      client.close();
      final data = json.decode(response.body) as Map<String, dynamic>;
      final od = OtherData.fromMap(data);
      notificationCount.value = int.tryParse(od.data.toString()) ?? 0;
      od.onChange();
    } catch (e) {
      sendAppLog(e);
    }
  }

  Future<UserBase> login(Map<String, dynamic> body) async {
    try {
      log(baseURL);
      final client = Client();
      final url = Uri.parse('${baseURL}login');
      log(url);
      log(body);
      final response = await client.post(url, body: body);
      client.close();
      log(response.body);
      final data = json.decode(response.body) as Map<String, dynamic>;
      final rp = Reply.fromMap(data);
      if (response.statusCode == 200 && rp.success) {
        final ub = UserBase.fromMap(data);
        log(ub.base.success);
        currentUser.value = ub.user;
        currentUser.value.onChange();
        return ub;
      } else {
        return UserBase(rp, User.emptyUser);
      }
    } catch (e) {
      sendAppLog(e);
      rethrow;
    }
  }

  Future<Reply> register(Map<String, dynamic> body) async {
    final clientHttp = HttpClient();
    final url = Uri.parse('${baseURL}signup');
    final request = await clientHttp.postUrl(url);

    final reqStr = json.encode(body);
    request.headers.set('content-type', 'application/json');
    request.headers.contentType =
        ContentType('application', 'json', charset: 'utf-8');
    request.write(reqStr);
    try {
      final response = await request.close();
      clientHttp.close();
      final data = await response.transform(utf8.decoder).join();
      final rpl = Reply.fromMap(json.decode(data));
      rpl.onChange();
      return response.statusCode == 200 ? rpl : Reply.emptyReply;
    } catch (e) {
      sendAppLog(e);
      rethrow;
    }
  }

  Future<PinCodeResult> getAddresses(Map<String, dynamic> body) async {
    try {
      final client = Client();
      final url = Uri.parse('${baseURL}postcode_lookup');
      final response = await client.post(url, body: body);
      log(response.body);
      client.close();
      final data = json.decode(response.body);
      final pcb = PinCodeResultBase.fromMap(data);
      pcb.result.onChange();
      return response.statusCode == 200 && pcb.success
          ? pcb.result
          : PinCodeResult.emptyResult;
    } catch (e) {
      sendAppLog(e);
      rethrow;
    }
  }

  Future<bool> updateUserDetails(Map<String, dynamic> body) async {
    final prefs = await sharedPrefs;
    final clientHttp = HttpClient();
    final url = Uri.parse('${baseURL}update_user_profile');
    final request = await clientHttp.postUrl(url);
    final reqStr = json.encode(body);
    request.headers.set('content-type', 'application/json');
    request.write(reqStr);
    try {
      final response = await request.close();
      clientHttp.close();
      final data = json.decode(await response.transform(utf8.decoder).join());
      final ub = UserBase.fromMap(data);
      currentUser.value = User.emptyUser;
      currentUser.value = ub.user;
      location.value = PinCodeResult.emptyResult;
      final p =
          ub.base.success && await prefs.setString('User', ub.user.toString());
      if (p) ub.user.onChange();
      return p;
    } catch (e) {
      sendAppLog(e);
      return false;
    }
  }

  Future<List<Property>> getProperties() async {
    final clientHttp = HttpClient();
    final url = Uri.parse('${baseURL}get_properties');
    final request = await clientHttp.postUrl(url);
    final body = currentUser.value.map;
    final reqStr = json.encode(body);
    request.headers.set('content-type', 'application/json');
    request.write(reqStr);
    try {
      final response = await request.close();
      clientHttp.close();
      final data = json.decode(await response.transform(utf8.decoder).join());
      final pb = PropertyBase.fromMap(data);
      remainingSpace.value = pb.docCount;
      totalDocsCount.value = pb.count;
      pb.onChange();
      return pb.reply.success && response.statusCode == 200
          ? pb.properties
          : <Property>[];
    } catch (e) {
      sendAppLog(e);
      rethrow;
    }

    /*try {
      final client = Client();
      final url = Uri.parse('${baseURL}get_properties');
      log(url);
      log(currentUser.value.map);
      final response = await client.post(url, body: currentUser.value.map);
      final data = json.decode(response.body);
      log(response.body);
      client.close();
      final pb = PropertyBase.fromMap(data);
      remainingSpace.value = pb.docCount;
      totalDocsCount.value = pb.count;
      pb.onChange();
      return pb.reply.success && response.statusCode == 200
          ? pb.properties
          : <Property>[];
    } catch (e) {
      sendAppLog(e);
      rethrow;
    }*/
  }

  Future<List<Document>> getDocuments({Property? property}) async {
    try {
      final client = Client();
      final url = Uri.parse('${baseURL}get_documents');
      log(url);
      log(property == null ? currentUser.value.map : property.map);
      final response = await client.post(url,
          body: property == null ? currentUser.value.map : property.map);
      log(response.body);
      client.close();
      final data = json.decode(response.body) as Map<String, dynamic>;
      final db = DocumentBase.fromMap(data);
      db.onChange();
      return response.statusCode == 200 && db.reply.success
          ? db.documents
          : <Document>[];
    } catch (e) {
      sendAppLog(e);
      rethrow;
    }
  }

  Future<List<UserNotification>> getNotifications() async {
    try {
      final client = Client();
      final url = Uri.parse('${baseURL}notifications');
      log(url);
      log(currentUser.value.map);
      final response = await client.post(url, body: currentUser.value.map);

      final data = json.decode(response.body) as Map<String, dynamic>;
      client.close();
      final np = UserNotificationBase.fromMap(data);
      log(data);
      return response.statusCode == 200 && np.base.success
          ? np.notifications
          : <UserNotification>[];
    } catch (e) {
      sendAppLog(e);
      rethrow;
    }
  }

  Future<Reply> deleteNotification(Map<String, dynamic> body) async {
    final clientHttp = HttpClient();
    final url = Uri.parse('${baseURL}delete_notifications');
    final request = await clientHttp.postUrl(url);
    final reqStr = json.encode(body);
    // request.headers
    //     .set('Authorization', 'Bearer ' + sharedPrefs.getString('apiToken'));
    request.headers.set('content-type', 'application/json');
    request.headers.contentType =
        ContentType('application', 'json', charset: 'utf-8');
    request.write(reqStr);
    try {
      final response = await request.close();
      clientHttp.close();
      final data = await response.transform(utf8.decoder).join();
      final rpl = Reply.fromMap(json.decode(data));
      rpl.onChange();
      return response.statusCode == 200 ? rpl : Reply.emptyReply;
    } catch (e) {
      sendAppLog(e);
      rethrow;
    }
  }

  Future<List<PropertyType>> getPropertyTypes() async {
    try {
      final client = Client();
      final url = Uri.parse('${baseURL}get_property_type');
      final response = await client.get(url);
      // log(response.body);
      client.close();
      final data = json.decode(response.body) as Map<String, dynamic>;
      final ptb = PropertyTypeBase.fromMap(data);
      return response.statusCode == 200 && ptb.reply.success
          ? ptb.propertyTypes
          : <PropertyType>[];
    } catch (e) {
      sendAppLog(e);
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getPropertyStatus(
      Map<String, dynamic> body) async {
    try {
      final client = Client();
      final url = Uri.parse('${baseURL}scan_properties');
      log(url);
      log(body);
      log('object');
      final response = await client.post(url, body: body);
      log(response.body);
      client.close();
      final data = json.decode(response.body) as Map<String, dynamic>;
      return response.statusCode == 200 ? data : <String, dynamic>{};
    } catch (e) {
      sendAppLog(e);
      rethrow;
    }
  }

  Future<OtherData> addProperty(Map<String, dynamic> body) async {
    try {
      final client = Client();
      final url = Uri.parse('${baseURL}addcustomerproperty');
      final response = await client.post(url, body: body);
      client.close();
      final data = json.decode(response.body) as Map<String, dynamic>;
      final od = OtherData.fromMap(data);
      od.onChange();
      log(data);
      return response.statusCode == 200
          ? od
          : OtherData(Reply.emptyReply, null);
    } catch (e) {
      sendAppLog(e);
      rethrow;
    }
  }

  Future<Reply> updatePropertyCode(Map<String, dynamic> body) async {
    try {
      final client = Client();
      final url = Uri.parse('${baseURL}updatepropertyqrcode');
      final response = await client.post(url, body: body);
      client.close();
      final data = json.decode(response.body) as Map<String, dynamic>;
      final rp = Reply.fromMap(data);
      rp.onChange();
      return response.statusCode == 200 && rp.success ? rp : Reply.emptyReply;
    } catch (e) {
      sendAppLog(e);
      rethrow;
    }
  }

  Future<List<FrequentlyAskedQuestion>> getFAQs() async {
    try {
      final client = Client();
      final url = Uri.parse('${baseURL}mobilequestion');
      final response = await client.get(url);
      client.close();
      final data = json.decode(response.body) as Map<String, dynamic>;
      final faqB = FAQBase.fromMap(data);
      return response.statusCode == 200 && faqB.reply.success
          ? faqB.faqs
          : <FrequentlyAskedQuestion>[];
    } catch (e) {
      sendAppLog(e);
      rethrow;
    }
  }

  Future<Reply> addDevice(Map<String, dynamic> body) async {
    try {
      final client = Client();
      log(body);
      final url = Uri.parse('${baseURL}linkdevice');
      final response = await client.post(url, body: body);
      log(response.body);
      client.close();
      final data = json.decode(response.body) as Map<String, dynamic>;
      final rp = Reply.fromMap(data);
      rp.onChange();
      return response.statusCode == 200 ? rp : Reply.emptyReply;
    } catch (e) {
      sendAppLog(e);
      rethrow;
    }
  }

  Future<Reply> updateProperty(Map<String, dynamic> body) async {
    try {
      final client = Client();
      final url = Uri.parse('${baseURL}update_property');
      final response = await client.post(url, body: body);
      client.close();
      final data = json.decode(response.body) as Map<String, dynamic>;
      final rp = Reply.fromMap(data);
      props.value = Property.emptyProperty;
      location.value = PinCodeResult.emptyResult;
      rp.onChange();
      return response.statusCode == 200 ? rp : Reply.emptyReply;
    } catch (e) {
      sendAppLog(e);
      rethrow;
    }
  }

  Future<List<DocumentType>> getDocumentTypes() async {
    try {
      final client = Client();
      final url = Uri.parse('${baseURL}get_certificate_type');
      final response = await client.get(url);
      client.close();
      final data = json.decode(response.body) as Map<String, dynamic>;
      final dtB = DocumentTypeBase.fromMap(data);
      return response.statusCode == 200 && dtB.reply.success
          ? dtB.types
          : <DocumentType>[];
    } catch (e) {
      sendAppLog(e);
      rethrow;
    }
  }

  // Future<OtherData> uploadImage(XFile image) async {
  //   try {
  //     final url = Uri.parse('${baseURL}userImageupload');
  //     final request = MultipartRequest('POST', url);
  //     final str =
  //         'data:image/jpeg;base64,${base64.encode(await image.readAsBytes())}';
  //     log(str);
  //     request.files.add(MultipartFile.fromString('file', str));
  //     log(request.fields);
  //     final response = await request.send();
  //     final repStr = await response.stream.transform(utf8.decoder).join();
  //     log(repStr);
  //     final data = json.decode(repStr) as Map<String, dynamic>;
  //     final od = OtherData.fromMap(data);
  //     od.onChange();
  //     return response.statusCode == 200
  //         ? od
  //         : OtherData(Reply.emptyReply, null);
  //   } catch (e) {
  //     sendAppLog(e);
  //     rethrow;
  //   }
  // }

  // Future<OtherData> uploadMultipleImages(List<XFile> images) async {
  //   try {
  //     final url = Uri.parse('${baseURL}userImageupload');
  //     final request = MultipartRequest('POST', url);
  //     String pics = 'data:image/jpeg;base64,';
  //     for (XFile image in images) {
  //       pics += base64.encode(await image.readAsBytes()) +
  //           (image == images.last ? '' : ',');
  //     }
  //     request.files.add(MultipartFile.fromString('file', pics));
  //     final response = await request.send();
  //     final data =
  //         json.decode(await response.stream.transform(utf8.decoder).join())
  //             as Map<String, dynamic>;
  //     final od = OtherData.fromMap(data);
  //     log(data);
  //     log('Api Success');
  //     od.onChange();
  //     return response.statusCode == 200
  //         ? od
  //         : OtherData(Reply.emptyReply, null);
  //   } catch (e) {
  //     sendAppLog(e);
  //     rethrow;
  //   }
  // }

  Future<Reply> addDocument(Map<String, dynamic> body) async {
    final client = Client();
    try {
      final url = Uri.parse('${baseURL}add_certificate');
      log(url);
      final response = await client.post(url, body: body);
      client.close();
      log(response.body);
      final data = json.decode(response.body) as Map<String, dynamic>;
      log(data);
      final rp = Reply.fromMap(data);
      if (response.statusCode == 200 && rp.success) {
        final ps = await getProperties();
        log(ps.length);
        rp.onChange();
      }
      return response.statusCode == 200 ? rp : Reply.emptyReply;
    } catch (e) {
      sendAppLog(e);
      rethrow;
    } finally {
      client.close();
    }
  }

  Future<Reply> editDocument(Map<String, dynamic> body) async {
    try {
      final client = Client();
      final url = Uri.parse('${baseURL}update_document');
      final response = await client.post(url, body: body);
      client.close();
      final data = json.decode(response.body) as Map<String, dynamic>;
      final rp = Reply.fromMap(data);
      rp.onChange();
      return response.statusCode == 200 ? rp : Reply.emptyReply;
    } catch (e) {
      sendAppLog(e);
      rethrow;
    }
  }

  Future<OtherData> addPropertyForOther(Map<String, dynamic> body) async {
    try {
      final client = Client();

      final url = Uri.parse('${baseURL}add_property');
      final consistBody = body;
      consistBody.removeWhere((key, value) => key == 'property_type_name');

      final response = await client.post(url, body: consistBody);
      log(response.body);
      client.close();
      final data = json.decode(response.body) as Map<String, dynamic>;
      final od = OtherData.fromMap(data);
      od.onChange();
      return response.statusCode == 200
          ? od
          : OtherData(Reply.emptyReply, null);
    } catch (e) {
      sendAppLog(e);
      rethrow;
    }
  }

  Future<OtherData> readNotifications(UserNotification notification) async {
    try {
      final client = Client();

      final url = Uri.parse('${baseURL}update_notification_status');
      final response = await client.post(url, body: notification.map);
      client.close();
      final data = json.decode(response.body) as Map<String, dynamic>;
      final od = OtherData.fromMap(data);
      od.onChange();
      return response.statusCode == 200
          ? od
          : OtherData(Reply.emptyReply, null);
    } catch (e) {
      sendAppLog(e);
      rethrow;
    }
  }

  Future<ReadRequest> readRequestNotification(String reqAccID) async {
    try {
      final client = Client();

      final url = Uri.parse('${baseURL}read_request');
      log(reqAccID);
      final response = await client.post(url, body: {'req_acc_id': reqAccID});
      log(response.body);
      client.close();
      final data = json.decode(response.body) as Map<String, dynamic>;
      log(data);
      final od = ReadRequest.fromMap(data);
      // od.onChange();
      // return od;
      return response.statusCode == 200 ? od : ReadRequest.emptyReply;
    } catch (e) {
      sendAppLog(e);
      rethrow;
    }
  }

  Future<Reply> resetPassword(Map<String, dynamic> body) async {
    try {
      final clientHttp = HttpClient();
      final url = Uri.parse('${baseURL}password/create');
      final request = await clientHttp.postUrl(url);
      final reqStr = json.encode(body);
      // request.headers
      //     .set('Authorization', 'Bearer ' + sharedPrefs.getString('apiToken'));
      request.headers.set('content-type', 'application/json');
      request.headers.contentType =
          ContentType('application', 'json', charset: 'utf-8');
      request.write(reqStr);

      final response = await request.close();
      clientHttp.close();
      final data = await response.transform(utf8.decoder).join();
      final rpl = Reply.fromMap(json.decode(data));
      rpl.onChange();
      return response.statusCode == 200 ? rpl : Reply.emptyReply;

      /*final client = Client();

      final url = Uri.parse('${baseURL}password/create');
      final response = await client.post(url, body: body);
      client.close();
      final data = json.decode(response.body) as Map<String, dynamic>;
      final rp = Reply.fromMap(data);
      rp.onChange();
      return response.statusCode == 200 && rp.success ? rp : Reply.emptyReply;*/
    } catch (e) {
      rethrow;
    }
  }

  Future<ContractorPropertyBase> getContractorProperties() async {
    try {
      final client = Client();

      final url = Uri.parse('${baseURL}get_properties');
      log(url);
      log(currentUser.value.map);
      final response = await client.post(url, body: currentUser.value.map);
      client.close();
      log(response.body);
      final data = json.decode(response.body) as Map<String, dynamic>;
      final cpb = ContractorPropertyBase.fromMap(data);
      remainingSpace.value = cpb.count;
      totalDocsCount.value = cpb.docCount;
      cpb.onChange();
      return response.statusCode == 200 && cpb.base.success
          ? cpb
          : ContractorPropertyBase(
              Reply.emptyReply, <Property>[], <Property>[], 0, 0);
    } catch (e) {
      sendAppLog(e);
      rethrow;
    }
  }

  Future<Reply> requestAccess(Property property) async {
    /*final clientHttp = HttpClient();
    final url = Uri.parse('${baseURL}request_access');
    final request = await clientHttp.postUrl(url);
    final body = property.jos;
    final reqStr = json.encode(body);
    request.headers.set('content-type', 'application/json');
    request.headers.contentType =
        ContentType('application', 'json', charset: 'utf-8');*/ /*
    request.write(reqStr);
    try {
      final response = await request.close();
      clientHttp.close();
      final data = response.body;
      final rp = Reply.fromMap(json.decode(data));
      rp.onChange();
      return response.statusCode == 200 ? rp : Reply.emptyReply;
    } catch (e) {
      sendAppLog(e);
      rethrow;
    }*/
/**/
    try {
      final client = Client();
      final url = Uri.parse('${baseURL}request_access');
      /*final response = await http.post(
          url,
          headers: {"Content-Type": "application/json"},
          body: property.jos);*/
      final response = await client.post(url, body: property.jos);
      client.close();
      final data = json.decode(response.body) as Map<String, dynamic>;
      final rp = Reply.fromMap(data);
      rp.onChange();
      return response.statusCode == 200 ? rp : Reply.emptyReply;
    } catch (e) {
      sendAppLog(e);
      rethrow;
    }
  }

  Future<Reply> requestAccessClone(Map<String, dynamic> body) async {
    try {
      final client = Client();
      final url = Uri.parse('${baseURL}request_access');
      log(url);
      log(body);
      final response = await client.post(url, body: body);
      log(response.body);
      client.close();
      final data = json.decode(response.body) as Map<String, dynamic>;
      final rp = Reply.fromMap(data);
      rp.onChange();
      return response.statusCode == 200 ? rp : Reply.emptyReply;
    } catch (e) {
      sendAppLog(e);
      rethrow;
    }
  }

  Future<Reply> requestAccessSecond(
      String propID, String userId, String propUserid) async {
    try {
      final client = Client();
      final url = Uri.parse('${baseURL}request_access');
      final response = await client.post(url, body: {
        'prop_id': propID,
        'user_id': userId,
        'prop_user_id': propUserid
      });
      client.close();
      final data = json.decode(response.body) as Map<String, dynamic>;
      final rp = Reply.fromMap(data);
      rp.onChange();
      return response.statusCode == 200 ? rp : Reply.emptyReply;
    } catch (e) {
      sendAppLog(e);
      rethrow;
    }
  }

  Future<UpdateAccess> updateRequestAccess(int reqAccId, String allowedDuration,
      int status, int notificationId) async {
    try {
      final client = Client();
      final url = Uri.parse('${baseURL}update_request_access');
      final body = {
        'req_acc_id': reqAccId.toString(),
        'allowed_duration': allowedDuration,
        'status': status.toString(),
        'user_id': currentUser.value.userID.toString(),
        'notification_id': notificationId.toString()
      };
      log(body);
      final response = await client.post(url, body: body);
      log(response.body);
      client.close();
      final data = json.decode(response.body) as Map<String, dynamic>;
      final rp = UpdateAccess.fromMap(data);
      rp.onChange();
      return response.statusCode == 200 ? rp : UpdateAccess.emptyReply;
    } catch (e) {
      sendAppLog(e);
      rethrow;
    }
  }

  Future<Reply> deleteNotificationUpdateAccess(int notificationId) async {
    final clientHttp = HttpClient();
    final url = Uri.parse('${baseURL}delete_notifications');
    final request = await clientHttp.postUrl(url);
    final body = {
      'notification_ids': [notificationId]
    };
    final reqStr = json.encode(body);
    request.headers.set('content-type', 'application/json');
    request.headers.contentType =
        ContentType('application', 'json', charset: 'utf-8');
    request.write(reqStr);
    try {
      final response = await request.close();
      clientHttp.close();
      final data = await response.transform(utf8.decoder).join();
      log(data);
      final rpl = Reply.fromMap(json.decode(data));
      rpl.onChange();
      return response.statusCode == 200 ? rpl : Reply.emptyReply;
    } catch (e) {
      sendAppLog(e);
      rethrow;
    }
  }

  Future<Property> getSinglePropertyData(Property property) async {
    try {
      final client = Client();

      final url = Uri.tryParse('${baseURL}get_properties') ?? Uri();
      log(url);
      log(property.map['puuid']);
      log('goyyala');
      property.map['user_id'] = currentUser.value.userID.toString();
      log(currentUser.value.userID);
      var body = {
        'puuid': property.map['puuid'],
        'user_id': currentUser.value.userID.toString(),
      };

      log(body);
      final response = await client.post(url, body: body);
      log(response.body);
      client.close();
      final data = json.decode(response.body) as Map<String, dynamic>;

      final pb = PropertyBase.fromMap(data);
      remainingSpace.value = pb.docCount;
      totalDocsCount.value = pb.count;
      log(pb.properties);
      return pb.properties.last;
    } catch (e) {
      sendAppLog(e);
      return Property.emptyProperty;
    }
  }

  Future<UserBase> getFavouritelandLordData() async {
    try {
      final client = Client();

      final url = Uri.tryParse('${baseURL}get_user_favorite') ?? Uri();
      final response = await client.post(url, body: currentUser.value.map);
      client.close();
      final data = json.decode(response.body) as Map<String, dynamic>;
      final ub = UserBase.fromMap(data);
      return ub;
    } catch (e) {
      sendAppLog(e);
      rethrow;
    }
  }

  Future<UserBase> checkValidMail(String mail, int roleID) async {
    try {
      final client = Client();
      final url = Uri.tryParse('${baseURL}checkemailexist') ?? Uri();
      log({
        'email': mail,
        'role_id': roleID.toString(),
        'user_id': currentUser.value.userID.toString()
      });
      final response = await client.post(url, body: {
        'email': mail,
        'role_id': roleID.toString(),
        'user_id': currentUser.value.userID.toString()
      });
      client.close();
      log(response.body);
      final data = json.decode(response.body) as Map<String, dynamic>;
      final rp = Reply.fromMap(data);
      if (response.statusCode == 200 && rp.success) {
        final ub = UserBase.fromMap(data);
        log('checking');
        log(ub.base.success);
        return ub;
      } else {
        return UserBase(rp, User.emptyUser);
      }
    } catch (e) {
      sendAppLog(e);
      log('object');
      return UserBase.emptyValue;
    }
  }

  Future<Reply> addLandLord(Map<String, dynamic> body) async {
    final clientHttp = HttpClient();
    final url = Uri.tryParse('${baseURL}addlandlordproperty') ?? Uri();
    log(url);
    final request = await clientHttp.postUrl(url);
    final reqStr = json.encode(body);
    log(reqStr);
    request.headers.set('content-type', 'application/json');
    request.headers.contentType =
        ContentType('application', 'json', charset: 'utf-8');
    request.write(reqStr);
    try {
      final response = await request.close();
      clientHttp.close();
      final data = await response.transform(utf8.decoder).join();
      log(data);
      final rpl = Reply.fromMap(json.decode(data));
      rpl.onChange();
      return response.statusCode == 200 ? rpl : Reply.emptyReply;
    } catch (e) {
      sendAppLog(e);
      rethrow;
    }
  }

  Future<AccessList> getPropertyaccessList(
      String propertyID, String propUserId) async {
    try {
      final client = Client();

      final url = Uri.tryParse('${baseURL}get_property_access_user') ?? Uri();
      log({
        'prop_user_id': propUserId,
        'prop_id': propertyID,
        'logged_user_id': currentUser.value.userID.toString()
      });
      final response = await client.post(url, body: {
        'prop_user_id': propUserId,
        'prop_id': propertyID,
        'logged_user_id': currentUser.value.userID.toString()
      });
      log(response.body);
      client.close();
      final data = json.decode(response.body) as Map<String, dynamic>;
      final rp = AccessList.fromMap(data);
      return rp;
    } catch (e) {
      sendAppLog(e);
      return AccessList.emptyReply;
    }
  }

  Future<Reply> propertyRevoke(
      int propertyID, int reqid, int propUserID) async {
    try {
      final client = Client();

      final url = Uri.tryParse('${baseURL}property_access_revoke') ?? Uri();
      log({
        'user_id': propUserID.toString(),
        'prop_id': propertyID.toString(),
        'req_acc_id': reqid.toString()
      });
      final response = await client.post(url, body: {
        'user_id': propUserID.toString(),
        'prop_id': propertyID.toString(),
        'req_acc_id': reqid.toString()
      });
      log(response.body);
      client.close();
      final data = json.decode(response.body) as Map<String, dynamic>;
      final rp = Reply.fromMap(data);
      return rp;
    } catch (e) {
      sendAppLog(e);
      return Reply.emptyReply;
    }
  }

  Future<Reply> notificationCheckBox(
      int notificationtype, int notificationStatus) async {
    try {
      final client = Client();

      final url = Uri.tryParse('${baseURL}notificationcheckbox') ?? Uri();
      log({
        'user_id': currentUser.value.userID.toString(),
        'notification_type': notificationtype.toString(),
        'notification_status': notificationStatus.toString()
      });
      final response = await client.post(url, body: {
        'user_id': currentUser.value.userID.toString(),
        'notification_type': notificationtype.toString(),
        'notification_status': notificationStatus.toString()
      });
      log(response.body);
      client.close();
      final data = json.decode(response.body) as Map<String, dynamic>;
      final rp = Reply.fromMap(data);
      return rp;
    } catch (e) {
      sendAppLog(e);
      return Reply.emptyReply;
    }
  }

  Future<UserBase> userDetails() async {
    try {
      final client = Client();
      final url = Uri.tryParse('${baseURL}getuserdetails') ?? Uri();
      // log({
      //   'user_id': currentUser.value.userID.toString(),
      // });
      final response = await client.post(url, body: {
        'user_id': currentUser.value.userID.toString(),
      });
      // log(response.body);
      client.close();
      final data = json.decode(response.body) as Map<String, dynamic>;
      final rp = Reply.fromMap(data);
      if (response.statusCode == 200 && rp.success) {
        final ub = UserBase.fromMap(data);
        log(ub.base.success);
        currentUser.value = ub.user;
        ub.user.onChange();
        return ub;
      } else {
        return UserBase(rp, User.emptyUser);
      }
    } catch (e) {
      sendAppLog(e);
      return UserBase.emptyValue;
    }
  }

  Future<Reply> deleteUser() async {
    final client = Client();
    try {
      final url = Uri.tryParse('${baseURL}deleteuser') ?? Uri();
      final response = await client.post(url, body: currentUser.value.map);
      client.close();
      return response.statusCode == 200
          ? Reply.emptyReply
          : Reply.fromMap(json.decode(response.body));
    } catch (e) {
      sendAppLog(e);
      client.close();
      return Reply.emptyReply;
    }
  }

  Future<OtherData> uploadImages(List<XFile> images) async {
    try {
      num sizeInMB = 0.0;
      final uri = Uri.tryParse('${baseURL}upload_documents') ?? Uri();
      final request = MultipartRequest('POST', uri);
      log(uri);
      for (XFile image in images) {
        log(image.name);
        log(image.path);
        // final compress =
        //     await FlutterNativeImage.compressImage(image.path, quality: 5);
        final pic = await image.readAsBytes();
        sizeInMB += (pic.lengthInBytes / 1048576);
        request.files
            .add(MultipartFile.fromBytes('file[]', pic, filename: image.name));
      }
      log('Total Size: $sizeInMB MB');
      final response = await request.send();
      final resStr = await response.stream.transform(utf8.decoder).join();
      log(resStr);
      final data = json.decode(resStr) as Map<String, dynamic>;
      return response.statusCode == 200
          ? OtherData.fromMap(data)
          : OtherData(Reply.emptyReply, null);
    } catch (e) {
      sendAppLog(e);
      rethrow;
    }
  }
}
