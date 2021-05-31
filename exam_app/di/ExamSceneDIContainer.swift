import UIKit

final class ExamSceneDIContainer {
    
    struct Dependencies {
        let apiDataTransferService: DataTransferService
    }
    
    private let dependencies: Dependencies
    
    // MARK: - Persistent Storage
    //    lazy var examQueriesStorage: ExamQueriesStorage = CoreDataExamQueriesStorage(maxStorageLimit: 10)
    //    lazy var examResponseCache: ExamResponseStorage = CoreDataExamResponseStorage()
    
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
    
    
    // MARK: - Use Cases
    func makeHomeUseCase() -> HomeUseCase {
        return DefaultHomeUseCase(examRepository: makeExamRepository())
    }
    func makeDetailUseCase() -> DetailUseCase {
        return DefaultDetailUseCase(examRepository: makeExamRepository())
    }
    
    // DIALOG
    func makeDialogSortAndFilterUseCase() -> DialogSortAndFilterUseCase {
        return DefaultDialogSortAndFilterUseCase(examRepository: makeExamRepository())
    }
    
    // MARK: - Repositories
    func makeExamRepository() -> ExamRepository {
        return DefaultExamRepository(dataTransferService: dependencies.apiDataTransferService)
    }
    
    // MARK: - Home
    func makeHomeViewController(closures: HomeViewModelClosures) -> HomeViewController {
        return HomeViewController.create(with: makeHomeViewModel(closures: closures))
    }
    
    func makeHomeViewModel(closures: HomeViewModelClosures) -> HomeViewModel {
        return DefaultHomeViewModel(homeUseCase: makeHomeUseCase(),
                                        closures: closures)
    }
    
    // MARK: - Detail
    func makeDetailViewController(closures: DetailViewModelClosures, localized_name:String, primary_attr:String, attack_type:String, img:String, base_health:String, base_mana:String, base_attack_min:String, base_attack_max:String, base_str:String, base_agi:String, base_int:String, attack_range:String, move_speed:String) -> DetailViewController {
        return DetailViewController.create(with: makeDetailViewModel(closures: closures, localized_name:localized_name, primary_attr:primary_attr, attack_type:attack_type, img:img, base_health:base_health, base_mana:base_mana, base_attack_min:base_attack_min, base_attack_max:base_attack_max, base_str:base_str, base_agi:base_agi, base_int:base_int, attack_range:attack_range, move_speed:move_speed))
    }
    
    func makeDetailViewModel(closures: DetailViewModelClosures, localized_name:String, primary_attr:String, attack_type:String, img:String, base_health:String, base_mana:String, base_attack_min:String, base_attack_max:String, base_str:String, base_agi:String, base_int:String, attack_range:String, move_speed:String) -> DetailViewModel {
        return DefaultDetailViewModel(detailUseCase: makeDetailUseCase(),
                                        closures: closures, localized_name:localized_name, primary_attr:primary_attr, attack_type:attack_type, img:img, base_health:base_health, base_mana:base_mana, base_attack_min:base_attack_min, base_attack_max:base_attack_max, base_str:base_str, base_agi:base_agi, base_int:base_int, attack_range:attack_range, move_speed:move_speed)
    }
    
    // MARK: - Dialog Sort And Filter
    func makeDialogSortAndFilterViewController(closures: DialogSortAndFilterViewModelClosures, sortCondition: Int, filterCondition: Int, sortBy: Int) -> DialogSortAndFilterViewController {
        
        return DialogSortAndFilterViewController.create(with: makeDialogSortAndFilterViewModel(closures: closures, sortCondition: sortCondition, filterCondition: filterCondition, sortBy: sortBy))
    }
    
    func makeDialogSortAndFilterViewModel(closures: DialogSortAndFilterViewModelClosures, sortCondition: Int, filterCondition: Int, sortBy: Int) -> DialogSortAndFilterViewModel {
        
        return DefaultDialogSortAndFilterViewModel(dialogSortAndFilterUseCase: makeDialogSortAndFilterUseCase(), closures: closures, sortCondition: sortCondition, filterCondition: filterCondition, sortBy: sortBy)
    }
    
    // MARK: - Flow Coordinators
    func makeExamFlowCoordinator(navigationController: UINavigationController) -> ExamFlowCoordinator {
        return ExamFlowCoordinator(navigationController: navigationController,
                                    dependencies: self)
    }
}

extension ExamSceneDIContainer: ExamFlowCoordinatorDependencies {
    
}
