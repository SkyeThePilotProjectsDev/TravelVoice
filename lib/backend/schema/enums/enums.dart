import 'package:collection/collection.dart';

enum RequestStatus {
  Requested,
  Accepted,
  Denied,
  Cancelled,
}

enum LocationSpecificity {
  Exact,
  Suburb,
  City,
  Country,
}

enum AccessLevel {
  Viewer,
  Member,
  Editor,
  Admin,
  SuperAdmin,
}

extension FFEnumExtensions<T extends Enum> on T {
  String serialize() => name;
}

extension FFEnumListExtensions<T extends Enum> on Iterable<T> {
  T? deserialize(String? value) =>
      firstWhereOrNull((e) => e.serialize() == value);
}

T? deserializeEnum<T>(String? value) {
  switch (T) {
    case (RequestStatus):
      return RequestStatus.values.deserialize(value) as T?;
    case (LocationSpecificity):
      return LocationSpecificity.values.deserialize(value) as T?;
    case (AccessLevel):
      return AccessLevel.values.deserialize(value) as T?;
    default:
      return null;
  }
}
