//
//  ThirdQuestionPageController.swift
//  SurveyApp
//
//  Created by Ziyun Wang on 9/1/16.
//  Copyright © 2016 Ziyun Wang. All rights reserved.
//

import UIKit

class ThirdQuestionPageController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet var answers1: UIPickerView!
    
    var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.answers1.delegate = self
        self.answers1.dataSource = self
        pickerData = ["On vacation", "Postcall/worked overnight", "Working days"]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func collectResponse() -> [String: String] {
        var response = [String:String]()
        let index = answers1.selectedRowInComponent(0)
        response["I\'m"] = pickerData[index]
        return response
    }
    
    
}
