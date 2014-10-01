//
//  ViewController.swift
//  MySafari
//
//  Created by Peter Hitchcock on 10/1/14.
//  Copyright (c) 2014 Peter Hitchcock. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate, UITextFieldDelegate {

    //IBOutlets
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var urlTextField: UITextField!

    //IBActions
    @IBAction func onBackButtonPressed(sender: AnyObject) {

        webView.goBack()
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        loadUrl("http://www.google.com")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {

        let urlString = urlTextField.text
        loadUrl(urlString)

        return true
    }

    func webViewDidStartLoad(webView: UIWebView) {

        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }

    func webViewDidFinishLoad(webView: UIWebView) {

        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }

    func loadUrl(urlString: NSString) {

        let url = NSURL(string: urlString)
        let urlRequest = NSURLRequest(URL: url)
        self.webView.loadRequest(urlRequest)
    }


}

