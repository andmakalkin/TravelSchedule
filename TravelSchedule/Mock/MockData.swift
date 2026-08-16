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
    
    static let rzd = Carrier(
        name: "ОАО «РЖД»",
        logo: "logoRZD",
        email: "i.lozgkina@yandex.ru",
        phone: "+7 (904) 329-27-71"
    )

    static let fgk = Carrier(
        name: "ФГК",
        logo: "logoFGK",
        email: "info@fgk.ru",
        phone: "+7 (800) 000-00-00"
    )

    static let uralLogistics = Carrier(
        name: "Урал логистика",
        logo: "logoUralLogistics",
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
            transferInfo: "С пересадкой в Костроме",
            departurePeriod: .evening
        ),
        
        TravelOption(
            carrier: fgk,
            date: "15 января",
            departureTime: "01:15",
            arrivalTime: "09:00",
            duration: "9 часов",
            transferInfo: nil,
            departurePeriod: .night
        ),
        
        TravelOption(
            carrier: uralLogistics,
            date: "16 января",
            departureTime: "12:30",
            arrivalTime: "21:00",
            duration: "9 часов",
            transferInfo: nil,
            departurePeriod: .day
        ),
        
        TravelOption(
            carrier: rzd,
            date: "17 января",
            departureTime: "08:20",
            arrivalTime: "17:00",
            duration: "9 часов",
            transferInfo: "С пересадкой в Москве",
            departurePeriod: .morning
        ),
        
        TravelOption(
            carrier: rzd,
            date: "14 января",
            departureTime: "22:30",
            arrivalTime: "08:15",
            duration: "20 часов",
            transferInfo: "С пересадкой в Костроме",
            departurePeriod: .evening
        ),
        
        TravelOption(
            carrier: fgk,
            date: "15 января",
            departureTime: "01:15",
            arrivalTime: "09:00",
            duration: "9 часов",
            transferInfo: nil,
            departurePeriod: .night
        ),
        
        TravelOption(
            carrier: uralLogistics,
            date: "15 января",
            departureTime: "12:30",
            arrivalTime: "21:00",
            duration: "9 часов",
            transferInfo: nil,
            departurePeriod: .day
        ),
        
        TravelOption(
            carrier: rzd,
            date: "17 января",
            departureTime: "08:20",
            arrivalTime: "17:00",
            duration: "9 часов",
            transferInfo: "С пересадкой в Москве",
            departurePeriod: .morning
        )
    ]
    
    static let stories: [Story] = (1...9).map { index in
        Story(
            title: "Text Text Text Text Text Text Text Text Text Text",
            description: "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text",
            largeImage: "story\(index)",
            previewImage: "story\(index)Preview"
        )
    }
}
