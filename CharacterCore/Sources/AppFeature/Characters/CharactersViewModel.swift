import Combine
import Foundation
import Kingfisher
import Models

public enum LoadingState {
    case loading
    case loaded([MainCharacter], refeshable: Bool)
    case error(CharactersError)
}

public class CharactersViewModel: CompositeStateViewModel {
    public struct State {
        var status: [FilterStatus] = FilterStatus.allCases
        var characters: [MainCharacter] = []
        var totalPages: Int = 1
        var parameters: CharacterParameters?
        public init(
            status: [FilterStatus] = FilterStatus.allCases,
            characters: [MainCharacter] = [],
            parameters: CharacterParameters? = .init(page: 1)
        ) {
            self.status = status
            self.characters = characters
            self.parameters = parameters
        }
    }

    public struct ViewState {
        var state: LoadingState = .loading
        var selectedStatus: FilterStatus?
        public init(
            state: LoadingState = .loading,
            selectedStatus: FilterStatus? = nil
        ) {
            self.state = state
            self.selectedStatus = selectedStatus
        }
    }

    var state: State
    @Published private(set) var viewState: ViewState

    weak private var router: AppRouter?

    private let charactersUseCase: CharactersUseCaseType
    private let filterUseCase: FilterUseCaseType?

    public init(
        state: State = .init(),
        viewState: ViewState = .init(),
        router: AppRouter,
        charactersUseCase: CharactersUseCaseType,
        filterUseCase: FilterUseCaseType? = nil
    ) {
        self.state = state
        self.viewState = viewState
        self.router = router
        self.charactersUseCase = charactersUseCase
        self.filterUseCase = filterUseCase
    }

    enum Action {
        case segmentTapped(selectedStatus: FilterStatus?)
        case loadData
        case loadMore(lastCellIndex: Int)
        case tableViewCellTapped(index: Int)
        case prefetchData([IndexPath])
    }

    func trigger(_ action: Action) async throws {
        switch action {
        case .loadData:
            try await loadData()
        case let .loadMore(indexPath):
            try await loadMore(indexPath: indexPath)
        case .segmentTapped(let selectedStatus):
            try await handleSegment(selectedStatus: selectedStatus)
        case .tableViewCellTapped(let index):
            tableViewCellTapped(index: index)
        case .prefetchData(let items):
            let prefetchCharacters = items.compactMap { index in
                state.characters.indices.contains(index.row)
                    ? state.characters[index.row] : nil
            }
            preLoadImages(data: prefetchCharacters)
        }
    }

    private func appendCharacters(_ data: [MainCharacter], refreshable: Bool) {
        state.characters.append(contentsOf: data)
        viewState.state = .loaded(data, refeshable: refreshable)
    }

    private func initiateParameters(status: String?) {
        state.parameters = CharacterParameters(
            page: 1,
            status: status
        )
    }
}
// MARK: - ImagePrefetcher
extension CharactersViewModel {
    fileprivate func preLoadImages(data: [MainCharacter]) {
        let urls = data.compactMap { $0.image }
        ImagePrefetcher(urls: urls).start()
    }
}
// MARK: - Handle Actions
private extension CharactersViewModel {
     func getCharactrs(
        parameters: CharacterParameters?,
        refreshable: Bool
    ) async {
        guard let parameters else { return }
        do {
            let data = try await self.charactersUseCase.getAllCharacters(
                parameters: parameters)
            self.state.totalPages = data.totalPages
            self.appendCharacters(data.characters, refreshable: refreshable)
        } catch {
            self.viewState.state = .error(handle(error: error))
        }
    }

    func loadData() async throws {
        self.viewState.state = .loading
        state.characters.removeAll()
        initiateParameters(status: viewState.selectedStatus?.rawValue)
        await getCharactrs(parameters: state.parameters, refreshable: true)
    }

    func loadMore(indexPath: Int) async throws {
        let preloadThreshold = 5
        guard indexPath >= state.characters.count - preloadThreshold,
            let nextPage = state.parameters?.page,
            nextPage < state.totalPages
        else { return }

        state.parameters?.page += 1
        await getCharactrs(parameters: state.parameters, refreshable: false)
    }

    func tableViewCellTapped(index: Int) {
        let character = state.characters[index]
        Task { @MainActor in
            router?.navigate(
                to: .characterDetails(character: character),
                type: .push
            )
        }
    }
    // MARK: - Segment
    func handleSegment(selectedStatus: FilterStatus?) async throws {
        guard let filter = filterUseCase?.handleFilter(selectedStatus: selectedStatus, parameters: state.parameters) else { return }
        state.parameters = filter.parameters
        viewState.selectedStatus = filter.selectedFilter
        try await loadData()
    }
}
// MARK: Handle Error For Characters
private extension CharactersViewModel {
    func handle(error: Error) -> CharactersError {
        if let networkError = error as? URLError {
            return .networkError(networkError.localizedDescription)
        }
        return .unknownError
    }
}

public enum CharactersError: Error, Equatable {
    case networkError(String)
    case decodingError(String)
    case unknownError
}
