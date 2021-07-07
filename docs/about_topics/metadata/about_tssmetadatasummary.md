---
title: "TssMetadataSummary"
---

# TOPIC
    This help topic describes the TssMetadataSummary class in the Thycotic.SecretServer module

# CLASS
    TssMetadataSummary

# INHERITANCE
    None

# DESCRIPTION
    The TssMetadataSummary class represents the MetadataSummaryModel object returned by Secret Server endpoint GET /metadata/summary.

# CONSTRUCTORS
    new()

# PROPERTIES
    CreateDateTime string <date-time>
        When the field value was created

    CreateUserId integer <int32>
        The user id of who entered the field value

    CreateUserName string
        Who entered the field value

    ItemId integer <int32>
        The ID of the item to which this metadata is associated

    MetadataFieldDataType string (MetadataFieldDataType)
        Field types for metadata values ("String" "Boolean" "Number" "DateTime" "User")

    MetadataFieldId integer <int32>
        The metadata field id

    MetadataFieldName string
        The metadata field name

    MetadataFieldSectionId integer <int32>
        The Metadata section ID

    MetadataFieldSectionName string
        The metadata section name

    MetadataFieldTypeName string
        Not currently populated, see MetadataFieldDataType

    MetadataItemDataId integer <int32>
        The sequence id for this specific metadata field

    MetadataType string (MetadataType)
    The types of entities that metadata can be associated to ("User" "Secret" "Folder" "Group")

    MetadataTypeName string
        Not currently populated, see MetadataType

    SortOrder integer <int32>
        The order in which to sort the metadata fields. This is currently not utilized.

    ValueBit boolean
        When this metadata field is a boolean this will be the value

    ValueDateTime string <date-time>
        When this metadata field is a datetime this will be the value

    ValueInt integer <int32>
        When this metadata field is a user this will be the user id

    ValueNumber number <double>
        When this metadata field is a number this will be the value

    ValueString string
        When this metadata field is a string this will be the value

    ValueUserDisplayName string
        When this metadata field is a user this will be the user display name

# METHODS

# RELATED LINKS:
    Search-TssMetadata