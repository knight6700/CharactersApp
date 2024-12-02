import Foundation
struct CharactersFactory {
    static func createCharactersViewController(router: AppRouter) -> CharactersViewController {
        let api = CharactersApi()
        let repository = CharactersRepository(api: api)
        let dataSource = CharactersDataSource(charactersRepository: repository)
        let viewModel = CharactersViewModel(
            state: CharactersViewModel.State(),
            viewState: CharactersViewModel.ViewState(),
            router: router,
            dataSource: dataSource
        )
        let vc = CharactersViewController(viewModel: viewModel)
        return vc
    }
}
