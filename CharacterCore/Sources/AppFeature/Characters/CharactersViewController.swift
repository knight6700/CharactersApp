import Combine
import DesignComponent
import Models
import SwiftUI
import UIKit

public class CharactersViewController: UIViewController {
    // MARK: - UI Elements
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        let action = UIAction { [weak self] _ in
            self?.send(.loadData)
        }
        refreshControl.addAction(action, for: .valueChanged)
        refreshControl.translatesAutoresizingMaskIntoConstraints = false
        return refreshControl
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.refreshControl = refreshControl
        return tableView
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // MARK: - DataSource & DataSourceSnapShot
    private var datasource: DataSource?

    // MARK: - Properties
    private var hostingController: UIHostingController<SegmentView>?
    private var cancellables = Set<AnyCancellable>()
    private var viewModel: CharactersViewModel

    public init(viewModel: CharactersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - View Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Characters"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        setupView()
        bindViewModel()
        send(.loadData)
    }

    // MARK: - Setup Views
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(stackView)

        hostingController = UIHostingController(rootView: segment)
        if let hostingController = hostingController {
            addChild(hostingController)
            stackView.addArrangedSubview(hostingController.view)
            hostingController.didMove(toParent: self)
        }

        stackView.addArrangedSubview(tableView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor, constant: -10)
        ])
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.identifier)
        datasource = makeDataSource()
        tableView.prefetchDataSource = self
    }

    private var segment: SegmentView {
        SegmentView(
            selectedStatus: Binding(
                get: { [weak self] in
                    self?.viewModel.viewState.selectedStatus
                },
                set: { [weak self] selected in
                    self?.send(.segmentTapped(selectedStatus: selected))
                }
            ),
            items: viewModel.state.status
        )
    }

    // MARK: - Bind ViewModel
    private func bindViewModel() {
        viewModel.$viewState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] viewState in
                self?.handle(viewState.state)
            }
            .store(in: &cancellables)
    }

    private func handle(_ state: LoadingState) {
        switch state {
        case .loading:
            showLoader()
        case let .loaded(data, refreshable):
            hideLoader()
            refreshControl.endRefreshing()
            updateSegmentView()
            handleSnapshot(data: data, refreshable: refreshable)
        case .error(let error):
            hideLoader()
            refreshControl.endRefreshing()
            showMessage(title: "Error", msg: error.localizedDescription)
        }
    }
    private func updateSegmentView() {
        guard let hostingController = hostingController else { return }
        hostingController.rootView = segment
    }
}

// MARK: - UITableViewDiffableDataSource & NSDiffableDataSourceSnapshot
extension CharactersViewController {
    fileprivate typealias DataSource = UITableViewDiffableDataSource<
        Sections, MainCharacter
    >
    fileprivate typealias DataSourceSnapShot = NSDiffableDataSourceSnapshot<
        Sections, MainCharacter
    >

    fileprivate enum Sections: Hashable {
        case main
    }

    private func makeDataSource() -> DataSource {
        DataSource(
            tableView: tableView,
            cellProvider: {
                [weak self] tableView, indexPath, itemIdentifier
                    -> UITableViewCell? in
                self?.cellForRow(tableView, indexPath: indexPath, item: itemIdentifier)
            }
        )
    }

    private func cellForRow(
        _ tableView: UITableView,
        indexPath: IndexPath,
        item: MainCharacter
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: UITableViewCell.identifier,
            for: indexPath
        )
        cell.selectionStyle = .none
        cell.contentConfiguration = UIHostingConfiguration {
            CharacterRowView(character: item)
        }
        return cell
    }

    private func handleSnapshot(data: [MainCharacter], refreshable: Bool) {
        guard let datasource else { return }
        var snapshot = datasource.snapshot()

        if snapshot.sectionIdentifiers.isEmpty {
            snapshot.appendSections([.main])
        }
        if refreshable {
            snapshot.deleteAllItems()
            snapshot.appendSections([.main])
            snapshot.appendItems(data, toSection: .main)
        } else {
            let existingIdentifiers = Set(snapshot.itemIdentifiers)
            let newItems = data.filter { !existingIdentifiers.contains($0) }
            snapshot.appendItems(newItems)
        }
        datasource.apply(snapshot, animatingDifferences: !refreshable)
    }

    func send(_ action: CharactersViewModel.Action) {
        Task {
            try? await viewModel.trigger(action)
        }
    }
}
// MARK: - UITableViewDelegate & 
extension CharactersViewController: UITableViewDelegate, UITableViewDataSourcePrefetching {
    public func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        send(.tableViewCellTapped(index: indexPath.row))
    }
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        send(.loadMore(lastCellIndex: indexPath.row))
    }
    public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        send(.prefetchData(indexPaths))
    }
}
