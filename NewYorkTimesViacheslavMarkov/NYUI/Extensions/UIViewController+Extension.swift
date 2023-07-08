//
//  UIViewController+Extension.swift
//  NYUI
//
//  Created by Viacheslav Markov on 06.07.2023.
//

import SafariServices

public extension UIViewController {
   func presentBasicAlert(
        title: String = "Error",
        message: String = "Something went wrong.",
        buttonTitle: String = "Okay",
        isAutomaticallyDismissed: Bool = false,
        completion: (() -> Void)? = nil
    ) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        if isAutomaticallyDismissed {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                alertController.dismiss(animated: true, completion: completion)
            })
        }
        let alertAction = UIAlertAction(title: buttonTitle, style: .default) { _ in
            alertController.dismiss(animated: true, completion: completion)
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
    
    func presentSafariVC(
        url: URL?,
        entersReaderIfAvailable: Bool = true
    ) {
        guard let url = url else {
            presentBasicAlert(message: "Sorry, we can't show this right now. Please try again later.")
            return
        }

        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = entersReaderIfAvailable

        let vc = SFSafariViewController(url: url, configuration: config)
        vc.preferredControlTintColor = .white
        vc.modalPresentationStyle = .popover
        present(vc, animated: true)
    }
}
