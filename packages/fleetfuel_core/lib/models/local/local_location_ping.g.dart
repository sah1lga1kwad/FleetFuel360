// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_location_ping.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetLocalLocationPingCollection on Isar {
  IsarCollection<LocalLocationPing> get localLocationPings => this.collection();
}

const LocalLocationPingSchema = CollectionSchema(
  name: r'LocalLocationPing',
  id: -3276655562245283930,
  properties: {
    r'accuracy': PropertySchema(
      id: 0,
      name: r'accuracy',
      type: IsarType.double,
    ),
    r'activity': PropertySchema(
      id: 1,
      name: r'activity',
      type: IsarType.string,
    ),
    r'altitude': PropertySchema(
      id: 2,
      name: r'altitude',
      type: IsarType.double,
    ),
    r'assignmentId': PropertySchema(
      id: 3,
      name: r'assignmentId',
      type: IsarType.string,
    ),
    r'batteryLevel': PropertySchema(
      id: 4,
      name: r'batteryLevel',
      type: IsarType.long,
    ),
    r'bearing': PropertySchema(
      id: 5,
      name: r'bearing',
      type: IsarType.double,
    ),
    r'companyId': PropertySchema(
      id: 6,
      name: r'companyId',
      type: IsarType.string,
    ),
    r'driverId': PropertySchema(
      id: 7,
      name: r'driverId',
      type: IsarType.string,
    ),
    r'firestoreId': PropertySchema(
      id: 8,
      name: r'firestoreId',
      type: IsarType.string,
    ),
    r'geohash': PropertySchema(
      id: 9,
      name: r'geohash',
      type: IsarType.string,
    ),
    r'isCharging': PropertySchema(
      id: 10,
      name: r'isCharging',
      type: IsarType.bool,
    ),
    r'isMoving': PropertySchema(
      id: 11,
      name: r'isMoving',
      type: IsarType.bool,
    ),
    r'latitude': PropertySchema(
      id: 12,
      name: r'latitude',
      type: IsarType.double,
    ),
    r'localId': PropertySchema(
      id: 13,
      name: r'localId',
      type: IsarType.string,
    ),
    r'longitude': PropertySchema(
      id: 14,
      name: r'longitude',
      type: IsarType.double,
    ),
    r'networkType': PropertySchema(
      id: 15,
      name: r'networkType',
      type: IsarType.string,
    ),
    r'recordedAt': PropertySchema(
      id: 16,
      name: r'recordedAt',
      type: IsarType.dateTime,
    ),
    r'speed': PropertySchema(
      id: 17,
      name: r'speed',
      type: IsarType.double,
    ),
    r'syncStatus': PropertySchema(
      id: 18,
      name: r'syncStatus',
      type: IsarType.string,
      enumMap: _LocalLocationPingsyncStatusEnumValueMap,
    ),
    r'syncedAt': PropertySchema(
      id: 19,
      name: r'syncedAt',
      type: IsarType.dateTime,
    ),
    r'vehicleId': PropertySchema(
      id: 20,
      name: r'vehicleId',
      type: IsarType.string,
    )
  },
  estimateSize: _localLocationPingEstimateSize,
  serialize: _localLocationPingSerialize,
  deserialize: _localLocationPingDeserialize,
  deserializeProp: _localLocationPingDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'localId': IndexSchema(
      id: 1199848425898359622,
      name: r'localId',
      unique: true,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'localId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _localLocationPingGetId,
  getLinks: _localLocationPingGetLinks,
  attach: _localLocationPingAttach,
  version: '3.1.0+1',
);

int _localLocationPingEstimateSize(
  LocalLocationPing object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.activity.length * 3;
  bytesCount += 3 + object.assignmentId.length * 3;
  bytesCount += 3 + object.companyId.length * 3;
  bytesCount += 3 + object.driverId.length * 3;
  {
    final value = object.firestoreId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.geohash.length * 3;
  bytesCount += 3 + object.localId.length * 3;
  bytesCount += 3 + object.networkType.length * 3;
  bytesCount += 3 + object.syncStatus.name.length * 3;
  bytesCount += 3 + object.vehicleId.length * 3;
  return bytesCount;
}

void _localLocationPingSerialize(
  LocalLocationPing object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.accuracy);
  writer.writeString(offsets[1], object.activity);
  writer.writeDouble(offsets[2], object.altitude);
  writer.writeString(offsets[3], object.assignmentId);
  writer.writeLong(offsets[4], object.batteryLevel);
  writer.writeDouble(offsets[5], object.bearing);
  writer.writeString(offsets[6], object.companyId);
  writer.writeString(offsets[7], object.driverId);
  writer.writeString(offsets[8], object.firestoreId);
  writer.writeString(offsets[9], object.geohash);
  writer.writeBool(offsets[10], object.isCharging);
  writer.writeBool(offsets[11], object.isMoving);
  writer.writeDouble(offsets[12], object.latitude);
  writer.writeString(offsets[13], object.localId);
  writer.writeDouble(offsets[14], object.longitude);
  writer.writeString(offsets[15], object.networkType);
  writer.writeDateTime(offsets[16], object.recordedAt);
  writer.writeDouble(offsets[17], object.speed);
  writer.writeString(offsets[18], object.syncStatus.name);
  writer.writeDateTime(offsets[19], object.syncedAt);
  writer.writeString(offsets[20], object.vehicleId);
}

LocalLocationPing _localLocationPingDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = LocalLocationPing();
  object.accuracy = reader.readDouble(offsets[0]);
  object.activity = reader.readString(offsets[1]);
  object.altitude = reader.readDouble(offsets[2]);
  object.assignmentId = reader.readString(offsets[3]);
  object.batteryLevel = reader.readLong(offsets[4]);
  object.bearing = reader.readDouble(offsets[5]);
  object.companyId = reader.readString(offsets[6]);
  object.driverId = reader.readString(offsets[7]);
  object.firestoreId = reader.readStringOrNull(offsets[8]);
  object.geohash = reader.readString(offsets[9]);
  object.isCharging = reader.readBool(offsets[10]);
  object.isMoving = reader.readBool(offsets[11]);
  object.isarId = id;
  object.latitude = reader.readDouble(offsets[12]);
  object.localId = reader.readString(offsets[13]);
  object.longitude = reader.readDouble(offsets[14]);
  object.networkType = reader.readString(offsets[15]);
  object.recordedAt = reader.readDateTime(offsets[16]);
  object.speed = reader.readDouble(offsets[17]);
  object.syncStatus = _LocalLocationPingsyncStatusValueEnumMap[
          reader.readStringOrNull(offsets[18])] ??
      SyncStatus.pending;
  object.syncedAt = reader.readDateTimeOrNull(offsets[19]);
  object.vehicleId = reader.readString(offsets[20]);
  return object;
}

P _localLocationPingDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readDouble(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    case 10:
      return (reader.readBool(offset)) as P;
    case 11:
      return (reader.readBool(offset)) as P;
    case 12:
      return (reader.readDouble(offset)) as P;
    case 13:
      return (reader.readString(offset)) as P;
    case 14:
      return (reader.readDouble(offset)) as P;
    case 15:
      return (reader.readString(offset)) as P;
    case 16:
      return (reader.readDateTime(offset)) as P;
    case 17:
      return (reader.readDouble(offset)) as P;
    case 18:
      return (_LocalLocationPingsyncStatusValueEnumMap[
              reader.readStringOrNull(offset)] ??
          SyncStatus.pending) as P;
    case 19:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 20:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _LocalLocationPingsyncStatusEnumValueMap = {
  r'pending': r'pending',
  r'uploading': r'uploading',
  r'synced': r'synced',
  r'failed': r'failed',
};
const _LocalLocationPingsyncStatusValueEnumMap = {
  r'pending': SyncStatus.pending,
  r'uploading': SyncStatus.uploading,
  r'synced': SyncStatus.synced,
  r'failed': SyncStatus.failed,
};

Id _localLocationPingGetId(LocalLocationPing object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _localLocationPingGetLinks(
    LocalLocationPing object) {
  return [];
}

void _localLocationPingAttach(
    IsarCollection<dynamic> col, Id id, LocalLocationPing object) {
  object.isarId = id;
}

extension LocalLocationPingByIndex on IsarCollection<LocalLocationPing> {
  Future<LocalLocationPing?> getByLocalId(String localId) {
    return getByIndex(r'localId', [localId]);
  }

  LocalLocationPing? getByLocalIdSync(String localId) {
    return getByIndexSync(r'localId', [localId]);
  }

  Future<bool> deleteByLocalId(String localId) {
    return deleteByIndex(r'localId', [localId]);
  }

  bool deleteByLocalIdSync(String localId) {
    return deleteByIndexSync(r'localId', [localId]);
  }

  Future<List<LocalLocationPing?>> getAllByLocalId(List<String> localIdValues) {
    final values = localIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'localId', values);
  }

  List<LocalLocationPing?> getAllByLocalIdSync(List<String> localIdValues) {
    final values = localIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'localId', values);
  }

  Future<int> deleteAllByLocalId(List<String> localIdValues) {
    final values = localIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'localId', values);
  }

  int deleteAllByLocalIdSync(List<String> localIdValues) {
    final values = localIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'localId', values);
  }

  Future<Id> putByLocalId(LocalLocationPing object) {
    return putByIndex(r'localId', object);
  }

  Id putByLocalIdSync(LocalLocationPing object, {bool saveLinks = true}) {
    return putByIndexSync(r'localId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByLocalId(List<LocalLocationPing> objects) {
    return putAllByIndex(r'localId', objects);
  }

  List<Id> putAllByLocalIdSync(List<LocalLocationPing> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'localId', objects, saveLinks: saveLinks);
  }
}

extension LocalLocationPingQueryWhereSort
    on QueryBuilder<LocalLocationPing, LocalLocationPing, QWhere> {
  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension LocalLocationPingQueryWhere
    on QueryBuilder<LocalLocationPing, LocalLocationPing, QWhereClause> {
  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterWhereClause>
      isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterWhereClause>
      isarIdNotEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterWhereClause>
      isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterWhereClause>
      isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterWhereClause>
      isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterWhereClause>
      localIdEqualTo(String localId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'localId',
        value: [localId],
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterWhereClause>
      localIdNotEqualTo(String localId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'localId',
              lower: [],
              upper: [localId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'localId',
              lower: [localId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'localId',
              lower: [localId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'localId',
              lower: [],
              upper: [localId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension LocalLocationPingQueryFilter
    on QueryBuilder<LocalLocationPing, LocalLocationPing, QFilterCondition> {
  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      accuracyEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'accuracy',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      accuracyGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'accuracy',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      accuracyLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'accuracy',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      accuracyBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'accuracy',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      activityEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      activityGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'activity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      activityLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'activity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      activityBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'activity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      activityStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'activity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      activityEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'activity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      activityContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'activity',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      activityMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'activity',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      activityIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activity',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      activityIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'activity',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      altitudeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'altitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      altitudeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'altitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      altitudeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'altitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      altitudeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'altitude',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      assignmentIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'assignmentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      assignmentIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'assignmentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      assignmentIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'assignmentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      assignmentIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'assignmentId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      assignmentIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'assignmentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      assignmentIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'assignmentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      assignmentIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'assignmentId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      assignmentIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'assignmentId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      assignmentIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'assignmentId',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      assignmentIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'assignmentId',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      batteryLevelEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'batteryLevel',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      batteryLevelGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'batteryLevel',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      batteryLevelLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'batteryLevel',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      batteryLevelBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'batteryLevel',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      bearingEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bearing',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      bearingGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bearing',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      bearingLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bearing',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      bearingBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bearing',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      companyIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'companyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      companyIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'companyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      companyIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'companyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      companyIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'companyId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      companyIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'companyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      companyIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'companyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      companyIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'companyId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      companyIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'companyId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      companyIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'companyId',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      companyIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'companyId',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      driverIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'driverId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      driverIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'driverId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      driverIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'driverId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      driverIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'driverId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      driverIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'driverId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      driverIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'driverId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      driverIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'driverId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      driverIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'driverId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      driverIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'driverId',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      driverIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'driverId',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      firestoreIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'firestoreId',
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      firestoreIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'firestoreId',
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      firestoreIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firestoreId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      firestoreIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'firestoreId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      firestoreIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'firestoreId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      firestoreIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'firestoreId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      firestoreIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'firestoreId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      firestoreIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'firestoreId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      firestoreIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'firestoreId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      firestoreIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'firestoreId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      firestoreIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firestoreId',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      firestoreIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'firestoreId',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      geohashEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'geohash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      geohashGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'geohash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      geohashLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'geohash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      geohashBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'geohash',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      geohashStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'geohash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      geohashEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'geohash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      geohashContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'geohash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      geohashMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'geohash',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      geohashIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'geohash',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      geohashIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'geohash',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      isChargingEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCharging',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      isMovingEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isMoving',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      isarIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      isarIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      latitudeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'latitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      latitudeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'latitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      latitudeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'latitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      latitudeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'latitude',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      localIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      localIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'localId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      localIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'localId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      localIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'localId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      localIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'localId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      localIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'localId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      localIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'localId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      localIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'localId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      localIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localId',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      localIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'localId',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      longitudeEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'longitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      longitudeGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'longitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      longitudeLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'longitude',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      longitudeBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'longitude',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      networkTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'networkType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      networkTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'networkType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      networkTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'networkType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      networkTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'networkType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      networkTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'networkType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      networkTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'networkType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      networkTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'networkType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      networkTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'networkType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      networkTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'networkType',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      networkTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'networkType',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      recordedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'recordedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      recordedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'recordedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      recordedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'recordedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      recordedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'recordedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      speedEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'speed',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      speedGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'speed',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      speedLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'speed',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      speedBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'speed',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      syncStatusEqualTo(
    SyncStatus value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'syncStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      syncStatusGreaterThan(
    SyncStatus value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'syncStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      syncStatusLessThan(
    SyncStatus value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'syncStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      syncStatusBetween(
    SyncStatus lower,
    SyncStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'syncStatus',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      syncStatusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'syncStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      syncStatusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'syncStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      syncStatusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'syncStatus',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      syncStatusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'syncStatus',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      syncStatusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'syncStatus',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      syncStatusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'syncStatus',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      syncedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'syncedAt',
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      syncedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'syncedAt',
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      syncedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'syncedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      syncedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'syncedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      syncedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'syncedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      syncedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'syncedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      vehicleIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vehicleId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      vehicleIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'vehicleId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      vehicleIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'vehicleId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      vehicleIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'vehicleId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      vehicleIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'vehicleId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      vehicleIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'vehicleId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      vehicleIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'vehicleId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      vehicleIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'vehicleId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      vehicleIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'vehicleId',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterFilterCondition>
      vehicleIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'vehicleId',
        value: '',
      ));
    });
  }
}

extension LocalLocationPingQueryObject
    on QueryBuilder<LocalLocationPing, LocalLocationPing, QFilterCondition> {}

extension LocalLocationPingQueryLinks
    on QueryBuilder<LocalLocationPing, LocalLocationPing, QFilterCondition> {}

extension LocalLocationPingQuerySortBy
    on QueryBuilder<LocalLocationPing, LocalLocationPing, QSortBy> {
  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      sortByAccuracy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accuracy', Sort.asc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      sortByAccuracyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accuracy', Sort.desc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      sortByActivity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activity', Sort.asc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      sortByActivityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activity', Sort.desc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      sortByAltitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'altitude', Sort.asc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      sortByAltitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'altitude', Sort.desc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      sortByAssignmentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assignmentId', Sort.asc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      sortByAssignmentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assignmentId', Sort.desc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      sortByBatteryLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'batteryLevel', Sort.asc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      sortByBatteryLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'batteryLevel', Sort.desc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      sortByBearing() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bearing', Sort.asc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      sortByBearingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bearing', Sort.desc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      sortByCompanyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyId', Sort.asc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      sortByCompanyIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyId', Sort.desc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      sortByDriverId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'driverId', Sort.asc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      sortByDriverIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'driverId', Sort.desc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      sortByFirestoreId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firestoreId', Sort.asc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      sortByFirestoreIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firestoreId', Sort.desc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      sortByGeohash() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'geohash', Sort.asc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      sortByGeohashDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'geohash', Sort.desc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      sortByIsCharging() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCharging', Sort.asc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      sortByIsChargingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCharging', Sort.desc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      sortByIsMoving() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMoving', Sort.asc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      sortByIsMovingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMoving', Sort.desc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      sortByLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.asc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      sortByLatitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.desc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      sortByLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localId', Sort.asc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      sortByLocalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localId', Sort.desc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      sortByLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.asc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      sortByLongitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.desc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      sortByNetworkType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'networkType', Sort.asc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      sortByNetworkTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'networkType', Sort.desc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      sortByRecordedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordedAt', Sort.asc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      sortByRecordedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordedAt', Sort.desc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      sortBySpeed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'speed', Sort.asc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      sortBySpeedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'speed', Sort.desc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      sortBySyncStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.asc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      sortBySyncStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.desc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      sortBySyncedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncedAt', Sort.asc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      sortBySyncedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncedAt', Sort.desc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      sortByVehicleId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleId', Sort.asc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      sortByVehicleIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleId', Sort.desc);
    });
  }
}

extension LocalLocationPingQuerySortThenBy
    on QueryBuilder<LocalLocationPing, LocalLocationPing, QSortThenBy> {
  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      thenByAccuracy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accuracy', Sort.asc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      thenByAccuracyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accuracy', Sort.desc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      thenByActivity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activity', Sort.asc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      thenByActivityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activity', Sort.desc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      thenByAltitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'altitude', Sort.asc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      thenByAltitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'altitude', Sort.desc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      thenByAssignmentId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assignmentId', Sort.asc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      thenByAssignmentIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'assignmentId', Sort.desc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      thenByBatteryLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'batteryLevel', Sort.asc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      thenByBatteryLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'batteryLevel', Sort.desc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      thenByBearing() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bearing', Sort.asc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      thenByBearingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bearing', Sort.desc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      thenByCompanyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyId', Sort.asc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      thenByCompanyIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'companyId', Sort.desc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      thenByDriverId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'driverId', Sort.asc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      thenByDriverIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'driverId', Sort.desc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      thenByFirestoreId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firestoreId', Sort.asc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      thenByFirestoreIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firestoreId', Sort.desc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      thenByGeohash() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'geohash', Sort.asc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      thenByGeohashDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'geohash', Sort.desc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      thenByIsCharging() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCharging', Sort.asc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      thenByIsChargingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCharging', Sort.desc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      thenByIsMoving() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMoving', Sort.asc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      thenByIsMovingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMoving', Sort.desc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      thenByLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.asc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      thenByLatitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'latitude', Sort.desc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      thenByLocalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localId', Sort.asc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      thenByLocalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localId', Sort.desc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      thenByLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.asc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      thenByLongitudeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longitude', Sort.desc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      thenByNetworkType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'networkType', Sort.asc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      thenByNetworkTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'networkType', Sort.desc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      thenByRecordedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordedAt', Sort.asc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      thenByRecordedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'recordedAt', Sort.desc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      thenBySpeed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'speed', Sort.asc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      thenBySpeedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'speed', Sort.desc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      thenBySyncStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.asc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      thenBySyncStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.desc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      thenBySyncedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncedAt', Sort.asc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      thenBySyncedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncedAt', Sort.desc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      thenByVehicleId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleId', Sort.asc);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QAfterSortBy>
      thenByVehicleIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vehicleId', Sort.desc);
    });
  }
}

extension LocalLocationPingQueryWhereDistinct
    on QueryBuilder<LocalLocationPing, LocalLocationPing, QDistinct> {
  QueryBuilder<LocalLocationPing, LocalLocationPing, QDistinct>
      distinctByAccuracy() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'accuracy');
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QDistinct>
      distinctByActivity({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'activity', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QDistinct>
      distinctByAltitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'altitude');
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QDistinct>
      distinctByAssignmentId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'assignmentId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QDistinct>
      distinctByBatteryLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'batteryLevel');
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QDistinct>
      distinctByBearing() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bearing');
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QDistinct>
      distinctByCompanyId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'companyId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QDistinct>
      distinctByDriverId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'driverId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QDistinct>
      distinctByFirestoreId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'firestoreId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QDistinct>
      distinctByGeohash({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'geohash', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QDistinct>
      distinctByIsCharging() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCharging');
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QDistinct>
      distinctByIsMoving() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isMoving');
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QDistinct>
      distinctByLatitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'latitude');
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QDistinct>
      distinctByLocalId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'localId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QDistinct>
      distinctByLongitude() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'longitude');
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QDistinct>
      distinctByNetworkType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'networkType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QDistinct>
      distinctByRecordedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'recordedAt');
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QDistinct>
      distinctBySpeed() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'speed');
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QDistinct>
      distinctBySyncStatus({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'syncStatus', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QDistinct>
      distinctBySyncedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'syncedAt');
    });
  }

  QueryBuilder<LocalLocationPing, LocalLocationPing, QDistinct>
      distinctByVehicleId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vehicleId', caseSensitive: caseSensitive);
    });
  }
}

extension LocalLocationPingQueryProperty
    on QueryBuilder<LocalLocationPing, LocalLocationPing, QQueryProperty> {
  QueryBuilder<LocalLocationPing, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<LocalLocationPing, double, QQueryOperations> accuracyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'accuracy');
    });
  }

  QueryBuilder<LocalLocationPing, String, QQueryOperations> activityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'activity');
    });
  }

  QueryBuilder<LocalLocationPing, double, QQueryOperations> altitudeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'altitude');
    });
  }

  QueryBuilder<LocalLocationPing, String, QQueryOperations>
      assignmentIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'assignmentId');
    });
  }

  QueryBuilder<LocalLocationPing, int, QQueryOperations>
      batteryLevelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'batteryLevel');
    });
  }

  QueryBuilder<LocalLocationPing, double, QQueryOperations> bearingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bearing');
    });
  }

  QueryBuilder<LocalLocationPing, String, QQueryOperations>
      companyIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'companyId');
    });
  }

  QueryBuilder<LocalLocationPing, String, QQueryOperations> driverIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'driverId');
    });
  }

  QueryBuilder<LocalLocationPing, String?, QQueryOperations>
      firestoreIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'firestoreId');
    });
  }

  QueryBuilder<LocalLocationPing, String, QQueryOperations> geohashProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'geohash');
    });
  }

  QueryBuilder<LocalLocationPing, bool, QQueryOperations> isChargingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCharging');
    });
  }

  QueryBuilder<LocalLocationPing, bool, QQueryOperations> isMovingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isMoving');
    });
  }

  QueryBuilder<LocalLocationPing, double, QQueryOperations> latitudeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'latitude');
    });
  }

  QueryBuilder<LocalLocationPing, String, QQueryOperations> localIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localId');
    });
  }

  QueryBuilder<LocalLocationPing, double, QQueryOperations>
      longitudeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'longitude');
    });
  }

  QueryBuilder<LocalLocationPing, String, QQueryOperations>
      networkTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'networkType');
    });
  }

  QueryBuilder<LocalLocationPing, DateTime, QQueryOperations>
      recordedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'recordedAt');
    });
  }

  QueryBuilder<LocalLocationPing, double, QQueryOperations> speedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'speed');
    });
  }

  QueryBuilder<LocalLocationPing, SyncStatus, QQueryOperations>
      syncStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'syncStatus');
    });
  }

  QueryBuilder<LocalLocationPing, DateTime?, QQueryOperations>
      syncedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'syncedAt');
    });
  }

  QueryBuilder<LocalLocationPing, String, QQueryOperations>
      vehicleIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vehicleId');
    });
  }
}
