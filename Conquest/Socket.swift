//
//  Socket.swift
//  Conquest
//
//  Created by Yehuda Lelah on 11/7/15.
//  Copyright © 2015 Alpha. All rights reserved.
//

import Foundation
import Socket_IO_Client_Swift

struct Socket {
    func connectToServer() {
        let socket = SocketIOClient(socketURL: "http://45.55.169.135:3000", options: [.Log(true), .ForcePolling(true)])
        
        socket.on("connect") { data, ack in
            print("socket connected")
        }
        
        socket.connect()
    }
}