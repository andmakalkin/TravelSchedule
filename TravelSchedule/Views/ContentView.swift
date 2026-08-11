import SwiftUI
import OpenAPIURLSession

struct ContentView: View {
    private let latitude = 59.864177
    private let longitude = 30.319163
    private let distance = 1
    private let fromStationCode = "s2006004" // Ленинградский вокзал
    private let toStationCode = "s9602494" // Московский вокзал
    private let uid = "778A_2_2" // Москва — Санкт-Петербург
    private let carrierCode = "4240" // РЖД
    
    var body: some View { }
    
    private func testGetNearestStations() {
        Task {
            do {
                let service = NearestStationsService(
                    client: try makeClient()
                )
                
                print("ℹ️ [testGetNearestStations] Выполнение запроса\n")
                
                let response = try await service.getNearestStations(
                    lat: latitude,
                    lng: longitude,
                    distance: distance
                )
                
                print("✅ [testGetNearestStations] Получен ответ:\n\(response)\n")
                
            } catch {
                print("❌ [testGetNearestStations] Получена ошибка:\n\(error)\n")
            }
        }
    }
    
    private func testGetScheduleBetweenStations() {
        Task {
            do {
                let service = ScheduleBetweenStationsService(
                    client: try makeClient()
                )
                
                print("ℹ️ [testGetScheduleBetweenStations] Выполнение запроса\n")
                
                let response = try await service.getScheduleBetweenStations(
                    from: fromStationCode,
                    to: toStationCode
                )
                
                print("✅ [testGetScheduleBetweenStations] Получен ответ:\n\(response)\n")
                
            } catch {
                print("❌ [testGetScheduleBetweenStations] Получена ошибка:\n\(error)\n")
            }
        }
    }
    
    private func testGetCopyright() {
        Task {
            do {
                let service = CopyrightService(
                    client: try makeClient()
                )
                
                print("ℹ️ [testGetCopyright] Выполнение запроса\n")
                
                let response = try await service.getCopyright()
                
                print("✅ [testGetCopyright] Получен ответ:\n\(response)\n")
                
            } catch {
                print("❌ [testGetCopyright] Получена ошибка:\n\(error)\n")
            }
        }
    }
    
    private func testGetScheduleForStation() {
        Task {
            do {
                let service = ScheduleForStationService(
                    client: try makeClient()
                )
                
                print("ℹ️ [testGetScheduleForStation] Выполнение запроса\n")
                
                let response = try await service.getScheduleForStation(
                    toStationCode
                )
                
                print("✅ [testGetScheduleForStation] Получен ответ:\n\(response)\n")
                
            } catch {
                print("❌ [testGetScheduleForStation] Получена ошибка:\n\(error)\n")
            }
        }
    }
    
    private func testGetThread() {
        Task {
            do {
                let service = ThreadService(
                    client: try makeClient()
                )
                
                print("ℹ️ [testGetThread] Выполнение запроса\n")
                
                let response = try await service.getThread(
                    uid: uid
                )
                
                print("✅ [testGetThread] Получен ответ:\n\(response)\n")
                
            } catch {
                print("❌ [testGetThread] Получена ошибка:\n\(error)\n")
            }
        }
    }
    
    private func testGetNearestSettlement() {
        Task {
            do {
                let service = NearestSettlementService(
                    client: try makeClient()
                )
                
                print("ℹ️ [testGetNearestSettlement] Выполнение запроса\n")
                
                let response = try await service.getNearestSettlement(
                    lat: latitude,
                    lng: longitude
                )
                
                print("✅ [testGetNearestSettlement] Получен ответ:\n\(response)\n")
                
            } catch {
                print("❌ [testGetNearestSettlement] Получена ошибка:\n\(error)\n")
            }
        }
    }
    
    private func testGetCarrier() {
        Task {
            do {
                let service = CarrierService(
                    client: try makeClient()
                )
                
                print("ℹ️ [testGetCarrier] Выполнение запроса\n")
                
                let response = try await service.getCarrier(
                    code: carrierCode
                )
                
                print("✅ [testGetCarrier] Получен ответ:\n\(response)\n")
                
            } catch {
                print("❌ [testGetCarrier] Получена ошибка:\n\(error)\n")
            }
        }
    }
    
    private func testGetStationsList() {
        Task {
            do {
                let service = StationsListService(
                    client: try makeClient()
                )
                
                print("ℹ️ [testGetStationsList] Выполнение запроса\n")
                
                let response = try await service.getStationsList()
                
                print("✅ [testGetStationsList] Получен список станций для \(response.countries.count) стран\n")
                
            } catch {
                print("❌ [testGetStationsList] Получена ошибка:\n\(error)\n")
            }
        }
    }
    
    private func makeClient() throws -> Client {
        Client(
            serverURL: try Servers.Server1.url(),
            transport: URLSessionTransport(),
            middlewares: [APIKeyMiddleware()]
        )
    }
}
