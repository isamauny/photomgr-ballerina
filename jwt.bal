//Set of functions to manage JWTs used by the Pixi application
import ballerina/jwt;

configurable string path_to_pk = "app/keys/private.key";

function issueJWT(FullUserRegistrationData userData) returns string|error {
    // This JWT is NOT secure, as we are taking the full user item and pushing it in the
    // JWT payload. 

    jwt:IssuerSignatureConfig sigConfig = {algorithm: jwt:RS384, config:{keyFile: path_to_pk}};

    jwt:IssuerConfig issuerConfig = {
        customClaims: {"user_profile": userData},
        issuer: "PixiApp",
        username: userData.user,
        audience: "vEwzbcasJVQm1jVYHUHCjhxZ4tYa",
        expTime: 600,
        signatureConfig: sigConfig
    };

    string jwt = check jwt:issue(issuerConfig);
    return jwt;
}
