//
//  ViewController.swift
//  DataApp
//
//  Created by Gayatri Sarnobat on 22/08/20.
//  Copyright © 2020 Gayatri Sarnobat. All rights reserved.
//

import UIKit
import Alamofire
import AVFoundation

class DAListViewController: UITableViewController {
    
    // MARK: Properties
    private var appDataList: [DAAppData]?
    
    // MARK: Private Properties
    private var detailsViewController: DADetailsViewController?

    // MARK: View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // hide separators initially
        self.tableView.separatorStyle = .none
        
        // clean up details
        self.cleanUpDetailsView()
        
        // show navigation title
        self.navigationController?.navigationBar.topItem?.title = "Application Data List"
        
        // show loading
        DAActivityIndicator.shared.startLoading()
        
        // request data fetch
        DAListHelper(delegate: self).fetchListData()
    }
    
    // MARK: Helper
    func cleanUpDetailsView() {
        if self.detailsViewController != nil {
            self.navigationController?.popViewController(animated: true)
            self.detailsViewController = nil
        }
    }
    
    // MARK: Table View Data Source and Delegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let appDataList = self.appDataList else {
            return 0
        }
        return appDataList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cellId") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "cellId")
        
        guard let dataItem = self.appDataList?[indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = "Created On : \(dataItem.date ?? "Some Date")"
        
        var dataItemData = "Something Went Wrong Here. Try refreshing later!"
        cell.accessoryType = .none
        
        if let actualData = dataItem.data, !actualData.isEmpty {
            dataItemData = actualData
            cell.accessoryType = .disclosureIndicator
        }
        
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.attributedText = nil
        
        switch dataItem.type {
            case DAAppDataType.text.rawValue :
                cell.detailTextLabel?.text = dataItem.data
            case DAAppDataType.image.rawValue :
                let dataStr = dataItemData as NSString
                let attributedString = NSMutableAttributedString(string: dataItemData)
                attributedString.addAttribute(.link, value: dataItemData, range: NSRange(location: 0, length: dataStr.length))
                cell.detailTextLabel?.attributedText = attributedString
            case DAAppDataType.other.rawValue :
                fallthrough
            default:
                cell.detailTextLabel?.text = dataItemData
        }
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // get the selected data item
        guard let dataItem = self.appDataList?[indexPath.row] else {
            return
        }
        
        // check if dataItem's data isn't nil, then only navigate
        guard let actualData = dataItem.data, !actualData.isEmpty else {
            return
        }
        
        self.cleanUpDetailsView()
        
        self.detailsViewController = DADetailsViewController()
        self.detailsViewController?.dataItem = dataItem
        self.navigationController?.pushViewController(self.detailsViewController!, animated: true)
    }

}

// MARK: List Helper Delegate
extension DAListViewController: DAListHelperDelegate {
    func didFetchListData(data: [DAAppData]?, error: AFError?) {
        
        // stop loading
        DAActivityIndicator.shared.stopLoading()
        
        if let responseData = data, responseData.count > 0 {
            self.appDataList = responseData
            
            // play sound
            DASoundHelper.playSound(sound: .data_received)
            
            self.tableView.separatorStyle = .singleLine
            self.tableView.reloadData()
        }
        else if let _ = error {
            self.tableView.separatorStyle = .none
            
            // play sound
            DASoundHelper.playSound(sound: .data_error)
            
            // show some alert for now
            let alertController = UIAlertController(title: "Oops", message: "Something went wrong! Please try again later", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                alertController.dismiss(animated: true, completion: nil)
            })
            
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
}

