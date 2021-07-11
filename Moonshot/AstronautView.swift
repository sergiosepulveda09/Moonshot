//
//  AstronautView.swift
//  Moonshot
//
//  Created by Sergio Sepulveda on 2021-07-11.
//

import SwiftUI

struct AstronautView: View {
    
    let astronaut: Astronaut
    var missions: [Mission]
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .padding()
                        .frame(width: geometry.size.width)
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    Text("Crew member of missions: ")
                        .font(.headline)
                        .padding(.horizontal)
                        .padding(.bottom, 5)
                        .frame(width: geometry.size.width, alignment: .leading)
                    VStack(spacing: 10) {
                        ForEach(missions) { mission in
                            Text("\(mission.displayName)")
                                .padding(.horizontal)
                                .frame(width: geometry.size.width, alignment: .leading)
                        }
                    }
                        
                }
            }
        
        }
        .navigationBarTitle(Text(self.astronaut.name), displayMode: .inline)
    }
    init(missions: [Mission], astronaut: Astronaut) {
        self.astronaut = astronaut

        var matches = [Mission]()

        for mission in missions {
            for member in mission.crew {
                if member.name == astronaut.id {
                    matches.append(mission)
                }
            }
        }

        self.missions = matches
    }


}

struct AstronautView_Previews: PreviewProvider {
    static var astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static var missions: [Mission] = Bundle.main.decode("missions.json")
    static var previews: some View {
        AstronautView(missions: missions, astronaut: astronauts[0])
    }
}
