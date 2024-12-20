import UIKit

public extension UIViewController {
    private static var spinnerTag = 999999
    func showMessage(title: String, msg: String) {
        guard Connectivity.shared.isConnected else {
            showToast(message: msg)
            return
        }
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func showLoader() {
        guard view.viewWithTag(UIViewController.spinnerTag) as? UIActivityIndicatorView == nil else { return }
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        spinner.tag = UIViewController.spinnerTag
        view.addSubview(spinner)
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    func hideLoader() {
        if let spinner = view.viewWithTag(UIViewController.spinnerTag) as? UIActivityIndicatorView {
            spinner.stopAnimating()
            spinner.removeFromSuperview()
        }
    }
    func showToast(message: String) {
        let toastView = UIView()
        toastView.backgroundColor = .red
        toastView.layer.cornerRadius = 10
        toastView.clipsToBounds = true

        let messageLabel = UILabel()
        messageLabel.text = !Connectivity.shared.isConnected ? "No Internet" : message
        messageLabel.textColor = .white
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 16)
        messageLabel.numberOfLines = 0
        messageLabel.translatesAutoresizingMaskIntoConstraints = false

        toastView.addSubview(messageLabel)

        NSLayoutConstraint.activate([
            messageLabel.leadingAnchor.constraint(equalTo: toastView.leadingAnchor, constant: 16),
            messageLabel.trailingAnchor.constraint(equalTo: toastView.trailingAnchor, constant: -16),
            messageLabel.topAnchor.constraint(equalTo: toastView.topAnchor, constant: 8),
            messageLabel.bottomAnchor.constraint(equalTo: toastView.bottomAnchor, constant: -8)
        ])

        self.view.addSubview(toastView)

        toastView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toastView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            toastView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            toastView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            toastView.heightAnchor.constraint(equalToConstant: 50)
        ])

        toastView.alpha = 0
        UIView.animate(withDuration: 0.5, animations: {
            toastView.alpha = 1
        })

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            UIView.animate(withDuration: 0.5, animations: {
                toastView.alpha = 0
            }, completion: { _ in
                toastView.removeFromSuperview()
            })
        }
    }
}
