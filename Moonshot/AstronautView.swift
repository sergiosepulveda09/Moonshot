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
                    VStack(spacing: 0) {
                        Image(self.astronaut.id)
                            .resizable()
                            .scaledToFit()
                            .padding()
                            .frame(width: geometry.size.width)
                        Text(self.astronaut.description)
                            .padding()
                            .layoutPriority(1)
                    }
                    .accessibilityElement(children: .ignore)
                    .accessibility(label: Text("\(astronaut.name), \(astronaut.description)"))
                    
                    //                    VStack(spacing: 10) {
                    //                        ForEach(missions) { mission in
                    //                            HStack {
                    //                                Image(mission.image)
                    //                                    .resizable()
                    //                                    .scaledToFit()
                    //                                    .padding(.horizontal)
                    //
                    //                                Text("\(mission.displayName)")
                    //                                    .padding(.horizontal)
                    //                                    .frame(width: geometry.size.width, alignment: .leading)
                    //                            }
                    //                        }
                    //                    }
                    VStack(alignment: .leading) {
                        Text("Crew member of missions: ")
                            .font(.headline)
                            .padding(.horizontal)
                            .padding(.bottom, 10)
                            .accessibility(hidden: true)
                        ForEach(missions) { mission in
                            HStack {
                                Image(mission.image)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke( Color.primary, lineWidth:  1))
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("\(mission.displayName)")
                                        .font(.headline)
                                    Text("\(mission.formattedLaunchDate)")
                                        .foregroundColor(.secondary)
                                }
                                Spacer()

                            }
                            .padding(.horizontal)
                            .accessibilityElement(children: .ignore)
                            .accessibility(label: Text("Crew member of mission: \(mission.displayName)"))
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
