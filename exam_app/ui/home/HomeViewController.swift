import UIKit

class HomeViewController: UIViewController, StoryboardInstantiable, Alertable, SeeDetails {
    
    private var viewModel: HomeViewModel!
    static let myNotification = Notification.Name("SortSelection")
    
    @IBOutlet weak var tblHome: UITableView!
    
    var sortCondition: Int = 0
    var filterCondition: Int = 0
    var sortingBy: Int = 0
    
    var notifList: [HeroesRes] = [HeroesRes]()
    var notifListRes: [HeroesRes] = [HeroesRes]()
//    let roleArr = ["Carry", "Disabler", "Escape"]
    
    // MARK: - Lifecycle
    
    static func create(with viewModel: HomeViewModel) -> HomeViewController {
        let view = HomeViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        bind(to: viewModel)
    }
    
    private func bind(to viewModel: HomeViewModel) {
        viewModel.error.observe(on: self) { [weak self] in self?.showError($0) }
        viewModel.loading.observe(on: self) { [weak self] in self?.updateLoading($0) }
        
        viewModel.getHeroesAllResponse.observe(on: self) { [weak self] in self?.getHeroesAllResponse($0) }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initDataRequest()
        NotificationCenter.default.addObserver(self, selector: #selector(onNotificationProductSelected(notification:)), name: HomeViewController.myNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: HomeViewController.myNotification, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - Private
    
    private func setupViews() {
        title = viewModel.screenTitle
        view.accessibilityIdentifier = AccessibilityIdentifier.HomeView
    }
    
    func initDataRequest() {
        viewModel.getHeroesAll()
    }
    
    func initResultCondition() {
        if filterCondition != 0 {
            if sortCondition != 0 {
                initFiltering(filterCondition: filterCondition)
                initSorting(sortCondition: sortCondition, sortBy: sortingBy)
            } else {
                initFiltering(filterCondition: filterCondition)
            }
        } else {
            if sortCondition != 0 {
                initSorting(sortCondition: sortCondition, sortBy: sortingBy)
            }
        }
        tblHome.reloadData()
    }
    
    func initFiltering(filterCondition: Int) {
        if filterCondition != 0 {
            switch filterCondition {
            case 1:
                notifList = notifList.filter { ($0.roles?.contains("Carry") ?? false) }
                break
            case 2:
                notifList = notifList.filter { $0.roles?.contains("Disabler") ?? false }
                break
            case 3:
                notifList = notifList.filter { $0.roles?.contains("Escape") ?? false }
                break
            default:
                break
            }
        }
    }
    
    func initSorting(sortCondition: Int, sortBy: Int){
        if sortCondition != 0 && sortBy != 0 {
            switch sortCondition {
            case 1:
                if sortBy == 1 {
                    notifList = notifList.sorted(by: { $0.base_health! < $1.base_health! })
                } else if sortBy == 2 {
                    notifList = notifList.sorted(by: { $0.base_health! > $1.base_health! })
                }
                break
            case 2:
                if sortBy == 1 {
                    notifList = notifList.sorted(by: { $0.base_attack_min! < $1.base_attack_min! })
                } else if sortBy == 2 {
                    notifList = notifList.sorted(by: { $0.base_attack_min! > $1.base_attack_min! })
                }
                break
            case 3:
                if sortBy == 1 {
                    notifList = notifList.sorted(by: { $0.base_mana! < $1.base_mana! })
                } else if sortBy == 2 {
                    notifList = notifList.sorted(by: { $0.base_mana! > $1.base_mana! })
                }
                break
            case 4:
                if sortBy == 1 {
                    notifList = notifList.sorted(by: { $0.move_speed! < $1.move_speed! })
                } else if sortBy == 2 {
                    notifList = notifList.sorted(by: { $0.move_speed! > $1.move_speed! })
                }
                break
            default:
                break
            }
        }
    }
    
    // MARK: - Action Button
    @IBAction func btnSortAndFilter(_ sender: Any) {
        viewModel.showDialogSortAndFilter(sortCondition: sortCondition, filterCondition: filterCondition, sortBy: sortingBy)
    }
    
    private func updateLoading(_ loading: HomeViewModelLoading?) {
        LoadingView.hide()
        
        switch loading {
        case .fullScreen: LoadingView.show()
        case .none: 
        print("")
        }
    }
    
    // MARK: - initDataResponse
    private func getHeroesAllResponse(_ heroesRes: [HeroesRes]?) {
        guard heroesRes != nil && heroesRes?.count != 0 else { return }
        
        notifListRes = heroesRes!
        notifList = notifListRes
        if sortCondition != 0 && filterCondition != 0 && sortingBy != 0 {
            initResultCondition()
        } else {
            tblHome.reloadData()
        }
    }
    
    private func showError(_ error: String) {
        guard !error.isEmpty else { return }
        showAlert(title: viewModel.errorTitle, message: error)
    }
    
    func showDetails(_ sender:HomeTableViewCell, id:Int) {
        if id != 0 {
            let datas = notifList[id]
            viewModel.showDetail(localized_name: datas.localized_name!, primary_attr: datas.primary_attr!, attack_type: datas.attack_type!, img: datas.img!, base_health: String(datas.base_health!), base_mana: String(datas.base_mana!), base_attack_min: String(datas.base_attack_min!), base_attack_max: String(datas.base_attack_max!), base_str: String(datas.base_str!), base_agi: String(datas.base_agi!), base_int: String(datas.base_int!), attack_range: String(datas.attack_range!), move_speed: String(datas.move_speed!))
        } else {
            let alert = UIAlertController(title: title, message: "Id not found", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(alert: UIAlertAction!) in
            }))
            self.present(alert, animated: true)
        }
        
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notifList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as! HomeTableViewCell
        
        cell.delegate = self
        let data = notifList[indexPath.row]
        cell.setData(data: data, position: indexPath.row)
        return cell
        
    }
    
    @objc func onNotificationProductSelected(notification:Notification) {
        let sort = notification.userInfo?["sort"] as? Int
        let filter = notification.userInfo?["filter"] as? Int
        let sortBy = notification.userInfo?["sortBy"] as? Int
        
        sortCondition = sort!
        filterCondition = filter!
        sortingBy = sortBy!
        
        notifList = notifListRes
        initResultCondition()
    }
    
}
