# Alert
Syntactic sugar for UIAlertController

# UIAlertController with beautiful API

```swift
Alert(title: "Info", message: "Wow")
.button("Ok") {
	print("Ok")
}
.button("Cancel", style: .cancel)
.show()
``` 

### .button()
It's function with optional style and closure parameters.

#### parameters
* `title: String`
* `style: UITableViewRowActionStyle?`
* `closure: (() -> Void)?`

#### default parameters
* `style = .default`
* `
closure = nil`

##### How to use
Add empty button with default style and empty action
```swift
.button("Empty button")
```

Add styled button with and empty action
```swift
.button("Empty button", style: .cancel)
```

Full customization button
```swift
.button("Delete", style: .destructive) {
	// Do something
}
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
.show(on:self, animation: false)
```

```swift
.show(on:self, animation: false) { print("Poof") }
```

