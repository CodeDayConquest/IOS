//
//  Socket.swift
//  Conquest
//
//  Created by Tyler Ilunga on 11/7/15.
//  Copyright © 2015 Alpha. All rights reserved.
//

import UIKit
import Socket_IO_Client_Swift

class Socket: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let socket = SocketIOClient(socketURL: "http://45.55.169.135:3000", options: [.Log(true), .ForcePolling(true)])
        
        socket.on("connect") {data, ack in
            print("socket connected")
        }
        
        
        socket.connect()

        
    }
}
