enum UserRole { user, seller }

extension UserRoleX on UserRole {
  String get value => name; // "user" বা "seller" string হিসেবে
}
