//
//  ViewController.swift
//  ProtocolExtenstion
//
//  Created by Abouzar Moradian on 9/10/24.
//

import UIKit
import Combine

protocol ObserveTimerProtocol: AnyObject, CounterLabelProtocol{
    
    func didCounterUpdated(counter: Int, countries: [String])
}

class ViewController: UIViewController, ContorlTimerDelegate {
    
   
    weak var delegate: ObserveTimerProtocol?
    
    @IBOutlet weak var counterLabel: UILabel!
    var timer: AnyPublisher<Date, Never>?
    var cancellable: AnyCancellable?
    var counter: Int = 0
    var secondScreen: SecondScreenVC?
    
    var countries: [String] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCountriesFromPlist()
        setupSecondScreen()
        counterLabel.text = String(counter)
        startTimer()
        
        
    }
    
    
    func didTimerControlled(action: TimerAction) {
        
        print("timer function delegate function called   \(action)")
        switch action {
        case .stop:
            finishTimer()
        case .restart:
            startTimer()
        }
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        
        guard let secondScreen = secondScreen else { return }
        
        secondScreen.mainScreen = self
        navigationController?.pushViewController(secondScreen, animated: true)
    }
    
    func setupSecondScreen(){
        
        let stotyboard = UIStoryboard(name: "Main", bundle: nil)
        secondScreen = stotyboard.instantiateViewController(withIdentifier: "SecondScreenVC") as? SecondScreenVC
        secondScreen?.delegate = self
    }
    
    func setupTimer(){
        
        timer = Timer.publish(every: 1, on: RunLoop.main, in: .common).autoconnect().eraseToAnyPublisher()
        cancellable = timer?.sink(receiveValue: { [weak self] Date in
            if let self = self{
                self.counter += 1
                self.counterLabel.text = String(self.counter)
                self.delegate?.didCounterUpdated(counter: counter, countries: countries)
                
            }
        })
    }
    
    
    func startTimer(){
        finishTimer()
        setupTimer()
    }
    
    func finishTimer(){
        
        cancellable?.cancel()
        cancellable = nil
        
        timer = nil
    }
    
    func getCountriesFromPlist(){
        
        let path = Bundle.main.path(forResource: "CountryPlist", ofType: "plist")
        if let path = path{
            let dict = NSDictionary(contentsOfFile: path)
            countries = dict?.object(forKey: "CountryList") as! [String]
            
            print(countries)
            
            
        }
    }


}

extension ObserveTimerProtocol{
    
    func didCounterUpdated(counter: Int, countries: [String]){
        counterLabel.text = String(counter)
        
        //counties =  countries
    }
}

