# SwiftPwned

A Vapor/Swift library that checks the https://haveibeenpwned.com/passwords API (all credit to Troy Hunt).

## Installation

SwiftPwned is available through SPM. To install it, simply add the following to your Package.swift file:

```swift
.package(url: "https://github.com/gotranseo/swift-pwned.git", from: "1.0.0")
```

Don't forget to also add it to dependencies array.

## Configuration

In your `configure.swift` add the following code:

```swift
import SwiftPwned

services.register { c -> SwiftPwned in
    return try SwiftPwned(client: c.make())
}
```

## Usage

```swift
let pwnedClient = try container.make(PwnedClient.self)
try pwnedClient.pwned(password: "password").wait() // true
```

> Note: Don't actually use `wait()`, respond to the future appropriately.
