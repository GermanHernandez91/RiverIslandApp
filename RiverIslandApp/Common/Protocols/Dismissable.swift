import UIKit

typealias DisplayOverlay = (Dismissable) -> Void

protocol Dismissable: UIViewController {
    var didTapDone: () -> Void { get set }
}
