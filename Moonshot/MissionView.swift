//
//  MissionView.swift
//  Moonshot
//
//  Created by Sergio Sepulveda on 2021-07-11.
//

import SwiftUI

struct MissionView: View {
    
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let astronauts: [CrewMember]
    let mission: Mission
    let missions: [Mission] = Bundle.main.decode("missions.json")
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    VStack(spacing: 0) {
                        Image(self.mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: geometry.size.width * 0.7)
                            .padding(.top)
                        Text(self.mission.formattedLaunchDate)
                        Text(self.mission.description)
                            .padding()
                            .layoutPriority(1)
                    }
                    .accessibilityElement(children: .ignore)
                    .accessibility(label: Text("\(mission.description) launched on \(mission.formattedLaunchDate)"))
                    ForEach(self.astronauts, id: \.role) { crewMember in
                        NavigationLink(destination: AstronautView(missions: missions, astronaut: crewMember.astronaut)) {
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 83, height: 60)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(isCommander(role: crewMember.role) ? Color.yellow : Color.primary, lineWidth: isCommander(role: crewMember.role) ? 3 : 1))
                                VStack(alignment: .leading) {
                                    Text("\(crewMember.astronaut.name)")
                                        .font(.headline)
                                    HStack(spacing: 20) {
                                        Text("\(crewMember.role)")
                                            .foregroundColor(.secondary)
                                        Image(systemName: isCommander(role: crewMember.role) ? "star.fill" : "person.fill")
                                            .foregroundColor(isCommander(role: crewMember.role) ? .yellow : .secondary)
                                            .frame(width: 10, height: 10)
                                    }
                                }
                                Spacer()
                            }
                            .padding(.horizontal)
                            .accessibilityElement(children: .ignore)
                            .accessibility(label: Text("\(crewMember.role): \(crewMember.astronaut.name)"))
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    
                    Spacer(minLength: 25)
                    
                }
                
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
    
    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission

        var matches = [CrewMember]()

        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name }) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        }

        self.astronauts = matches
    }
    func isCommander(role: String) -> Bool {
        role == "Commander"
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        MissionView(mission: missions[0],astronauts: astronauts)
    }
}
