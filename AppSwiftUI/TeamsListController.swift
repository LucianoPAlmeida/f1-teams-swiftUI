//
//  TeamsListController.swift
//  CombineApp
//
//  Created by Luciano Almeida on 16/06/19.
//  Copyright © 2019 Luciano Almeida. All rights reserved.
//

import Combine
import Foundation
import SwiftUI

class TeamsList: ObservableObject {
    var teams: [Team] = [] {
        didSet {
            didChange.send(teams)
        }
    }
    
    var didChange = CurrentValueSubject<[Team], Never>([])
}

class TeamsListController {
  
    var injected: String = "$(JOEY_CATCH_PHASE)"
  
    @Published var isFetching: Bool = false
    
    let url = "https://formula1.getsandbox.com/teams"
    func fetchDrivers(into teamList: TeamsList) {
        self.isFetching = true
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: URL(string: url)!) { (data, response, error) in
          DispatchQueue.main.async {
            if let data = data, let teams = try? JSONDecoder().decode([Team].self, from: data) {
              teamList.teams = teams
            }
            self.isFetching = false
          }
        }
        task.resume()
    }
}
