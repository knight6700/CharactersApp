import Router
import struct Models.MainCharacter
import UIKit
import SwiftUI

public enum AppRoute: RouteRepresentable {
    case characters
    case characterDetails(character: MainCharacter)

    public var path: String {
        switch self {
        case .characters: return "/characters"
        case .characterDetails(let character): return "/charactersDetails/\(character)"
        }
    }
}
public class AppRouter: Router<AppRoute> {
    public override func createViewController(for route: AppRoute) -> UIViewController {
        switch route {
        case .characters:
            return CharactersFactory.createCharactersViewController(router: self)
        case .characterDetails(character: let character):
            let viewModel = CharacterDetailsViewModel(state: .init(character: character), appRouter: self)
            let rootView = CharacterDetailsView(viewModel: viewModel)
                .navigationBarBackButtonHidden(true)
            let hosting = UIHostingController(rootView: rootView)
            hosting.navigationItem.backBarButtonItem?.isHidden = true
            hosting.navigationItem.hidesBackButton = true
            return hosting
        }
    }

    public func start() -> UIViewController {
        let rootViewController  = createViewController(for: .characters)
        guard let navigationController else {
            return UINavigationController(rootViewController: rootViewController)
        }
        navigationController.setViewControllers([rootViewController], animated: false)
        return navigationController
    }

}
