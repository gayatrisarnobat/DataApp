//
//  DARootViewController.swift
//  DataApp
//
//  Created by Gayatri Sarnobat on 22/08/20.
//  Copyright © 2020 Gayatri Sarnobat. All rights reserved.
//

import UIKit

class DARootViewController: UINavigationController {
    
    // MARK: Properties
    private var listViewController: DAListViewController?

    // MARK: View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.prepareListViewController()
    }
    
    // MARK: Setup Helpers
    func prepareListViewController() {
        if self.listViewController == nil {
            self.listViewController = DAListViewController()
            self.pushViewController(self.listViewController!, animated: true)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
