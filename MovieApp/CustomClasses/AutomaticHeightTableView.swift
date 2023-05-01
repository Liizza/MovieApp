//
//  AutomaticHeightTableView.swift
//  MovieApp
//
//  Created by user222465 on 12/1/22.
//

import UIKit

class AutomaticHeightTableView: UITableView {
    
    var maxHeight: CGFloat {
        UIScreen.main.bounds.height/2
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
        self.layoutIfNeeded()
       
    }
    override var intrinsicContentSize: CGSize{
        let height = min(contentSize.height, maxHeight)
        return CGSize(width: contentSize.width, height: height)
    }
    
}
