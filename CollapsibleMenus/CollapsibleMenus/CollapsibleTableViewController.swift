
//  ViewController.swift
//  CollapsibleMenus
//
//  Created by Mickey Goga on 2/15/18.
//  Copyright © 2018 Magy Elias. All rights reserved.
//

import UIKit

//MARK:- Step 4. The UITableView DataSource and Delegate


class CollapsibleTableViewController: UITableViewController {
    
    var sections = sectionsData
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK:- Step 2. Setup TableView to Support Autosizing
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        self.title = "Apple Products"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    //Here is the key ingredient of implementing the collapsible table section, if the section is collapsed, then that section should not have any row.
    //Noticed that we don't need to render any cell for the collapsed section, this can improve the performance a lot if there are tons of cells in that section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].collapsed ? 0 : sections[section].items.count
    }
    
    //Next, we use tableView's viewForHeaderInSection function to hook up our custom header
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
        
        header.titleLabel.text = sections[section].name
        header.arrowLabel.text = ">"
        header.setCollapsed(sections[section].collapsed)
        
        header.section = section
        header.delegate = self
        
        return header
    }
    
    //Setup the normal row cell is pretty straightforward:
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CollapsibleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CollapsibleTableViewCell ?? CollapsibleTableViewCell(style: .default, reuseIdentifier: "cell")
        
        let item : Item = sections[indexPath.section].items[indexPath.row]
        
        cell.nameLabel.text = item.name
        cell.detailLabel.text = item.detail
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }
}

//MARK:- Step 5. How to Toggle Collapse and Expand

//The idea is pretty starightforward, reverse the collapsed flag for the section and tell the tableView to reload that section.
//After the sections get reloaded, the number of cells in that section will be recalculated and redrawn.
extension CollapsibleTableViewController : CollapsibleTableViewHeaderDelegate {
    func toggleSelection(_ header: CollapsibleTableViewHeader, section: Int) {
        let collapsed = !sections[section].collapsed
        
        //Toggle collapse
        sections[section].collapsed = collapsed
        header.setCollapsed(collapsed)
        
        //Reload the whole section
        tableView.reloadSections(NSIndexSet(index:section) as IndexSet, with: .automatic)
    }
}

