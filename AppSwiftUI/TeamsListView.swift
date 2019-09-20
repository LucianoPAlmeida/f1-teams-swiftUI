//
//  TeamsListView.swift
//  CombineApp
//
//  Created by Luciano Almeida on 16/06/19.
//  Copyright © 2019 Luciano Almeida. All rights reserved.
//

import SwiftUI
import Combine

struct TeamsListView : View {
    var controller = TeamsListController()
    
    @State var showIndicator: Bool = false
    @ObservedObject var teamList = TeamsList()
    
    var body: some View {
        NavigationView {
            VStack {
                if showIndicator {
                  ActivityIndicatorView()
                }
                List(teamList.teams, rowContent: { (team) in
                    TeamView(team: team)
                })
            }
            .padding()
            .navigationBarTitle(Text("F1 2019"))
            
        }
        .onAppear(perform: {
            self.controller.fetchDrivers(into: self.teamList)
        })
        .onReceive(controller.$isFetching) { (isFetching) in
            if self.showIndicator != isFetching {
              self.showIndicator = isFetching
            }
        }
        
    }
}

struct TeamView: View {
    @State var team: Team
    var body: some View {
      VStack(alignment: .leading, spacing: 1.0) {
            Text(team.name)
            Text("\(team.engine) engine")
            VStack(alignment: .leading) {
                Text("Drivers").bold()
                ForEach(team.drivers) { driver in
                    Text("\(driver.name) #\(driver.number)")
                }
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        TeamsListView()
    }
}
#endif
