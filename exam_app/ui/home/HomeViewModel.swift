import Foundation

struct HomeViewModelClosures {
    let showDetail: (_ localized_name:String, _ primary_attr:String,_ attack_type:String,_ img:String,_ base_health:String,_ base_mana:String, _ base_attack_min:String,_ base_attack_max:String, _ base_str:String,_ base_agi:String,_ base_int:String, _ attack_range:String,_ move_speed:String) -> Void
    let showDialogSortAndFilter: (_ sortCondition: Int, _ filterCondition: Int, _ sortBy: Int) -> Void
}

enum HomeViewModelLoading {
    case fullScreen
}

protocol HomeViewModelInput {
    func getHeroesAll()
    
    func showDetail(localized_name:String, primary_attr:String, attack_type:String, img:String, base_health:String, base_mana:String, base_attack_min:String, base_attack_max:String, base_str:String, base_agi:String, base_int:String, attack_range:String, move_speed:String)
    func showDialogSortAndFilter(sortCondition: Int, filterCondition: Int, sortBy: Int)
}

protocol HomeViewModelOutput {
    var getHeroesAllResponse: Observable<[HeroesRes]?> { get }
    
    var loading: Observable<HomeViewModelLoading?> { get }
    var error: Observable<String> { get }
    var screenTitle: String { get }
    var errorTitle: String { get }
    
    var getHeroesAllResponseisEmpty: Bool { get }
}

protocol HomeViewModel: HomeViewModelInput, HomeViewModelOutput { }

final class DefaultHomeViewModel: HomeViewModel {
    
    private let homeUseCase: HomeUseCase
    private let closures: HomeViewModelClosures?
    
    private var homeLoadTask: Cancellable? { willSet { homeLoadTask?.cancel() } }
    
    private var getHeroesAllResponseLoadTask: Cancellable? { willSet { getHeroesAllResponseLoadTask?.cancel() } }
    
    // MARK: - OUTPUT
    let getHeroesAllResponse: Observable<[HeroesRes]?> = Observable(nil)
    
    var getHeroesAllResponseisEmpty: Bool { return getHeroesAllResponse.value == nil }
    
    let loading: Observable<HomeViewModelLoading?> = Observable(.none)
    let error: Observable<String> = Observable("")
    let screenTitle = NSLocalizedString("Home", comment: "")
    let errorTitle = NSLocalizedString("Error", comment: "")
    
    init(homeUseCase: HomeUseCase,
         closures: HomeViewModelClosures? = nil) {
        self.homeUseCase = homeUseCase
        self.closures = closures
    }
    
    // MARK: - Private
    private func getHeroesAllResponse(_ heroesAllResponse: [HeroesRes]) {
        getHeroesAllResponse.value = heroesAllResponse
    }
    
    private func handle(error: Error) {
        self.error.value = error.isInternetConnectionError ?
            NSLocalizedString("No internet connection", comment: "") :
            NSLocalizedString("Failed loading Login", comment: "")
    }
}

// MARK: - INPUT. View event methods
extension DefaultHomeViewModel {
    
    func getHeroesAll() {
        loading.value = .fullScreen
        
        getHeroesAllResponseLoadTask = homeUseCase.getHeroesAll(
            completion: { result in
                switch result {
                case .success(let res):
                    self.getHeroesAllResponse(res)
                case .failure(let error):
                    self.handle(error: error)
                }
                self.loading.value = .none
        })
    }
    
    func didCancel() {
        homeLoadTask?.cancel()
        
        getHeroesAllResponseLoadTask?.cancel()
    }
    
    func showDetail(localized_name:String, primary_attr:String, attack_type:String, img:String, base_health:String, base_mana:String, base_attack_min:String, base_attack_max:String, base_str:String, base_agi:String, base_int:String, attack_range:String, move_speed:String){
        closures?.showDetail(localized_name, primary_attr, attack_type, img, base_health, base_mana, base_attack_min, base_attack_max, base_str, base_agi, base_int, attack_range, move_speed)
    }
    
    func showDialogSortAndFilter(sortCondition: Int, filterCondition: Int, sortBy: Int){
        closures?.showDialogSortAndFilter(sortCondition, filterCondition, sortBy)
    }
    
}
