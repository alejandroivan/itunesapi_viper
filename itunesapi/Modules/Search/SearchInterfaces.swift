import UIKit

enum SearchNavigationOption {
}

protocol SearchWireframeInterface: WireframeInterface {
    func navigate(to option: SearchNavigationOption)
}

protocol SearchViewInterface: ViewInterface {
}

protocol SearchPresenterInterface: PresenterInterface {
}

protocol SearchInteractorInterface: InteractorInterface {
}
