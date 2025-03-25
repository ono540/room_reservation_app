enum RegistrationType { newEntry, edit }

extension RegistrationTypeExtension on RegistrationType {
  String get name => toString().split('.').last;
}
