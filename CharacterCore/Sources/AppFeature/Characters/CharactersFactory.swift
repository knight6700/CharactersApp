import Foundation
struct CharactersFactory {
    static func createCharactersViewController(router: AppRouter) -> CharactersViewController {
        let api = CharactersDataSource()
        let repository = CharactersRepository(dataSource: api)
        let dataSource = CharactersUseCase(charactersRepository: repository)
        let viewModel = CharactersViewModel(
            state: CharactersViewModel.State(),
            viewState: CharactersViewModel.ViewState(),
            router: router,
            charactersUseCase: dataSource
        )
        let vc = CharactersViewController(viewModel: viewModel)
        return vc
    }
}
