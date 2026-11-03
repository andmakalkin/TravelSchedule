import Observation

@MainActor
@Observable
final class AppDependencies {
    let viewModelFactory: ViewModelFactory

    init(viewModelFactory: ViewModelFactory) {
        self.viewModelFactory = viewModelFactory
    }
}
