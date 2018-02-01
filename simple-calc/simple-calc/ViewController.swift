//
//  ViewController.swift
//  simple-calc
//
//  Created by Govind Pillai on 1/29/18.
//  Copyright © 2018 info.u.washington.edu.govindg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var count: UIButton!
    @IBOutlet weak var avg: UIButton!
    @IBOutlet weak var fact: UIButton!
    @IBOutlet weak var screenText: UILabel!
    @IBOutlet weak var modulus: UIButton!
    @IBOutlet weak var divide: UIButton!
    @IBOutlet weak var multiply: UIButton!
    @IBOutlet weak var subtract: UIButton!
    @IBOutlet weak var add: UIButton!
    @IBOutlet weak var equals: UIButton!
    @IBOutlet weak var zero: UIButton!
    @IBOutlet weak var one: UIButton!
    @IBOutlet weak var two: UIButton!
    @IBOutlet weak var three: UIButton!
    @IBOutlet weak var four: UIButton!
    @IBOutlet weak var five: UIButton!
    @IBOutlet weak var six: UIButton!
    @IBOutlet weak var seven: UIButton!
    @IBOutlet weak var eight: UIButton!
    @IBOutlet weak var nine: UIButton!
    var text: String = ""
    var avgints : [Int] = []
    var countints : [Int] = []
    var avgCheck: Bool = false
    var countCheck: Bool = false
    var calculated: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    @IBAction func numPushed(_ sender: UIButton) {
        if screenText!.text! == "0" || calculated {
            screenText!.text = sender.currentTitle!
        } else {
            screenText!.text = screenText!.text! + sender.currentTitle!
        }
        text = screenText!.text!
        calculated = false
    }
    
    @IBAction func operationPushed(_ sender: UIButton) {
        screenText!.text = screenText!.text! + " " + sender.currentTitle! + " "
        calculated = false
    }
    
    @IBAction func equalsPushed(_ sender: UIButton) {
        if avgCheck {
            avgints.append(Int(text)!)
            var sum : Int = 0
            for i in avgints {
                sum += i
            }
            let result : Int = (sum / avgints.count)
            screenText!.text = String(result)
            text = screenText!.text!
            avgints = []
            avgCheck = false
        } else if countCheck {
            countints.append(Int(text)!)
            let result : Int = countints.count
            screenText!.text = String(result)
            text = screenText!.text!
            countints = []
            countCheck = false
        } else {
            let result : Int = calculate(text)
            screenText!.text = String(result)
            text = screenText!.text!
        }
        calculated = true
    }
    
    @IBAction func clearPushed(_ sender: UIButton) {
        screenText!.text = ""
        text = ""
        countCheck = false
        avgCheck = false
        countints = []
        avgints = []
    }
    
    @IBAction func factPushed(_ sender: UIButton) {
        if text.split(separator: " ").count > 1 {
            screenText!.text = "Invalid"
            text = screenText!.text!
        } else {
            let result : Int = do_factorial(Int(text)!)
            if result == -1 {
                screenText!.text = "Overflow"
                text = screenText!.text!
            } else {
                screenText!.text = String(result)
                text = screenText!.text!
            }
        }
        calculated = true
    }
    
    @IBAction func avgPushed(_ sender: UIButton) {
        avgCheck = true
        if text.split(separator: " ").count > 1 {
            screenText!.text = "Invalid"
            text = screenText!.text!
        } else {
            avgints.append(Int(text)!)
        }
        calculated = true
    }
    
    @IBAction func countPushed(_ sender: UIButton) {
        countCheck = true
        if text.split(separator: " ").count > 1 {
            screenText!.text = "Invalid"
            text = screenText!.text!
        } else {
            countints.append(Int(text)!)
        }
        calculated = true
    }
    
    public func calculate(_ arg: String) -> Int {
        return calculate(arg.split(separator: " ").map({ substr in String(substr) }) )
    }
    
    public func calculate(_ args: [String]) -> Int {
        let size = args.count
        // Checking for regular operations
        if size == 1 {
            return Int(args[0])!
        }
        if size == 3 {
            let num1 = Int(args[0])!
            let num2 = Int(args[2])!
            switch args[1] {
            case "+":
                return num1 + num2
            case "-":
                return num1 - num2
            case "*":
                return num1 * num2
            case "/":
                return num1 / num2
            case "%":
                return do_mod(num1, num2)
            default:
                return 0
            }
        }
        return 0
    }
    // Modulus function
    public func do_mod(_ num1: Int, _ num2: Int) -> Int {
        let div = num1 / num2
        return num1 - (div * num2)
    }
    // Factorial function
    public func do_factorial(_ num: Int) -> Int {
        if num >= 20 {
            return -1
        }
        if num == 0 || num == 1 {
            return 1
        }
        return num * do_factorial(num - 1)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

