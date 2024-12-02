import Foundation
import Models
import Testing

@testable import AppFeature

class CharactersViewModelTests {
    // Mock dependencies
    var api: MockCharactersApi
    var repository: MockCharactersRepository
    var dataSource: MockCharactersDataSource
    var viewModel: CharactersViewModel

    init() {
        // Initialize mock API, repository, and data source
        api = MockCharactersApi(result: .failure(TimeoutError()))
        repository = MockCharactersRepository(api: api)
        dataSource = MockCharactersDataSource(repository: repository)
        viewModel = CharactersViewModel(router: .init(), dataSource: dataSource)
    }

    @Test("Test to verify Loading initial state")
    func testInitialStateIsLoading() {
        #expect(viewModel.viewState.state == .loading)
    }

    @Test("Test To Verify LoadData at page One")
    func testLoadDataPageOne() async throws {
        let expectedPageOneDTo = MockCharacters.mock
        let expectedCharacterInfoPageOne =
            expectedPageOneDTo.results?.map { MainCharacter(characterInfo: $0) }
            ?? []
        api = MockCharactersApi(result: .success(expectedPageOneDTo))
        repository = MockCharactersRepository(api: api)
        dataSource = MockCharactersDataSource(repository: repository)
        // Initialize view model
        viewModel = CharactersViewModel(router: .init(), dataSource: dataSource)
        try await viewModel.trigger(.loadData)

        // Check that the view state reflects loaded characters
        #expect(
            viewModel.viewState.state == .loaded(expectedCharacterInfoPageOne, refeshable: true)
        )
    }

    @Test("Test To Verify Next page loaded")
    func testLoadMoreNextPageLoading() async throws {
        // MARK: - Setup Mocks for intial Api Response
        let expectedPageTwoDTO = (MockCharacters.mock.results ?? []) + (MockCharacters.mockMore.results ?? [])
        let expepectedPageTwoDTO = CharactersDTO(info: MockCharacters.mockMore.info, results: expectedPageTwoDTO)
        // Initialize mock API, repository, and data source
        api = MockCharactersApi(result: .success(expepectedPageTwoDTO))
        repository = MockCharactersRepository(api: api)
        dataSource = MockCharactersDataSource(repository: repository)
        // Initialize view model
        viewModel = CharactersViewModel(router: .init(), dataSource: dataSource)

        // MARK: - Trigger load data View DidLoaded Here
        try await viewModel.trigger(.loadData)

        // Check that the view state reflects loaded characters
        // MARK: - Load More Characters
        let expectedPageTwoDTo = MockCharacters.mockMore
        api = MockCharactersApi(result: .success(expectedPageTwoDTo))
        dataSource = MockCharactersDataSource(repository: repository)

        let expectedCharacterInfoPageTwo =
        expepectedPageTwoDTO.results?.map { MainCharacter(characterInfo: $0) }
            ?? []

        // emulate reaching last index - 1
        try await viewModel.trigger(.loadMore(lastCellIndex: 38))

        #expect(repository.params?.page == 2)
        #expect(repository.fetchCalled == 2)
        // Verify the total count and updated view state
        #expect(
            viewModel.viewState.state == .loaded(expectedCharacterInfoPageTwo, refeshable: false)
        )
    }
    @Test("Test To Verify Filter Applied loaded")
    func testFilterAppliedLoading() async throws {
        // MARK: - Setup Mocks for intial Api Response
        let expectFilterDTO = MockCharacters.filterMock(status: .alive)
        // Initialize mock API, repository, and data source
        api = MockCharactersApi(result: .success(expectFilterDTO))
        repository = MockCharactersRepository(api: api)
        dataSource = MockCharactersDataSource(repository: repository)
        // Initialize view model
        viewModel = CharactersViewModel(router: .init(), dataSource: dataSource)

        // MARK: - Trigger load data View DidLoaded Here
        try await viewModel.trigger(.loadData)

        let expectedLiveCharacters =
        expectFilterDTO.results?.map { MainCharacter(characterInfo: $0) }
            ?? []

        try await viewModel.trigger(.segmentTapped(selectedStatus: .alive))
        #expect(repository.params?.status == "Alive")
        #expect(repository.params?.page == 1)
        #expect(repository.fetchCalled == 2)
        // Verify the total count and updated view state
        #expect(
            viewModel.viewState.state == .loaded(expectedLiveCharacters, refeshable: true)
        )
    }

    @Test("Test Error state")
    func testCharacterViewModel() async throws {
        api = MockCharactersApi(result: .failure(CharactersError.unknownError))
        repository = MockCharactersRepository(api: api)
        dataSource = MockCharactersDataSource(repository: repository)
        // Initialize view model
        viewModel = CharactersViewModel(router: .init(), dataSource: dataSource)
        try await viewModel.trigger(.loadData)
        #expect(viewModel.viewState.state == .error(.unknownError))
    }
}
