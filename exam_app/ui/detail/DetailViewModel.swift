import Foundation

struct DetailViewModelClosures {
}

enum DetailViewModelLoading {
    case fullScreen
}

protocol DetailViewModelInput {
    
}

protocol DetailViewModelOutput {
    var localized_name: String { get }
    var primary_attr: String { get }
    var attack_type: String { get }
    var img: String { get }
    var base_health: String { get }
    var base_mana: String { get }
    var base_attack_min: String { get }
    var base_attack_max: String { get }
    var base_str: String { get }
    var base_agi: String { get }
    var base_int: String { get }
    var attack_range: String { get }
    var move_speed: String { get }
    
    var loading: Observable<DetailViewModelLoading?> { get }
    var screenTitle: String { get }
}

protocol DetailViewModel: DetailViewModelInput, DetailViewModelOutput { }

final class DefaultDetailViewModel: DetailViewModel {
    
    private let detailUseCase: DetailUseCase
    private let closures: DetailViewModelClosures?
    internal let localized_name: String
    internal let primary_attr: String
    internal let attack_type: String
    internal let img: String
    internal let base_health: String
    internal let base_mana: String
    internal let base_attack_min: String
    internal let base_attack_max: String
    internal let base_str: String
    internal let base_agi: String
    internal let base_int: String
    internal let attack_range: String
    internal let move_speed: String

    private var detailLoadTask: Cancellable? { willSet { detailLoadTask?.cancel() } }
    
    // MARK: - OUTPUT
    
    let loading: Observable<DetailViewModelLoading?> = Observable(.none)
    let screenTitle = NSLocalizedString("Detail", comment: "")
    
    init(detailUseCase: DetailUseCase,
         closures: DetailViewModelClosures? = nil, localized_name:String, primary_attr:String, attack_type:String, img:String, base_health:String, base_mana:String, base_attack_min:String, base_attack_max:String, base_str:String, base_agi:String, base_int:String, attack_range:String, move_speed:String) {
        self.detailUseCase = detailUseCase
        self.closures = closures
        self.localized_name = localized_name
        self.primary_attr = primary_attr
        self.attack_type = attack_type
        self.img = img
        self.base_health = base_health
        self.base_mana = base_mana
        self.base_attack_min = base_attack_min
        self.base_attack_max = base_attack_max
        self.base_str = base_str
        self.base_agi = base_agi
        self.base_int = base_int
        self.attack_range = attack_range
        self.move_speed = move_speed
    }
}

// MARK: - INPUT. View event methods
extension DefaultDetailViewModel {

    func viewDidLoad() { }

    func didCancel() {
        detailLoadTask?.cancel()
    }
    
}
