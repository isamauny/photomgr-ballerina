import ballerina/io;
import ballerina/log;
import ballerina/time;
import ballerina/uuid;
import ballerinax/mongodb as mongodb;

type RegistrationFailed record {|
    string message;
|};

# Reusable functions
public function registerUser(mongodb:Database usersDb, UserRegistrationData user) returns registerResponse|RegistrationFailed|error {

    // Does user exist ? 
    UsersItem|error response = findUser(usersDb, user.user);

    if (response is UsersItem) {
        // User already exists
        RegistrationFailed returnMessage = {message: "User creation failed"};
        io:println("UserCreation Failed: Existing User");
        return returnMessage;
    }
    else {
        log:printInfo("Could not find user, registering");
        registerResponse|error userCreationResponse = createUser(usersDb, user);
        if (userCreationResponse is registerResponse) {
            return userCreationResponse;
        } else {
            RegistrationFailed returnMessage = {message: "User creation failed"};
            io:println("User Creation Failed: database error at creation time");
            return returnMessage;
        }
    }
}

isolated function findUser(mongodb:Database usersDb, string email) returns UsersItem|error {
    mongodb:Collection users = check usersDb->getCollection("users");
    map<json> search_filter = {"user": email};

    do {
        UsersItem|mongodb:DatabaseError|mongodb:ApplicationError|error|() findResult = users->findOne(filter = search_filter, targetType = UsersItem);

        if (findResult is UsersItem) {
            return findResult;
        }
        else {
            return error(string `Users with email ${email} does not exist`);
        }
    }
}

function createUser(mongodb:Database usersDb, UserRegistrationData userData) returns registerResponse|error {
    mongodb:Collection users = check usersDb->getCollection("users");
    string user_id = uuid:createType1AsString();
    string onboarding_date = time:utcToString(time:utcNow());

    FullUserRegistrationData userforDB = {_id: user_id, user: userData.user, pass: userData.pass, name: userData.name, is_admin: userData.is_admin, account_balance: userData.account_balance, onboarding_date};

    mongodb:Error? updateResult = users->insertOne(userforDB);

    if (updateResult is mongodb:Error) {
        // Error occured
        io:println(updateResult);
        log:printInfo("user Creation failed", updateResult);
        
        registerResponse response = {_id: "00000", token: null, message: "creation failed"};
        return response;

    }
    else {
        // An update happened
        string|error jwt_token = issueJWT(userforDB);
        registerResponse response;

        if (jwt_token is string) {
            response = {_id: user_id, token: jwt_token, message: "creation successful"};
        }
        else {
            response = {_id: user_id, token: null, message: "creation successful"};

        }
        return response;
    }
}
