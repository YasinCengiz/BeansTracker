//
//  ConfigurationOption.swift
//  Beanz
//
//  Created by Yasin on 16.02.2023.
//

import Foundation

struct ConfigurationOption: Identifiable, Codable, Hashable {
    
    let id: UUID
    let name: String
    let calories: Int
    
    static let none = ConfigurationOption(id: UUID(), name: "None", calories: 0)
    
}

