//
//  ViewController.swift
//  Demo10 Calculator
//
//  Created by LukeLin on 2022/2/7.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button01: UIButton!
    @IBOutlet var button02: UIButton!
    @IBOutlet var button03: UIButton!
    @IBOutlet var button04: UIButton!
    @IBOutlet var button05: UIButton!
    @IBOutlet var button06: UIButton!
    @IBOutlet var button07: UIButton!
    @IBOutlet var button08: UIButton!
    @IBOutlet var button09: UIButton!
    @IBOutlet var button00: UIButton!
    @IBOutlet var buttondot: UIButton!
    @IBOutlet var buttonequal: UIButton!
    
    @IBOutlet var buttonallclean: UIButton!
    @IBOutlet var buttonnegative: UIButton!
    @IBOutlet var buttonprecent: UIButton!
    @IBOutlet var buttondivision: UIButton!
    @IBOutlet var buttonmulti: UIButton!
    @IBOutlet var buttonminus: UIButton!
    @IBOutlet var buttonplus: UIButton!
    

    @IBOutlet var answerLabel: UILabel!

    
    //暫時存放正在編輯的數字
    var operatezone = ""
    
    //浮點化數值暫存區、準備做運算的數字暫存區
    var numberzone = [Float]()
    
    //儲存用過的運算符號
    var usedsymbols = [String]()
    
    //儲存未使用過的運算符號
    var unusedsymbols = [String]()
    
    //判斷負數的布林值
    var nagative: Bool = false
    
    //最後被使用的符號
    var symbols = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        answerLabel.text = "0"
        

        // Do any additional setup after loading the view.
    }
    
    func addNumtooperatezone(stringnumber: String) {
        operatezone += stringnumber
        answerLabel.text! = operatezone
    }
    
    func foursymbols() {
        
        usedsymbols.append(symbols)
        symbols = ""
        numberzone.remove(at: 1)
        
        //unusedsymbols.remove(at: 0)
        
    }
    
    func calculate() {
        
        //symbols = unusedsymbols.first ?? ""
        
        switch symbols {
            
        case "+":
            numberzone[0] += numberzone[1]
            foursymbols()
            
        case "-":
            numberzone[0] -= numberzone[1]
            foursymbols()
            
        case "x":
            numberzone[0] *= numberzone[1]
            foursymbols()
            
        case "/":
            numberzone[0] /= numberzone[1]
            foursymbols()
            
        default:
            operatezone += ""
        }
        
        if numberzone.count > 0 {
            
            if numberzone[0] - Float(Int(numberzone[0])) == 0 {
                
                answerLabel.text = String(Int(numberzone[0]))
                
            }else{
                
                answerLabel.text = String(numberzone[0])
                
            }
        }
    }
    
    //新增已使用過的運算符號至暫存區
    func addusedsymbols (symbol: String) {
        
        if unusedsymbols.count < 2 {

            usedsymbols.append(symbol)
        }
        
        //準備運算的數字達到 2 時, 即可做運算
        if numberzone.count == 2 {
            
            symbols += symbol
            calculate()
            
        }
        
        //不論觸發運算與否都需要清空編輯區
        
        operatezone = ""
    
    }
    
    
    
    //所有按鈕的偵測
    @IBAction func buttonpress(_ sender: UIButton) {
        
        //偵測數字、百分比、小數點按鈕
        switch sender {
            
        case button00:
            addNumtooperatezone(stringnumber: "0")
        
        case button01:
            addNumtooperatezone(stringnumber: "1")
            
        case button02:
            addNumtooperatezone(stringnumber: "2")
            
        case button03:
            addNumtooperatezone(stringnumber: "3")

        case button04:
            addNumtooperatezone(stringnumber: "4")

        case button05:
            addNumtooperatezone(stringnumber: "5")

        case button06:
            addNumtooperatezone(stringnumber: "6")

        case button07:
            addNumtooperatezone(stringnumber: "7")
            
        case button08:
            addNumtooperatezone(stringnumber: "8")

        case button09:
            addNumtooperatezone(stringnumber: "9")

        case buttondot:
            
            //只允許有一個小數點因此需要檢查是否已經有小數點
            if !operatezone.contains(".") {
                if answerLabel.text == "0" && operatezone == "" {
                    operatezone += "0"
                }

                operatezone += "."
                answerLabel.text! = operatezone
                print(operatezone)
            }
        case buttonprecent:
            
            //對正在編輯的數字進行百分比
            if operatezone != "0" {
                //把數字浮點化後存入暫存區
                numberzone.append(Float(operatezone)! / 10)
                //更新答案區，使用last回傳陣列得值（因為只有一個元素即回傳該元素，正常指回傳最後一個值）
                answerLabel.text = String(numberzone.last!)
                //把浮點化的新數值更新到正在編輯暫存區
                operatezone = String(numberzone.last!)
                //把浮點化數值暫存區中的數值刪除
                numberzone.removeLast()
            }
        //代表數字編輯已完成,將數字存進浮點矩陣裡
        default:
            
            //判斷即將運算的數字是否小於兩個數且並非只有負號
            if numberzone.count < 2 && operatezone != "-" {
                if operatezone != "" {
                    numberzone.append(Float(operatezone)!)
                    print (numberzone)
                }
            }
        }
        
        //偵測運算符號按鈕
        switch sender {
        case buttondivision:
            addusedsymbols(symbol: "/")
            
        case buttonmulti:
            addusedsymbols(symbol: "x")
            
        case buttonplus:
            addusedsymbols(symbol: "+")
        
        case buttonminus:
            addusedsymbols(symbol: "-")
            
        //按下等於後需要運算, 也要初始化
        case buttonequal:
            if numberzone.count == 2 {
                
                symbols = usedsymbols.last!
                calculate()
                
            }
            operatezone = String(numberzone[0])
        
            
        case buttonnegative:
            if numberzone.count > 0 && operatezone != "" {
                
                //正號改負號
                if !nagative {
                    
                    nagative = true
                    
                    //判斷是否為浮點數, 並改為負數
                    if operatezone.contains(".") {
                        
                        answerLabel.text = String((Float(operatezone) ?? 0) - 2 * (Float(operatezone) ?? 0))
                    }else{
                        answerLabel.text = String((Int(operatezone) ?? 0) - 2 * (Int(operatezone) ?? 0))

                    }
                    
                    operatezone = answerLabel.text ?? "0"
                    numberzone.removeLast()
                }else{
                    //負號改為正號
                    nagative = false
                                            
                    if operatezone.contains(".") {
                    answerLabel.text = String((Float(operatezone) ?? 0) - 2 * (Float(operatezone) ?? 0))
                            } else {
                    answerLabel.text = String((Int(operatezone) ?? 0 ) - 2 * (Int(operatezone) ?? 0))
                                
                                            }
                                        
                    operatezone = answerLabel.text ?? "0"
                    numberzone.removeLast()
                }
                //如果只有負數
            } else if answerLabel.text == "-" {
                
                operatezone = ""
                answerLabel.text = "0"
            } else {
                //如果是正數
                operatezone += "-"
                answerLabel.text = "-"
            }
            
        default:
            
            operatezone += ""
        }
    }
    
    //清除功能
    @IBAction func clear(_ sender: UIButton) {
        
        unusedsymbols = []
        usedsymbols = []
        answerLabel.text = "0"
        operatezone = ""
        numberzone = []
        nagative = false

    }
}

