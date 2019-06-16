//
//  Model.swift
//  CombineApp
//
//  Created by Luciano Almeida on 16/06/19.
//  Copyright © 2019 Luciano Almeida. All rights reserved.
//
import SwiftUI

struct Team: Identifiable, Codable {
    var id: Int
    var name: String
    var engine: String
    var drivers: [Driver] = []
}


struct Driver: Identifiable, Codable {
    var id: String { number }
    var number: String
    var name: String
}
