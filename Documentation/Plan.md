# Awswift Plan

### Step 0: Run Swift code in Lambda

* Possible as per [this](https://medium.com/@gigq/using-swift-in-aws-lambda-6e2a67a27e03#.1roff3mwn) blog post
* Rather than copying files around, compile Swift for AWS Lambda environment
* Lambda is supposedly based on Amazon Linux as per [docs](http://docs.aws.amazon.com/lambda/latest/dg/current-supported-versions.html). Some differences have been observed - document these?
* Can spin up an instance with Amazon Linux AMI and compile there - lame.
* Alternative: create Docker image from AMI and use _that_ to build Swift code. **AMI to Docker image tool has now been made**: https://github.com/aidansteele/ami2docker

### Step 1: CLI tool to (build and?) package up a Swift app into a Lambda zip-friendly format

* Make a CLI tool (in Swift of course!) that can build a Swift app and zip it up alongside the minimum required Swift runtime components
* It would build it inside a public `awswift/lambda-compiler` Docker image (created above)
* Zip has to be less than 50MB - ideally much less if application code is going to be large
  * See what we can strip out, what files can literally be `strip`'d and so on
  * Future "optimisation" could be not bundling the Swift runtime in every Zip, but the Node handler downloading a (checksummed) runtime on first cold launch
* Once the AWS SDK MVP is done, CLI tool could have some subcommands, e.g.
  * `up` creates (if needed) a Lambda function, builds and uploads latest code
  * `down` deletes function
  * `invoke` invokes the function with parameters
  * `logs` could show the CloudWatch logs
  * `local-invoke` for faster testing maybe
* Fastlane-y
  * Tells you about updates to CLI tool
  * Lots of emoji fun
  * Dat felix street cred

### Step 2: AWS SDK for Swift MVP

* Swift package published to Github
* Can take a `URLRequest` object and return the `Authorization` header

### Step 3: Flesh out AWS SDK for Swift

* Modelled based on Objc/Ruby SDKs. Client class per service with instance methods for each API method
* Maximise Swiftiness
* Support both sync and async call patterns - maybe promises too?

### Step 4: Pipeline for deploying long-running services to EB/ECS

* A simple way to generate Docker images for running Swift apps
* First would be all-in-one image w/ compiler
* Second would be a builder container and a runtime container
* Would the above CLI tool be extended to support this use-case or would it be a new tool? Would still do logs and stuff

### Step 5: Optimise Swift Lambda interface

* First interface is  a simple JSON stdin/stdout single process per invocation model
* Second interface maybe a long-running (in Lambda terms) daemon w/ multiplexed responses back to standard Node handler
* Remote debugging using LLDB, ngrok. First appcode/vscode, maybe xcode?
