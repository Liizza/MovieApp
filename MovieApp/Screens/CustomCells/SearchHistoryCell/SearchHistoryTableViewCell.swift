//
//  BlankSearchTableViewCell.swift
//  MovieApp
//
//  Created by user222465 on 10/14/22.
//

import UIKit

class SearchHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var searchTermLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(searchTerm:String?){
        guard let searchTerm = searchTerm else{
            return
        }
        searchTermLabel.text = searchTerm
        
    }
    
}
