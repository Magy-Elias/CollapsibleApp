
//  ViewController.swift
//  CollapsibleMenus
//
//  Created by Mickey Goga on 2/15/18.
//  Copyright © 2018 Magy Elias. All rights reserved.
//

import UIKit

//MARK:- Step 4. The UITableView DataSource and Delegate


class CollapsibleTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Step 2. Setup TableView to Support Autosizing
        let tableView : UITableView = UITableView()
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
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
        return header
    }
}
