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
import Moya

class TeamsList: ObservableObject {
    var teams: [Team] = [] {
        didSet {
            didChange.send(teams)
        }
    }
    
    var didChange = CurrentValueSubject<[Team], Never>([])
}

class TeamsListController {
  
  @Published var isFetching: Bool = false
  
  var provider = MoyaProvider<TeamTarget>()
  
  func fetchDrivers(into teamList: TeamsList) {
    self.isFetching = true
    provider.request(.teams) { (result) in
      DispatchQueue.main.async {
        switch result {
        case .success(let response):
          if let teams = try? response.map([Team].self) {
            teamList.teams = teams
          }
          break
        case .failure:
          break
        }
        self.isFetching = false
      }
    }
  }
}

enum TeamTarget {
  case teams
}

extension TeamTarget: TargetType {
  var baseURL: URL {
    return URL(string: "https://formula1.getsandbox.com")!
  }
  
  var path: String {
    return "teams"
  }
  
  var method: Moya.Method {
    return .get
  }
  
  var sampleData: Data {
    return Data()
  }
  
  var task: Task {
    return .requestPlain
  }
  
  var headers: [String : String]? {
    return [:]
  }
}
