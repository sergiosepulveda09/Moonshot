//
//  Mission.swift
//  Moonshot
//
//  Created by Sergio Sepulveda on 2021-07-11.
//

import Foundation



struct Mission: Codable, Identifiable {

    //Nested Struct, To get it we can use Mission.CrewRole
    struct CrewRole: Codable {
        let name: String
        let role: String
    }

    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String


    var displayName: String {
        "Apollo \(id)"
    }
    var image: String {
        "apollo\(id)"
    }
    var formattedLaunchDate: String {
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        } else {
            return "N/A"
        }
    }
}
