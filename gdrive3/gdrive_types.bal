// Copyright (c) 2018, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

documentation{
    Represents GDrive error.

    F{{message}} GDrive error message
    F{{cause}} The error which caused the GDrive error
}
public type GDriveError {
    string message;
    error? cause;
};

documentation{
    Represents the resource about the user, the user's Drive, and system capabilities.

    F{{kind}} 	Identifies what kind of resource this is. Value: the fixed string "drive#about"
    F{{user}}   The authenticated user
    F{{importFormats}}  A map of source MIME type to possible targets for all supported imports
    F{{exportFormats}} A map of source MIME type to possible targets for all supported exports
    F{{maxImportSizes}} A map of maximum import sizes by MIME type, in bytes
    F{{maxUploadSize}} 	The maximum upload size in bytes
    F{{appInstalled}} Whether the user has installed the requesting app
    F{{folderColorPalette}} The currently supported folder colors as RGB hex strings
    F{{teamDriveThemes}} A list of themes that are supported for Team Drives
    F{{canCreateTeamDrives}} Whether the user can create Team Drives
}
public type About {
    string kind;
    User user;
    json importFormats;
    json exportFormats;
    json maxImportSizes;
    string maxUploadSize;
    boolean appInstalled;
    string[] folderColorPalette;
    json teamDriveThemes;
    boolean canCreateTeamDrives;
    StorageQuota storageQuota;
};

documentation{
    Represents authenticated user.

    F{{kind}} Identifies what kind of resource this is. Value: the fixed string "drive#user"
    F{{displayName}} A plain text displayable name for this user
    F{{photoLink}} A link to the user's profile photo, if available
    F{{me}} Whether this user is the requesting user
    F{{permissionId}} The user's ID as visible in Permission resources
    F{{emailAddress}} The email address of the user
}
public type User {
    string kind;
    string displayName;
    string photoLink;
    boolean me;
    string permissionId;
    string emailAddress;
};

documentation{
    Represents the user's storage quota limits and usage. All fields are measured in bytes.

    F{{usageLimit}} The usage limit, if applicable. This will not be present if the user has unlimited storage.
    F{{usage}} The total usage across all services
    F{{usageInDrive}} The usage by all files in Google Drive
    F{{usageInDriveTrash}} 	The usage by trashed files in Google Drive
}
public type StorageQuota {
    string usageLimit;
    string usage;
    string usageInDrive;
    string usageInDriveTrash;
};

