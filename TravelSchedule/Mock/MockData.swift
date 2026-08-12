enum MockData {
    static let cities: [City] = [
        City(
            name: "Москва",
            stations: [
                Station(
                    name: "Киевский вокзал",
                    cityName: "Москва"
                ),
                Station(
                    name: "Курский вокзал",
                    cityName: "Москва"
                ),
                Station(
                    name: "Ярославский вокзал",
                    cityName: "Москва"
                ),
                Station(
                    name: "Белорусский вокзал",
                    cityName: "Москва"
                ),
                Station(
                    name: "Савёловский вокзал",
                    cityName: "Москва"
                ),
                Station(
                    name: "Ленинградский вокзал",
                    cityName: "Москва"
                )
            ]
        ),

        City(
            name: "Санкт-Петербург",
            stations: [
                Station(
                    name: "Балтийский вокзал",
                    cityName: "Санкт-Петербург"
                ),
                Station(
                    name: "Московский вокзал",
                    cityName: "Санкт-Петербург"
                ),
                Station(
                    name: "Витебский вокзал",
                    cityName: "Санкт-Петербург"
                ),
                Station(
                    name: "Финляндский вокзал",
                    cityName: "Санкт-Петербург"
                )
            ]
        ),

        City(
            name: "Сочи",
            stations: [
                Station(
                    name: "Сочи",
                    cityName: "Сочи"
                ),
                Station(
                    name: "Адлер",
                    cityName: "Сочи"
                )
            ]
        ),

        City(
            name: "Горный воздух",
            stations: [
                Station(
                    name: "Горный воздух",
                    cityName: "Горный воздух"
                )
            ]
        ),

        City(
            name: "Краснодар",
            stations: [
                Station(
                    name: "Краснодар-1",
                    cityName: "Краснодар"
                )
            ]
        ),

        City(
            name: "Казань",
            stations: [
                Station(
                    name: "Казань-Пасс.",
                    cityName: "Казань"
                )
            ]
        ),

        City(
            name: "Омск",
            stations: [
                Station(
                    name: "Омск-Пасс.",
                    cityName: "Омск"
                )
            ]
        )
    ]
    
    static let travelOptions: [TravelOption] = [
        TravelOption(
            carrierName: "РЖД",
            carrierLogo: "logoRZD",
            date: "14 января",
            departureTime: "22:30",
            arrivalTime: "08:15",
            duration: "20 часов",
            transferInfo: "С пересадкой в Костроме",
            departurePeriod: .evening
        ),
        
        TravelOption(
            carrierName: "ФГК",
            carrierLogo: "logoFGK",
            date: "15 января",
            departureTime: "01:15",
            arrivalTime: "09:00",
            duration: "9 часов",
            transferInfo: nil,
            departurePeriod: .night
        ),
        
        TravelOption(
            carrierName: "Урал логистика",
            carrierLogo: "logoUralLogistics",
            date: "16 января",
            departureTime: "12:30",
            arrivalTime: "21:00",
            duration: "9 часов",
            transferInfo: nil,
            departurePeriod: .day
        ),
        
        TravelOption(
            carrierName: "РЖД",
            carrierLogo: "logoRZD",
            date: "17 января",
            departureTime: "08:20",
            arrivalTime: "17:00",
            duration: "9 часов",
            transferInfo: "С пересадкой в Москве",
            departurePeriod: .morning
        ),
        
        TravelOption(
            carrierName: "РЖД",
            carrierLogo: "logoRZD",
            date: "14 января",
            departureTime: "22:30",
            arrivalTime: "08:15",
            duration: "20 часов",
            transferInfo: "С пересадкой в Костроме",
            departurePeriod: .evening
        ),
        
        TravelOption(
            carrierName: "ФГК",
            carrierLogo: "logoFGK",
            date: "15 января",
            departureTime: "01:15",
            arrivalTime: "09:00",
            duration: "9 часов",
            transferInfo: nil,
            departurePeriod: .night
        ),
        
        TravelOption(
            carrierName: "Урал логистика",
            carrierLogo: "logoUralLogistics",
            date: "15 января",
            departureTime: "12:30",
            arrivalTime: "21:00",
            duration: "9 часов",
            transferInfo: nil,
            departurePeriod: .day
        ),
        
        TravelOption(
            carrierName: "РЖД",
            carrierLogo: "logoRZD",
            date: "17 января",
            departureTime: "08:20",
            arrivalTime: "17:00",
            duration: "9 часов",
            transferInfo: "С пересадкой в Москве",
            departurePeriod: .morning
        )
    ]
}
