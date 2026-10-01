import ballerina/os;

// Base address of service2, injected by the platform. Never hardcode an
// upstream address — this is the single place config is read from.
configurable string service2Url = os:getEnv("SERVICE2_URL");
