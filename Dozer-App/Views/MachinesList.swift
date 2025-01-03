import SwiftUI

struct MachinesList: View {
    @EnvironmentObject var machinesViewModel: MachinesViewModel
    @Binding var machinesList: [Machine]
    
    var body: some View {
        List($machinesList) { machine in
            MachineListItem(machine: machine)
        }
    }
}
