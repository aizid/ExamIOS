import UIKit

class DialogSortAndFilterViewController: UIViewController, StoryboardInstantiable {
    
    private var viewModel: DialogSortAndFilterViewModel!
    
    @IBOutlet weak var ivBaseHealth: UIImageView!
    @IBOutlet weak var ivBaseAttack: UIImageView!
    @IBOutlet weak var ivBaseMana: UIImageView!
    @IBOutlet weak var ivBaseSpeed: UIImageView!
    @IBOutlet weak var ivFilterCarry: UIImageView!
    @IBOutlet weak var ivFilterDisabler: UIImageView!
    @IBOutlet weak var ivFilterEscape: UIImageView!
    
    var sortCondition: Int = 0
    var filterCondition: Int = 0
    
    var boolBaseHealth: Int = 0
    var boolBaseAttack: Int = 0
    var boolBaseMana: Int = 0
    var boolBaseSpeed: Int = 0
    
    // MARK: - Lifecycle
    
    static func create(with viewModel: DialogSortAndFilterViewModel) -> DialogSortAndFilterViewController {
        let view = DialogSortAndFilterViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        bind(to: viewModel)
    }
    
    private func bind(to viewModel: DialogSortAndFilterViewModel) {
        viewModel.loading.observe(on: self) { [weak self] in self?.updateLoading($0) }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    // MARK: - Private
    
    private func setupViews() {
        title = viewModel.screenTitle
        view.accessibilityIdentifier = AccessibilityIdentifier.DialogSortAndFilterView
        
        initData()
    }
    
    func initData() {
        sortCondition = viewModel.sortCondition
        filterCondition = viewModel.filterCondition
        initSetAscAndDesc(SortBy: viewModel.sortBy)
        
        initCheckSortingImg()
        initCheckFilterImg()
    }
    
    func initCheckSorting(condition: Int) {
        if condition == sortCondition {
//            sortCondition = 0
            initReturnCondition()
        } else {
            sortCondition = condition
            
            boolBaseHealth = 0
            boolBaseAttack = 0
            boolBaseMana = 0
            boolBaseSpeed = 0
        }
    }
    func initCheckFiltering(condition: Int) {
        if condition == filterCondition {
//            filterCondition = 0
        } else {
            filterCondition = condition
        }
    }
    func initCheckSortingImg() {
        if boolBaseHealth == 1 {
            ivBaseHealth.image = UIImage(named: "ic_asc")
        } else if boolBaseHealth == 2 {
            ivBaseHealth.image = UIImage(named: "ic_desc")
        } else {
            ivBaseHealth.image = nil
        }
        if boolBaseAttack == 1 {
            ivBaseAttack.image = UIImage(named: "ic_asc")
        } else if boolBaseAttack == 2 {
            ivBaseAttack.image = UIImage(named: "ic_desc")
        } else {
            ivBaseAttack.image = nil
        }
        if boolBaseMana == 1 {
            ivBaseMana.image = UIImage(named: "ic_asc")
        } else if boolBaseMana == 2 {
            ivBaseMana.image = UIImage(named: "ic_desc")
        } else {
            ivBaseMana.image = nil
        }
        if boolBaseSpeed == 1 {
            ivBaseSpeed.image = UIImage(named: "ic_asc")
        } else if boolBaseSpeed == 2 {
            ivBaseSpeed.image = UIImage(named: "ic_desc")
        } else {
            ivBaseSpeed.image = nil
        }
    }
    func initCheckFilterImg() {
        ivFilterCarry.image = nil
        ivFilterDisabler.image = nil
        ivFilterEscape.image = nil
        
        switch filterCondition {
        case 1:
            ivFilterCarry.image = UIImage(named: "ic_checklist")
            break
        case 2:
            ivFilterDisabler.image = UIImage(named: "ic_checklist")
            break
        case 3:
            ivFilterEscape.image = UIImage(named: "ic_checklist")
            break
        default:
            break
        }
    }
    func initGetAscAndDesc() -> Int {
        var result: Int = 0
        switch sortCondition {
        case 1:
            result = boolBaseHealth
            break
        case 2:
            result = boolBaseAttack
            break
        case 3:
            result = boolBaseMana
            break
        case 4:
            result = boolBaseSpeed
            break
        default:
            result = 0
            break
        }
        return result
    }
    func initSetAscAndDesc(SortBy: Int) {
        switch sortCondition {
        case 1:
            boolBaseHealth = SortBy
            break
        case 2:
            boolBaseAttack = SortBy
            break
        case 3:
            boolBaseMana = SortBy
            break
        case 4:
            boolBaseSpeed = SortBy
            break
        default:
            break
        }
    }
    func initReturnCondition() {
        switch sortCondition {
        case 1:
            if boolBaseHealth == 2 {
                boolBaseHealth = 0
            }
            break
        case 2:
            if boolBaseAttack == 2 {
                boolBaseAttack = 0
            }
            break
        case 3:
            if boolBaseMana == 2 {
                boolBaseMana = 0
            }
            break
        case 4:
            if boolBaseSpeed == 2 {
                boolBaseSpeed = 0
            }
            break
        default:
            break
        }
    }
    
    @IBAction func btnBaseHealth(_ sender: Any) {
        initCheckSorting(condition: 1)
        if sortCondition != 0 {
            if boolBaseHealth == 0 {
                boolBaseHealth = 1
            } else {
                boolBaseHealth = 2
            }
        }
        initCheckSortingImg()
        
    }
    @IBAction func btnBaseAttack(_ sender: Any) {
        initCheckSorting(condition: 2)
        if sortCondition != 0 {
            if boolBaseAttack == 0 {
                boolBaseAttack = 1
            } else {
                boolBaseAttack = 2
            }
        }
        initCheckSortingImg()
    }
    @IBAction func btnBaseMana(_ sender: Any) {
        initCheckSorting(condition: 3)
        if sortCondition != 0 {
            if boolBaseMana == 0 {
                boolBaseMana = 1
            } else {
                boolBaseMana = 2
            }
        }
        initCheckSortingImg()
    }
    @IBAction func btnBaseSpeed(_ sender: Any) {
        initCheckSorting(condition: 4)
        if sortCondition != 0 {
            if boolBaseSpeed == 0 {
                boolBaseSpeed = 1
            } else {
                boolBaseSpeed = 2
            }
        }
        initCheckSortingImg()
    }
    
    @IBAction func btnCarry(_ sender: Any) {
        initCheckFiltering(condition: 1)
        initCheckFilterImg()
    }
    @IBAction func btnDisabler(_ sender: Any) {
        initCheckFiltering(condition: 2)
        initCheckFilterImg()
    }
    @IBAction func btnEscape(_ sender: Any) {
        initCheckFiltering(condition: 3)
        initCheckFilterImg()
    }
    
    @IBAction func btnClose(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
        
    }
    @IBAction func btnOk(_ sender: Any) {
        NotificationCenter.default.post(name: HomeViewController.myNotification, object: nil, userInfo: ["sort": sortCondition, "sortBy": initGetAscAndDesc(), "filter": filterCondition])
        self.dismiss(animated: false, completion: nil)
    }
    
    private func updateLoading(_ loading: DialogSortAndFilterViewModelLoading?) {
        LoadingView.hide()
    }
}
