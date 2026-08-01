import Foundation
import HTTPTypes
import OpenAPIRuntime

nonisolated struct APIKeyMiddleware: ClientMiddleware {
    private let apiKey = "cba5ddb3-8073-41d4-b988-811e4d0c6354"
    
    func intercept(
        _ request: HTTPRequest,
        body: HTTPBody?,
        baseURL: URL,
        operationID: String,
        next: @concurrent @Sendable (
            HTTPRequest,
            HTTPBody?,
            URL
        ) async throws -> (
            HTTPResponse,
            HTTPBody?
        )
    ) async throws -> (HTTPResponse, HTTPBody?) {
        var request = request
        
        request.headerFields[.authorization] = apiKey
        
        return try await next(
            request,
            body,
            baseURL
        )
    }
}
