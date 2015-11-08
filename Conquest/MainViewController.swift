//
//  MainViewController.swift
//  Conquest
//
//  Created by Zafir Abou-Zamzam on 11/7/15.
//  Copyright © 2015 Alpha. All rights reserved.
//

import UIKit
import Socket_IO_Client_Swift

let socket = SocketIOClient(socketURL: "http://45.55.169.135:3000", options: [.Log(true), .ForcePolling(true)])

class MainViewController: UIViewController {

    @IBOutlet weak var playButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connectToServer()
        
        self.view.backgroundColor = UIColor.purpleColor()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goToGame(sender: UIButton) {
        socket.emit("join", "join")
        
        toGame()
    }

    
    func connectToServer() {
        socket.on("connect") { data, ack in
            print("socket connected")
        }
        
        socket.on("error") { data, ack in
            self.playButton.enabled = false
            self.playButton.titleLabel?.text = "Can't connect"
        }
        
        socket.connect()
    }
    
    func toGame() // goes to game view controller
    {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let gameViewController = mainStoryboard.instantiateViewControllerWithIdentifier("GameViewController") as! GameViewController
        // may need to use show if deprecated
        // self.navigationController?.showViewController(gameViewController, sender: self)
        self.navigationController?.pushViewController(gameViewController, animated: false)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    
    }
    

}
