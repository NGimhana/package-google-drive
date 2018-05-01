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

import ballerina/log;

function convertJsonAboutToAboutType(json sourceAboutJsonObject) returns About {
    About targetAbout;
    targetAbout.kind = sourceAboutJsonObject.kind.toString();
    targetAbout.user = convertJsonUserToUserType(sourceAboutJsonObject.user);
    targetAbout.appInstalled = check <boolean>sourceAboutJsonObject.appInstalled;
    targetAbout.canCreateTeamDrives = check <boolean>sourceAboutJsonObject.canCreateTeamDrives;
    targetAbout.exportFormats = sourceAboutJsonObject.exportFormats;
    targetAbout.importFormats = sourceAboutJsonObject.importFormats;
    targetAbout.maxImportSizes = sourceAboutJsonObject.maxImportSizes;
    match <json[]>sourceAboutJsonObject.folderColorPalette {
        json[] folderColors => {
            targetAbout.folderColorPalette = convertJSONArrayToStringArray(folderColors);
        }
        //No key named folderColorPalette in the response.
        error err => log:printDebug("No folder colors supported for user" + targetAbout.user.displayName);
    }
    targetAbout.teamDriveThemes = sourceAboutJsonObject.teamDriveThemes.toString();
    targetAbout.maxUploadSize = sourceAboutJsonObject.maxUploadSize.toString();
    targetAbout.storageQuota = converJsonStorageQuotaToType(sourceAboutJsonObject.storageQuota);
    return targetAbout;
}


function convertJsonUserToUserType(json sourceUserJsonObject) returns User {
    User targetUser;
    targetUser.kind = sourceUserJsonObject.kind.toString();
    targetUser.emailAddress = sourceUserJsonObject.emailAddress.toString();
    targetUser.displayName = sourceUserJsonObject.displayName.toString();
    targetUser.permissionId = sourceUserJsonObject.permissionId.toString();
    targetUser.photoLink = sourceUserJsonObject.photoLink.toString();
    targetUser.me   = check <boolean>sourceUserJsonObject.me;
    return targetUser;
}

function converJsonStorageQuotaToType(json sourceStorageJsonObject) returns StorageQuota {
    StorageQuota targetStorage;
    targetStorage.usage = sourceStorageJsonObject.usage.toString();
    targetStorage.usageInDrive = sourceStorageJsonObject.usageInDrive.toString();
    targetStorage.usageInDriveTrash = sourceStorageJsonObject.usageInDriveTrash.toString();
    targetStorage.usageLimit = sourceStorageJsonObject.usageLimit.toString();
    return targetStorage;
}