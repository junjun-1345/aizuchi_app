// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userHash() => r'e260b1560767f1afdeedc1c8907c8f38149358c3';

/// See also [user].
@ProviderFor(user)
final userProvider = AutoDisposeStreamProvider<Map<String, dynamic>>.internal(
  user,
  name: r'userProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserRef = AutoDisposeStreamProviderRef<Map<String, dynamic>>;
String _$messageCountIntHash() => r'37f56d844c11113606c051a57fc6c135767c6468';

/// See also [messageCountInt].
@ProviderFor(messageCountInt)
final messageCountIntProvider = AutoDisposeStreamProvider<int>.internal(
  messageCountInt,
  name: r'messageCountIntProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$messageCountIntHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MessageCountIntRef = AutoDisposeStreamProviderRef<int>;
String _$dailyCountIntHash() => r'a1996baa9440219b863c4f82ec4c2f16a98555fb';

/// See also [dailyCountInt].
@ProviderFor(dailyCountInt)
final dailyCountIntProvider = AutoDisposeStreamProvider<int>.internal(
  dailyCountInt,
  name: r'dailyCountIntProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dailyCountIntHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DailyCountIntRef = AutoDisposeStreamProviderRef<int>;
String _$dailyKeyStreamHash() => r'ba71d4aae690c70f753a3cadb4f245ab6af77c1f';

/// See also [dailyKeyStream].
@ProviderFor(dailyKeyStream)
final dailyKeyStreamProvider = StreamProvider<QuerySnapshot<Object?>>.internal(
  dailyKeyStream,
  name: r'dailyKeyStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dailyKeyStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DailyKeyStreamRef = StreamProviderRef<QuerySnapshot<Object?>>;
String _$dailyMessageStreamHash() =>
    r'178507d3e590844daf4fa776bebc56da9874800f';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

typedef DailyMessageStreamRef = StreamProviderRef<QuerySnapshot<Object?>>;

/// See also [dailyMessageStream].
@ProviderFor(dailyMessageStream)
const dailyMessageStreamProvider = DailyMessageStreamFamily();

/// See also [dailyMessageStream].
class DailyMessageStreamFamily
    extends Family<AsyncValue<QuerySnapshot<Object?>>> {
  /// See also [dailyMessageStream].
  const DailyMessageStreamFamily();

  /// See also [dailyMessageStream].
  DailyMessageStreamProvider call(
    String dailyKey,
  ) {
    return DailyMessageStreamProvider(
      dailyKey,
    );
  }

  @override
  DailyMessageStreamProvider getProviderOverride(
    covariant DailyMessageStreamProvider provider,
  ) {
    return call(
      provider.dailyKey,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'dailyMessageStreamProvider';
}

/// See also [dailyMessageStream].
class DailyMessageStreamProvider
    extends StreamProvider<QuerySnapshot<Object?>> {
  /// See also [dailyMessageStream].
  DailyMessageStreamProvider(
    this.dailyKey,
  ) : super.internal(
          (ref) => dailyMessageStream(
            ref,
            dailyKey,
          ),
          from: dailyMessageStreamProvider,
          name: r'dailyMessageStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$dailyMessageStreamHash,
          dependencies: DailyMessageStreamFamily._dependencies,
          allTransitiveDependencies:
              DailyMessageStreamFamily._allTransitiveDependencies,
        );

  final String dailyKey;

  @override
  bool operator ==(Object other) {
    return other is DailyMessageStreamProvider && other.dailyKey == dailyKey;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, dailyKey.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
