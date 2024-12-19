import UIKit

class WebinarsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let webinars: [Webinar] = [
        Webinar(
            title: "iOS Development 101",
            speaker: "John Doe",
            date: Date(),
            timeZone: TimeZone.current,
            picture: "ios101.jpg",
            description: """
                In this webinar, we’ll cover the very basics of iOS development, starting with the setup of Xcode and your first Swift project. 
                You’ll learn how to create user interfaces using Interface Builder and programmatically with Swift. 
                The focus will be on building simple applications, understanding the structure of iOS apps, and working with the UIKit framework. 
                We will also introduce you to Swift’s core concepts like variables, control flow, and functions. 
                By the end of the session, you will have the foundation to start developing your own iOS apps.
                """,
            url: "https://example.com/ios101",
            views: 450
        ),
        Webinar(
            title: "Advanced Swift Techniques",
            speaker: "Jane Smith",
            date: Date(),
            timeZone: TimeZone(identifier: "America/New_York")!,
            picture: "swift_advanced.jpg",
            description: """
                This advanced Swift webinar dives deep into some of the more complex aspects of the language. 
                Topics covered include closures, protocols, advanced enums, and error handling techniques. 
                You’ll also learn about generics and how to use them to write more flexible and reusable code. 
                Additionally, we’ll take a look at concurrency in Swift, including new async/await syntax introduced in Swift 5.5. 
                This session is ideal for developers who are already familiar with Swift basics and want to level up their knowledge.
                """,
            url: "https://example.com/advanced_swift",
            views: 1200
        ),
        Webinar(
            title: "Building UI with SwiftUI",
            speaker: "Alice Brown",
            date: Date(),
            timeZone: TimeZone(identifier: "Europe/London")!,
            picture: "swiftui_ui.jpg",
            description: """
                SwiftUI has revolutionized how we build UIs for iOS apps. This webinar will introduce you to SwiftUI's declarative approach 
                to UI design, where you can describe the UI and let SwiftUI handle the rendering. 
                We’ll explore how to build user interfaces using SwiftUI’s views, stacks, and modifiers. 
                Additionally, we will cover the new features in SwiftUI 2.0, such as lazy stacks, color pickers, and menu buttons. 
                By the end of the session, you'll be comfortable building UIs for iOS, macOS, and watchOS using SwiftUI.
                """,
            url: "https://example.com/swiftui",
            views: 850
        ),
        Webinar(
            title: "Mastering Networking in iOS",
            speaker: "David Green",
            date: Date(),
            timeZone: TimeZone(identifier: "America/Los_Angeles")!,
            picture: "networking_ios.jpg",
            description: """
                In this session, we’ll explore how to manage networking in iOS apps. 
                We’ll cover URLSession, how to make REST API calls, and handle responses using JSON. 
                You’ll also learn about using Codable to map responses to Swift objects, handling errors, and parsing complex data structures. 
                We'll also discuss best practices for dealing with network connectivity issues, making your app resilient, and optimizing for performance.
                If you're interested in building apps that interact with APIs and online services, this is the webinar for you!
                """,
            url: "https://example.com/networking_ios",
            views: 550
        ),
        Webinar(
            title: "Understanding Core Data",
            speaker: "Sophia Lee",
            date: Date(),
            timeZone: TimeZone(identifier: "Asia/Tokyo")!,
            picture: "coredata.jpg",
            description: """
                Core Data is Apple's framework for managing the model layer of an application. This webinar will provide you with a 
                solid understanding of how to use Core Data to manage persistent data in iOS apps. 
                We will cover how to set up a Core Data stack, create and manage entities, and use the context to perform CRUD operations. 
                Additionally, we will explore relationships between entities, migrations, and how to optimize Core Data for performance. 
                Whether you're building a simple app or a more complex app with large datasets, Core Data is an essential tool you need to master.
                """,
            url: "https://example.com/coredata",
            views: 700
        ),
        Webinar(
            title: "Mastering Auto Layout",
            speaker: "Michael Harris",
            date: Date(),
            timeZone: TimeZone(identifier: "America/Chicago")!,
            picture: "autolayout.jpg",
            description: """
                Auto Layout is the heart of building responsive UIs in iOS. In this session, we will break down Auto Layout constraints 
                and explain how to use them to create flexible, adaptive layouts that look great on any device. 
                We'll also dive into best practices for working with stack views, managing ambiguity, and debugging Auto Layout issues. 
                We’ll cover how to handle dynamic content, different screen sizes, and how to use constraints programmatically. 
                By the end, you'll have a strong understanding of how to create interfaces that adjust smoothly to varying screen sizes and orientations.
                """,
            url: "https://example.com/autolayout",
            views: 1150
        ),
        Webinar(
            title: "Debugging Techniques for iOS",
            speaker: "Emily White",
            date: Date(),
            timeZone: TimeZone(identifier: "Europe/Berlin")!,
            picture: "debugging_ios.jpg",
            description: """
                Debugging is a crucial skill for every developer. In this webinar, we’ll cover the essential debugging tools and techniques 
                in Xcode. You will learn how to effectively use breakpoints, the Xcode debugger, and Instruments to track down performance 
                issues and bugs in your iOS apps. We'll also go over debugging tips for working with network requests, memory management, 
                and multithreading. This session is designed to help you become more efficient in diagnosing and fixing issues in your code.
                """,
            url: "https://example.com/debugging_ios",
            views: 600
        ),
        Webinar(
            title: "iOS App Architecture Patterns",
            speaker: "Chris Black",
            date: Date(),
            timeZone: TimeZone(identifier: "Australia/Sydney")!,
            picture: "ios_architecture.jpg",
            description: """
                In this webinar, we’ll dive deep into iOS app architecture patterns, such as MVC, MVVM, and VIPER. 
                Understanding the right architecture pattern for your app is key to building scalable, maintainable, and testable applications. 
                We’ll discuss the pros and cons of each architecture, and how they can be applied in different types of apps. 
                You’ll also learn how to apply Clean Architecture principles to ensure your code is well-structured and easy to maintain. 
                This session is perfect for developers looking to improve their understanding of iOS app design and architecture.
                """,
            url: "https://example.com/app_architecture",
            views: 950
        ),
        Webinar(
            title: "Mastering Swift Concurrency",
            speaker: "Olivia Johnson",
            date: Date(),
            timeZone: TimeZone(identifier: "America/New_York")!,
            picture: "swift_concurrency.jpg",
            description: """
                Swift 5.5 introduces modern concurrency features to make working with asynchronous code more straightforward. 
                This webinar will walk you through Swift's async/await syntax, structured concurrency, and how to handle multiple tasks running 
                simultaneously without the need for callbacks. You’ll also learn about task groups and how to manage concurrency efficiently 
                in iOS apps. By the end of this session, you'll have the tools to write cleaner, safer, and more efficient asynchronous code.
                """,
            url: "https://example.com/swift_concurrency",
            views: 1300
        ),
        Webinar(
            title: "Building Real-Time Apps with WebSockets",
            speaker: "Ethan Roberts",
            date: Date(),
            timeZone: TimeZone(identifier: "America/Los_Angeles")!,
            picture: "websocket_ios.jpg",
            description: """
                Real-time apps, like chat applications or live sports tracking, require efficient data transfer protocols. 
                In this webinar, we'll introduce WebSockets and how to use them to establish bi-directional communication between 
                an iOS app and a server. You’ll learn how to implement WebSockets in iOS using URLSessionWebSocketTask and handle 
                incoming messages in real time. We will also explore WebSocket error handling, reconnection strategies, and performance optimizations. 
                If you're building an app that needs real-time data, this is the webinar for you!
                """,
            url: "https://example.com/websocket_ios",
            views: 800
        )
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }

}

extension WebinarsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return webinars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "webinarCell", for: indexPath) as! WebinarsTableViewCell

        cell.update(with: webinars[indexPath.row])
        cell.showsReorderControl = true
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Optional: remove separator lines (if not needed)
        cell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        cell.preservesSuperviewLayoutMargins = false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
     //UITableViewDelegate method
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedWebinar = webinars[indexPath.row]

        // Instantiate the ArticleDetailsViewController
        if let webinarDetailsVC = storyboard?.instantiateViewController(withIdentifier: "WebinarDetailsViewController") as? WebinarDetailsViewController {
            // Pass the selected article to the ArticleDetailsViewController
            webinarDetailsVC.webinar = selectedWebinar

            // Push the detail view controller
            navigationController?.pushViewController(webinarDetailsVC, animated: true)
        }
    }
}
