//
//  ContentView.swift
//  Moonshot
//
//  Created by Sergio Sepulveda on 2021-07-07.
//

import SwiftUI

struct ContentView: View {
    
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    @State private var showingCrew: Bool = false
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 44, height: 44)
                    VStack(alignment: .leading) {
                        Text("\(mission.displayName)")
                            .font(.headline)
                        let getAstronauts: [String] = getAstronauts(mission: mission, astronauts: astronauts)
                        Text("\(showingCrew ? mission.formattedLaunchDate : "\(getAstronauts.minimalDescription)")")
                            .animation(.linear(duration: 0.3))
                            
                    }
                }
            }
            .navigationBarTitle(Text("Moonshot"))
            .navigationBarItems(trailing: Button(showingCrew ? "Show Crews" : "Show Dates") {
                self.showingCrew.toggle()
            })
        }
    }
    
    
}

func getAstronauts (mission: Mission, astronauts: [Astronaut]) -> [String]  {
    var matches = [String]()
    for member in mission.crew {
        if let match = astronauts.first(where: { $0.id == member.name }) {
            matches.append(match.name)
        } else {
            fatalError("Missing Members")
        }
    }
    return matches
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Sequence {
    var minimalDescription: String {
        return map { "\($0)" }.joined(separator: " , ")
    }
}
