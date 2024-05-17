import '../helpers/helper.dart';

import 'reply.dart';
import 'user_notification.dart';

class UserNotificationBase {
  final Reply2 base;
  final List<UserNotification> notifications;
  UserNotificationBase(this.base, this.notifications);
  factory UserNotificationBase.fromMap(Map<String, dynamic> json) {
    log(json);
    return UserNotificationBase(
        Reply2.fromMap(json),
        json['data'] == null
            ? <UserNotification>[]
            : List<Map<String, dynamic>>.from(json['data'])
                .map(UserNotification.fromMap)
                .toList());
  }
}
