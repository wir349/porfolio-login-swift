//
//  ViewController.swift
//  testSwift
//
//  Created by Waleed Rahman on 5/12/15.
//  Copyright (c) 2015 Waleed. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, AccountServiceProtocol {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    private weak var activeTextField: UITextField?
    private var animatedDistance: CGFloat = 0.0
    
    let KEYBOARD_ANIMATION_DURATION :CGFloat = 0.3;
    let MINIMUM_SCROLL_FRACTION:CGFloat = 0.2;
    let MAXIMUM_SCROLL_FRACTION:CGFloat = 1.0;
    let PORTRAIT_KEYBOARD_HEIGHT:CGFloat = 216;
    let IOS7_PORTRAIT_KEYBOARD_HEIGHT:CGFloat = 260;
    let LANDSCAPE_KEYBOARD_HEIGHT:CGFloat = 140;

    
    var accountService: AccountService {
        AccountService.sharedInstance.delegate = self
        return AccountService.sharedInstance
    }
    /*
    @property (nonatomic, strong) AccountService *accountService;
    
    
    - (IBAction)hideKeyboard:(id)sender;
    -(IBAction)loginPressed:(id)sender;
*/
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setupUI();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI() {
        //Align Text for RTL languages
        if AppUtility.getCurrentLanguageDirection() == NSLocaleLanguageDirection.RightToLeft
        {
            self.alignForRTLLanguage()
        }
        if AppUtility .getCurrentLanguage() == "ar"
        {
            self.setupForArabic()
        }
        
        //hide navigation bar - done to avoid navigation bar errors
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.emailTextField.text = ""
        self.passwordTextField.text = ""
        self.enableUI()
        if AccountService.sharedInstance.getSignedInUser() != nil
        {
            self.navigateToPaymentScreen()
        }
    }
    
    //The following code aligns all text for Right-To-Left Languages to Right-Aligned
    func alignForRTLLanguage()
    {
        (self.view.viewWithTag(70) as! UILabel).textAlignment = NSTextAlignment.Right
        self.emailTextField.textAlignment = NSTextAlignment.Right
        self.passwordTextField.textAlignment = NSTextAlignment.Right
    }
    
    func setupForArabic()
    {
        //Nothing for now
    }
    
    func enableUI()
    {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        let loginButton:UIButton = self.view.viewWithTag(3) as! UIButton
        loginButton.enabled = true
        self.emailTextField.enabled = true
        self.passwordTextField.enabled = true
    }
    
    func disableUI()
    {
        let loginButton:UIButton = self.view.viewWithTag(3) as! UIButton
        loginButton.enabled = false
        self.emailTextField.enabled = false
        self.passwordTextField.enabled = false
    }
    
    
    func loginRequestCallback(success: Bool, failureResponse response: String)
    {
        if success {
            self.navigateToPaymentScreen()
        }
        else {
            let alertView:UIAlertView = AppUtility.createAlertViewWithMessage(response, title: "Error", tag: 101)
            alertView.show()
        }
    }
    
    func navigateToPaymentScreen()
    {
        let user:UserModel = self.accountService.getSignedInUser()!
        println("Signed in User ID: \(user.userId)")
        println("Signed in User Access Token: \(user.accessToken)")
        self.performSegueWithIdentifier(SIGN_IN_TO_PAYMENT_OPTIONS_SEGUE, sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == SIGN_IN_TO_PAYMENT_OPTIONS_SEGUE {
            //Do something for setting things up, right now I haven't built anything
        }

    }
    
    @IBAction func loginPressed(sender: UIButton) {
        self.view.endEditing(true)
        let userEmail: String = self.emailTextField.text;
        let userPassword: String = self.passwordTextField.text;
        self.accountService.makeLoginRequestWithEmailAddress(userEmail, andPassword: userPassword)
    }
    
    @IBAction func hideKeyboard(sender: AnyObject) {
        activeTextField?.resignFirstResponder()
    }
    

}

