import UIKit

protocol SeeDetails{
    func showDetails(_: HomeTableViewCell, id:Int)
}

class HomeTableViewCell: UITableViewCell {
    
    var delegate: SeeDetails?
    
    @IBOutlet weak var tvItemNotifLabel: UILabel!
    @IBOutlet weak var ivItemNotifImage: UIImageView!
    @IBOutlet weak var tvItemAttribut: UILabel!
    @IBOutlet weak var tvItemType: UILabel!
    
    var heroesId: Int = 0
    var position: Int = 0
    
    func setData(data:HeroesRes, position: Int) {
        heroesId = data.id
        self.position = position
        let image: String = GlobalFunc.CHECK_STRING_EMPTY_NULL(value: data.img)
        let imgUrl = URL(string: "https://api.opendota.com" + image)!
        ivItemNotifImage.load(url: imgUrl)
        
        tvItemNotifLabel.text = data.localized_name
        tvItemAttribut.text = data.primary_attr
        tvItemType.text = data.attack_type
    }
    
    @IBAction func btnSeeDetails(_ sender: Any) {
        if heroesId != 0 {
            self.delegate?.showDetails(self, id: position)
        }
    }
    
}
