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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func configure(searchTerm: String?) {
        guard let searchTerm = searchTerm else { return }
        searchTermLabel.text = searchTerm
    }
}
