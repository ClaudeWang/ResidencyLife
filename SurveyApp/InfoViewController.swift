//
//  InfoViewController.swift
//  SurveyApp
//
//  Created by Ziyun Wang on 9/27/16.
//  Copyright © 2016 Ziyun Wang. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var genderPicker: UIPickerView!
    @IBOutlet var maritalPicker: UIPickerView!
    @IBOutlet var childrenPicker: UIPickerView!
    @IBOutlet var pg4Picker: UIPickerView!
    
    @IBOutlet var age: UITextField!
    var pickerDataGender = ["----", "Male", "Female"]
    var pickerDataMarital = ["----", "Single", "Married", "Separated", "Divorced", "Widowed"]
    var pickerDataChildren = ["0", "1", "2-3", "3+"]
    var pickerDataPG4 = ["1", "2", "3", "4"]
    override func viewDidLoad() {
        super.viewDidLoad()
        //add done button to keyboard
        let toolbarDone = UIToolbar.init()
        toolbarDone.sizeToFit()
        let barBtnDone = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "dismissKeyboard")
        toolbarDone.items = [barBtnDone]
        age.inputAccessoryView = toolbarDone
        
        
        age.keyboardType = UIKeyboardType.NumberPad
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func finishInput(sender: AnyObject) {

        //check basic validity
        //age

        if (!checkAge()) {
            return
        }
        
        //get email and age.
        let age_val = Int(age.text!)!
        let email_val = NSUserDefaults.standardUserDefaults().valueForKey("ID") as! String
        let gender = pickerDataGender[genderPicker.selectedRowInComponent(0)]
        let marital = pickerDataMarital[maritalPicker.selectedRowInComponent(0)]
        let children = pickerDataChildren[childrenPicker.selectedRowInComponent(0)]
        let pg4 = pickerDataPG4[pg4Picker.selectedRowInComponent(0)]
        
        
        let timestamp = NSDate().timeIntervalSince1970
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let client = delegate.client!
        let item = ["age": age_val, "email": email_val, "PG4": pg4, "gender": gender, "children": children, "marital": marital, "timestamp": String(timestamp)]
        let itemTable = client.tableWithName("DemographicsItem")
        itemTable.insert(item as [NSObject : AnyObject]) {
            (insertedItem, error) in
            if (error != nil) {
                print("Error" + error!.description);
            } else {
                print("Item inserted, id: ");
            }
        }
        performSegueWithIdentifier("infoToStart", sender: self)
    }
    
    func fireAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let alertAction = UIAlertAction(title: "Go back and change it", style: .Default, handler: nil)
        alert.addAction(alertAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }

    func checkAge() -> Bool{
        if (age.text == "") {
            fireAlert("Age cannot be empty")
            return false
        }
        if let age = Int(age.text!) {
            if (age < 18) {
                fireAlert("You have to be over 18 to use the app")
                return false
            }
        }else {
            fireAlert("Please enter valid age")
            return false
        }
        return true
    }
    
    
    //delegate functions for the pickers.
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 0) {
            return pickerDataGender[row]
        }else if (pickerView.tag == 1) {
            return pickerDataMarital[row]
        }else if (pickerView.tag == 2){
            return pickerDataChildren[row]
        }else {
            return pickerDataPG4[row]
        }
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 0) {
            return pickerDataGender.count
        }else if (pickerView.tag == 1) {
            return pickerDataMarital.count
        }else if (pickerView.tag == 2){
            return pickerDataChildren.count
        }else {
            return pickerDataPG4.count
        }
    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}
