import SwiftUI

struct MachineDetailsView: View {
    @EnvironmentObject var machinesViewModel: MachinesViewModel
    
    @Binding var machine: Machine
    
    @State private var successUpdate: Bool = false
    
    var body: some View {
        Form {
            generalMachineInfo
            /*Section(header: Text("Options")) {
                ForEach($machine.options) { $option in
                    Text(option.optionName)
                }
            }*/
            updateMachineButton
        }
    }
    
    var generalMachineInfo: some View {
        Section(header: Text("Machine Details")) {
            TextField(text: $machine.machineName) {
                Text("Machine Name")
            }
            TextField(text: $machine.machineType) {
                Text("Machine Type")
            }
        }
    }
    
    var updateMachineButton: some View {
        Button("Save Changes") {
            machinesViewModel.updateMachine(machine: machine)
            successUpdate.toggle()
        }
        .foregroundStyle(.green)
        .alert("Success", isPresented: $successUpdate) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("Changes saved")
        }
    }
}

/*#Preview {
    MachineDetailsView(machine: Machine(machineName: "Test", machineType: "Test", basePrice: 0, options: []))
}*/
