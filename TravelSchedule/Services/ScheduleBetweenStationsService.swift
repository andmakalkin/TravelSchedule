import OpenAPIRuntime
import OpenAPIURLSession

typealias ScheduleBetweenStationsResponse = Components.Schemas.ScheduleBetweenStationsResponse

protocol ScheduleBetweenStationsServiceProtocol {
    func getScheduleBetweenStations(
        from: String,
        to: String
    ) async throws -> ScheduleBetweenStationsResponse
}

final class ScheduleBetweenStationsService: ScheduleBetweenStationsServiceProtocol {
    private let client: Client
    
    init(client: Client) {
        self.client = client
    }
    
    func getScheduleBetweenStations(
        from stationFrom: String,
        to stationTo: String
    ) async throws -> ScheduleBetweenStationsResponse {
        let response = try await client.getScheduleBetweenStations(
            query: .init(
                from: stationFrom,
                to: stationTo
            )
        )
        
        return try response.ok.body.json
    }
}
