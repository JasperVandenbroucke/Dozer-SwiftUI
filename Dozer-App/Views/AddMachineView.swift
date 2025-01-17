import SwiftUI

struct AddMachineView: View {
    
    @EnvironmentObject var machinesViewModel: MachinesViewModel
    
    @State var machineName: String = ""
    @State var machineType: String = ""
    @State var machinePrice: Double = 0.0
    
    @State var optionName: String = ""
    @State var optionPrice: Double = 0.0
    
    @State private var options: [Option] = []
    
    var body: some View {
        Form {
            machineInfo
            machineOptions
            addMachineButton
        }
    }
    
    var machineInfo: some View {
        Section(header: Text("Machine Info")) {
            TextField("Machine Name", text: $machineName)
            TextField("Machine Type", text: $machineType)
            TextField("Price", value: $machinePrice, format: .number)
        }
    }
    
    @ViewBuilder
    var machineOptions: some View {
        Section(header: Text("Machine Options")) {
            TextField("Option Name", text: $optionName)
            TextField("Option Price", value: $optionPrice, format: .number)
            Button("Add Option") {
                addOption()
            }
        }
        Section {
            Text("Amount of options: \(options.count)")
            ForEach(options) { option in
                Text(option.optionName)
            }
        }
    }
    
    var addMachineButton: some View {
        Button("Add Machine") {
            Task {
                await addMachine()
            }
        }
        .foregroundStyle(.green)
        .alert("Success", isPresented: $machinesViewModel.successCreate) {
            Button("OK", role: .cancel) {
                resetState()
            }
        } message: {
            Text("Successfully added machine")
        }
        .alert("Oops something went wrong", isPresented: $machinesViewModel.errorCreate) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(machinesViewModel.errorMessage)
        }
    }
    
    func addOption() {
        if !optionName.isEmpty && !optionPrice.isNaN && optionPrice > 0 {
            options.append(Option(id: options.count+1,optionName: optionName, price: optionPrice))
            optionName = ""
            optionPrice = 0.0
        }
    }
    
    func addMachine() async {
        // TODO: IMPLEMENT AN ADD MACHINE (PASSING VALUES NO MACHINE)
        await machinesViewModel.createMachine(
            machineName: machineName,
            machineType: machineType,
            machinePrice: machinePrice,
            options: options
        )
    }
    
    func resetState() {
        machineName = ""
        machineType = ""
        machinePrice = 0.0
        options.removeAll()
    }
}

#Preview {
    AddMachineView()
}
