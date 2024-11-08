// AUTO-GENERATED FILE. DO NOT MODIFY.
// This file is auto-generated by the Ballerina OpenAPI tool.

import ballerina/http;

# Pixi Photo Sharing API
public isolated client class Client {
    final http:Client clientEp;
    final readonly & ApiKeysConfig apiKeyConfig;
    # Gets invoked to initialize the `connector`.
    #
    # + apiKeyConfig - API keys for authorization 
    # + config - The configurations to be used when initializing the `connector` 
    # + serviceUrl - URL of the target service 
    # + return - An error if connector initialization failed 
    public isolated function init(ApiKeysConfig apiKeyConfig, ConnectionConfig config =  {}, string serviceUrl = "https://photo-demo.westeurope.cloudapp.azure.com/api") returns error? {
        http:ClientConfiguration httpClientConfig = {httpVersion: config.httpVersion, timeout: config.timeout, forwarded: config.forwarded, poolConfig: config.poolConfig, compression: config.compression, circuitBreaker: config.circuitBreaker, retryConfig: config.retryConfig, validation: config.validation};
        do {
            if config.http1Settings is ClientHttp1Settings {
                ClientHttp1Settings settings = check config.http1Settings.ensureType(ClientHttp1Settings);
                httpClientConfig.http1Settings = {...settings};
            }
            if config.http2Settings is http:ClientHttp2Settings {
                httpClientConfig.http2Settings = check config.http2Settings.ensureType(http:ClientHttp2Settings);
            }
            if config.cache is http:CacheConfig {
                httpClientConfig.cache = check config.cache.ensureType(http:CacheConfig);
            }
            if config.responseLimits is http:ResponseLimitConfigs {
                httpClientConfig.responseLimits = check config.responseLimits.ensureType(http:ResponseLimitConfigs);
            }
            if config.secureSocket is http:ClientSecureSocket {
                httpClientConfig.secureSocket = check config.secureSocket.ensureType(http:ClientSecureSocket);
            }
            if config.proxy is http:ProxyConfig {
                httpClientConfig.proxy = check config.proxy.ensureType(http:ProxyConfig);
            }
        }
        http:Client httpEp = check new (serviceUrl, httpClientConfig);
        self.clientEp = httpEp;
        self.apiKeyConfig = apiKeyConfig.cloneReadOnly();
        return;
    }

    # Delete User
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    resource isolated function delete admin/user/[string userid](map<string|string[]> headers = {}) returns inline_response_200_2|error {
        string resourcePath = string `/admin/user/${getEncodedUri(userid)}`;
        map<anydata> headerValues = {...headers};
        headerValues["x-access-token"] = self.apiKeyConfig.x\-access\-token;
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        return self.clientEp->delete(resourcePath, headers = httpHeaders);
    }

    # Delete user picture
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    resource isolated function delete picture/[string id](map<string|string[]> headers = {}) returns inline_response_200_3|error {
        string resourcePath = string `/picture/${getEncodedUri(id)}`;
        map<anydata> headerValues = {...headers};
        headerValues["x-access-token"] = self.apiKeyConfig.x\-access\-token;
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        return self.clientEp->delete(resourcePath, headers = httpHeaders);
    }

    # Returns the list of ALL users. Must be admin to call.
    #
    # + headers - Headers to be sent with the request 
    # + return - List Users 
    resource isolated function get admin/all_users(AdminallusersHeaders headers) returns UsersListItem[]|error {
        string resourcePath = string `/admin/all_users`;
        map<anydata> headerValues = {...headers};
        headerValues["x-access-token"] = self.apiKeyConfig.x\-access\-token;
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # search for a specific user
    #
    # + headers - Headers to be sent with the request 
    # + queries - Queries to be sent with the request 
    # + return - successful authentication user photo json object 
    resource isolated function get admin/users/search(UserSearchHeaders headers, *UserSearchQueries queries) returns UsersItem[]|error {
        string resourcePath = string `/admin/users/search`;
        resourcePath = resourcePath + check getPathForQueryParam(queries);
        map<anydata> headerValues = {...headers};
        headerValues["x-access-token"] = self.apiKeyConfig.x\-access\-token;
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # get user information
    #
    # + headers - Headers to be sent with the request 
    # + return - successful authentication sent user information 
    resource isolated function get user/info(map<string|string[]> headers = {}) returns UsersItem[]|error {
        string resourcePath = string `/user/info`;
        map<anydata> headerValues = {...headers};
        headerValues["x-access-token"] = self.apiKeyConfig.x\-access\-token;
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # Return user's pictures
    #
    # + headers - Headers to be sent with the request 
    # + return - OK 
    resource isolated function get user/pictures(map<string|string[]> headers = {}) returns PicturesList|error {
        string resourcePath = string `/user/pictures`;
        map<anydata> headerValues = {...headers};
        headerValues["x-access-token"] = self.apiKeyConfig.x\-access\-token;
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        return self.clientEp->get(resourcePath, httpHeaders);
    }

    # Attach picture to user account
    #
    # + headers - Headers to be sent with the request 
    # + payload - File to upload 
    # + return - OK 
    resource isolated function post picture/file_upload(picture_file_upload_body payload, map<string|string[]> headers = {}) returns ConfirmationMessage|error {
        string resourcePath = string `/picture/file_upload`;
        map<anydata> headerValues = {...headers};
        headerValues["x-access-token"] = self.apiKeyConfig.x\-access\-token;
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    # Attach picture to user account
    #
    # + headers - Headers to be sent with the request 
    # + payload - File to upload 
    # + return - OK 
    resource isolated function post picture/upload(picture_upload_body payload, map<string|string[]> headers = {}) returns ConfirmationMessage|error {
        string resourcePath = string `/picture/upload`;
        map<anydata> headerValues = {...headers};
        headerValues["x-access-token"] = self.apiKeyConfig.x\-access\-token;
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, httpHeaders);
    }

    # user/password based login
    #
    # + headers - Headers to be sent with the request 
    resource isolated function post user/login(user_login_body payload, map<string|string[]> headers = {}) returns registerResponse|error {
        string resourcePath = string `/user/login`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # register for an account
    #
    # + headers - Headers to be sent with the request 
    # + return - successfully registered, token received 
    resource isolated function post user/register(UserRegistrationData payload, map<string|string[]> headers = {}) returns inline_response_200_1|ErrorMessage|error {
        string resourcePath = string `/user/register`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->post(resourcePath, request, headers);
    }

    # edit user information
    #
    # + headers - Headers to be sent with the request 
    # + payload - userobject 
    # + return - successful authentication sent user information 
    resource isolated function put user/edit_info(EdituserinfoHeaders headers, UserUpdateData payload) returns ErrorMessage|error {
        string resourcePath = string `/user/edit_info`;
        map<anydata> headerValues = {...headers};
        headerValues["x-access-token"] = self.apiKeyConfig.x\-access\-token;
        map<string|string[]> httpHeaders = getMapForHeaders(headerValues);
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        return self.clientEp->put(resourcePath, request, httpHeaders);
    }
}
