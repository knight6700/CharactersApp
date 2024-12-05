import Foundation
import Models

public protocol FilterUseCaseType {
    func handleFilter(selectedStatus: FilterStatus?, parameters: CharacterParameters?) -> (parameters: CharacterParameters?, selectedFilter: FilterStatus?)
}

struct FilterUseCase: FilterUseCaseType {
    func handleFilter(selectedStatus: FilterStatus?, parameters: CharacterParameters?) -> (parameters: CharacterParameters?, selectedFilter: FilterStatus?) {
        var updatedParameters = parameters
        var selectedStatus = selectedStatus
        if parameters?.status == selectedStatus?.rawValue {
            updatedParameters = .init(page: 1)
            selectedStatus = nil
        } else {
            updatedParameters = .init(page: 1, status: selectedStatus?.rawValue)
        }
        return (updatedParameters, selectedStatus)
    }
}
