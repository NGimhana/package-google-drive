Connects to Google Drive from Ballerina. 

# Package Overview

The Google Drive connector allows you to work with files in Google Drive through the Google Drive REST API. It handles OAuth 2.0 
authentication. It also provides the ability to get information about user, user's Drive, search for files, and create file etc.

**Get information about user, user's Drive**

The `Dushani/gdrive3` package contains an operation to get information about the user, user's Drive, and system capabilities. 

**File Operations**

The `Dushani/gdrive3` package contains operations to get list of files in Drive and search for file.

## Compatibility
|                           |    Version     |  
| :------------------------:|:--------------:| 
|     Ballerina Language    |     0.970.0   |
|     Google Drive API      |      v3       |  

## Sample
First, import the `Dushani/gdrive3` package into the Ballerina project.
```ballerina
import Dushani/gdrive3;
```
Instantiate the connector by giving authentication details in the HTTP client config, which has built-in support for 
BasicAuth and OAuth 2.0. Google Drive uses OAuth 2.0 to authenticate and authorize requests. The Google Drive connector can be 
minimally instantiated in the HTTP client config using the access token or using the client ID, client secret, 
and refresh token.

**Obtaining Tokens to Run the Sample**

1. Visit [Google API Console](https://console.developers.google.com), click **Create Project**, and follow the wizard to create a new project.
2. Go to **Credentials -> OAuth consent screen**, enter a product name to be shown to users, and click **Save**.
3. On the **Credentials** tab, click **Create credentials** and select **OAuth client ID**. 
4. Select an application type, enter a name for the application, and specify a redirect URI (enter https://developers.google.com/oauthplayground if you want to use 
[OAuth 2.0 playground](https://developers.google.com/oauthplayground) to receive the authorization code and obtain the 
access token and refresh token). 
5. Click **Create**. Your client ID and client secret appear. 
6. In a separate browser window or tab, visit [OAuth 2.0 playground](https://developers.google.com/oauthplayground), select the required Gmail API scopes, and then click **Authorize APIs**.
7. When you receive your authorization code, click **Exchange authorization code for tokens** to obtain the refresh token and access token. 

You can now enter the credentials in the HTTP client config. 
```ballerina
endpoint gdrive3:Client gDriveEP {
    clientConfig:{
        auth:{
            accessToken:accessToken,
            clientId:clientId,
            clientSecret:clientSecret,
            refreshToken:refreshToken
        }
    }
};
```

The `getAboutInformation` function get information about user, user's Drive, and system capabilities. `About` is a 
structure that contains all those information.
```ballerina
var aboutResponse = gDriveEP->getAboutInformation();
match aboutResponse {
    About aboutInfo => io:println(aboutInfo);
    GDriveError error => io:println(error);
}
```

The response from `getAboutInformation` is either an `About` type object (if successful) or a `GDriveError` (if unsuccessful). The `match` operation can be 
used to handle the response if an error occurs.

The `getFile` function get information about a file in Drive. The response from `getFile` is either a json representation
of File resource or a `GDriveError`(if unsuccessful).
```ballerina
    var response = gDriveEP->getFile(fileId);
    match response {
        json file => io:println(file);
        GDriveError error => io:println(error);
    }
```

The `listFiles` function get a list of files in Drive. The response from `listFiles` is either a json representation of list of
files or a `GDriveError`(if unsuccessful).
```ballerina
    var response = gDriveEP->listFiles();
    match response {
        json fileList => io:println(fileList);
        GDriveError error => io:println(error);
    }
```

