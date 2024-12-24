//
//  MachineListItem.swift
//  Dozer-App
//
//  Created by Jasper Vandenbroucke on 24/12/2024.
//

import SwiftUI

struct MachineListItem: View {
    var machine: Machine
    
    var body: some View {
        NavigationLink(destination: MachineDetailsView(machine: machine)) {
            HStack {
                Image(systemName: "truck.box.fill")
                Text(machine.machineName)
                    .font(.headline)
                    .lineLimit(1)
            }
            .padding(.vertical, 8)
        }
    }
}

#Preview {
    MachineListItem(machine: Machine(machineName: "Test", machineType: "Bulldozer", basePrice: 10000, options: []))
}
