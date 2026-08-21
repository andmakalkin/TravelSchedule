enum MockData {
    static let cities: [City] = [
        City(
            name: "Москва",
            stations: [
                Station(
                    code: "01",
                    name: "Киевский вокзал",
                    cityName: "Москва"
                ),
                Station(
                    code: "02",
                    name: "Курский вокзал",
                    cityName: "Москва"
                ),
                Station(
                    code: "03",
                    name: "Ярославский вокзал",
                    cityName: "Москва"
                ),
                Station(
                    code: "04",
                    name: "Белорусский вокзал",
                    cityName: "Москва"
                ),
                Station(
                    code: "05",
                    name: "Савёловский вокзал",
                    cityName: "Москва"
                ),
                Station(
                    code: "06",
                    name: "Ленинградский вокзал",
                    cityName: "Москва"
                )
            ]
        ),

        City(
            name: "Санкт-Петербург",
            stations: [
                Station(
                    code: "07",
                    name: "Балтийский вокзал",
                    cityName: "Санкт-Петербург"
                ),
                Station(
                    code: "08",
                    name: "Московский вокзал",
                    cityName: "Санкт-Петербург"
                ),
                Station(
                    code: "09",
                    name: "Витебский вокзал",
                    cityName: "Санкт-Петербург"
                ),
                Station(
                    code: "10",
                    name: "Финляндский вокзал",
                    cityName: "Санкт-Петербург"
                )
            ]
        ),

        City(
            name: "Сочи",
            stations: [
                Station(
                    code: "11",
                    name: "Сочи",
                    cityName: "Сочи"
                ),
                Station(
                    code: "12",
                    name: "Адлер",
                    cityName: "Сочи"
                )
            ]
        ),

        City(
            name: "Горный воздух",
            stations: [
                Station(
                    code: "13",
                    name: "Горный воздух",
                    cityName: "Горный воздух"
                )
            ]
        ),

        City(
            name: "Краснодар",
            stations: [
                Station(
                    code: "14",
                    name: "Краснодар-1",
                    cityName: "Краснодар"
                )
            ]
        ),

        City(
            name: "Казань",
            stations: [
                Station(
                    code: "15",
                    name: "Казань-Пасс.",
                    cityName: "Казань"
                )
            ]
        ),

        City(
            name: "Омск",
            stations: [
                Station(
                    code: "16",
                    name: "Омск-Пасс.",
                    cityName: "Омск"
                )
            ]
        )
    ]
    
    static let rzd = Carrier(
        code: 01,
        name: "ОАО «РЖД»",
        logoURL: nil,
        email: "i.lozgkina@yandex.ru",
        phone: "+7 (904) 329-27-71"
    )

    static let fgk = Carrier(
        code: 02,
        name: "ФГК",
        logoURL: nil,
        email: "info@fgk.ru",
        phone: "+7 (800) 000-00-00"
    )

    static let uralLogistics = Carrier(
        code: 03,
        name: "Урал логистика",
        logoURL: nil,
        email: "info@ural-logistics.ru",
        phone: "+7 (800) 000-00-00"
    )
    
    static let travelOptions: [TravelOption] = [
        TravelOption(
            carrier: rzd,
            date: "14 января",
            departureTime: "22:30",
            arrivalTime: "08:15",
            duration: "20 часов",
            hasTransfers: true,
            departurePeriod: .evening
        ),
        
        TravelOption(
            carrier: nil,
            date: "14 января",
            departureTime: "22:30",
            arrivalTime: "08:15",
            duration: "20 часов",
            hasTransfers: true,
            departurePeriod: .evening
        ),
        
        TravelOption(
            carrier: fgk,
            date: "15 января",
            departureTime: "01:15",
            arrivalTime: "09:00",
            duration: "9 часов",
            hasTransfers: false,
            departurePeriod: .night
        ),
        
        TravelOption(
            carrier: uralLogistics,
            date: "16 января",
            departureTime: "12:30",
            arrivalTime: "21:00",
            duration: "9 часов",
            hasTransfers: false,
            departurePeriod: .day
        ),
        
        TravelOption(
            carrier: rzd,
            date: "17 января",
            departureTime: "08:20",
            arrivalTime: "17:00",
            duration: "9 часов",
            hasTransfers: true,
            departurePeriod: .morning
        ),
        
        TravelOption(
            carrier: rzd,
            date: "14 января",
            departureTime: "22:30",
            arrivalTime: "08:15",
            duration: "20 часов",
            hasTransfers: true,
            departurePeriod: .evening
        ),
        
        TravelOption(
            carrier: fgk,
            date: "15 января",
            departureTime: "01:15",
            arrivalTime: "09:00",
            duration: "9 часов",
            hasTransfers: false,
            departurePeriod: .night
        ),
        
        TravelOption(
            carrier: uralLogistics,
            date: "15 января",
            departureTime: "12:30",
            arrivalTime: "21:00",
            duration: "9 часов",
            hasTransfers: false,
            departurePeriod: .day
        ),
        
        TravelOption(
            carrier: rzd,
            date: "17 января",
            departureTime: "08:20",
            arrivalTime: "17:00",
            duration: "9 часов",
            hasTransfers: true,
            departurePeriod: .morning
        )
    ]
}
