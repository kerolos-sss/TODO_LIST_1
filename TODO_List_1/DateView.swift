//
//  DateView.swift
//  kero_test_swift_1
//
//  Created by Kero on 2/22/17.
//  Copyright © 2017 Kero. All rights reserved.
//

import UIKit

class DateView: UITextField {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var date = Date()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //self.date = Date()
       // dateTextInputPressed(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addTarget(self, action: #selector( dateTextInputPressed(_:) ), for: UIControlEvents.editingDidBegin)
        
        
        //dateTextInputPressed(self)

    }
    
    func viewController() ->UIViewController?
    {
        var next = self as UIView?
        while (next != nil){
            
            let nextResponder = next?.next
            
            if ( nextResponder is  UIViewController )
            {
                return nextResponder as? UIViewController
            }
            next = next?.superview!
        }

    
        return nil;
    }
    
    func dateTextInputPressed(_ sender: UITextField) {
        
        //Create the view
        let inputView = UIView(frame: CGRect (x:0, y:0, width: (self.viewController()?.view.frame.width)!, height:240))
        
        
        let datePickerView  : UIDatePicker = UIDatePicker(frame: CGRect(x:0, y:40, width: 0, height: 0))
        datePickerView.datePickerMode = .dateAndTime
        
        
        inputView.addSubview(datePickerView) // add date picker to UIView
        
        let doneButton = UIButton(frame: CGRect(x: ((self.viewController()?.view.frame.size.width)!/2) - (100/2), y:0, width:100, height:50))
        doneButton.setTitle("Done", for: .normal )//UIControlState.Normal)
        doneButton.setTitle("Done", for: .highlighted) // UIControlState.Highlighted)
        doneButton.setTitleColor(UIColor.black, for: .normal ) // UIControlState.Normal)
        doneButton.setTitleColor(UIColor.gray, for: .highlighted)//  UIControlState.Highlighted)
        
        inputView.addSubview(doneButton) // add Button to UIView
        
        doneButton.addTarget(self, action: #selector(doneButton(sender:)), for: UIControlEvents.touchUpInside) // set button click event
        
        sender.inputView = inputView
        datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: UIControlEvents.valueChanged)
        
        handleDatePicker(sender: datePickerView) // Set the date on start.
        self.date = datePickerView.date
    }
    
    func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        self.date = sender.date
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
        self.text = dateFormatter.string(from: self.date)
    }
    
    func doneButton(sender:UIButton)
    {
        sender.resignFirstResponder() // To resign the inputView on clicking done.
        
        self.endEditing(true)
    }
    


}
