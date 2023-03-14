//
//  ListResultCell.swift

import Foundation
import UIKit

class MovieSearchResultCell: UITableViewCell {
    
    @IBOutlet weak var filmImageView: UIImageView!
    @IBOutlet weak var nameAndYearLabel: UILabel!
    
    var imageData : Data?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public var item: ListResult!
    {
        didSet{

            DispatchQueue.global().async
            {
                if self.item.poster != "N/A" && self.item.poster != ""
                {
                    URLSession.shared.dataTask(with: URL(string: self.item.poster)!) { data, response, error in
                        if let data = data {
                            self.imageData = data
                            DispatchQueue.main.async {
                                self.filmImageView.image = UIImage(data: self.imageData!)
                            }
                        }
                        
                    }.resume()
                    
                }
            }
            
            self.nameAndYearLabel.text = item.title + " "  + item.year
        }
    }

}

