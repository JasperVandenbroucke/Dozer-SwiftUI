import SwiftUI

struct HomeScreen: View {
    
    // Injecting the MachinesViewModel
    @EnvironmentObject var machinesViewModel: MachinesViewModel
    
    var body: some View {
        VStack() {
            // Search
            
            // Machines
            List(machinesViewModel.machinesList) { machine in
                MachineListItem(machine: machine)
            }
        }
    }
}

struct MachineListItem: View {
    var machine: Machine
    
    var body: some View {
        NavigationLink(destination: MachineDetailsView(machine: machine)) {
            HStack {
                Text(machine.machineName)
                    .font(.headline)
                    .lineLimit(1)
            }
            .padding(.vertical, 8)
        }
    }
}

#Preview {
    HomeScreen()
        .environmentObject(MachinesViewModel())
}
