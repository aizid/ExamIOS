import UIKit

protocol ExamFlowCoordinatorDependencies  {
    func makeHomeViewController(closures: HomeViewModelClosures) -> HomeViewController
    
    func makeDetailViewController(closures: DetailViewModelClosures, localized_name:String, primary_attr:String, attack_type:String, img:String, base_health:String, base_mana:String, base_attack_min:String, base_attack_max:String, base_str:String, base_agi:String, base_int:String, attack_range:String, move_speed:String) -> DetailViewController
    
    //
    func makeDialogSortAndFilterViewController(closures: DialogSortAndFilterViewModelClosures, sortCondition: Int, filterCondition: Int, sortBy: Int) -> DialogSortAndFilterViewController
    
}

class ExamFlowCoordinator {
    
    private weak var navigationController: UINavigationController?
    private let dependencies: ExamFlowCoordinatorDependencies
    
    private weak var homeVC: HomeViewController?
    
    init(navigationController: UINavigationController,
         dependencies: ExamFlowCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies = dependencies
    }
    
    func start() {
        // Note: here we keep strong reference with closures, this way this flow do not need to be strong referenced
        showHome()
        
        UITabBar.appearance().tintColor = UIColor(named: "color_primary")
        UITabBar.appearance().backgroundColor = UIColor.white
    }
    
    private func showHome() {
        let closures = HomeViewModelClosures(showDetail: showDetail, showDialogSortAndFilter: showDialogSortAndFilter)
        let vc = dependencies.makeHomeViewController(closures: closures)
        navigationController?.pushViewController(vc, animated: true)
        navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        homeVC = vc
    }
    
    private func showDetail(localized_name:String, primary_attr:String, attack_type:String, img:String, base_health:String, base_mana:String, base_attack_min:String, base_attack_max:String, base_str:String, base_agi:String, base_int:String, attack_range:String, move_speed:String) {
        let closures = DetailViewModelClosures()
        let vc = dependencies.makeDetailViewController(closures: closures, localized_name:localized_name, primary_attr:primary_attr, attack_type:attack_type, img:img, base_health:base_health, base_mana:base_mana, base_attack_min:base_attack_min, base_attack_max:base_attack_max, base_str:base_str, base_agi:base_agi, base_int:base_int, attack_range:attack_range, move_speed:move_speed)
        navigationController?.pushViewController(vc, animated: true)
        navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    // DIALOG
    private func showDialogSortAndFilter(sortCondition: Int, filterCondition: Int, sortBy: Int) {
        let closures = DialogSortAndFilterViewModelClosures()
        let vc = dependencies.makeDialogSortAndFilterViewController(closures: closures, sortCondition: sortCondition, filterCondition: filterCondition, sortBy: sortBy)
        vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        homeVC?.present(vc, animated: false, completion: nil)
    }
}
