import OpenAPIRuntime
import OpenAPIURLSession

typealias ScheduleForStationResponse = Components.Schemas.ScheduleForStationResponse

protocol ScheduleForStationServiceProtocol {
    func getScheduleForStation(_ station: String) async throws -> ScheduleForStationResponse
}

final class ScheduleForStationService: ScheduleForStationServiceProtocol {
    private let client: Client
    
    init(client: Client) {
        self.client = client
    }
    
    func getScheduleForStation(_ station: String) async throws -> ScheduleForStationResponse {
        let response = try await client.getScheduleForStation(
            query: .init(station: station)
        )
        
        return try response.ok.body.json
    }
}
