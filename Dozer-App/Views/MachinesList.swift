import SwiftUI

struct MachinesList: View {
    @EnvironmentObject var machinesViewModel: MachinesViewModel
    var machinesList: [Machine]
    
    var body: some View {
        List(machinesList) { machine in
            NavigationLink(destination: MachineDetailsView(machine: $machinesViewModel.currentMachine)) {
                MachineListItem(machine: machine)
            }
            .simultaneousGesture(TapGesture().onEnded { machinesViewModel.currentMachine = machine })
        }
    }
}
