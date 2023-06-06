//
//  Serving.swift
//  Beanz
//
//  Created by Yasin on 20.02.2023.
//

import Foundation

struct Serving: Identifiable, Codable, Equatable {
    
    var id: UUID
    let name: String
    let description: String
    let caffeine: Int
    let calories: Int
    
}
