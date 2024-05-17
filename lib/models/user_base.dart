import 'user.dart';
import 'reply.dart';

class UserBase {
  final Reply base;
  User user;
  UserBase(this.base, this.user);
  static UserBase emptyValue = UserBase(Reply.emptyReply, User.emptyUser);
  factory UserBase.fromMap(Map<String, dynamic> json) {
    return UserBase(
        Reply.fromMap(json),
        json['user'] == null &&
                json['usersData'] == null &&
                json['user_details'] == null &&
                json['details'] == null
            ? User.emptyUser
            : User.fromMap(json['user'] ??
                (json['usersData'] ??
                    json['user_details'] ??
                    json['details'])));
  }
}
