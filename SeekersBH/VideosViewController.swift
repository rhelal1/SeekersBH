import UIKit

class VideosViewController: UIViewController {

    @IBOutlet weak var videosTable: UITableView!
    
    let videos: [Video] = [
        Video(
            title: "Mastering Swift Programming",
            speaker: "John Doe",
            channel: "SwiftMaster",
            duration: 3600,  // 1 hour
            picture: "swift_programming.jpg",
            description: """
                In this comprehensive course, we will explore the core principles of Swift programming in-depth. 
                Whether you're a beginner or an experienced developer, this session will teach you everything from the basics 
                of syntax and data structures to advanced topics like closures, protocols, and generics. You'll learn how to work with Swift's 
                powerful features such as optionals, type inference, and memory management. The session also covers practical techniques 
                for debugging and optimizing your Swift code, and provides tips on writing clean, readable, and maintainable code.
                """,
            url: "https://example.com/swift_programming",
            views: 5000
        ),
        Video(
            title: "Introduction to iOS Development",
            speaker: "Jane Smith",
            channel: "iOS Dev Academy",
            duration: 1800,  // 30 minutes
            picture: "ios_intro.jpg",
            description: """
                This beginner-friendly session will introduce you to the world of iOS development. Starting from scratch, 
                we’ll guide you through the process of setting up your development environment with Xcode, Apple's powerful IDE. 
                We will cover the basics of Swift and the iOS SDK, including how to create a simple user interface using Interface Builder. 
                By the end of the session, you'll have built your very first iOS app and have the foundational knowledge needed to pursue further iOS development.
                """,
            url: "https://example.com/ios_intro",
            views: 15000
        ),
        Video(
            title: "Building UI with SwiftUI",
            speaker: "Alice Brown",
            channel: "SwiftUI Tutorials",
            duration: 2700,  // 45 minutes
            picture: "swiftui_ui.jpg",
            description: """
                SwiftUI has emerged as a revolutionary framework for creating user interfaces in iOS, macOS, watchOS, and tvOS. 
                In this session, we’ll cover the declarative syntax of SwiftUI and how to use it to design stunning UIs with just a few lines of code. 
                We’ll explore key components such as `VStack`, `HStack`, and `ZStack`, as well as modifiers, transitions, and animations. 
                You’ll also learn how to work with lists, navigation views, and handle user input with SwiftUI. By the end of the video, you'll be able to confidently design modern UIs for any Apple platform using SwiftUI.
                """,
            url: "https://example.com/swiftui_ui",
            views: 12000
        ),
        Video(
            title: "Debugging Tips for iOS Developers",
            speaker: "David Green",
            channel: "iOS Dev Tips",
            duration: 1500,  // 25 minutes
            picture: "debugging_tips.jpg",
            description: """
                Debugging is a crucial part of software development, and mastering it can save you hours of frustration. 
                In this video, we'll dive deep into the various debugging tools available in Xcode, including breakpoints, 
                LLDB, and the Debug navigator. You’ll learn how to set and manage breakpoints effectively, use the console to inspect 
                variables and call stacks, and how to track down tricky memory issues with Instruments. 
                The session also covers techniques for debugging asynchronous code, network requests, and managing errors. Whether you’re a seasoned developer or just starting out, this session will help you become a more efficient and effective debugger.
                """,
            url: "https://example.com/debugging_tips",
            views: 3000
        ),
        Video(
            title: "Core Data for Beginners",
            speaker: "Sophia Lee",
            channel: "iOS Data",
            duration: 2400,  // 40 minutes
            picture: "coredata_tutorial.jpg",
            description: """
                Core Data is a powerful framework for managing the model layer of your iOS apps, enabling you to store and retrieve 
                data efficiently. This tutorial takes you through the core concepts of Core Data, including setting up the Core Data stack, 
                creating and managing entities, and performing CRUD (Create, Read, Update, Delete) operations. You will also learn how to 
                handle relationships between entities and how to use Core Data to save and fetch data from a persistent store. 
                The video covers best practices for optimizing Core Data performance and dealing with common pitfalls. By the end of this video, 
                you'll have a solid understanding of Core Data and be able to integrate it into your own iOS apps.
                """,
            url: "https://example.com/coredata_tutorial",
            views: 8000
        ),
        Video(
            title: "Advanced Swift Techniques",
            speaker: "Michael Harris",
            channel: "SwiftExpert",
            duration: 3600,  // 1 hour
            picture: "advanced_swift.jpg",
            description: """
                Take your Swift programming skills to the next level in this advanced tutorial. We’ll dive into advanced topics such as 
                closures, protocols, error handling, and how to leverage generics for flexible and reusable code. You’ll learn how to write 
                cleaner, more efficient Swift code that scales well with larger projects. This session also covers advanced Swift features 
                like custom operators, functional programming patterns, and Swift’s memory management techniques. 
                By the end of the video, you’ll have the expertise to solve complex problems in Swift and create more robust applications.
                """,
            url: "https://example.com/advanced_swift",
            views: 9500
        ),
        Video(
            title: "Building Real-Time Apps with WebSockets",
            speaker: "Olivia Johnson",
            channel: "Networking Mastery",
            duration: 2100,  // 35 minutes
            picture: "websocket_app.jpg",
            description: """
                Real-time applications require efficient communication protocols that allow data to be transmitted instantly between the client 
                and the server. In this video, we’ll learn how to implement WebSockets in your iOS apps to enable two-way communication 
                between the app and the server. You'll get hands-on experience with establishing WebSocket connections, sending and receiving 
                messages in real-time, and handling errors and disconnections. We’ll also cover practical strategies for optimizing WebSocket 
                connections for performance and reliability. By the end of this session, you'll be able to create real-time features like 
                live chat, notifications, and more.
                """,
            url: "https://example.com/websocket_app",
            views: 4500
        ),
        Video(
            title: "Creating Beautiful Animations in iOS",
            speaker: "Chris Black",
            channel: "iOS Animations",
            duration: 1800,  // 30 minutes
            picture: "animations_ios.jpg",
            description: """
                Animation is one of the key components in creating engaging user experiences. In this tutorial, we’ll explore the world of 
                animations in iOS using both UIKit and Core Animation. You'll learn how to animate views and layers, create smooth transitions, 
                and build interactive animations. We’ll also cover advanced animation techniques, including keyframe animations, spring animations, 
                and how to use `UIViewPropertyAnimator` for more flexible animations. By the end of this session, you'll be able to add beautiful, 
                fluid animations to your iOS apps, enhancing the user experience and making your apps more dynamic and fun to use.
                """,
            url: "https://example.com/animations_ios",
            views: 22000
        ),
        Video(
            title: "Swift Concurrency: Mastering Async/Await",
            speaker: "Olivia Johnson",
            channel: "Swift Dev",
            duration: 3300,  // 55 minutes
            picture: "swift_concurrency.jpg",
            description: """
                Swift 5.5 introduced modern concurrency features, including `async/await`, which simplify working with asynchronous code. 
                This video will guide you through the new concurrency model in Swift, explaining how to use `async/await` for cleaner, 
                more readable code. You'll learn how to work with tasks, task groups, and how to manage concurrency safely. 
                We’ll also cover structured concurrency, which allows for better management of asynchronous operations and reduces the risk of bugs. 
                By the end of the video, you'll understand how to write efficient and maintainable asynchronous code in Swift.
                """,
            url: "https://example.com/swift_concurrency",
            views: 16000
        ),
]

    
    override func viewDidLoad() {
        super.viewDidLoad()

        videosTable.dataSource = self
        videosTable.delegate = self
    }

}

extension VideosViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "videoCell", for: indexPath) as! VideosTableViewCell

        cell.update(with: videos[indexPath.row])
        cell.showsReorderControl = true
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Optional: remove separator lines (if not needed)
        cell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        cell.preservesSuperviewLayoutMargins = false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    // UITableViewDelegate method
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedVideo = videos[indexPath.row]

        // Instantiate the ArticleDetailsViewController
        if let videoDetailsVC = storyboard?.instantiateViewController(withIdentifier: "VideoDetailsViewController") as? VideoDetailsViewController {
            // Pass the selected article to the ArticleDetailsViewController
            videoDetailsVC.video = selectedVideo

            // Push the detail view controller
            navigationController?.pushViewController(videoDetailsVC, animated: true)
        }
    }
}
