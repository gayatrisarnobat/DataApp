//
//  DADetailsViewController.swift
//  DataApp
//
//  Created by Gayatri Sarnobat on 23/08/20.
//  Copyright © 2020 Gayatri Sarnobat. All rights reserved.
//

import UIKit
import SnapKit

class DADetailsViewController: UIViewController {
    
    // MARK: Properties to be Initialized by Parent VC
    var dataItem: DAAppData!

    // MARK: View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set background color
        self.view.backgroundColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // show navigation title
        self.navigationController?.navigationBar.topItem?.title = "Details"
        
        // show details data
        self.displayDetailsData()
    }
    
    // MARK: Helpers
    
    func displayDetailsData() {
        // add date and data
        let dataTextView = UITextView()
        // do not allow to edit
        dataTextView.isEditable = false
        dataTextView.dataDetectorTypes = .link
        
        // prepare text to be displayed
        var textStr = "Created On :\n\(self.dataItem.date ?? "Some Date")"
        
        textStr.append("\n\n\(self.dataItem.data ?? "")")
        dataTextView.text = textStr
        
        // add as a subview
        self.view.addSubview(dataTextView)
 
        // add constraints
        dataTextView.snp.makeConstraints({ (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        })
    }
}
