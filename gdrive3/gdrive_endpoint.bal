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

documentation{
    Represents Google Drive endpoint.

    E{{}}
    F{{gDriveConfig}} Google Drive endpoint configuration
    F{{gDriveConnector}} Google Drive connector
}
public type Client object {
    public {
        GoogleDriveConfiguration gDriveConfig;
        GoogleDriveConnector gDriveConnector;
    }

    documentation{
        Gets called when the Google Drive endpoint is beign initialized.

        P{{gDriveConfig}} Google Drive connector configuration
    }
    public function init(GoogleDriveConfiguration gDriveConfig) {
        gDriveConfig.clientConfig.url = BASE_URL;
        match gDriveConfig.clientConfig.auth {
            () => {}
            http:AuthConfig authConfig => {
                authConfig.refreshUrl = REFRESH_TOKEN_EP;
                authConfig.scheme = OAUTH;
            }
        }
        self.gDriveConnector = new;
        self.gDriveConnector.client.init(gDriveConfig.clientConfig);
    }

    documentation{
        Returns the connector that client code uses.
    }
    public function getCallerActions() returns GoogleDriveConnector {
        return self.gDriveConnector;
    }
};

documentation{
    Represents the Google Crive client endpoint configuration.

    F{{clientConfig}} The HTTP Client endpoint configuration
}
public type GoogleDriveConfiguration {
    http:ClientEndpointConfig clientConfig;
};
