//
//  ViewController.swift
//  todolist1
//
//  Created by Shizhong Hao on 10/8/18.
//  Copyright © 2018 Shizhong Hao. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,GADBannerViewDelegate{
    
    var list = ["Oct 08  3:00PM Grocerry shopping","Oct 10  9:00PM 1 Hour Cardio"]
    private var datePicker:UIDatePicker?
    
    @IBOutlet weak var inputTime: UITextField!
    
    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var inputText: UITextField!
    @IBOutlet weak var label1111: UILabel!
    
    @IBOutlet weak var button1: UIButton!
    @IBAction func addItem(_ sender: UIButton) {
        if (inputText.text != "" && inputTime.text != "")
        {
            let taskMessage = inputTime.text! + " " + inputText.text!
            list.append(taskMessage)
            list.sort()
            view.endEditing(true)
            
            inputText.text = ""
            inputTime.text = ""
            myTableView.reloadData()
        }
    }
    
    @IBOutlet weak var myTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .dateAndTime
        //datePicker?.datePickerMode = .time
        datePicker?.addTarget(self, action: #selector(ViewController.dateChanged(datePicker:)), for: .valueChanged)
        inputTime.inputView = datePicker
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @objc func dateChanged(datePicker:UIDatePicker){
        
        let dateForm = DateFormatter()
        
        dateForm.dateFormat = "MMM dd  h:mma"
        //dateForm.dateFormat = "hh:mma"
        inputTime.text = dateForm.string(from:datePicker.date)
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (list.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = list[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete
        {
            self.list.remove(at:indexPath.row)
            myTableView.reloadData()
        }
    }


}

