import Foundation

import Foundation

typealias DisplayError = (ErrorMessage) -> Void

struct AlertAction {
    let title: String
    let action: () -> Void
    
    init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
}

struct AlertViewModel {
    let title: String
    let message: String
    let actions: [AlertAction]
    
    init(title: String, message: String, actions: [AlertAction]) {
        self.title = title
        self.message = message
        self.actions = actions
    }
}

struct ErrorMessage {
    let title: String
    let description: String?
    let actions: [AlertAction]
    let screenType: ErrorScreenType
    let actionTitle: String
    
    init(title: String,
         description: String? = nil,
         actionTitle: String,
         screenType: ErrorScreenType,
         alertAction: (() -> Void)? = nil) {
        
        let alertAction = [AlertAction(title: actionTitle, action: alertAction ?? {})]
        self.init(title: title,
                  description: description,
                  screenType: screenType,
                  alertActions: alertAction)
    }
    
    init(title: String, description: String? = nil, screenType: ErrorScreenType, alertActions: [AlertAction]) {
        self.title = title
        self.description = description
        self.screenType = screenType
        self.actions = alertActions
        
        if actions.count >= 1 {
            actionTitle = actions[0].title
            if actions.count > 1 && screenType != .alert {
                print("Warning: Modal/full screen alerts only support 1 item.")
            }
        } else {
            actionTitle = "Close"
            print("Warning: Modal/full screen alerts only support 1 item. defaulting button title to *close*")
        }
    }
}

