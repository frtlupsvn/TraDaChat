//
//  ViewController.swift
//  TraDa
//
//  Created by Zoom NGUYEN on 10/27/15.
//  Copyright © 2015 Zoom NGUYEN. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var txtChatField: UITextField!
    @IBOutlet weak var tableviewChat: UITableView!
    @IBOutlet weak var keyboardContraint: NSLayoutConstraint!
    
    var socket: SocketIOClient!
    var chatArrayMessage: NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableviewChat.estimatedRowHeight = 80;
        tableviewChat.rowHeight = UITableViewAutomaticDimension
        tableviewChat.separatorStyle = .None
        
        chatArrayMessage = NSMutableArray()
        socket = setupSocketIO()
        
        socket.on("new message"){data, ack in
            let item = data as? NSArray
            let message = item?.firstObject as? NSDictionary
            
            // Receive message
            self.addTextToArrayMessage(message?.objectForKey("message") as! NSString)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSendTapped(sender: AnyObject) {
        if (!txtChatField.text!.isEmpty){
            socket.emit("new message", txtChatField.text!)
            addTextToArrayMessage(txtChatField.text!)
            resetTextField(txtChatField)
        }
    }
    
    func resetTextField(textfield:UITextField) {
        textfield.text = ""
    }
    
    func addTextToArrayMessage(text:NSString){
        chatArrayMessage.addObject(text)
        tableviewChat.reloadData()
    }
    
    //MARK: SOCKET.IO
    func setupSocketIO()-> SocketIOClient {
        let socket = SocketIOClient(socketURL: "http://192.168.2.156:3000", options: [.Log(true), .ForcePolling(true)])
        socket.connect()
        return socket
    }
    
    //MARK: TABLE VIEW
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatArrayMessage.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell_ : ChatTableViewCell? = tableView.dequeueReusableCellWithIdentifier("ChatCellLeft") as? ChatTableViewCell
        
        cell_?.chatTextLbel.text = chatArrayMessage.objectAtIndex(indexPath.row) as? String
        
        return cell_!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        keyboardContraint.constant = 220
    }
    func textFieldDidEndEditing(textField: UITextField) {
        keyboardContraint.constant = 0
    }

}

