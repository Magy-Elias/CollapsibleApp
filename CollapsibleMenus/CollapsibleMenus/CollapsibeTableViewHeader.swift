//
//  CollapsibeTableViewHeader.swift
//  CollapsibleMenus
//
//  Created by Mickey Goga on 2/18/18.
//  Copyright © 2018 Magy Elias. All rights reserved.
//

import UIKit

//MARK:- Step 3. The Section Header

//According to Apple API reference, we should use UITableViewHeaderFooterView. Let's subclass it and implement the section header CollapsibleTableViewHeader:
class CollapsibleTableViewHeader : UITableViewHeaderFooterView {
    let titleLabel = UILabel()
    let arrowLabel = UILabel()
    
    var delegate : CollapsibleTableViewHeaderDelegate?
    var section : Int = 0
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        //Content View
        contentView.backgroundColor = UIColor(red:0.18, green:0.22, blue:0.27, alpha:1.0)
        
        let marginGuide = contentView.layoutMarginsGuide
        
        //Arrow Label
        contentView.addSubview(arrowLabel)
        arrowLabel.textColor = UIColor.white
        arrowLabel.translatesAutoresizingMaskIntoConstraints = false
        arrowLabel.widthAnchor.constraint(equalToConstant: 12).isActive = true
        arrowLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        arrowLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        arrowLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        
        //Title Label
        contentView.addSubview(titleLabel)
        titleLabel.textColor = UIColor.white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CollapsibleTableViewHeader.tapHeader(_:))))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tapHeader(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let cell = gestureRecognizer.view as? CollapsibleTableViewHeader else {
            return
        }
        delegate?.toggleSelection(self, section: cell.section)
    }
    
    func setCollapsed(_ collapsed: Bool) {
        // Animate the arrow rotation (see Extensions.swf)
        arrowLabel.rotate(collapsed ? 0.0 : .pi/2)
    }
}

//We need to collapse or expand the section when user taps on the header, to achieve this, let's borrow UITapGestureRecognizer. Also we need to delegate this event to the table view to update the collapsed property.
protocol CollapsibleTableViewHeaderDelegate {
    func toggleSelection(_ header: CollapsibleTableViewHeader, section: Int)
}
