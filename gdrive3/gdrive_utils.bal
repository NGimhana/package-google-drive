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

documentation{Handles the http response.
    P{{response}} - Http response or HttpConnectorEror
    R{{}} - If successful returns json reponse. Else returns GDriveError.
}
function handleResponse (http:Response|error response) returns (json|GDriveError){
    match response {
        http:Response httpResponse => {
            if (httpResponse.statusCode == http:NO_CONTENT_204){
                return true;
            }
            match httpResponse.getJsonPayload(){
                json jsonPayload => {
                    if (httpResponse.statusCode == http:OK_200) {
                        return jsonPayload;
                    }
                    else {
                        GDriveError gDriveError;
                        gDriveError.message = STATUS_CODE + COLON_SYMBOL + jsonPayload.error.code.toString()
                            + SEMICOLON_SYMBOL + WHITE_SPACE + MESSAGE + COLON_SYMBOL + WHITE_SPACE
                            + jsonPayload.error.message.toString();
                        foreach err in jsonPayload.error.errors {
                            string reason = err.reason.toString();
                            string message = err.message.toString();
                            string location = err.location.toString();
                            string locationType = err.locationType.toString();
                            string domain = err.domain.toString();
                            gDriveError.message += NEW_LINE + ERROR + COLON_SYMBOL + WHITE_SPACE + NEW_LINE + DOMAIN
                                + COLON_SYMBOL + WHITE_SPACE + domain + SEMICOLON_SYMBOL + WHITE_SPACE
                                + REASON + COLON_SYMBOL + WHITE_SPACE + reason + SEMICOLON_SYMBOL
                                + WHITE_SPACE + MESSAGE + COLON_SYMBOL + WHITE_SPACE + message
                                + SEMICOLON_SYMBOL + WHITE_SPACE + LOCATION_TYPE + COLON_SYMBOL
                                + WHITE_SPACE + locationType + SEMICOLON_SYMBOL + WHITE_SPACE
                                + LOCATION + COLON_SYMBOL + WHITE_SPACE + location;
                        }
                        return gDriveError;
                    }
                }
                error payloadError => {
                    GDriveError gDriveError = { message:"Error occurred when parsing to json response; message: " +
                        payloadError.message, cause:payloadError.cause };
                    return gDriveError;
                }
            }
        }
        error err => {
            GDriveError gDriveError = { message:"Error occurred during HTTP Client invocation; message: "
                +  err.message, cause:err.cause };
            return gDriveError;
        }
    }
}

documentation{Create url encoded request body with given key and value.
    P{{requestPath}} - Request path to be appended values.
    P{{key}} - Key of the form value parameter.
    P{{value}} - Value of the form value parameter.
    R{{}} - If successful returns created request with encoded string. Else returns GDriveError.
}
function appendEncodedURIParameter(string requestPath, string key, string value) returns (string|GDriveError) {
    var encodedVar = http:encode(value, UTF_8);
    string encodedString;
    match encodedVar {
        string encoded => encodedString = encoded;
        error err => {
            GDriveError gDriveError = {message:"Error occurred when encoding the value " + value + " with charset "
                + UTF_8, cause:err};
            return gDriveError;
        }
    }
    if (requestPath != EMPTY_STRING) {
        requestPath += AMPERSAND_SYMBOL;
    }
    else {
        requestPath += QUESTION_MARK_SYMBOL;
    }
    return requestPath + key + EQUAL_SYMBOL + encodedString;
}

documentation{Converts json string array to string array.

    P{{sourceJsonObject}} - Json array
    R{{}} - String array
}
function convertJSONArrayToStringArray(json[] sourceJsonObject) returns string[] {
    string[] targetStringArray = [];
    foreach i, element in sourceJsonObject {
        targetStringArray[i] = element.toString();
    }
    return targetStringArray;
}
