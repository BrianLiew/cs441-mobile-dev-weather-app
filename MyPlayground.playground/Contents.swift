import UIKit

func closure() -> Void {
    print("function done")
}

func function_1(using: @escaping () -> Void) -> Bool {
    DispatchQueue.main.async {
        closure()
    }
    return true
}

print(function_1(using: closure))


