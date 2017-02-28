//
//  DetailViewController.swift
//  TODO_List_1
//
//  Created by Kero on 2/26/17.
//  Copyright © 2017 Kero. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {


    @IBOutlet weak var titleTxt: UITextField!
    @IBOutlet weak var dateBtn: DateButton!
    @IBOutlet weak var timeBtn: DateButton!
    @IBOutlet weak var editBtn: UIButton!
    
    var isInEditMode : Bool = false
    var somethingDidChange :( ()->() )? = nil
    
    
    func toggleEditing(sender : UIButton){
        isInEditMode = !isInEditMode
        if(!isInEditMode){
            self.detailItem?.text = titleTxt.text
        }
        else{
            
        }
        configureView()
        
    }
    
    
    
    func enableEditing()  {
        
        

        func dateHandler (date :Date){
            
            self.detailItem?.time = date
            self.configureView()
            self.somethingDidChange?()
        }
        
        dateBtn.didChangeDateHandler = dateHandler
        timeBtn.didChangeDateHandler = dateHandler

        

        
        titleTxt.addTarget(self, action: #selector(didEndEditing(sender:)), for: UIControlEvents.editingChanged)
        titleTxt.addTarget(self, action: #selector(didEndEditing(sender:)), for: UIControlEvents.editingDidEnd)
        
        titleTxt.addTarget(self, action: #selector(didEndEditing(sender:)), for: UIControlEvents.editingDidEndOnExit)
        
        
    }
    
    func didEndEditing (sender :UITextView){
        
        self.detailItem?.text = sender.text
        self.configureView()
        self.somethingDidChange?()
    }
    
    
    
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    

    func configureView() {
        
        self.editBtn?.addTarget(self, action: #selector(toggleEditing(sender:)), for: UIControlEvents.touchUpInside)
        
        
        if(titleTxt != nil){
            // Update the user interface for the detail item.
            dateBtn.pickerType = .Date
            dateBtn.setCurrentDate(detailItem?.time)
            dateBtn.isEnabled = self.isInEditMode
            timeBtn.pickerType = .Time
            timeBtn.setCurrentDate(detailItem?.time)
            timeBtn.isEnabled = self.isInEditMode
            titleTxt.text = detailItem?.text
            titleTxt.isEnabled = self.isInEditMode
            if(isInEditMode){
                self.enableEditing()
                self.editBtn.setTitle("Done", for: .normal)
            }else{
                self.editBtn.setTitle("Edit", for: .normal)
            }
            
            if let detail = self.detailItem {
                if let label = self.detailDescriptionLabel {
                    label.text = detail.description
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: ToDoItem? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    
    
}

