//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ___VARIABLE_productName:identifier___PresenterProtocol: class {
	// do someting...
}

class ___VARIABLE_productName:identifier___Presenter: ___VARIABLE_productName:identifier___PresenterProtocol {	
	weak var view: ___VARIABLE_productName:identifier___ViewControllerProtocol?
	
	init(view: ___VARIABLE_productName:identifier___ViewControllerProtocol?) {
		self.view = view
	}
}
