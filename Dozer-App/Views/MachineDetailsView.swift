//
//  MachineDetailsView.swift
//  Dozer-App
//
//  Created by Jasper Vandenbroucke on 23/12/2024.
//

import SwiftUI

struct MachineDetailsView: View {
    var machine: Machine
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    MachineDetailsView(machine: Machine(machineName: "Test", machineType: "Test", basePrice: 0, options: []))
}
