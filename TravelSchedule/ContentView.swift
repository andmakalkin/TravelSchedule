import SwiftUI
import OpenAPIURLSession

struct ContentView: View {
    let lat = 59.864177
    let lng = 30.319163
    let distance = 1
    let station1 = "s2006004" // Ленинградский вокзал
    let station2 = "s9602494" // Московский вокзал
    let uid = "778A_2_2" // Москва — Санкт-Петербург
    let carrierCode = "4240" // РЖД
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            // Раскомментировать по очереди для проверки
            testGetNearestStations()
//            testGetScheduleBetweenStations()
//            testGetCopyright()
//            testGetScheduleForStation()
//            testGetThread()
//            testGetNearestSettlement()
//            testGetCarrier()
//            testGetStationsList()
        }
    }
    
    private func testGetNearestStations() {
        Task {
            do {
                let service = NearestStationsService(
                    client: try makeClient()
                )
                
                print("ℹ️ [testGetNearestStations] Выполнение запроса\n")
                
                let response = try await service.getNearestStations(
                    lat: lat,
                    lng: lng,
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
                    from: station1,
                    to: station2
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
                    station2
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
                    lat: lat,
                    lng: lng
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

#Preview {
    ContentView()
}
