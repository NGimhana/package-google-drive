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

import ballerina/test;
import ballerina/config;

endpoint Client gDriveEP {
    clientConfig: {
        auth: {
            accessToken: config:getAsString("ACCESS_TOKEN"),
            clientId: config:getAsString("CLIENT_ID"),
            clientSecret: config:getAsString("CLIENT_SECRET"),
            refreshToken: config:getAsString("REFRESH_TOKEN")
        }
    }
};

@test:Config
function testgetAbout() {
    var aboutResponse = gDriveEP->getAboutInformation();
    match aboutResponse {
        About aboutInfo => io:println(aboutInfo);
        GDriveError error => io:println(error);
    }
}

@test:Config
function testgetFile() {
    var response = gDriveEP->getFile("1a_SOIJcchCoLTX55Lx0gEvHJ8soiUSZa1XDa_qCencw");
    match response {
        json file => io:println(file);
        GDriveError error => io:println(error);
    }
}

@test:Config
function testListFiles() {
    var response = gDriveEP->listFiles();
    match response {
        json fileList => io:println(fileList);
        GDriveError error => io:println(error);
    }
}

