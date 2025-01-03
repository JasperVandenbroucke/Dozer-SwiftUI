import SwiftUI

struct MachinesList: View {
    @EnvironmentObject var machinesViewModel: MachinesViewModel
    var machinesList: [Machine]
    
    var body: some View {
        List(machinesList) { machine in
            MachineListItem(machine: machine)
                .onTapGesture {
                    machinesViewModel.currentMachine = machine
                }
                .background(Color.blue)
        }
    }
}
