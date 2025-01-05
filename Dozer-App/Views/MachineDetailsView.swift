import SwiftUI

struct MachineDetailsView: View {
    @EnvironmentObject var machinesViewModel: MachinesViewModel
    
    @Binding var machine: Machine
    
    var body: some View {
        Form {
            generalMachineInfo
            machineOptions
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
    
    var machineOptions: some View {
        Section(header: Text("Options")) {
            ForEach(machine.options) { option in
                Text(option.optionName)
            }
        }
    }
    
    var updateMachineButton: some View {
        Button("Save Changes") {
            Task {
                await machinesViewModel.updateMachine(machine: machine)
            }
        }
        .foregroundStyle(.green)
        .alert("Success", isPresented: $machinesViewModel.successUpdate) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("Changes saved")
        }
        .alert("Oops something went wrong", isPresented: $machinesViewModel.errorUpdate) {
            Button("Ok", role: .cancel) {}
        } message: {
            Text(machinesViewModel.errorMessage)
        }
    }
}

/*#Preview {
    MachineDetailsView(machine: Machine(machineName: "Test", machineType: "Test", basePrice: 0, options: []))
}*/
