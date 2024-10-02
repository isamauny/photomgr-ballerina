// AUTO-GENERATED FILE.
// This file is auto-generated by the Ballerina OpenAPI tool.

import ballerina/http;
import ballerinax/mongodb;
import ballerina/io;
import ballerina/uuid;

configurable string host = "localhost";
configurable int port = 27017;

configurable string username = ?;
configurable string password = ?;
configurable string db_name = ?;

final mongodb:Client db_connection = check new ({
    connection: {
        serverAddress: {
            host: host,
            port: port
        },
        auth: <mongodb:ScramSha256AuthCredential>{
            username: username,
            password: password,
            database: db_name
        }   
    }
});


listener http:Listener main_endpoint = new (8090);

service /api/pixi on main_endpoint {

    private final mongodb:Database usersDb;

    function init() returns error? {
        // Initialize connection to Mongo database. 
        // This code assumes MongoDB is running with auth ON.
        self.usersDb = check db_connection->getDatabase(db_name);
        io:println ("Connection to database established...");
    }
    
    // # Delete User
    // #
    // # + return - returns can be any of following types 
    // # http:Ok (OK)
    // # http:Forbidden (Forbidden)
    // # http:Response (unexpected error)
    // resource function delete admin/user/[string userid]() returns inline_response_200_2|ForbiddenAuthenticationError|http:Response {
    // }

    // # Delete user picture
    // #
    // # + return - returns can be any of following types 
    // # http:Ok (OK)
    // # http:Forbidden (Forbidden)
    // # http:Response (unexpected error)
    // resource function delete picture/[string id]() returns inline_response_200_3|ForbiddenAuthenticationError|http:Response {
    // }

    // # Returns the list of ALL users. Must be admin to call.
    // #
    // # + return - returns can be any of following types 
    // # http:Ok (List Users)
    // # http:Forbidden (No token provided or invalid token.)
    // # http:Response (unexpected error)
    // resource function get admin/all_users(@http:Header string x\-access\-token) returns UsersListItem[]|ForbiddenAuthenticationError|http:Response {
    // }

    // # get user information
    // #
    // # + return - returns can be any of following types 
    // # http:Ok (successful authentication sent user information)
    // # http:Forbidden (invalid or missing token)
    // # http:Response (unexpected error)
    // resource function get user/info() returns UsersItem[]|ForbiddenAuthenticationError|http:Response {
    // }

    // # Return user's pictures
    // #
    // # + return - returns can be any of following types 
    // # http:Ok (OK)
    // # http:Forbidden (invalid or missing token)
    // # http:Response (unexpected error)
    // resource function get user/pictures() returns PicturesList|ForbiddenAuthenticationError|http:Response {
    // }

    // # Attach picture to user account
    // #
    // # + payload - File to upload 
    // # + return - returns can be any of following types 
    // # http:Ok (OK)
    // # http:Forbidden (invalid or missing token)
    // # http:Response (unexpected error)
    // resource function post picture/file_upload(@http:Payload picture_file_upload_body payload) returns OkConfirmationMessage|ForbiddenAuthenticationError|http:Response {
    // }

    // # Attach picture to user account
    // #
    // # + payload - File to upload 
    // # + return - returns can be any of following types 
    // # http:Ok (OK)
    // # http:Forbidden (invalid or missing token)
    // # http:Response (unexpected error)
    // resource function post picture/upload(@http:Payload picture_upload_body payload) returns OkConfirmationMessage|ForbiddenAuthenticationError|http:Response {
    // }

    // # user/password based login
    // #
    // # + return - returns can be any of following types 
    // # http:UnprocessableEntity (missing parameters)
    // # http:Response (unexpected error)
    // resource function post user/login(@http:Payload user_login_body payload) returns OkInline_response_200|UnprocessableEntityErrorMessage|http:Response {
    // }

    # register for an account
    # + return - http:Ok (successfully registered, token received)
    # + return - http:BadRequest (email address already registered)
    # + return - http:Response (unexpected error)
    isolated resource function post user/register(@http:Payload UserRegistrationData payload) returns AcceptedErrorMessage|http:Response| BadContentMessage{
        string transaction_id = uuid:createType4AsString();

        registerResponse|RegistrationFailed|error createResponse = registerUser(self.usersDb, payload);
        http:Response response = new http:Response ();


        if createResponse is RegistrationFailed {
            response.statusCode = 400;
            response.setHeader("x-transaction-id", transaction_id) ;
            response.setJsonPayload(createResponse, "application/json");

            return response;
        }

        else if createResponse is registerResponse {
            response.statusCode = 201;
            response.setHeader("x-transaction-id", transaction_id) ;
            response.setJsonPayload(createResponse, "application/json");

            return response;
        }
        else {
            ErrorMessage errorPayload  = { message: "Invalid Input"};
            BadContentMessage errorResponse = {
                body: errorPayload
            };
            return errorResponse;
        }
    }

    // # edit user information
    // #
    // # + payload - userobject 
    // # + return - returns can be any of following types 
    // # http:Ok (successful authentication sent user information)
    // # http:Forbidden (invalid or missing token)
    // # http:Response (unexpected error)
    // resource function put user/edit_info(@http:Header string x\-access\-token, @http:Payload UserUpdateData payload) returns ErrorMessage|ForbiddenAuthenticationError|http:Response {
    // }
}
