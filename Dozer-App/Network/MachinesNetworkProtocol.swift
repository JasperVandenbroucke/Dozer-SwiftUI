import Foundation

protocol MachinesNetworkProtocol {
    func fetchMachines(completionHandler: @escaping ([Machine]) -> Void)
    func createMachine(machine: Machine, completionHandler: @escaping (Machine) -> Void)
    func updateMachineById(machine: Machine, completionHandler: @escaping (Machine) -> Void)
    func deleteMachineById(id: Int, completionHandler: @escaping (Machine) -> Void)
}
