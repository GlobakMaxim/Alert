# Alert
Lightweight helper for working with UIAlertController

# UIAlertController with beautiful API

```swift
Alert(title: "Info", message: "Wow")
.button("Ok") { print("Ok") }
.cancel("Cancel")
.show()
``` 

### .button()
It's function with optional style and closure parameters.

#### parameters
* `title: String`
* `action: (() -> Void)?`

##### How to use
Add empty button with default style and empty action
```swift
.button("Empty button")
```

##### For each style has its own function

For common `.default` style
```swift
.button("Ok") { print("Ok button pressed") }
```

... for `.cancel`
```swift
.cancel("Cancel")
```

and `.destructive`
```swift
.destructive("Delete") { print("Delete") }
```

### .show()
Show your alert everywhere

This function looking for top view controller and show alert controller on it

#### parameters
* `on viewController: UIViewController?`
* `animated: Bool`
* `completion: (() -> Void)?`

#### default parameters
* `viewController = nil`
* `animated = true`
* `completion = nil`

##### How to use
Most common
```swift
.show()
```

If you want present alert on current viewController
p.s. This way will save time to search top view controller
```swift
.show(on: self)
```

```swift
.show(on:self, animated: false)
```

```swift
.show(on:self, animated: false) { print("Poof") }
```
