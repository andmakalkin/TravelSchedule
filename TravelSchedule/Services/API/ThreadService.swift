import OpenAPIRuntime
import OpenAPIURLSession

typealias ThreadResponse = Components.Schemas.ThreadResponse

protocol ThreadServiceProtocol {
    func getThread(uid: String) async throws -> ThreadResponse
}

final class ThreadService: ThreadServiceProtocol {
    private let client: Client
    
    init(client: Client) {
        self.client = client
    }
    
    func getThread(uid: String) async throws -> ThreadResponse {
        let response = try await client.getThread(
            query: .init(uid: uid)
        )
        
        return try response.ok.body.json
    }
}
