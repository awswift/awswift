import PackageDescription

#if os(Linux)
let platformPackages: [Package.Dependency] = []
#else
let platformPackages = [Package.Dependency.Package(url: "https://github.com/mxcl/PromiseKit.git", majorVersion: 4)]
#endif

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
    .Package(url: "https://github.com/czechboy0/Jay.git", majorVersion: 1),
    .Package(url: "https://github.com/kylef/URITemplate.swift", majorVersion: 2),
  ] + platformPackages
)
