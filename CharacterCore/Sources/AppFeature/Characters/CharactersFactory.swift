import Foundation
struct CharactersFactory {
    static func createCharactersViewController(router: AppRouter) -> CharactersViewController {
        let charactersRemoteDataSource = CharactersRemoteDataSource()
        let repository = CharactersRepository(dataSource: charactersRemoteDataSource)
        let dataSource = CharactersUseCase(charactersRepository: repository)
        let filterUseCase = FilterUseCase()
        let viewModel = CharactersViewModel(
            state: CharactersViewModel.State(),
            viewState: CharactersViewModel.ViewState(),
            router: router,
            charactersUseCase: dataSource,
            filterUseCase: filterUseCase
        )
        let vc = CharactersViewController(viewModel: viewModel)
        return vc
    }
}
