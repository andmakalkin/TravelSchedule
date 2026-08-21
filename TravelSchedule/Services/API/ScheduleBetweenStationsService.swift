import OpenAPIRuntime
import OpenAPIURLSession

typealias ScheduleBetweenStationsResponse = Components.Schemas.ScheduleBetweenStationsResponse

protocol ScheduleBetweenStationsServiceProtocol {
    func getScheduleBetweenStations(
        from: String,
        to: String,
        date: String,
        transfers: Bool,
        offset: Int,
        limit: Int
    ) async throws -> ScheduleBetweenStationsResponse
}

final class ScheduleBetweenStationsService: ScheduleBetweenStationsServiceProtocol {
    private let client: Client
    
    init(client: Client) {
        self.client = client
    }
    
    func getScheduleBetweenStations(
        from stationFrom: String,
        to stationTo: String,
        date: String,
        transfers: Bool,
        offset: Int,
        limit: Int
    ) async throws -> ScheduleBetweenStationsResponse {
        let response = try await client.getScheduleBetweenStations(
            query: .init(
                from: stationFrom,
                to: stationTo,
                date: date,
                transfers: transfers,
                offset: offset,
                limit: limit
            )
        )
        
        return try response.ok.body.json
    }
}
