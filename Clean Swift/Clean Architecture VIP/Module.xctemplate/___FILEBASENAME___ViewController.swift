//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ___VARIABLE_productName:identifier___ViewControllerProtocol: class {
	var router: ___VARIABLE_productName:identifier___RouterProtocol? { get set }
}

class ___VARIABLE_productName:identifier___ViewController: UIViewController {
	var interactor: ___VARIABLE_productName:identifier___InteractorProtocol?
	var router: ___VARIABLE_productName:identifier___RouterProtocol?

	override func viewDidLoad() {
        super.viewDidLoad()
		// do someting...
    }
}

extension ___VARIABLE_productName:identifier___ViewController: ___VARIABLE_productName:identifier___ViewControllerProtocol {
	// do someting...
}
