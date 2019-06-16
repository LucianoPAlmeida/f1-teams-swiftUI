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

class TeamsList: BindableObject {
    var teams: [Team] = [] {
        didSet {
            didChange.send(teams)
        }
    }
    
    var didChange = CurrentValueSubject<[Team], Never>([])
}

class TeamsListController {
    
    var isFetching: AnySubject<Bool, Never> = CurrentValueSubject<Bool, Never>(false).eraseToAnySubject()
    
    let url = "https://formula1.getsandbox.com/teams"
    func fetchDrivers(into teamList: TeamsList) {
        self.isFetching.send(true)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: URL(string: url)!) { (data, response, error) in
            if let data = data, let teams = try? JSONDecoder().decode([Team].self, from: data) {
                DispatchQueue.main.async {
                    teamList.teams = teams
                }
            }
            self.isFetching.send(false)
        }
        task.resume()
    }
}
