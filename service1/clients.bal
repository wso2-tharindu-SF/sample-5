import service1.service2;

// An injected address may end in "/" — strip it so the generated client's
// leading-"/" resource paths join onto exactly one slash, never zero or two.
final service2:Client service2Client = check new (stripTrailingSlash(service2Url));

function stripTrailingSlash(string baseUrl) returns string {
    if baseUrl.endsWith("/") {
        return baseUrl.substring(0, baseUrl.length() - 1);
    }
    return baseUrl;
}
