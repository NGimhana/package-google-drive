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

import ballerina/http;
import ballerina/io;

documentation{
    Represents the Google Drive Client Connector.

    F{{client}} HTTP Client used in Google Drive connector
}
public type GoogleDriveConnector object {
    public {
        http:Client client;
    }

    documentation{
        Get about information of a user, user drive, system settings.

        R{{}} If successful, returns About. Else returns GDriveError.
    }
    public function getAboutInformation() returns About|GDriveError;

    documentation{
        Get file resource.

        R{{}} If successful, returns File json. Else returns GDriveError.
    }
    public function getFile(string fileId) returns json|GDriveError;

    documentation{
        List files in Google Drive.
    }
    public function listFiles() returns json|GDriveError;
};


public function GoogleDriveConnector::getAboutInformation() returns About|GDriveError{
    endpoint http:Client httpClient = self.client;
    string getAboutInfoPath = FORWARD_SLASH_SYMBOL + ABOUT_RESOURCE;
    string uriParams;
    //Include all the fields in the response
    uriParams = check appendEncodedURIParameter(uriParams, FIELDS, STAR_SYMBOL);
    getAboutInfoPath += uriParams;
    var httpResponse = httpClient->get(getAboutInfoPath);
    match handleResponse(httpResponse){
        json jsonResponse => return convertJsonAboutToAboutType(jsonResponse);
        GDriveError gDriveError => return gDriveError;
    }
}

public function GoogleDriveConnector::getFile(string fileId) returns json|GDriveError{
    endpoint http:Client httpClient = self.client;
    string getFilePath = FORWARD_SLASH_SYMBOL + FILES_RESOURCE + FORWARD_SLASH_SYMBOL + fileId;
    var httpResponse = httpClient->get(getFilePath);
    match handleResponse(httpResponse){
        json jsonResponse => return jsonResponse;
        GDriveError gDriveError => return gDriveError;
    }
}

public function GoogleDriveConnector::listFiles() returns json|GDriveError{
    endpoint http:Client httpClient = self.client;
    string listFilesPath = FORWARD_SLASH_SYMBOL + FILES_RESOURCE;
    var httpResponse = httpClient->get(listFilesPath);
    match handleResponse(httpResponse){
        json jsonResponse => return jsonResponse;
        GDriveError gDriveError => return gDriveError;
    }
}



