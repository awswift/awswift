import Foundation
import Signer
struct Ecr {
  struct Client {
    let region: String
    let credentialsProvider: AwsCredentialsProvider
    let session: URLSession
    let queue: DispatchQueue

    init(region: String) {
      self.region = region
      self.credentialsProvider = DefaultChainProvider()
      self.session = URLSession(configuration: URLSessionConfiguration.default)
      self.queue = DispatchQueue(label: "awswift.Ecr.Client.queue")
    }

    func scope() -> AwsCredentialsScope {
      return AwsCredentialsScope(url: URL(string: "https://")!)!
    }

/**
<p>Notify Amazon ECR that you intend to upload an image layer.</p> <note> <p>This operation is used by the Amazon ECR proxy, and it is not intended for general use by customers. Use the <code>docker</code> CLI to pull, tag, and push images.</p> </note>
 */
func initiateLayerUpload(input: InitiateLayerUploadRequest) -> ApiCallTask<InitiateLayerUploadResponse> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://ecr.\(self.region).amazonaws.com/", 
      httpMethod: "POST", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p>Uploads an image layer part to Amazon ECR.</p> <note> <p>This operation is used by the Amazon ECR proxy, and it is not intended for general use by customers. Use the <code>docker</code> CLI to pull, tag, and push images.</p> </note>
 */
func uploadLayerPart(input: UploadLayerPartRequest) -> ApiCallTask<UploadLayerPartResponse> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://ecr.\(self.region).amazonaws.com/", 
      httpMethod: "POST", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p>Inform Amazon ECR that the image layer upload for a specified registry, repository name, and upload ID, has completed. You can optionally provide a <code>sha256</code> digest of the image layer for data validation purposes.</p> <note> <p>This operation is used by the Amazon ECR proxy, and it is not intended for general use by customers. Use the <code>docker</code> CLI to pull, tag, and push images.</p> </note>
 */
func completeLayerUpload(input: CompleteLayerUploadRequest) -> ApiCallTask<CompleteLayerUploadResponse> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://ecr.\(self.region).amazonaws.com/", 
      httpMethod: "POST", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p>Creates an image repository.</p>
 */
func createRepository(input: CreateRepositoryRequest) -> ApiCallTask<CreateRepositoryResponse> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://ecr.\(self.region).amazonaws.com/", 
      httpMethod: "POST", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p>Lists all the image IDs for a given repository.</p> <p>You can filter images based on whether or not they are tagged by setting the <code>tagStatus</code> parameter to <code>TAGGED</code> or <code>UNTAGGED</code>. For example, you can filter your results to return only <code>UNTAGGED</code> images and then pipe that result to a <a>BatchDeleteImage</a> operation to delete them. Or, you can filter your results to return only <code>TAGGED</code> images to list all of the tags in your repository.</p>
 */
func listImages(input: ListImagesRequest) -> ApiCallTask<ListImagesResponse> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://ecr.\(self.region).amazonaws.com/", 
      httpMethod: "POST", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p>Check the availability of multiple image layers in a specified registry and repository.</p> <note> <p>This operation is used by the Amazon ECR proxy, and it is not intended for general use by customers. Use the <code>docker</code> CLI to pull, tag, and push images.</p> </note>
 */
func batchCheckLayerAvailability(input: BatchCheckLayerAvailabilityRequest) -> ApiCallTask<BatchCheckLayerAvailabilityResponse> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://ecr.\(self.region).amazonaws.com/", 
      httpMethod: "POST", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p>Deletes an existing image repository. If a repository contains images, you must use the <code>force</code> option to delete it.</p>
 */
func deleteRepository(input: DeleteRepositoryRequest) -> ApiCallTask<DeleteRepositoryResponse> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://ecr.\(self.region).amazonaws.com/", 
      httpMethod: "POST", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p>Describes image repositories in a registry.</p>
 */
func describeRepositories(input: DescribeRepositoriesRequest) -> ApiCallTask<DescribeRepositoriesResponse> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://ecr.\(self.region).amazonaws.com/", 
      httpMethod: "POST", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p>Creates or updates the image manifest associated with an image.</p> <note> <p>This operation is used by the Amazon ECR proxy, and it is not intended for general use by customers. Use the <code>docker</code> CLI to pull, tag, and push images.</p> </note>
 */
func putImage(input: PutImageRequest) -> ApiCallTask<PutImageResponse> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://ecr.\(self.region).amazonaws.com/", 
      httpMethod: "POST", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p>Retrieves a token that is valid for a specified registry for 12 hours. This command allows you to use the <code>docker</code> CLI to push and pull images with Amazon ECR. If you do not specify a registry, the default registry is assumed.</p> <p>The <code>authorizationToken</code> returned for each registry specified is a base64 encoded string that can be decoded and used in a <code>docker login</code> command to authenticate to a registry. The AWS CLI offers an <code>aws ecr get-login</code> command that simplifies the login process.</p>
 */
func getAuthorizationToken(input: GetAuthorizationTokenRequest) -> ApiCallTask<GetAuthorizationTokenResponse> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://ecr.\(self.region).amazonaws.com/", 
      httpMethod: "POST", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p>Retrieves the repository policy for a specified repository.</p>
 */
func getRepositoryPolicy(input: GetRepositoryPolicyRequest) -> ApiCallTask<GetRepositoryPolicyResponse> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://ecr.\(self.region).amazonaws.com/", 
      httpMethod: "POST", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p>Returns metadata about the images in a repository, including image size and creation date.</p> <note> <p>Beginning with Docker version 1.9, the Docker client compresses image layers before pushing them to a V2 Docker registry. The output of the <code>docker images</code> command shows the uncompressed image size, so it may return a larger image size than the image sizes returned by <a>DescribeImages</a>.</p> </note>
 */
func describeImages(input: DescribeImagesRequest) -> ApiCallTask<DescribeImagesResponse> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://ecr.\(self.region).amazonaws.com/", 
      httpMethod: "POST", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p>Gets detailed information for specified images within a specified repository. Images are specified with either <code>imageTag</code> or <code>imageDigest</code>.</p>
 */
func batchGetImage(input: BatchGetImageRequest) -> ApiCallTask<BatchGetImageResponse> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://ecr.\(self.region).amazonaws.com/", 
      httpMethod: "POST", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p>Applies a repository policy on a specified repository to control access permissions.</p>
 */
func setRepositoryPolicy(input: SetRepositoryPolicyRequest) -> ApiCallTask<SetRepositoryPolicyResponse> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://ecr.\(self.region).amazonaws.com/", 
      httpMethod: "POST", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p>Deletes a list of specified images within a specified repository. Images are specified with either <code>imageTag</code> or <code>imageDigest</code>.</p>
 */
func batchDeleteImage(input: BatchDeleteImageRequest) -> ApiCallTask<BatchDeleteImageResponse> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://ecr.\(self.region).amazonaws.com/", 
      httpMethod: "POST", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p>Retrieves the pre-signed Amazon S3 download URL corresponding to an image layer. You can only get URLs for image layers that are referenced in an image.</p> <note> <p>This operation is used by the Amazon ECR proxy, and it is not intended for general use by customers. Use the <code>docker</code> CLI to pull, tag, and push images.</p> </note>
 */
func getDownloadUrlForLayer(input: GetDownloadUrlForLayerRequest) -> ApiCallTask<GetDownloadUrlForLayerResponse> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://ecr.\(self.region).amazonaws.com/", 
      httpMethod: "POST", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p>Deletes the repository policy from a specified repository.</p>
 */
func deleteRepositoryPolicy(input: DeleteRepositoryPolicyRequest) -> ApiCallTask<DeleteRepositoryPolicyResponse> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://ecr.\(self.region).amazonaws.com/", 
      httpMethod: "POST", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


  }
public struct DescribeRepositoriesRequest: RestJsonSerializable {
/**
<p>A list of repositories to describe. If this parameter is omitted, then all repositories in a registry are described.</p>
 */
  public let repositoryNames: [String]?
/**
<p>The <code>nextToken</code> value returned from a previous paginated <code>DescribeRepositories</code> request where <code>maxResults</code> was used and the results exceeded the value of that parameter. Pagination continues from the end of the previous results that returned the <code>nextToken</code> value. This value is <code>null</code> when there are no more results to return.</p> <note> <p>This token should be treated as an opaque identifier that is only used to retrieve the next items in a list and not for other programmatic purposes.</p> </note>
 */
  public let nextToken: String?
/**
<p>The maximum number of repository results returned by <code>DescribeRepositories</code> in paginated output. When this parameter is used, <code>DescribeRepositories</code> only returns <code>maxResults</code> results in a single page along with a <code>nextToken</code> response element. The remaining results of the initial request can be seen by sending another <code>DescribeRepositories</code> request with the returned <code>nextToken</code> value. This value can be between 1 and 100. If this parameter is not used, then <code>DescribeRepositories</code> returns up to 100 results and a <code>nextToken</code> value, if applicable.</p>
 */
  public let maxResults: Int?
/**
<p>The AWS account ID associated with the registry that contains the repositories to be described. If you do not specify a registry, the default registry is assumed.</p>
 */
  public let registryId: String?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if repositoryNames != nil { body["repositoryNames"] = repositoryNames! }
    if nextToken != nil { body["nextToken"] = nextToken! }
    if maxResults != nil { body["maxResults"] = maxResults! }
    if registryId != nil { body["registryId"] = registryId! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - repositoryNames: <p>A list of repositories to describe. If this parameter is omitted, then all repositories in a registry are described.</p>
      - nextToken: <p>The <code>nextToken</code> value returned from a previous paginated <code>DescribeRepositories</code> request where <code>maxResults</code> was used and the results exceeded the value of that parameter. Pagination continues from the end of the previous results that returned the <code>nextToken</code> value. This value is <code>null</code> when there are no more results to return.</p> <note> <p>This token should be treated as an opaque identifier that is only used to retrieve the next items in a list and not for other programmatic purposes.</p> </note>
      - maxResults: <p>The maximum number of repository results returned by <code>DescribeRepositories</code> in paginated output. When this parameter is used, <code>DescribeRepositories</code> only returns <code>maxResults</code> results in a single page along with a <code>nextToken</code> response element. The remaining results of the initial request can be seen by sending another <code>DescribeRepositories</code> request with the returned <code>nextToken</code> value. This value can be between 1 and 100. If this parameter is not used, then <code>DescribeRepositories</code> returns up to 100 results and a <code>nextToken</code> value, if applicable.</p>
      - registryId: <p>The AWS account ID associated with the registry that contains the repositories to be described. If you do not specify a registry, the default registry is assumed.</p>
 */
  public init(repositoryNames: [String]?, nextToken: String?, maxResults: Int?, registryId: String?) {
self.repositoryNames = repositoryNames
self.nextToken = nextToken
self.maxResults = maxResults
self.registryId = registryId
  }
}

public struct ListImagesResponse: RestJsonDeserializable {
/**
<p>The <code>nextToken</code> value to include in a future <code>ListImages</code> request. When the results of a <code>ListImages</code> request exceed <code>maxResults</code>, this value can be used to retrieve the next page of results. This value is <code>null</code> when there are no more results to return.</p>
 */
  public let nextToken: String?
/**
<p>The list of image IDs for the requested repository.</p>
 */
  public let imageIds: [ImageIdentifier]?


  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> ListImagesResponse {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return ListImagesResponse(
        nextToken: jsonDict["nextToken"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      imageIds: jsonDict["imageIds"].flatMap { ($0 is NSNull) ? nil : [ImageIdentifier].deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - nextToken: <p>The <code>nextToken</code> value to include in a future <code>ListImages</code> request. When the results of a <code>ListImages</code> request exceed <code>maxResults</code>, this value can be used to retrieve the next page of results. This value is <code>null</code> when there are no more results to return.</p>
      - imageIds: <p>The list of image IDs for the requested repository.</p>
 */
  public init(nextToken: String?, imageIds: [ImageIdentifier]?) {
self.nextToken = nextToken
self.imageIds = imageIds
  }
}

public struct BatchDeleteImageResponse: RestJsonDeserializable {
/**
<p>Any failures associated with the call.</p>
 */
  public let failures: [ImageFailure]?
/**
<p>The image IDs of the deleted images.</p>
 */
  public let imageIds: [ImageIdentifier]?


  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> BatchDeleteImageResponse {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return BatchDeleteImageResponse(
        failures: jsonDict["failures"].flatMap { ($0 is NSNull) ? nil : [ImageFailure].deserialize(response: response, body: .json($0)) },
      imageIds: jsonDict["imageIds"].flatMap { ($0 is NSNull) ? nil : [ImageIdentifier].deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - failures: <p>Any failures associated with the call.</p>
      - imageIds: <p>The image IDs of the deleted images.</p>
 */
  public init(failures: [ImageFailure]?, imageIds: [ImageIdentifier]?) {
self.failures = failures
self.imageIds = imageIds
  }
}


/**
<p>An object representing authorization data for an Amazon ECR registry.</p>
 */
public struct AuthorizationData: RestJsonSerializable, RestJsonDeserializable {
/**
<p>A base64-encoded string that contains authorization data for the specified Amazon ECR registry. When the string is decoded, it is presented in the format <code>user:password</code> for private registry authentication using <code>docker login</code>.</p>
 */
  public let authorizationToken: String?
/**
<p>The Unix time in seconds and milliseconds when the authorization token expires. Authorization tokens are valid for 12 hours.</p>
 */
  public let expiresAt: Date?
/**
<p>The registry URL to use for this authorization token in a <code>docker login</code> command. The Amazon ECR registry URL format is <code>https://aws_account_id.dkr.ecr.region.amazonaws.com</code>. For example, <code>https://012345678910.dkr.ecr.us-east-1.amazonaws.com</code>.. </p>
 */
  public let proxyEndpoint: String?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if authorizationToken != nil { body["authorizationToken"] = authorizationToken! }
    if expiresAt != nil { body["expiresAt"] = expiresAt! }
    if proxyEndpoint != nil { body["proxyEndpoint"] = proxyEndpoint! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> AuthorizationData {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return AuthorizationData(
        authorizationToken: jsonDict["authorizationToken"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      expiresAt: jsonDict["expiresAt"].flatMap { ($0 is NSNull) ? nil : Date.deserialize(response: response, body: .json($0)) },
      proxyEndpoint: jsonDict["proxyEndpoint"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - authorizationToken: <p>A base64-encoded string that contains authorization data for the specified Amazon ECR registry. When the string is decoded, it is presented in the format <code>user:password</code> for private registry authentication using <code>docker login</code>.</p>
      - expiresAt: <p>The Unix time in seconds and milliseconds when the authorization token expires. Authorization tokens are valid for 12 hours.</p>
      - proxyEndpoint: <p>The registry URL to use for this authorization token in a <code>docker login</code> command. The Amazon ECR registry URL format is <code>https://aws_account_id.dkr.ecr.region.amazonaws.com</code>. For example, <code>https://012345678910.dkr.ecr.us-east-1.amazonaws.com</code>.. </p>
 */
  public init(authorizationToken: String?, expiresAt: Date?, proxyEndpoint: String?) {
self.authorizationToken = authorizationToken
self.expiresAt = expiresAt
self.proxyEndpoint = proxyEndpoint
  }
}

/**
<p>Layer parts must be at least 5 MiB in size.</p>
 */
public struct LayerPartTooSmallException: Error, RestJsonDeserializable {
/**
<p>The error message associated with the exception.</p>
 */
  public let message: String?


  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> LayerPartTooSmallException {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return LayerPartTooSmallException(
        message: jsonDict["message"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - message: <p>The error message associated with the exception.</p>
 */
  public init(message: String?) {
self.message = message
  }
}

/**
<p>The specified repository could not be found. Check the spelling of the specified repository and ensure that you are performing operations on the correct registry.</p>
 */
public struct RepositoryNotFoundException: Error, RestJsonDeserializable {
/**
<p>The error message associated with the exception.</p>
 */
  public let message: String?


  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> RepositoryNotFoundException {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return RepositoryNotFoundException(
        message: jsonDict["message"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - message: <p>The error message associated with the exception.</p>
 */
  public init(message: String?) {
self.message = message
  }
}

/**
<p>The specified parameter is invalid. Review the available parameters for the API request.</p>
 */
public struct InvalidParameterException: Error, RestJsonDeserializable {
/**
<p>The error message associated with the exception.</p>
 */
  public let message: String?


  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> InvalidParameterException {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return InvalidParameterException(
        message: jsonDict["message"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - message: <p>The error message associated with the exception.</p>
 */
  public init(message: String?) {
self.message = message
  }
}

public struct DescribeImagesResponse: RestJsonDeserializable {
/**
<p>The <code>nextToken</code> value to include in a future <code>DescribeImages</code> request. When the results of a <code>DescribeImages</code> request exceed <code>maxResults</code>, this value can be used to retrieve the next page of results. This value is <code>null</code> when there are no more results to return.</p>
 */
  public let nextToken: String?
/**
<p>A list of <a>ImageDetail</a> objects that contain data about the image.</p>
 */
  public let imageDetails: [ImageDetail]?


  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> DescribeImagesResponse {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return DescribeImagesResponse(
        nextToken: jsonDict["nextToken"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      imageDetails: jsonDict["imageDetails"].flatMap { ($0 is NSNull) ? nil : [ImageDetail].deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - nextToken: <p>The <code>nextToken</code> value to include in a future <code>DescribeImages</code> request. When the results of a <code>DescribeImages</code> request exceed <code>maxResults</code>, this value can be used to retrieve the next page of results. This value is <code>null</code> when there are no more results to return.</p>
      - imageDetails: <p>A list of <a>ImageDetail</a> objects that contain data about the image.</p>
 */
  public init(nextToken: String?, imageDetails: [ImageDetail]?) {
self.nextToken = nextToken
self.imageDetails = imageDetails
  }
}

public struct DeleteRepositoryResponse: RestJsonDeserializable {
/**
<p>The repository that was deleted.</p>
 */
  public let repository: Repository?


  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> DeleteRepositoryResponse {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return DeleteRepositoryResponse(
        repository: jsonDict["repository"].flatMap { ($0 is NSNull) ? nil : Repository.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - repository: <p>The repository that was deleted.</p>
 */
  public init(repository: Repository?) {
self.repository = repository
  }
}


/**
<p>An object representing an Amazon ECR image layer.</p>
 */
public struct Layer: RestJsonSerializable, RestJsonDeserializable {
/**
<p>The size, in bytes, of the image layer.</p>
 */
  public let layerSize: Int?
/**
<p>The availability status of the image layer. Valid values are <code>AVAILABLE</code> and <code>UNAVAILABLE</code>.</p>
 */
  public let layerAvailability: Layeravailability?
/**
<p>The <code>sha256</code> digest of the image layer.</p>
 */
  public let layerDigest: String?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if layerSize != nil { body["layerSize"] = layerSize! }
    if layerAvailability != nil { body["layerAvailability"] = layerAvailability! }
    if layerDigest != nil { body["layerDigest"] = layerDigest! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Layer {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return Layer(
        layerSize: jsonDict["layerSize"].flatMap { ($0 is NSNull) ? nil : Int.deserialize(response: response, body: .json($0)) },
      layerAvailability: jsonDict["layerAvailability"].flatMap { ($0 is NSNull) ? nil : Layeravailability.deserialize(response: response, body: .json($0)) },
      layerDigest: jsonDict["layerDigest"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - layerSize: <p>The size, in bytes, of the image layer.</p>
      - layerAvailability: <p>The availability status of the image layer. Valid values are <code>AVAILABLE</code> and <code>UNAVAILABLE</code>.</p>
      - layerDigest: <p>The <code>sha256</code> digest of the image layer.</p>
 */
  public init(layerSize: Int?, layerAvailability: Layeravailability?, layerDigest: String?) {
self.layerSize = layerSize
self.layerAvailability = layerAvailability
self.layerDigest = layerDigest
  }
}

public struct DescribeImagesRequest: RestJsonSerializable {
/**
<p>The <code>nextToken</code> value returned from a previous paginated <code>DescribeImages</code> request where <code>maxResults</code> was used and the results exceeded the value of that parameter. Pagination continues from the end of the previous results that returned the <code>nextToken</code> value. This value is <code>null</code> when there are no more results to return.</p>
 */
  public let nextToken: String?
/**
<p>The list of image IDs for the requested repository.</p>
 */
  public let imageIds: [ImageIdentifier]?
/**
<p>The maximum number of repository results returned by <code>DescribeImages</code> in paginated output. When this parameter is used, <code>DescribeImages</code> only returns <code>maxResults</code> results in a single page along with a <code>nextToken</code> response element. The remaining results of the initial request can be seen by sending another <code>DescribeImages</code> request with the returned <code>nextToken</code> value. This value can be between 1 and 100. If this parameter is not used, then <code>DescribeImages</code> returns up to 100 results and a <code>nextToken</code> value, if applicable.</p>
 */
  public let maxResults: Int?
/**
<p>The filter key and value with which to filter your <code>DescribeImages</code> results.</p>
 */
  public let filter: DescribeImagesFilter?
/**
<p>A list of repositories to describe. If this parameter is omitted, then all repositories in a registry are described.</p>
 */
  public let repositoryName: String
/**
<p>The AWS account ID associated with the registry that contains the repository in which to list images. If you do not specify a registry, the default registry is assumed.</p>
 */
  public let registryId: String?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if nextToken != nil { body["nextToken"] = nextToken! }
    if imageIds != nil { body["imageIds"] = imageIds! }
    if maxResults != nil { body["maxResults"] = maxResults! }
    if filter != nil { body["filter"] = filter! }
    body["repositoryName"] = repositoryName
    if registryId != nil { body["registryId"] = registryId! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - nextToken: <p>The <code>nextToken</code> value returned from a previous paginated <code>DescribeImages</code> request where <code>maxResults</code> was used and the results exceeded the value of that parameter. Pagination continues from the end of the previous results that returned the <code>nextToken</code> value. This value is <code>null</code> when there are no more results to return.</p>
      - imageIds: <p>The list of image IDs for the requested repository.</p>
      - maxResults: <p>The maximum number of repository results returned by <code>DescribeImages</code> in paginated output. When this parameter is used, <code>DescribeImages</code> only returns <code>maxResults</code> results in a single page along with a <code>nextToken</code> response element. The remaining results of the initial request can be seen by sending another <code>DescribeImages</code> request with the returned <code>nextToken</code> value. This value can be between 1 and 100. If this parameter is not used, then <code>DescribeImages</code> returns up to 100 results and a <code>nextToken</code> value, if applicable.</p>
      - filter: <p>The filter key and value with which to filter your <code>DescribeImages</code> results.</p>
      - repositoryName: <p>A list of repositories to describe. If this parameter is omitted, then all repositories in a registry are described.</p>
      - registryId: <p>The AWS account ID associated with the registry that contains the repository in which to list images. If you do not specify a registry, the default registry is assumed.</p>
 */
  public init(nextToken: String?, imageIds: [ImageIdentifier]?, maxResults: Int?, filter: DescribeImagesFilter?, repositoryName: String, registryId: String?) {
self.nextToken = nextToken
self.imageIds = imageIds
self.maxResults = maxResults
self.filter = filter
self.repositoryName = repositoryName
self.registryId = registryId
  }
}



/**
<p>An object with identifying information for an Amazon ECR image.</p>
 */
public struct ImageIdentifier: RestJsonSerializable, RestJsonDeserializable {
/**
<p>The tag used for the image.</p>
 */
  public let imageTag: String?
/**
<p>The <code>sha256</code> digest of the image manifest.</p>
 */
  public let imageDigest: String?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if imageTag != nil { body["imageTag"] = imageTag! }
    if imageDigest != nil { body["imageDigest"] = imageDigest! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> ImageIdentifier {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return ImageIdentifier(
        imageTag: jsonDict["imageTag"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      imageDigest: jsonDict["imageDigest"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - imageTag: <p>The tag used for the image.</p>
      - imageDigest: <p>The <code>sha256</code> digest of the image manifest.</p>
 */
  public init(imageTag: String?, imageDigest: String?) {
self.imageTag = imageTag
self.imageDigest = imageDigest
  }
}

public struct DeleteRepositoryPolicyResponse: RestJsonDeserializable {
/**
<p>The JSON repository policy that was deleted from the repository.</p>
 */
  public let policyText: String?
/**
<p>The registry ID associated with the request.</p>
 */
  public let registryId: String?
/**
<p>The repository name associated with the request.</p>
 */
  public let repositoryName: String?


  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> DeleteRepositoryPolicyResponse {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return DeleteRepositoryPolicyResponse(
        policyText: jsonDict["policyText"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      registryId: jsonDict["registryId"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      repositoryName: jsonDict["repositoryName"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - policyText: <p>The JSON repository policy that was deleted from the repository.</p>
      - registryId: <p>The registry ID associated with the request.</p>
      - repositoryName: <p>The repository name associated with the request.</p>
 */
  public init(policyText: String?, registryId: String?, repositoryName: String?) {
self.policyText = policyText
self.registryId = registryId
self.repositoryName = repositoryName
  }
}

/**
<p>The upload could not be found, or the specified upload id is not valid for this repository.</p>
 */
public struct UploadNotFoundException: Error, RestJsonDeserializable {
/**
<p>The error message associated with the exception.</p>
 */
  public let message: String?


  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> UploadNotFoundException {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return UploadNotFoundException(
        message: jsonDict["message"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - message: <p>The error message associated with the exception.</p>
 */
  public init(message: String?) {
self.message = message
  }
}

/**
<p>An object representing an Amazon ECR image layer failure.</p>
 */
public struct LayerFailure: RestJsonSerializable, RestJsonDeserializable {
/**
<p>The reason for the failure.</p>
 */
  public let failureReason: String?
/**
<p>The failure code associated with the failure.</p>
 */
  public let failureCode: Layerfailurecode?
/**
<p>The layer digest associated with the failure.</p>
 */
  public let layerDigest: String?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if failureReason != nil { body["failureReason"] = failureReason! }
    if failureCode != nil { body["failureCode"] = failureCode! }
    if layerDigest != nil { body["layerDigest"] = layerDigest! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> LayerFailure {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return LayerFailure(
        failureReason: jsonDict["failureReason"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      failureCode: jsonDict["failureCode"].flatMap { ($0 is NSNull) ? nil : Layerfailurecode.deserialize(response: response, body: .json($0)) },
      layerDigest: jsonDict["layerDigest"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - failureReason: <p>The reason for the failure.</p>
      - failureCode: <p>The failure code associated with the failure.</p>
      - layerDigest: <p>The layer digest associated with the failure.</p>
 */
  public init(failureReason: String?, failureCode: Layerfailurecode?, layerDigest: String?) {
self.failureReason = failureReason
self.failureCode = failureCode
self.layerDigest = layerDigest
  }
}


/**
<p>An object representing an Amazon ECR image failure.</p>
 */
public struct ImageFailure: RestJsonSerializable, RestJsonDeserializable {
/**
<p>The image ID associated with the failure.</p>
 */
  public let imageId: ImageIdentifier?
/**
<p>The code associated with the failure.</p>
 */
  public let failureCode: Imagefailurecode?
/**
<p>The reason for the failure.</p>
 */
  public let failureReason: String?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if imageId != nil { body["imageId"] = imageId! }
    if failureCode != nil { body["failureCode"] = failureCode! }
    if failureReason != nil { body["failureReason"] = failureReason! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> ImageFailure {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return ImageFailure(
        imageId: jsonDict["imageId"].flatMap { ($0 is NSNull) ? nil : ImageIdentifier.deserialize(response: response, body: .json($0)) },
      failureCode: jsonDict["failureCode"].flatMap { ($0 is NSNull) ? nil : Imagefailurecode.deserialize(response: response, body: .json($0)) },
      failureReason: jsonDict["failureReason"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - imageId: <p>The image ID associated with the failure.</p>
      - failureCode: <p>The code associated with the failure.</p>
      - failureReason: <p>The reason for the failure.</p>
 */
  public init(imageId: ImageIdentifier?, failureCode: Imagefailurecode?, failureReason: String?) {
self.imageId = imageId
self.failureCode = failureCode
self.failureReason = failureReason
  }
}


public struct BatchGetImageResponse: RestJsonDeserializable {
/**
<p>Any failures associated with the call.</p>
 */
  public let failures: [ImageFailure]?
/**
<p>A list of image objects corresponding to the image references in the request.</p>
 */
  public let images: [Image]?


  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> BatchGetImageResponse {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return BatchGetImageResponse(
        failures: jsonDict["failures"].flatMap { ($0 is NSNull) ? nil : [ImageFailure].deserialize(response: response, body: .json($0)) },
      images: jsonDict["images"].flatMap { ($0 is NSNull) ? nil : [Image].deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - failures: <p>Any failures associated with the call.</p>
      - images: <p>A list of image objects corresponding to the image references in the request.</p>
 */
  public init(failures: [ImageFailure]?, images: [Image]?) {
self.failures = failures
self.images = images
  }
}

/**
<p>The specified repository and registry combination does not have an associated repository policy.</p>
 */
public struct RepositoryPolicyNotFoundException: Error, RestJsonDeserializable {
/**
<p>The error message associated with the exception.</p>
 */
  public let message: String?


  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> RepositoryPolicyNotFoundException {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return RepositoryPolicyNotFoundException(
        message: jsonDict["message"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - message: <p>The error message associated with the exception.</p>
 */
  public init(message: String?) {
self.message = message
  }
}



/**
<p>The specified repository already exists in the specified registry.</p>
 */
public struct RepositoryAlreadyExistsException: Error, RestJsonDeserializable {
/**
<p>The error message associated with the exception.</p>
 */
  public let message: String?


  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> RepositoryAlreadyExistsException {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return RepositoryAlreadyExistsException(
        message: jsonDict["message"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - message: <p>The error message associated with the exception.</p>
 */
  public init(message: String?) {
self.message = message
  }
}

/**
<p>The layer digest calculation performed by Amazon ECR upon receipt of the image layer does not match the digest specified.</p>
 */
public struct InvalidLayerException: Error, RestJsonDeserializable {
/**
<p>The error message associated with the exception.</p>
 */
  public let message: String?


  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> InvalidLayerException {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return InvalidLayerException(
        message: jsonDict["message"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - message: <p>The error message associated with the exception.</p>
 */
  public init(message: String?) {
self.message = message
  }
}

enum Layeravailability: String, RestJsonDeserializable, RestJsonSerializable {
  case `aVAILABLE` = "AVAILABLE"
  case `uNAVAILABLE` = "UNAVAILABLE"

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Layeravailability {
    guard case let .json(json) = body else { fatalError() }
    return Layeravailability(rawValue: json as! String)!
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}

/**
<p>The image layer already exists in the associated repository.</p>
 */
public struct LayerAlreadyExistsException: Error, RestJsonDeserializable {
/**
<p>The error message associated with the exception.</p>
 */
  public let message: String?


  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> LayerAlreadyExistsException {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return LayerAlreadyExistsException(
        message: jsonDict["message"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - message: <p>The error message associated with the exception.</p>
 */
  public init(message: String?) {
self.message = message
  }
}


/**
<p>The operation did not succeed because it would have exceeded a service limit for your account. For more information, see <a href="http://docs.aws.amazon.com/AmazonECR/latest/userguide/service_limits.html">Amazon ECR Default Service Limits</a> in the Amazon EC2 Container Registry User Guide.</p>
 */
public struct LimitExceededException: Error, RestJsonDeserializable {
/**
<p>The error message associated with the exception.</p>
 */
  public let message: String?


  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> LimitExceededException {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return LimitExceededException(
        message: jsonDict["message"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - message: <p>The error message associated with the exception.</p>
 */
  public init(message: String?) {
self.message = message
  }
}

public struct GetAuthorizationTokenRequest: RestJsonSerializable {
/**
<p>A list of AWS account IDs that are associated with the registries for which to get authorization tokens. If you do not specify a registry, the default registry is assumed.</p>
 */
  public let registryIds: [String]?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if registryIds != nil { body["registryIds"] = registryIds! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - registryIds: <p>A list of AWS account IDs that are associated with the registries for which to get authorization tokens. If you do not specify a registry, the default registry is assumed.</p>
 */
  public init(registryIds: [String]?) {
self.registryIds = registryIds
  }
}

public struct SetRepositoryPolicyResponse: RestJsonDeserializable {
/**
<p>The JSON repository policy text applied to the repository.</p>
 */
  public let policyText: String?
/**
<p>The registry ID associated with the request.</p>
 */
  public let registryId: String?
/**
<p>The repository name associated with the request.</p>
 */
  public let repositoryName: String?


  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> SetRepositoryPolicyResponse {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return SetRepositoryPolicyResponse(
        policyText: jsonDict["policyText"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      registryId: jsonDict["registryId"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      repositoryName: jsonDict["repositoryName"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - policyText: <p>The JSON repository policy text applied to the repository.</p>
      - registryId: <p>The registry ID associated with the request.</p>
      - repositoryName: <p>The repository name associated with the request.</p>
 */
  public init(policyText: String?, registryId: String?, repositoryName: String?) {
self.policyText = policyText
self.registryId = registryId
self.repositoryName = repositoryName
  }
}

/**
<p>The specified layers could not be found, or the specified layer is not valid for this repository.</p>
 */
public struct LayersNotFoundException: Error, RestJsonDeserializable {
/**
<p>The error message associated with the exception.</p>
 */
  public let message: String?


  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> LayersNotFoundException {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return LayersNotFoundException(
        message: jsonDict["message"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - message: <p>The error message associated with the exception.</p>
 */
  public init(message: String?) {
self.message = message
  }
}


/**
<p>The specified image has already been pushed, and there are no changes to the manifest or image tag since the last push.</p>
 */
public struct ImageAlreadyExistsException: Error, RestJsonDeserializable {
/**
<p>The error message associated with the exception.</p>
 */
  public let message: String?


  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> ImageAlreadyExistsException {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return ImageAlreadyExistsException(
        message: jsonDict["message"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - message: <p>The error message associated with the exception.</p>
 */
  public init(message: String?) {
self.message = message
  }
}

enum Layerfailurecode: String, RestJsonDeserializable, RestJsonSerializable {
  case `invalidLayerDigest` = "InvalidLayerDigest"
  case `missingLayerDigest` = "MissingLayerDigest"

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Layerfailurecode {
    guard case let .json(json) = body else { fatalError() }
    return Layerfailurecode(rawValue: json as! String)!
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}

/**
<p>An object that describes an image returned by a <a>DescribeImages</a> operation.</p>
 */
public struct ImageDetail: RestJsonSerializable, RestJsonDeserializable {
/**
<p>The size, in bytes, of the image in the repository.</p> <note> <p>Beginning with Docker version 1.9, the Docker client compresses image layers before pushing them to a V2 Docker registry. The output of the <code>docker images</code> command shows the uncompressed image size, so it may return a larger image size than the image sizes returned by <a>DescribeImages</a>.</p> </note>
 */
  public let imageSizeInBytes: Int?
/**
<p>The name of the repository to which this image belongs.</p>
 */
  public let repositoryName: String?
/**
<p>The <code>sha256</code> digest of the image manifest.</p>
 */
  public let imageDigest: String?
/**
<p>The list of tags associated with this image.</p>
 */
  public let imageTags: [String]?
/**
<p>The date and time, expressed in standard JavaScript date format, at which the current image was pushed to the repository. </p>
 */
  public let imagePushedAt: Date?
/**
<p>The AWS account ID associated with the registry to which this image belongs.</p>
 */
  public let registryId: String?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if imageSizeInBytes != nil { body["imageSizeInBytes"] = imageSizeInBytes! }
    if repositoryName != nil { body["repositoryName"] = repositoryName! }
    if imageDigest != nil { body["imageDigest"] = imageDigest! }
    if imageTags != nil { body["imageTags"] = imageTags! }
    if imagePushedAt != nil { body["imagePushedAt"] = imagePushedAt! }
    if registryId != nil { body["registryId"] = registryId! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> ImageDetail {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return ImageDetail(
        imageSizeInBytes: jsonDict["imageSizeInBytes"].flatMap { ($0 is NSNull) ? nil : Int.deserialize(response: response, body: .json($0)) },
      repositoryName: jsonDict["repositoryName"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      imageDigest: jsonDict["imageDigest"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      imageTags: jsonDict["imageTags"].flatMap { ($0 is NSNull) ? nil : [String].deserialize(response: response, body: .json($0)) },
      imagePushedAt: jsonDict["imagePushedAt"].flatMap { ($0 is NSNull) ? nil : Date.deserialize(response: response, body: .json($0)) },
      registryId: jsonDict["registryId"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - imageSizeInBytes: <p>The size, in bytes, of the image in the repository.</p> <note> <p>Beginning with Docker version 1.9, the Docker client compresses image layers before pushing them to a V2 Docker registry. The output of the <code>docker images</code> command shows the uncompressed image size, so it may return a larger image size than the image sizes returned by <a>DescribeImages</a>.</p> </note>
      - repositoryName: <p>The name of the repository to which this image belongs.</p>
      - imageDigest: <p>The <code>sha256</code> digest of the image manifest.</p>
      - imageTags: <p>The list of tags associated with this image.</p>
      - imagePushedAt: <p>The date and time, expressed in standard JavaScript date format, at which the current image was pushed to the repository. </p>
      - registryId: <p>The AWS account ID associated with the registry to which this image belongs.</p>
 */
  public init(imageSizeInBytes: Int?, repositoryName: String?, imageDigest: String?, imageTags: [String]?, imagePushedAt: Date?, registryId: String?) {
self.imageSizeInBytes = imageSizeInBytes
self.repositoryName = repositoryName
self.imageDigest = imageDigest
self.imageTags = imageTags
self.imagePushedAt = imagePushedAt
self.registryId = registryId
  }
}


public struct GetAuthorizationTokenResponse: RestJsonDeserializable {
/**
<p>A list of authorization token data objects that correspond to the <code>registryIds</code> values in the request.</p>
 */
  public let authorizationData: [AuthorizationData]?


  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> GetAuthorizationTokenResponse {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return GetAuthorizationTokenResponse(
        authorizationData: jsonDict["authorizationData"].flatMap { ($0 is NSNull) ? nil : [AuthorizationData].deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - authorizationData: <p>A list of authorization token data objects that correspond to the <code>registryIds</code> values in the request.</p>
 */
  public init(authorizationData: [AuthorizationData]?) {
self.authorizationData = authorizationData
  }
}

public struct InitiateLayerUploadResponse: RestJsonDeserializable {
/**
<p>The upload ID for the layer upload. This parameter is passed to further <a>UploadLayerPart</a> and <a>CompleteLayerUpload</a> operations.</p>
 */
  public let uploadId: String?
/**
<p>The size, in bytes, that Amazon ECR expects future layer part uploads to be.</p>
 */
  public let partSize: Int?


  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> InitiateLayerUploadResponse {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return InitiateLayerUploadResponse(
        uploadId: jsonDict["uploadId"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      partSize: jsonDict["partSize"].flatMap { ($0 is NSNull) ? nil : Int.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - uploadId: <p>The upload ID for the layer upload. This parameter is passed to further <a>UploadLayerPart</a> and <a>CompleteLayerUpload</a> operations.</p>
      - partSize: <p>The size, in bytes, that Amazon ECR expects future layer part uploads to be.</p>
 */
  public init(uploadId: String?, partSize: Int?) {
self.uploadId = uploadId
self.partSize = partSize
  }
}

/**
<p>The specified layer is not available because it is not associated with an image. Unassociated image layers may be cleaned up at any time.</p>
 */
public struct LayerInaccessibleException: Error, RestJsonDeserializable {
/**
<p>The error message associated with the exception.</p>
 */
  public let message: String?


  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> LayerInaccessibleException {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return LayerInaccessibleException(
        message: jsonDict["message"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - message: <p>The error message associated with the exception.</p>
 */
  public init(message: String?) {
self.message = message
  }
}


/**
<p>The specified layer upload does not contain any layer parts.</p>
 */
public struct EmptyUploadException: Error, RestJsonDeserializable {
/**
<p>The error message associated with the exception.</p>
 */
  public let message: String?


  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> EmptyUploadException {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return EmptyUploadException(
        message: jsonDict["message"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - message: <p>The error message associated with the exception.</p>
 */
  public init(message: String?) {
self.message = message
  }
}

public struct BatchGetImageRequest: RestJsonSerializable {
/**
<p>The AWS account ID associated with the registry that contains the images to describe. If you do not specify a registry, the default registry is assumed.</p>
 */
  public let registryId: String?
/**
<p>A list of image ID references that correspond to images to describe. The format of the <code>imageIds</code> reference is <code>imageTag=tag</code> or <code>imageDigest=digest</code>.</p>
 */
  public let imageIds: [ImageIdentifier]
/**
<p>The repository that contains the images to describe.</p>
 */
  public let repositoryName: String

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if registryId != nil { body["registryId"] = registryId! }
    body["imageIds"] = imageIds
    body["repositoryName"] = repositoryName
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - registryId: <p>The AWS account ID associated with the registry that contains the images to describe. If you do not specify a registry, the default registry is assumed.</p>
      - imageIds: <p>A list of image ID references that correspond to images to describe. The format of the <code>imageIds</code> reference is <code>imageTag=tag</code> or <code>imageDigest=digest</code>.</p>
      - repositoryName: <p>The repository that contains the images to describe.</p>
 */
  public init(registryId: String?, imageIds: [ImageIdentifier], repositoryName: String) {
self.registryId = registryId
self.imageIds = imageIds
self.repositoryName = repositoryName
  }
}

public struct DeleteRepositoryPolicyRequest: RestJsonSerializable {
/**
<p>The AWS account ID associated with the registry that contains the repository policy to delete. If you do not specify a registry, the default registry is assumed.</p>
 */
  public let registryId: String?
/**
<p>The name of the repository that is associated with the repository policy to delete.</p>
 */
  public let repositoryName: String

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if registryId != nil { body["registryId"] = registryId! }
    body["repositoryName"] = repositoryName
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - registryId: <p>The AWS account ID associated with the registry that contains the repository policy to delete. If you do not specify a registry, the default registry is assumed.</p>
      - repositoryName: <p>The name of the repository that is associated with the repository policy to delete.</p>
 */
  public init(registryId: String?, repositoryName: String) {
self.registryId = registryId
self.repositoryName = repositoryName
  }
}

public struct GetDownloadUrlForLayerResponse: RestJsonDeserializable {
/**
<p>The pre-signed Amazon S3 download URL for the requested layer.</p>
 */
  public let downloadUrl: String?
/**
<p>The digest of the image layer to download.</p>
 */
  public let layerDigest: String?


  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> GetDownloadUrlForLayerResponse {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return GetDownloadUrlForLayerResponse(
        downloadUrl: jsonDict["downloadUrl"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      layerDigest: jsonDict["layerDigest"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - downloadUrl: <p>The pre-signed Amazon S3 download URL for the requested layer.</p>
      - layerDigest: <p>The digest of the image layer to download.</p>
 */
  public init(downloadUrl: String?, layerDigest: String?) {
self.downloadUrl = downloadUrl
self.layerDigest = layerDigest
  }
}


public struct CreateRepositoryRequest: RestJsonSerializable {
/**
<p>The name to use for the repository. The repository name may be specified on its own (such as <code>nginx-web-app</code>) or it can be prepended with a namespace to group the repository into a category (such as <code>project-a/nginx-web-app</code>).</p>
 */
  public let repositoryName: String

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["repositoryName"] = repositoryName
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - repositoryName: <p>The name to use for the repository. The repository name may be specified on its own (such as <code>nginx-web-app</code>) or it can be prepended with a namespace to group the repository into a category (such as <code>project-a/nginx-web-app</code>).</p>
 */
  public init(repositoryName: String) {
self.repositoryName = repositoryName
  }
}

/**
<p>An object representing an Amazon ECR image.</p>
 */
public struct Image: RestJsonSerializable, RestJsonDeserializable {
/**
<p>The image manifest associated with the image.</p>
 */
  public let imageManifest: String?
/**
<p>An object containing the image tag and image digest associated with an image.</p>
 */
  public let imageId: ImageIdentifier?
/**
<p>The name of the repository associated with the image.</p>
 */
  public let repositoryName: String?
/**
<p>The AWS account ID associated with the registry containing the image.</p>
 */
  public let registryId: String?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if imageManifest != nil { body["imageManifest"] = imageManifest! }
    if imageId != nil { body["imageId"] = imageId! }
    if repositoryName != nil { body["repositoryName"] = repositoryName! }
    if registryId != nil { body["registryId"] = registryId! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Image {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return Image(
        imageManifest: jsonDict["imageManifest"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      imageId: jsonDict["imageId"].flatMap { ($0 is NSNull) ? nil : ImageIdentifier.deserialize(response: response, body: .json($0)) },
      repositoryName: jsonDict["repositoryName"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      registryId: jsonDict["registryId"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - imageManifest: <p>The image manifest associated with the image.</p>
      - imageId: <p>An object containing the image tag and image digest associated with an image.</p>
      - repositoryName: <p>The name of the repository associated with the image.</p>
      - registryId: <p>The AWS account ID associated with the registry containing the image.</p>
 */
  public init(imageManifest: String?, imageId: ImageIdentifier?, repositoryName: String?, registryId: String?) {
self.imageManifest = imageManifest
self.imageId = imageId
self.repositoryName = repositoryName
self.registryId = registryId
  }
}


public struct GetRepositoryPolicyResponse: RestJsonDeserializable {
/**
<p>The JSON repository policy text associated with the repository.</p>
 */
  public let policyText: String?
/**
<p>The registry ID associated with the request.</p>
 */
  public let registryId: String?
/**
<p>The repository name associated with the request.</p>
 */
  public let repositoryName: String?


  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> GetRepositoryPolicyResponse {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return GetRepositoryPolicyResponse(
        policyText: jsonDict["policyText"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      registryId: jsonDict["registryId"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      repositoryName: jsonDict["repositoryName"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - policyText: <p>The JSON repository policy text associated with the repository.</p>
      - registryId: <p>The registry ID associated with the request.</p>
      - repositoryName: <p>The repository name associated with the request.</p>
 */
  public init(policyText: String?, registryId: String?, repositoryName: String?) {
self.policyText = policyText
self.registryId = registryId
self.repositoryName = repositoryName
  }
}


public struct GetDownloadUrlForLayerRequest: RestJsonSerializable {
/**
<p>The name of the repository that is associated with the image layer to download.</p>
 */
  public let repositoryName: String
/**
<p>The AWS account ID associated with the registry that contains the image layer to download. If you do not specify a registry, the default registry is assumed.</p>
 */
  public let registryId: String?
/**
<p>The digest of the image layer to download.</p>
 */
  public let layerDigest: String

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["repositoryName"] = repositoryName
    if registryId != nil { body["registryId"] = registryId! }
    body["layerDigest"] = layerDigest
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - repositoryName: <p>The name of the repository that is associated with the image layer to download.</p>
      - registryId: <p>The AWS account ID associated with the registry that contains the image layer to download. If you do not specify a registry, the default registry is assumed.</p>
      - layerDigest: <p>The digest of the image layer to download.</p>
 */
  public init(repositoryName: String, registryId: String?, layerDigest: String) {
self.repositoryName = repositoryName
self.registryId = registryId
self.layerDigest = layerDigest
  }
}



/**
<p>An object representing a filter on a <a>ListImages</a> operation.</p>
 */
public struct ListImagesFilter: RestJsonSerializable, RestJsonDeserializable {
/**
<p>The tag status with which to filter your <a>ListImages</a> results. You can filter results based on whether they are <code>TAGGED</code> or <code>UNTAGGED</code>.</p>
 */
  public let tagStatus: Tagstatus?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if tagStatus != nil { body["tagStatus"] = tagStatus! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> ListImagesFilter {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return ListImagesFilter(
        tagStatus: jsonDict["tagStatus"].flatMap { ($0 is NSNull) ? nil : Tagstatus.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - tagStatus: <p>The tag status with which to filter your <a>ListImages</a> results. You can filter results based on whether they are <code>TAGGED</code> or <code>UNTAGGED</code>.</p>
 */
  public init(tagStatus: Tagstatus?) {
self.tagStatus = tagStatus
  }
}

public struct SetRepositoryPolicyRequest: RestJsonSerializable {
/**
<p>If the policy you are attempting to set on a repository policy would prevent you from setting another policy in the future, you must force the <a>SetRepositoryPolicy</a> operation. This is intended to prevent accidental repository lock outs.</p>
 */
  public let force: Bool?
/**
<p>The JSON repository policy text to apply to the repository.</p>
 */
  public let policyText: String
/**
<p>The name of the repository to receive the policy.</p>
 */
  public let repositoryName: String
/**
<p>The AWS account ID associated with the registry that contains the repository. If you do not specify a registry, the default registry is assumed.</p>
 */
  public let registryId: String?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if force != nil { body["force"] = force! }
    body["policyText"] = policyText
    body["repositoryName"] = repositoryName
    if registryId != nil { body["registryId"] = registryId! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - force: <p>If the policy you are attempting to set on a repository policy would prevent you from setting another policy in the future, you must force the <a>SetRepositoryPolicy</a> operation. This is intended to prevent accidental repository lock outs.</p>
      - policyText: <p>The JSON repository policy text to apply to the repository.</p>
      - repositoryName: <p>The name of the repository to receive the policy.</p>
      - registryId: <p>The AWS account ID associated with the registry that contains the repository. If you do not specify a registry, the default registry is assumed.</p>
 */
  public init(force: Bool?, policyText: String, repositoryName: String, registryId: String?) {
self.force = force
self.policyText = policyText
self.repositoryName = repositoryName
self.registryId = registryId
  }
}

public struct CreateRepositoryResponse: RestJsonDeserializable {
/**
<p>The repository that was created.</p>
 */
  public let repository: Repository?


  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> CreateRepositoryResponse {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return CreateRepositoryResponse(
        repository: jsonDict["repository"].flatMap { ($0 is NSNull) ? nil : Repository.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - repository: <p>The repository that was created.</p>
 */
  public init(repository: Repository?) {
self.repository = repository
  }
}

/**
<p>The image requested does not exist in the specified repository.</p>
 */
public struct ImageNotFoundException: Error, RestJsonDeserializable {
/**

 */
  public let message: String?


  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> ImageNotFoundException {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return ImageNotFoundException(
        message: jsonDict["message"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - message: 
 */
  public init(message: String?) {
self.message = message
  }
}




public struct BatchCheckLayerAvailabilityRequest: RestJsonSerializable {
/**
<p>The name of the repository that is associated with the image layers to check.</p>
 */
  public let repositoryName: String
/**
<p>The AWS account ID associated with the registry that contains the image layers to check. If you do not specify a registry, the default registry is assumed.</p>
 */
  public let registryId: String?
/**
<p>The digests of the image layers to check.</p>
 */
  public let layerDigests: [String]

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["repositoryName"] = repositoryName
    if registryId != nil { body["registryId"] = registryId! }
    body["layerDigests"] = layerDigests
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - repositoryName: <p>The name of the repository that is associated with the image layers to check.</p>
      - registryId: <p>The AWS account ID associated with the registry that contains the image layers to check. If you do not specify a registry, the default registry is assumed.</p>
      - layerDigests: <p>The digests of the image layers to check.</p>
 */
  public init(repositoryName: String, registryId: String?, layerDigests: [String]) {
self.repositoryName = repositoryName
self.registryId = registryId
self.layerDigests = layerDigests
  }
}

public struct GetRepositoryPolicyRequest: RestJsonSerializable {
/**
<p>The AWS account ID associated with the registry that contains the repository. If you do not specify a registry, the default registry is assumed.</p>
 */
  public let registryId: String?
/**
<p>The name of the repository whose policy you want to retrieve.</p>
 */
  public let repositoryName: String

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if registryId != nil { body["registryId"] = registryId! }
    body["repositoryName"] = repositoryName
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - registryId: <p>The AWS account ID associated with the registry that contains the repository. If you do not specify a registry, the default registry is assumed.</p>
      - repositoryName: <p>The name of the repository whose policy you want to retrieve.</p>
 */
  public init(registryId: String?, repositoryName: String) {
self.registryId = registryId
self.repositoryName = repositoryName
  }
}

/**
<p>These errors are usually caused by a server-side issue.</p>
 */
public struct ServerException: Error, RestJsonDeserializable {
/**
<p>The error message associated with the exception.</p>
 */
  public let message: String?


  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> ServerException {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return ServerException(
        message: jsonDict["message"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - message: <p>The error message associated with the exception.</p>
 */
  public init(message: String?) {
self.message = message
  }
}


public struct BatchCheckLayerAvailabilityResponse: RestJsonDeserializable {
/**
<p>Any failures associated with the call.</p>
 */
  public let failures: [LayerFailure]?
/**
<p>A list of image layer objects corresponding to the image layer references in the request.</p>
 */
  public let layers: [Layer]?


  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> BatchCheckLayerAvailabilityResponse {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return BatchCheckLayerAvailabilityResponse(
        failures: jsonDict["failures"].flatMap { ($0 is NSNull) ? nil : [LayerFailure].deserialize(response: response, body: .json($0)) },
      layers: jsonDict["layers"].flatMap { ($0 is NSNull) ? nil : [Layer].deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - failures: <p>Any failures associated with the call.</p>
      - layers: <p>A list of image layer objects corresponding to the image layer references in the request.</p>
 */
  public init(failures: [LayerFailure]?, layers: [Layer]?) {
self.failures = failures
self.layers = layers
  }
}

public struct PutImageRequest: RestJsonSerializable {
/**
<p>The image manifest corresponding to the image to be uploaded.</p>
 */
  public let imageManifest: String
/**
<p>The AWS account ID associated with the registry that contains the repository in which to put the image. If you do not specify a registry, the default registry is assumed.</p>
 */
  public let registryId: String?
/**
<p>The name of the repository in which to put the image.</p>
 */
  public let repositoryName: String

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["imageManifest"] = imageManifest
    if registryId != nil { body["registryId"] = registryId! }
    body["repositoryName"] = repositoryName
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - imageManifest: <p>The image manifest corresponding to the image to be uploaded.</p>
      - registryId: <p>The AWS account ID associated with the registry that contains the repository in which to put the image. If you do not specify a registry, the default registry is assumed.</p>
      - repositoryName: <p>The name of the repository in which to put the image.</p>
 */
  public init(imageManifest: String, registryId: String?, repositoryName: String) {
self.imageManifest = imageManifest
self.registryId = registryId
self.repositoryName = repositoryName
  }
}

public struct UploadLayerPartResponse: RestJsonDeserializable {
/**
<p>The upload ID associated with the request.</p>
 */
  public let uploadId: String?
/**
<p>The repository name associated with the request.</p>
 */
  public let repositoryName: String?
/**
<p>The registry ID associated with the request.</p>
 */
  public let registryId: String?
/**
<p>The integer value of the last byte received in the request.</p>
 */
  public let lastByteReceived: Int?


  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> UploadLayerPartResponse {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return UploadLayerPartResponse(
        uploadId: jsonDict["uploadId"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      repositoryName: jsonDict["repositoryName"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      registryId: jsonDict["registryId"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      lastByteReceived: jsonDict["lastByteReceived"].flatMap { ($0 is NSNull) ? nil : Int.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - uploadId: <p>The upload ID associated with the request.</p>
      - repositoryName: <p>The repository name associated with the request.</p>
      - registryId: <p>The registry ID associated with the request.</p>
      - lastByteReceived: <p>The integer value of the last byte received in the request.</p>
 */
  public init(uploadId: String?, repositoryName: String?, registryId: String?, lastByteReceived: Int?) {
self.uploadId = uploadId
self.repositoryName = repositoryName
self.registryId = registryId
self.lastByteReceived = lastByteReceived
  }
}


public struct DescribeRepositoriesResponse: RestJsonDeserializable {
/**
<p>A list of repository objects corresponding to valid repositories.</p>
 */
  public let repositories: [Repository]?
/**
<p>The <code>nextToken</code> value to include in a future <code>DescribeRepositories</code> request. When the results of a <code>DescribeRepositories</code> request exceed <code>maxResults</code>, this value can be used to retrieve the next page of results. This value is <code>null</code> when there are no more results to return.</p>
 */
  public let nextToken: String?


  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> DescribeRepositoriesResponse {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return DescribeRepositoriesResponse(
        repositories: jsonDict["repositories"].flatMap { ($0 is NSNull) ? nil : [Repository].deserialize(response: response, body: .json($0)) },
      nextToken: jsonDict["nextToken"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - repositories: <p>A list of repository objects corresponding to valid repositories.</p>
      - nextToken: <p>The <code>nextToken</code> value to include in a future <code>DescribeRepositories</code> request. When the results of a <code>DescribeRepositories</code> request exceed <code>maxResults</code>, this value can be used to retrieve the next page of results. This value is <code>null</code> when there are no more results to return.</p>
 */
  public init(repositories: [Repository]?, nextToken: String?) {
self.repositories = repositories
self.nextToken = nextToken
  }
}




public struct InitiateLayerUploadRequest: RestJsonSerializable {
/**
<p>The AWS account ID associated with the registry that you intend to upload layers to. If you do not specify a registry, the default registry is assumed.</p>
 */
  public let registryId: String?
/**
<p>The name of the repository that you intend to upload layers to.</p>
 */
  public let repositoryName: String

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if registryId != nil { body["registryId"] = registryId! }
    body["repositoryName"] = repositoryName
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - registryId: <p>The AWS account ID associated with the registry that you intend to upload layers to. If you do not specify a registry, the default registry is assumed.</p>
      - repositoryName: <p>The name of the repository that you intend to upload layers to.</p>
 */
  public init(registryId: String?, repositoryName: String) {
self.registryId = registryId
self.repositoryName = repositoryName
  }
}

enum Imagefailurecode: String, RestJsonDeserializable, RestJsonSerializable {
  case `invalidImageDigest` = "InvalidImageDigest"
  case `invalidImageTag` = "InvalidImageTag"
  case `imageTagDoesNotMatchDigest` = "ImageTagDoesNotMatchDigest"
  case `imageNotFound` = "ImageNotFound"
  case `missingDigestAndTag` = "MissingDigestAndTag"

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Imagefailurecode {
    guard case let .json(json) = body else { fatalError() }
    return Imagefailurecode(rawValue: json as! String)!
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}




public struct DeleteRepositoryRequest: RestJsonSerializable {
/**
<p>Force the deletion of the repository if it contains images.</p>
 */
  public let force: Bool?
/**
<p>The AWS account ID associated with the registry that contains the repository to delete. If you do not specify a registry, the default registry is assumed.</p>
 */
  public let registryId: String?
/**
<p>The name of the repository to delete.</p>
 */
  public let repositoryName: String

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if force != nil { body["force"] = force! }
    if registryId != nil { body["registryId"] = registryId! }
    body["repositoryName"] = repositoryName
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - force: <p>Force the deletion of the repository if it contains images.</p>
      - registryId: <p>The AWS account ID associated with the registry that contains the repository to delete. If you do not specify a registry, the default registry is assumed.</p>
      - repositoryName: <p>The name of the repository to delete.</p>
 */
  public init(force: Bool?, registryId: String?, repositoryName: String) {
self.force = force
self.registryId = registryId
self.repositoryName = repositoryName
  }
}

public struct PutImageResponse: RestJsonDeserializable {
/**
<p>Details of the image uploaded.</p>
 */
  public let image: Image?


  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> PutImageResponse {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return PutImageResponse(
        image: jsonDict["image"].flatMap { ($0 is NSNull) ? nil : Image.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - image: <p>Details of the image uploaded.</p>
 */
  public init(image: Image?) {
self.image = image
  }
}

/**
<p>An object representing a repository.</p>
 */
public struct Repository: RestJsonSerializable, RestJsonDeserializable {
/**
<p>The URI for the repository. You can use this URI for Docker <code>push</code> and <code>pull</code> operations.</p>
 */
  public let repositoryUri: String?
/**
<p>The name of the repository.</p>
 */
  public let repositoryName: String?
/**
<p>The AWS account ID associated with the registry that contains the repository.</p>
 */
  public let registryId: String?
/**
<p>The date and time, in JavaScript date/time format, when the repository was created.</p>
 */
  public let createdAt: Date?
/**
<p>The Amazon Resource Name (ARN) that identifies the repository. The ARN contains the <code>arn:aws:ecr</code> namespace, followed by the region of the repository, the AWS account ID of the repository owner, the repository namespace, and then the repository name. For example, <code>arn:aws:ecr:region:012345678910:repository/test</code>.</p>
 */
  public let repositoryArn: String?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if repositoryUri != nil { body["repositoryUri"] = repositoryUri! }
    if repositoryName != nil { body["repositoryName"] = repositoryName! }
    if registryId != nil { body["registryId"] = registryId! }
    if createdAt != nil { body["createdAt"] = createdAt! }
    if repositoryArn != nil { body["repositoryArn"] = repositoryArn! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Repository {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return Repository(
        repositoryUri: jsonDict["repositoryUri"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      repositoryName: jsonDict["repositoryName"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      registryId: jsonDict["registryId"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      createdAt: jsonDict["createdAt"].flatMap { ($0 is NSNull) ? nil : Date.deserialize(response: response, body: .json($0)) },
      repositoryArn: jsonDict["repositoryArn"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - repositoryUri: <p>The URI for the repository. You can use this URI for Docker <code>push</code> and <code>pull</code> operations.</p>
      - repositoryName: <p>The name of the repository.</p>
      - registryId: <p>The AWS account ID associated with the registry that contains the repository.</p>
      - createdAt: <p>The date and time, in JavaScript date/time format, when the repository was created.</p>
      - repositoryArn: <p>The Amazon Resource Name (ARN) that identifies the repository. The ARN contains the <code>arn:aws:ecr</code> namespace, followed by the region of the repository, the AWS account ID of the repository owner, the repository namespace, and then the repository name. For example, <code>arn:aws:ecr:region:012345678910:repository/test</code>.</p>
 */
  public init(repositoryUri: String?, repositoryName: String?, registryId: String?, createdAt: Date?, repositoryArn: String?) {
self.repositoryUri = repositoryUri
self.repositoryName = repositoryName
self.registryId = registryId
self.createdAt = createdAt
self.repositoryArn = repositoryArn
  }
}

/**
<p>Deletes specified images within a specified repository. Images are specified with either the <code>imageTag</code> or <code>imageDigest</code>.</p>
 */
public struct BatchDeleteImageRequest: RestJsonSerializable {
/**
<p>The AWS account ID associated with the registry that contains the image to delete. If you do not specify a registry, the default registry is assumed.</p>
 */
  public let registryId: String?
/**
<p>A list of image ID references that correspond to images to delete. The format of the <code>imageIds</code> reference is <code>imageTag=tag</code> or <code>imageDigest=digest</code>.</p>
 */
  public let imageIds: [ImageIdentifier]
/**
<p>The repository that contains the image to delete.</p>
 */
  public let repositoryName: String

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if registryId != nil { body["registryId"] = registryId! }
    body["imageIds"] = imageIds
    body["repositoryName"] = repositoryName
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - registryId: <p>The AWS account ID associated with the registry that contains the image to delete. If you do not specify a registry, the default registry is assumed.</p>
      - imageIds: <p>A list of image ID references that correspond to images to delete. The format of the <code>imageIds</code> reference is <code>imageTag=tag</code> or <code>imageDigest=digest</code>.</p>
      - repositoryName: <p>The repository that contains the image to delete.</p>
 */
  public init(registryId: String?, imageIds: [ImageIdentifier], repositoryName: String) {
self.registryId = registryId
self.imageIds = imageIds
self.repositoryName = repositoryName
  }
}

/**
<p>The specified repository contains images. To delete a repository that contains images, you must force the deletion with the <code>force</code> parameter.</p>
 */
public struct RepositoryNotEmptyException: Error, RestJsonDeserializable {
/**
<p>The error message associated with the exception.</p>
 */
  public let message: String?


  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> RepositoryNotEmptyException {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return RepositoryNotEmptyException(
        message: jsonDict["message"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - message: <p>The error message associated with the exception.</p>
 */
  public init(message: String?) {
self.message = message
  }
}




public struct CompleteLayerUploadResponse: RestJsonDeserializable {
/**
<p>The upload ID associated with the layer.</p>
 */
  public let uploadId: String?
/**
<p>The repository name associated with the request.</p>
 */
  public let repositoryName: String?
/**
<p>The registry ID associated with the request.</p>
 */
  public let registryId: String?
/**
<p>The <code>sha256</code> digest of the image layer.</p>
 */
  public let layerDigest: String?


  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> CompleteLayerUploadResponse {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return CompleteLayerUploadResponse(
        uploadId: jsonDict["uploadId"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      repositoryName: jsonDict["repositoryName"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      registryId: jsonDict["registryId"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      layerDigest: jsonDict["layerDigest"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - uploadId: <p>The upload ID associated with the layer.</p>
      - repositoryName: <p>The repository name associated with the request.</p>
      - registryId: <p>The registry ID associated with the request.</p>
      - layerDigest: <p>The <code>sha256</code> digest of the image layer.</p>
 */
  public init(uploadId: String?, repositoryName: String?, registryId: String?, layerDigest: String?) {
self.uploadId = uploadId
self.repositoryName = repositoryName
self.registryId = registryId
self.layerDigest = layerDigest
  }
}



/**
<p>The layer part size is not valid, or the first byte specified is not consecutive to the last byte of a previous layer part upload.</p>
 */
public struct InvalidLayerPartException: Error, RestJsonDeserializable {
/**
<p>The upload ID associated with the exception.</p>
 */
  public let uploadId: String?
/**
<p>The error message associated with the exception.</p>
 */
  public let message: String?
/**
<p>The repository name associated with the exception.</p>
 */
  public let repositoryName: String?
/**
<p>The registry ID associated with the exception.</p>
 */
  public let registryId: String?
/**
<p>The last valid byte received from the layer part upload that is associated with the exception.</p>
 */
  public let lastValidByteReceived: Int?


  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> InvalidLayerPartException {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return InvalidLayerPartException(
        uploadId: jsonDict["uploadId"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      message: jsonDict["message"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      repositoryName: jsonDict["repositoryName"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      registryId: jsonDict["registryId"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      lastValidByteReceived: jsonDict["lastValidByteReceived"].flatMap { ($0 is NSNull) ? nil : Int.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - uploadId: <p>The upload ID associated with the exception.</p>
      - message: <p>The error message associated with the exception.</p>
      - repositoryName: <p>The repository name associated with the exception.</p>
      - registryId: <p>The registry ID associated with the exception.</p>
      - lastValidByteReceived: <p>The last valid byte received from the layer part upload that is associated with the exception.</p>
 */
  public init(uploadId: String?, message: String?, repositoryName: String?, registryId: String?, lastValidByteReceived: Int?) {
self.uploadId = uploadId
self.message = message
self.repositoryName = repositoryName
self.registryId = registryId
self.lastValidByteReceived = lastValidByteReceived
  }
}


public struct UploadLayerPartRequest: RestJsonSerializable {
/**
<p>The upload ID from a previous <a>InitiateLayerUpload</a> operation to associate with the layer part upload.</p>
 */
  public let uploadId: String
/**
<p>The base64-encoded layer part payload.</p>
 */
  public let layerPartBlob: Data
/**
<p>The name of the repository that you are uploading layer parts to.</p>
 */
  public let repositoryName: String
/**
<p>The integer value of the last byte of the layer part.</p>
 */
  public let partLastByte: Int
/**
<p>The AWS account ID associated with the registry that you are uploading layer parts to. If you do not specify a registry, the default registry is assumed.</p>
 */
  public let registryId: String?
/**
<p>The integer value of the first byte of the layer part.</p>
 */
  public let partFirstByte: Int

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["uploadId"] = uploadId
    body["layerPartBlob"] = layerPartBlob
    body["repositoryName"] = repositoryName
    body["partLastByte"] = partLastByte
    if registryId != nil { body["registryId"] = registryId! }
    body["partFirstByte"] = partFirstByte
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - uploadId: <p>The upload ID from a previous <a>InitiateLayerUpload</a> operation to associate with the layer part upload.</p>
      - layerPartBlob: <p>The base64-encoded layer part payload.</p>
      - repositoryName: <p>The name of the repository that you are uploading layer parts to.</p>
      - partLastByte: <p>The integer value of the last byte of the layer part.</p>
      - registryId: <p>The AWS account ID associated with the registry that you are uploading layer parts to. If you do not specify a registry, the default registry is assumed.</p>
      - partFirstByte: <p>The integer value of the first byte of the layer part.</p>
 */
  public init(uploadId: String, layerPartBlob: Data, repositoryName: String, partLastByte: Int, registryId: String?, partFirstByte: Int) {
self.uploadId = uploadId
self.layerPartBlob = layerPartBlob
self.repositoryName = repositoryName
self.partLastByte = partLastByte
self.registryId = registryId
self.partFirstByte = partFirstByte
  }
}


public struct CompleteLayerUploadRequest: RestJsonSerializable {
/**
<p>The upload ID from a previous <a>InitiateLayerUpload</a> operation to associate with the image layer.</p>
 */
  public let uploadId: String
/**
<p>The name of the repository to associate with the image layer.</p>
 */
  public let repositoryName: String
/**
<p>The AWS account ID associated with the registry to which to upload layers. If you do not specify a registry, the default registry is assumed.</p>
 */
  public let registryId: String?
/**
<p>The <code>sha256</code> digest of the image layer.</p>
 */
  public let layerDigests: [String]

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["uploadId"] = uploadId
    body["repositoryName"] = repositoryName
    if registryId != nil { body["registryId"] = registryId! }
    body["layerDigests"] = layerDigests
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - uploadId: <p>The upload ID from a previous <a>InitiateLayerUpload</a> operation to associate with the image layer.</p>
      - repositoryName: <p>The name of the repository to associate with the image layer.</p>
      - registryId: <p>The AWS account ID associated with the registry to which to upload layers. If you do not specify a registry, the default registry is assumed.</p>
      - layerDigests: <p>The <code>sha256</code> digest of the image layer.</p>
 */
  public init(uploadId: String, repositoryName: String, registryId: String?, layerDigests: [String]) {
self.uploadId = uploadId
self.repositoryName = repositoryName
self.registryId = registryId
self.layerDigests = layerDigests
  }
}

enum Tagstatus: String, RestJsonDeserializable, RestJsonSerializable {
  case `tAGGED` = "TAGGED"
  case `uNTAGGED` = "UNTAGGED"

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Tagstatus {
    guard case let .json(json) = body else { fatalError() }
    return Tagstatus(rawValue: json as! String)!
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}


/**
<p>An object representing a filter on a <a>DescribeImages</a> operation.</p>
 */
public struct DescribeImagesFilter: RestJsonSerializable, RestJsonDeserializable {
/**
<p>The tag status with which to filter your <a>DescribeImages</a> results. You can filter results based on whether they are <code>TAGGED</code> or <code>UNTAGGED</code>.</p>
 */
  public let tagStatus: Tagstatus?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if tagStatus != nil { body["tagStatus"] = tagStatus! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> DescribeImagesFilter {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return DescribeImagesFilter(
        tagStatus: jsonDict["tagStatus"].flatMap { ($0 is NSNull) ? nil : Tagstatus.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - tagStatus: <p>The tag status with which to filter your <a>DescribeImages</a> results. You can filter results based on whether they are <code>TAGGED</code> or <code>UNTAGGED</code>.</p>
 */
  public init(tagStatus: Tagstatus?) {
self.tagStatus = tagStatus
  }
}



public struct ListImagesRequest: RestJsonSerializable {
/**
<p>The <code>nextToken</code> value returned from a previous paginated <code>ListImages</code> request where <code>maxResults</code> was used and the results exceeded the value of that parameter. Pagination continues from the end of the previous results that returned the <code>nextToken</code> value. This value is <code>null</code> when there are no more results to return.</p> <note> <p>This token should be treated as an opaque identifier that is only used to retrieve the next items in a list and not for other programmatic purposes.</p> </note>
 */
  public let nextToken: String?
/**
<p>The maximum number of image results returned by <code>ListImages</code> in paginated output. When this parameter is used, <code>ListImages</code> only returns <code>maxResults</code> results in a single page along with a <code>nextToken</code> response element. The remaining results of the initial request can be seen by sending another <code>ListImages</code> request with the returned <code>nextToken</code> value. This value can be between 1 and 100. If this parameter is not used, then <code>ListImages</code> returns up to 100 results and a <code>nextToken</code> value, if applicable.</p>
 */
  public let maxResults: Int?
/**
<p>The filter key and value with which to filter your <code>ListImages</code> results.</p>
 */
  public let filter: ListImagesFilter?
/**
<p>The repository whose image IDs are to be listed.</p>
 */
  public let repositoryName: String
/**
<p>The AWS account ID associated with the registry that contains the repository to list images in. If you do not specify a registry, the default registry is assumed.</p>
 */
  public let registryId: String?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if nextToken != nil { body["nextToken"] = nextToken! }
    if maxResults != nil { body["maxResults"] = maxResults! }
    if filter != nil { body["filter"] = filter! }
    body["repositoryName"] = repositoryName
    if registryId != nil { body["registryId"] = registryId! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - nextToken: <p>The <code>nextToken</code> value returned from a previous paginated <code>ListImages</code> request where <code>maxResults</code> was used and the results exceeded the value of that parameter. Pagination continues from the end of the previous results that returned the <code>nextToken</code> value. This value is <code>null</code> when there are no more results to return.</p> <note> <p>This token should be treated as an opaque identifier that is only used to retrieve the next items in a list and not for other programmatic purposes.</p> </note>
      - maxResults: <p>The maximum number of image results returned by <code>ListImages</code> in paginated output. When this parameter is used, <code>ListImages</code> only returns <code>maxResults</code> results in a single page along with a <code>nextToken</code> response element. The remaining results of the initial request can be seen by sending another <code>ListImages</code> request with the returned <code>nextToken</code> value. This value can be between 1 and 100. If this parameter is not used, then <code>ListImages</code> returns up to 100 results and a <code>nextToken</code> value, if applicable.</p>
      - filter: <p>The filter key and value with which to filter your <code>ListImages</code> results.</p>
      - repositoryName: <p>The repository whose image IDs are to be listed.</p>
      - registryId: <p>The AWS account ID associated with the registry that contains the repository to list images in. If you do not specify a registry, the default registry is assumed.</p>
 */
  public init(nextToken: String?, maxResults: Int?, filter: ListImagesFilter?, repositoryName: String, registryId: String?) {
self.nextToken = nextToken
self.maxResults = maxResults
self.filter = filter
self.repositoryName = repositoryName
self.registryId = registryId
  }
}


}
