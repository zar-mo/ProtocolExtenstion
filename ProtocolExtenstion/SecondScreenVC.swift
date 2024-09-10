//
//  SecondScreenVC.swift
//  ProtocolExtenstion
//
//  Created by Abouzar Moradian on 9/10/24.
//

import UIKit

enum TimerAction{
    case stop
    case restart
}

protocol CounterLabelProtocol {
    
    var counterLabel: UILabel! {get set}
    var counties: [String] {get set}
}

protocol ContorlTimerDelegate : AnyObject  {
    
        func didTimerControlled(action: TimerAction)
}

class SecondScreenVC: UIViewController, ObserveTimerProtocol {
    
// MARK: we can commont the method out because we defined a default implmentation for the protocol through extension
    
//    func didCounterUpdated(counter: Int) {
//        
//        print("update counter called")
//        counterLabel.text = String(counter)
//    }
    

    weak var delegate: ContorlTimerDelegate?
    @IBOutlet weak var counterLabel: UILabel!
    
    var counties: [String] = []
    
    var mainScreen: ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainScreen?.delegate = self
        
    }
    
    @IBAction func stopTimerButton(_ sender: UIButton) {
        
        delegate?.didTimerControlled(action: .stop)
    }
    

    @IBAction func restartTimerButton(_ sender: UIButton) {
        
        delegate?.didTimerControlled(action: .restart)

    }
    
    func setupMainScreen(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        mainScreen = storyboard.instantiateViewController(withIdentifier: "mainScreen") as? ViewController
        mainScreen?.delegate = self
    }
}


