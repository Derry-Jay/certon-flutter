class Role {
  final int roleID;
  final String role;
  Role(this.roleID, this.role);
  Map<String, dynamic> get json {
    Map<String, dynamic> map = <String, dynamic>{};
    map['roleName'] = role;
    map['role_id'] = roleID;
    return map;
  }

  factory Role.fromMap(Map<String, dynamic> json) {
    return Role(json['role_id'] ?? -1, json['roleName'] ?? '');
  }

  @override
  String toString() {
    // TODO: implement toString
    return role.isEmpty || role == 'null' ? '' : role;
  }

  @override
  bool operator ==(Object other) {
    // TODO: implement ==
    return other is Role && roleID == other.roleID;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => roleID.hashCode;
}
