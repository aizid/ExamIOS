import UIKit

class DetailViewController: UIViewController, StoryboardInstantiable {

    private var viewModel: DetailViewModel!
    
    @IBOutlet weak var ivHeroesImage: UIImageView!
    
    @IBOutlet weak var tvHeroesName: UILabel!
    @IBOutlet weak var tvHeroesAttribut: UILabel!
    @IBOutlet weak var tvHeroesType: UILabel!
    @IBOutlet weak var tvHeroesHealth: UILabel!
    @IBOutlet weak var tvHeroesMana: UILabel!
    @IBOutlet weak var tvHeroesBAseAttackMax: UILabel!
    @IBOutlet weak var tvHeroesBaseAttackMin: UILabel!
    @IBOutlet weak var tvHeroesBaseStr: UILabel!
    @IBOutlet weak var tvHeroesBaseAgi: UILabel!
    @IBOutlet weak var tvHeroesBaseInt: UILabel!
    @IBOutlet weak var tvHeroesBaseArrackRange: UILabel!
    @IBOutlet weak var tvHeroesBaseSpeed: UILabel!
    
    
    // MARK: - Lifecycle
    
    static func create(with viewModel: DetailViewModel) -> DetailViewController {
        let view = DetailViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        bind(to: viewModel)
    }

    private func bind(to viewModel: DetailViewModel) {
        viewModel.loading.observe(on: self) { [weak self] in self?.updateLoading($0) }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    // MARK: - Private

    private func setupViews() {
        title = viewModel.screenTitle
        view.accessibilityIdentifier = AccessibilityIdentifier.DetailView
        
        initData()
    }
    
    func initData() {
        let image: String = GlobalFunc.CHECK_STRING_EMPTY_NULL(value: viewModel.img)
        let imgUrl = URL(string: "https://api.opendota.com" + image)!
        ivHeroesImage.load(url: imgUrl)
        
        tvHeroesName.text = viewModel.localized_name
        tvHeroesAttribut.text = viewModel.primary_attr
        tvHeroesType.text = viewModel.attack_type
        tvHeroesHealth.text = viewModel.base_health
        tvHeroesMana.text = viewModel.base_mana
        tvHeroesBAseAttackMax.text = viewModel.base_attack_max
        tvHeroesBaseAttackMin.text = viewModel.base_attack_min
        tvHeroesBaseStr.text = viewModel.base_str
        tvHeroesBaseAgi.text = viewModel.base_agi
        tvHeroesBaseInt.text = viewModel.base_int
        tvHeroesBaseArrackRange.text = viewModel.attack_range
        tvHeroesBaseSpeed.text = viewModel.move_speed
    }
    
    @IBAction func btnBackDetail(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func updateLoading(_ loading: DetailViewModelLoading?) {
        LoadingView.hide()
    }
}
