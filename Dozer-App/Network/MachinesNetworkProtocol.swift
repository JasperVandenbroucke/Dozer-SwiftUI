import Foundation

protocol MachinesNetworkProtocol {
    func fetchMachines() async throws -> [Machine]
    func createMachine(machine: Machine) async throws -> Machine
    func updateMachine(machine: Machine) async throws -> Machine
    func deleteMachineById(id: Int) async throws -> Machine
}
