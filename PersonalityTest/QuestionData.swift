//
//  Question.swift
//  PersonalityTest
//
//  Created by Elise on 9/25/22.
//

import Foundation

struct QuestionData {
    var text: String
    var type: ResponseType
    var answers: [Answer]
}

enum ResponseType {
    case single, multiple, ranged
}

struct Answer {
    var text: String
    var type: CountryType
}

enum CountryType: String {
    case argentina = "Argentina 🏔", thailand = "Thailand 🏝", japan = "Japan 🌃", spain = "Spain 💃🏻"
    
    var description: String {
        switch self {
        case .argentina:
            return "Beautiful mountain scenery and steak for dinner."
        case .thailand:
            return "Island vibes, scuba diving, pad thai, and spicy curries."
        case .japan:
            return "Futuristic cities and as much sushi as you can eat!"
        case .spain:
            return "Incredible architecture, dancing, tapas, and wine!"
        }
    }
}

/*struct MyDestination {
    var countryDescription: String
    var countryTypeEnum: CountryType
}
 (this is just answer struct) */
