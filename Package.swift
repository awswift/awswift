import PackageDescription

let package = Package(
  name: "Awswift",
  targets: [
    Target(name: "Signer"),
    Target(name: "Codegen"),
    Target(name: "Awswift", dependencies: ["Signer"])
  ],
  dependencies: [
    .Package(url: "https://github.com/IBM-Swift/BlueCryptor.git", majorVersion: 0, minor: 7),
    .Package(url: "https://github.com/kylef/Commander.git", majorVersion: 0, minor: 5),
    .Package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", versions: Version(3,0,0)..<Version(4, .max, .max)),
    .Package(url: "https://github.com/kylef/URITemplate.swift", majorVersion: 2),
    .Package(url: "https://github.com/mxcl/PromiseKit.git", majorVersion: 4),
  ]
)
