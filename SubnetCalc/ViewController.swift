//
//  ViewController.swift
//  SubnetCalc
//
//  Created by Jorge Sirias on 11/10/19.
//  Copyright © 2019 Jorge Sirias. All rights reserved.
//

import UIKit
import Foundation

//Global Variables
var IpAddress: String?
//var numDotDecimal: Int?  //Keeps count of the amount of dot decimals in the IpAddress string
let MAX_NUM_DOT_DECIMAL: Int = 4  //The max number of dot deciamls in IP address.

class ViewController: UIViewController
{
    @IBOutlet var IpPromptLabel: UILabel!
    @IBOutlet var IpTxtField: UITextField!
    
    var inputStr: String?
    
    //Entry point for code execution after view loads
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        IpPromptLabel.text = "Enter IP Address:"
        
    
    }
    
    
    @IBAction func checkIPAdress(_ sender: UIButton)
    {
    
        inputStr =  IpTxtField.text
        
        if(validateIPAddr(inputStr!) != true)
        {
            let invalidIP = UIAlertController(title:"Invalid IP Address", message: "Please try again.", preferredStyle: .alert)
            
            invalidIP.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
            self.present(invalidIP, animated: true)
            
            
            IpTxtField.text = ""
            
        }
    
    }
    
    //Helper method that uses Regex to validate user input
    //Cannot contain non-numeric characters and must include at least 4 dots
    private func validateIPAddr(_ userInput: String) -> Bool
    {
    
        var octet: String = ""
        
        if( checkForLetters(userInput) == false )
        {
            return false
        }
        else if(userInput.contains(".") && countNumDecPoints(userInput))
        {
           
            for char in userInput
            {
                
                if(char == ".")
                {
                    if( (Int(octet)! >= 0) && (Int(octet)! <= 255) )
                    {
                        octet = ""
                        continue
                    }
                    else{ return false }
                    
                }
                else
                {
                    
                    octet += [char]
                    
                }
                
            }
            
            return true
            
        }
        else{ return false }
        
        
            
    }

    
    //Helper method for validating if user input has provided only 3 decimal points in the user input
    //Otherwise advise user to provide an IP address in the proper format
    private func countNumDecPoints(_ userInput: String) -> Bool
    {
        
        let MAX_DEC_POINTS = 3
        var count: Int = 0
        
        for char in userInput
        {
            
            if( count > MAX_DEC_POINTS )
            {
                return false
            }
            else if( char == "." )
            {
                count += 1
            }
        
        }
        
        if( count < MAX_DEC_POINTS )
        {
            return false
        }
        else
        {
            return true
        }
        
    }
    
    private func checkForLetters(_ userInput: String) -> Bool
    {
        
        for chars in userInput
        {
            
            let strRange = NSRange(location: 0, length: chars.utf16.count)
            let regexExt = try! NSRegularExpression(pattern: "\\d")
            
            if(regexExt.firstMatch(in: String(chars), options: [], range: strRange) == nil)
            {
                return false
            }
            else
            {
                continue
            }
            
        }
        
        return true
        
    }
    

}

