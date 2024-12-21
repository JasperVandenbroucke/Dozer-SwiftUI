import SwiftUI

struct HomeScreen: View {
    
    // Create a viewModel instance here
    @StateObject var machinesViewModel = MachinesViewModel()
    
    var body: some View {
        Text("Hello World!")
    }
}

#Preview {
    HomeScreen()
}
