// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'googleauth_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userChangesHash() => r'a3e4f08da0c44eeee3dc1d36289461d960c4e3c1';

/// FirebaseのユーザーをAsyncValue型で管理するプロバイダー
///
///
/// Copied from [userChanges].
@ProviderFor(userChanges)
final userChangesProvider = StreamProvider<User?>.internal(
  userChanges,
  name: r'userChangesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userChangesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserChangesRef = StreamProviderRef<User?>;
String _$userHash() => r'11c4c7c6b66953f3878c804baf073b3e0989e5d3';

///
/// ユーザー
///
///
/// Copied from [user].
@ProviderFor(user)
final userProvider = Provider<String?>.internal(
  user,
  name: r'userProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserRef = ProviderRef<String?>;
String _$signedInHash() => r'691cf78ae561b4c826fa842583e66b6f2b7df231';

/// See also [signedIn].
@ProviderFor(signedIn)
final signedInProvider = Provider<bool>.internal(
  signedIn,
  name: r'signedInProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$signedInHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SignedInRef = ProviderRef<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
