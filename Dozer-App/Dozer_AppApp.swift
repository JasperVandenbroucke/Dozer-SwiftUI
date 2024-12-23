import SwiftUI

@main
struct Dozer_AppApp: App {
    // Creating the ViewModel for the entire app
    @StateObject var machinesViewModel = MachinesViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeScreen()
                .environmentObject(machinesViewModel)
        }
    }
}
