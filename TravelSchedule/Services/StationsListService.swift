import OpenAPIRuntime
import OpenAPIURLSession
import Foundation

typealias StationsListResponse = Components.Schemas.StationsListResponse

protocol StationsListServiceProtocol {
    func getStationsList() async throws -> StationsListResponse
}

final class StationsListService: StationsListServiceProtocol {
    private let client: Client
    
    init(client: Client) {
        self.client = client
    }
    
    func getStationsList() async throws -> StationsListResponse {
        let response = try await client.getStationsList(
            query: .init()
        )
        
        let responseBody = try response.ok.body.html
        
        let limit = 100 * 1024 * 1024
        let fullData = try await Data(collecting: responseBody, upTo: limit)
        
        let stationsList = try JSONDecoder().decode(StationsListResponse.self, from: fullData)
        
        return stationsList
    }
}
