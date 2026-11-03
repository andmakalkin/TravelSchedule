import OpenAPIRuntime
import OpenAPIURLSession

typealias CarrierResponse = Components.Schemas.CarrierResponse

protocol CarrierServiceProtocol {
    func getCarrier(code: String) async throws -> CarrierResponse
}

final class CarrierService: CarrierServiceProtocol {
    private let client: Client
    
    init(client: Client) {
        self.client = client
    }
    
    func getCarrier(code: String) async throws -> CarrierResponse {
        let response = try await client.getCarrier(
            query: .init(code: code)
        )
        
        return try response.ok.body.json
    }
}
