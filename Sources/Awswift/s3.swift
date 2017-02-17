import Foundation
import Signer

struct s3 {
    struct Client {
        let region: String
        let credentialsProvider: AwsCredentialsProvider
        let session: URLSession
        let queue: DispatchQueue

        init(region: String) {
            self.region = region
            self.credentialsProvider = DefaultChainProvider()
            self.session = URLSession(configuration: URLSessionConfiguration.default)
            self.queue = DispatchQueue(label: "awswift.s3.Client.queue")
        }

        func scope() -> AwsCredentialsScope {
           return AwsCredentialsScope(url: baseURL())!
        }

        func credentials() -> AwsCredentials {
            return credentialsProvider.provideAwsCredentials()!
        }

        func baseURL() -> URL {
            return URL(string: "https://s3-\(region).amazonaws.com/")!
        }

        func awsApiCallTask<O: AwswiftDeserializable>(request: RestXmlRequest, completionHandler: @escaping (_: O?, _: Error?) -> ()) -> URLSessionTask {
            let unsignedRequest = RestXmlRequestSerializer(input: request, baseURL: baseURL())
            let httpRequest = dateAndSignRequest(request: unsignedRequest, credentials: credentials(), scope: scope())
            
            return session.dataTask(with: httpRequest, completionHandler: { (data, response, error) in
                self.queue.async {
                    let http = response as! HTTPURLResponse
                    if error != nil {
                        completionHandler(nil, error)
                    } else if 200..<300 ~= http.statusCode {
                        let doc = try! XMLDocument(data: data!, options: 0)
                        let root = doc.rootElement()!
                        let hackRoot = root.child(at: 0)
                        let ret = O.deserialize(response: http, body: hackRoot)
                        completionHandler(ret, nil)
                    } else {
                        completionHandler(nil, UnexpectedStatusResponse(response: http, data: data))
                    }
                }
            })
        }

        
        func AbortMultipartUpload(input: AbortMultipartUploadRequest, completionHandler: @escaping (_: AbortMultipartUploadOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "DELETE",
                relativeUrl: "/{Bucket}/{Key+}",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func CompleteMultipartUpload(input: CompleteMultipartUploadRequest, completionHandler: @escaping (_: CompleteMultipartUploadOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "POST",
                relativeUrl: "/{Bucket}/{Key+}",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func CopyObject(input: CopyObjectRequest, completionHandler: @escaping (_: CopyObjectOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "PUT",
                relativeUrl: "/{Bucket}/{Key+}",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func CreateBucket(input: CreateBucketRequest, completionHandler: @escaping (_: CreateBucketOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "PUT",
                relativeUrl: "/{Bucket}",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func CreateMultipartUpload(input: CreateMultipartUploadRequest, completionHandler: @escaping (_: CreateMultipartUploadOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "POST",
                relativeUrl: "/{Bucket}/{Key+}?uploads",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func DeleteBucket(input: DeleteBucketRequest, completionHandler: @escaping (_: AwsApiVoidOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "DELETE",
                relativeUrl: "/{Bucket}",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func DeleteBucketCors(input: DeleteBucketCorsRequest, completionHandler: @escaping (_: AwsApiVoidOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "DELETE",
                relativeUrl: "/{Bucket}?cors",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func DeleteBucketLifecycle(input: DeleteBucketLifecycleRequest, completionHandler: @escaping (_: AwsApiVoidOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "DELETE",
                relativeUrl: "/{Bucket}?lifecycle",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func DeleteBucketPolicy(input: DeleteBucketPolicyRequest, completionHandler: @escaping (_: AwsApiVoidOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "DELETE",
                relativeUrl: "/{Bucket}?policy",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func DeleteBucketReplication(input: DeleteBucketReplicationRequest, completionHandler: @escaping (_: AwsApiVoidOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "DELETE",
                relativeUrl: "/{Bucket}?replication",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func DeleteBucketTagging(input: DeleteBucketTaggingRequest, completionHandler: @escaping (_: AwsApiVoidOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "DELETE",
                relativeUrl: "/{Bucket}?tagging",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func DeleteBucketWebsite(input: DeleteBucketWebsiteRequest, completionHandler: @escaping (_: AwsApiVoidOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "DELETE",
                relativeUrl: "/{Bucket}?website",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func DeleteObject(input: DeleteObjectRequest, completionHandler: @escaping (_: DeleteObjectOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "DELETE",
                relativeUrl: "/{Bucket}/{Key+}",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func DeleteObjects(input: DeleteObjectsRequest, completionHandler: @escaping (_: DeleteObjectsOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "POST",
                relativeUrl: "/{Bucket}?delete",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func GetBucketAccelerateConfiguration(input: GetBucketAccelerateConfigurationRequest, completionHandler: @escaping (_: GetBucketAccelerateConfigurationOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "GET",
                relativeUrl: "/{Bucket}?accelerate",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func GetBucketAcl(input: GetBucketAclRequest, completionHandler: @escaping (_: GetBucketAclOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "GET",
                relativeUrl: "/{Bucket}?acl",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func GetBucketCors(input: GetBucketCorsRequest, completionHandler: @escaping (_: GetBucketCorsOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "GET",
                relativeUrl: "/{Bucket}?cors",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func GetBucketLifecycle(input: GetBucketLifecycleRequest, completionHandler: @escaping (_: GetBucketLifecycleOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "GET",
                relativeUrl: "/{Bucket}?lifecycle",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func GetBucketLifecycleConfiguration(input: GetBucketLifecycleConfigurationRequest, completionHandler: @escaping (_: GetBucketLifecycleConfigurationOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "GET",
                relativeUrl: "/{Bucket}?lifecycle",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func GetBucketLocation(input: GetBucketLocationRequest, completionHandler: @escaping (_: GetBucketLocationOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "GET",
                relativeUrl: "/{Bucket}?location",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func GetBucketLogging(input: GetBucketLoggingRequest, completionHandler: @escaping (_: GetBucketLoggingOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "GET",
                relativeUrl: "/{Bucket}?logging",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func GetBucketNotification(input: GetBucketNotificationConfigurationRequest, completionHandler: @escaping (_: NotificationConfigurationDeprecated?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "GET",
                relativeUrl: "/{Bucket}?notification",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func GetBucketNotificationConfiguration(input: GetBucketNotificationConfigurationRequest, completionHandler: @escaping (_: NotificationConfiguration?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "GET",
                relativeUrl: "/{Bucket}?notification",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func GetBucketPolicy(input: GetBucketPolicyRequest, completionHandler: @escaping (_: GetBucketPolicyOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "GET",
                relativeUrl: "/{Bucket}?policy",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func GetBucketReplication(input: GetBucketReplicationRequest, completionHandler: @escaping (_: GetBucketReplicationOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "GET",
                relativeUrl: "/{Bucket}?replication",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func GetBucketRequestPayment(input: GetBucketRequestPaymentRequest, completionHandler: @escaping (_: GetBucketRequestPaymentOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "GET",
                relativeUrl: "/{Bucket}?requestPayment",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func GetBucketTagging(input: GetBucketTaggingRequest, completionHandler: @escaping (_: GetBucketTaggingOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "GET",
                relativeUrl: "/{Bucket}?tagging",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func GetBucketVersioning(input: GetBucketVersioningRequest, completionHandler: @escaping (_: GetBucketVersioningOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "GET",
                relativeUrl: "/{Bucket}?versioning",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func GetBucketWebsite(input: GetBucketWebsiteRequest, completionHandler: @escaping (_: GetBucketWebsiteOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "GET",
                relativeUrl: "/{Bucket}?website",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func GetObject(input: GetObjectRequest, completionHandler: @escaping (_: GetObjectOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "GET",
                relativeUrl: "/{Bucket}/{Key+}",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func GetObjectAcl(input: GetObjectAclRequest, completionHandler: @escaping (_: GetObjectAclOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "GET",
                relativeUrl: "/{Bucket}/{Key+}?acl",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func GetObjectTorrent(input: GetObjectTorrentRequest, completionHandler: @escaping (_: GetObjectTorrentOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "GET",
                relativeUrl: "/{Bucket}/{Key+}?torrent",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func HeadBucket(input: HeadBucketRequest, completionHandler: @escaping (_: AwsApiVoidOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "HEAD",
                relativeUrl: "/{Bucket}",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func HeadObject(input: HeadObjectRequest, completionHandler: @escaping (_: HeadObjectOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "HEAD",
                relativeUrl: "/{Bucket}/{Key+}",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func ListBuckets(input: AwsApiVoidInput, completionHandler: @escaping (_: ListBucketsOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "GET",
                relativeUrl: "/",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func ListMultipartUploads(input: ListMultipartUploadsRequest, completionHandler: @escaping (_: ListMultipartUploadsOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "GET",
                relativeUrl: "/{Bucket}?uploads",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func ListObjectVersions(input: ListObjectVersionsRequest, completionHandler: @escaping (_: ListObjectVersionsOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "GET",
                relativeUrl: "/{Bucket}?versions",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func ListObjects(input: ListObjectsRequest, completionHandler: @escaping (_: ListObjectsOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "GET",
                relativeUrl: "/{Bucket}",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func ListObjectsV2(input: ListObjectsV2Request, completionHandler: @escaping (_: ListObjectsV2Output?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "GET",
                relativeUrl: "/{Bucket}?list-type=2",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func ListParts(input: ListPartsRequest, completionHandler: @escaping (_: ListPartsOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "GET",
                relativeUrl: "/{Bucket}/{Key+}",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func PutBucketAccelerateConfiguration(input: PutBucketAccelerateConfigurationRequest, completionHandler: @escaping (_: AwsApiVoidOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "PUT",
                relativeUrl: "/{Bucket}?accelerate",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func PutBucketAcl(input: PutBucketAclRequest, completionHandler: @escaping (_: AwsApiVoidOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "PUT",
                relativeUrl: "/{Bucket}?acl",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func PutBucketCors(input: PutBucketCorsRequest, completionHandler: @escaping (_: AwsApiVoidOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "PUT",
                relativeUrl: "/{Bucket}?cors",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func PutBucketLifecycle(input: PutBucketLifecycleRequest, completionHandler: @escaping (_: AwsApiVoidOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "PUT",
                relativeUrl: "/{Bucket}?lifecycle",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func PutBucketLifecycleConfiguration(input: PutBucketLifecycleConfigurationRequest, completionHandler: @escaping (_: AwsApiVoidOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "PUT",
                relativeUrl: "/{Bucket}?lifecycle",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func PutBucketLogging(input: PutBucketLoggingRequest, completionHandler: @escaping (_: AwsApiVoidOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "PUT",
                relativeUrl: "/{Bucket}?logging",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func PutBucketNotification(input: PutBucketNotificationRequest, completionHandler: @escaping (_: AwsApiVoidOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "PUT",
                relativeUrl: "/{Bucket}?notification",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func PutBucketNotificationConfiguration(input: PutBucketNotificationConfigurationRequest, completionHandler: @escaping (_: AwsApiVoidOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "PUT",
                relativeUrl: "/{Bucket}?notification",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func PutBucketPolicy(input: PutBucketPolicyRequest, completionHandler: @escaping (_: AwsApiVoidOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "PUT",
                relativeUrl: "/{Bucket}?policy",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func PutBucketReplication(input: PutBucketReplicationRequest, completionHandler: @escaping (_: AwsApiVoidOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "PUT",
                relativeUrl: "/{Bucket}?replication",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func PutBucketRequestPayment(input: PutBucketRequestPaymentRequest, completionHandler: @escaping (_: AwsApiVoidOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "PUT",
                relativeUrl: "/{Bucket}?requestPayment",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func PutBucketTagging(input: PutBucketTaggingRequest, completionHandler: @escaping (_: AwsApiVoidOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "PUT",
                relativeUrl: "/{Bucket}?tagging",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func PutBucketVersioning(input: PutBucketVersioningRequest, completionHandler: @escaping (_: AwsApiVoidOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "PUT",
                relativeUrl: "/{Bucket}?versioning",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func PutBucketWebsite(input: PutBucketWebsiteRequest, completionHandler: @escaping (_: AwsApiVoidOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "PUT",
                relativeUrl: "/{Bucket}?website",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func PutObject(input: PutObjectRequest, completionHandler: @escaping (_: PutObjectOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "PUT",
                relativeUrl: "/{Bucket}/{Key+}",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func PutObjectAcl(input: PutObjectAclRequest, completionHandler: @escaping (_: PutObjectAclOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "PUT",
                relativeUrl: "/{Bucket}/{Key+}?acl",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func RestoreObject(input: RestoreObjectRequest, completionHandler: @escaping (_: RestoreObjectOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "POST",
                relativeUrl: "/{Bucket}/{Key+}?restore",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func UploadPart(input: UploadPartRequest, completionHandler: @escaping (_: UploadPartOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "PUT",
                relativeUrl: "/{Bucket}/{Key+}",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func UploadPartCopy(input: UploadPartCopyRequest, completionHandler: @escaping (_: UploadPartCopyOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restXmlSerialize()

            let request = RestXmlRequest(
                method: "PUT",
                relativeUrl: "/{Bucket}/{Key+}",
                node: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
    }

    
    struct AbortIncompleteMultipartUpload: RestXmlSerializable, AwswiftDeserializable {
        public let daysafterinitiation: Int?
        

        init(
            daysafterinitiation: Int?
            
        ) {
            self.daysafterinitiation = daysafterinitiation
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(daysafterinitiation?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> AbortIncompleteMultipartUpload {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let daysafterinitiation = try! body.nodes(forXPath: "DaysAfterInitiation").first.flatMapNoNulls { v in
                return Int.deserialize(response: response, body: v)
            }
            

            return AbortIncompleteMultipartUpload(
                
                daysafterinitiation: daysafterinitiation
                
            )
        }
        
    }
    
    struct AbortMultipartUploadOutput: RestXmlSerializable, AwswiftDeserializable {
        public let requestcharged: RequestCharged?
        

        init(
            requestcharged: RequestCharged?
            
        ) {
            self.requestcharged = requestcharged
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            element.addChild(requestcharged?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> AbortMultipartUploadOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let requestcharged = try! body.nodes(forXPath: "x-amz-request-charged").first.flatMapNoNulls { v in
                return RequestCharged.deserialize(response: response, body: v)
            }
            

            return AbortMultipartUploadOutput(
                
                requestcharged: requestcharged
                
            )
        }
        
    }
    
    struct AbortMultipartUploadRequest: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String
        public let key: String
        public let requestpayer: RequestPayer?
        public let uploadid: String
        

        init(
            bucket: String,
            key: String,
            requestpayer: RequestPayer?,
            uploadid: String
            
        ) {
            self.bucket = bucket
            self.key = key
            self.requestpayer = requestpayer
            self.uploadid = uploadid
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(bucket.restXmlSerialize().node)
            
            element.addChild(key.restXmlSerialize().node)
            
            element.addChild(requestpayer?.restXmlSerialize().node)
            
            element.addChild(uploadid.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> AbortMultipartUploadRequest {
            fatalError()
        }
        
        
    }
    
    struct AccelerateConfiguration: RestXmlSerializable, AwswiftDeserializable {
        public let status: BucketAccelerateStatus?
        

        init(
            status: BucketAccelerateStatus?
            
        ) {
            self.status = status
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(status?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> AccelerateConfiguration {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let status = try! body.nodes(forXPath: "Status").first.flatMapNoNulls { v in
                return BucketAccelerateStatus.deserialize(response: response, body: v)
            }
            

            return AccelerateConfiguration(
                
                status: status
                
            )
        }
        
    }
    
    struct AccessControlPolicy: RestXmlSerializable, AwswiftDeserializable {
        public let grants: [Grant]?
        public let owner: Owner?
        

        init(
            grants: [Grant]?,
            owner: Owner?
            
        ) {
            self.grants = grants
            self.owner = owner
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(grants?.restXmlSerialize().node)
            
            element.addChild(owner?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> AccessControlPolicy {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let grants = try! body.nodes(forXPath: "AccessControlList").first.flatMapNoNulls { v in
                return [Grant].deserialize(response: response, body: v)
            }
            
            let owner = try! body.nodes(forXPath: "Owner").first.flatMapNoNulls { v in
                return Owner.deserialize(response: response, body: v)
            }
            

            return AccessControlPolicy(
                
                grants: grants,
                
                owner: owner
                
            )
        }
        
    }
    
    struct Bucket: RestXmlSerializable, AwswiftDeserializable {
        public let creationdate: Date?
        public let name: String?
        

        init(
            creationdate: Date?,
            name: String?
            
        ) {
            self.creationdate = creationdate
            self.name = name
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(creationdate?.restXmlSerialize().node)
            
            element.addChild(name?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> Bucket {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let creationdate = try! body.nodes(forXPath: "CreationDate").first.flatMapNoNulls { v in
                return Date.deserialize(response: response, body: v)
            }
            
            let name = try! body.nodes(forXPath: "Name").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return Bucket(
                
                creationdate: creationdate,
                
                name: name
                
            )
        }
        
    }
    
    struct BucketAlreadyExists: RestXmlSerializable, AwswiftDeserializable {
        

        init(
            
        ) {
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            return .object([:])
            
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> BucketAlreadyExists {
            guard let body = body as? XMLElement else { fatalError() }
            
            

            return BucketAlreadyExists(
                
            )
        }
        
    }
    
    struct BucketAlreadyOwnedByYou: RestXmlSerializable, AwswiftDeserializable {
        

        init(
            
        ) {
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            return .object([:])
            
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> BucketAlreadyOwnedByYou {
            guard let body = body as? XMLElement else { fatalError() }
            
            

            return BucketAlreadyOwnedByYou(
                
            )
        }
        
    }
    
    struct BucketLifecycleConfiguration: RestXmlSerializable, AwswiftDeserializable {
        public let rules: [LifecycleRule]
        

        init(
            rules: [LifecycleRule]
            
        ) {
            self.rules = rules
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(rules.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> BucketLifecycleConfiguration {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let rules = try! body.nodes(forXPath: "Rule").first.flatMapNoNulls { v in
                return [LifecycleRule].deserialize(response: response, body: v)
            }
            

            return BucketLifecycleConfiguration(
                
                rules: rules!
                
            )
        }
        
    }
    
    struct BucketLoggingStatus: RestXmlSerializable, AwswiftDeserializable {
        public let loggingenabled: LoggingEnabled?
        

        init(
            loggingenabled: LoggingEnabled?
            
        ) {
            self.loggingenabled = loggingenabled
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(loggingenabled?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> BucketLoggingStatus {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let loggingenabled = try! body.nodes(forXPath: "LoggingEnabled").first.flatMapNoNulls { v in
                return LoggingEnabled.deserialize(response: response, body: v)
            }
            

            return BucketLoggingStatus(
                
                loggingenabled: loggingenabled
                
            )
        }
        
    }
    
    struct CORSConfiguration: RestXmlSerializable, AwswiftDeserializable {
        public let corsrules: [CORSRule]
        

        init(
            corsrules: [CORSRule]
            
        ) {
            self.corsrules = corsrules
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(corsrules.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> CORSConfiguration {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let corsrules = try! body.nodes(forXPath: "CORSRule").first.flatMapNoNulls { v in
                return [CORSRule].deserialize(response: response, body: v)
            }
            

            return CORSConfiguration(
                
                corsrules: corsrules!
                
            )
        }
        
    }
    
    struct CORSRule: RestXmlSerializable, AwswiftDeserializable {
        public let allowedheaders: [String]?
        public let allowedmethods: [String]
        public let allowedorigins: [String]
        public let exposeheaders: [String]?
        public let maxageseconds: Int?
        

        init(
            allowedheaders: [String]?,
            allowedmethods: [String],
            allowedorigins: [String],
            exposeheaders: [String]?,
            maxageseconds: Int?
            
        ) {
            self.allowedheaders = allowedheaders
            self.allowedmethods = allowedmethods
            self.allowedorigins = allowedorigins
            self.exposeheaders = exposeheaders
            self.maxageseconds = maxageseconds
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(allowedheaders?.restXmlSerialize().node)
            
            element.addChild(allowedmethods.restXmlSerialize().node)
            
            element.addChild(allowedorigins.restXmlSerialize().node)
            
            element.addChild(exposeheaders?.restXmlSerialize().node)
            
            element.addChild(maxageseconds?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> CORSRule {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let allowedheaders = try! body.nodes(forXPath: "AllowedHeader").first.flatMapNoNulls { v in
                return [String].deserialize(response: response, body: v)
            }
            
            let allowedmethods = try! body.nodes(forXPath: "AllowedMethod").first.flatMapNoNulls { v in
                return [String].deserialize(response: response, body: v)
            }
            
            let allowedorigins = try! body.nodes(forXPath: "AllowedOrigin").first.flatMapNoNulls { v in
                return [String].deserialize(response: response, body: v)
            }
            
            let exposeheaders = try! body.nodes(forXPath: "ExposeHeader").first.flatMapNoNulls { v in
                return [String].deserialize(response: response, body: v)
            }
            
            let maxageseconds = try! body.nodes(forXPath: "MaxAgeSeconds").first.flatMapNoNulls { v in
                return Int.deserialize(response: response, body: v)
            }
            

            return CORSRule(
                
                allowedheaders: allowedheaders,
                
                allowedmethods: allowedmethods!,
                
                allowedorigins: allowedorigins!,
                
                exposeheaders: exposeheaders,
                
                maxageseconds: maxageseconds
                
            )
        }
        
    }
    
    struct CloudFunctionConfiguration: RestXmlSerializable, AwswiftDeserializable {
        public let cloudfunction: String?
        public let event: Event?
        public let events: [Event]?
        public let id: String?
        public let invocationrole: String?
        

        init(
            cloudfunction: String?,
            event: Event?,
            events: [Event]?,
            id: String?,
            invocationrole: String?
            
        ) {
            self.cloudfunction = cloudfunction
            self.event = event
            self.events = events
            self.id = id
            self.invocationrole = invocationrole
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(cloudfunction?.restXmlSerialize().node)
            
            element.addChild(event?.restXmlSerialize().node)
            
            element.addChild(events?.restXmlSerialize().node)
            
            element.addChild(id?.restXmlSerialize().node)
            
            element.addChild(invocationrole?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> CloudFunctionConfiguration {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let cloudfunction = try! body.nodes(forXPath: "CloudFunction").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let event = try! body.nodes(forXPath: "Event").first.flatMapNoNulls { v in
                return Event.deserialize(response: response, body: v)
            }
            
            let events = try! body.nodes(forXPath: "Event").first.flatMapNoNulls { v in
                return [Event].deserialize(response: response, body: v)
            }
            
            let id = try! body.nodes(forXPath: "Id").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let invocationrole = try! body.nodes(forXPath: "InvocationRole").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return CloudFunctionConfiguration(
                
                cloudfunction: cloudfunction,
                
                event: event,
                
                events: events,
                
                id: id,
                
                invocationrole: invocationrole
                
            )
        }
        
    }
    
    struct CommonPrefix: RestXmlSerializable, AwswiftDeserializable {
        public let prefix: String?
        

        init(
            prefix: String?
            
        ) {
            self.prefix = prefix
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(prefix?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> CommonPrefix {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let prefix = try! body.nodes(forXPath: "Prefix").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return CommonPrefix(
                
                prefix: prefix
                
            )
        }
        
    }
    
    struct CompleteMultipartUploadOutput: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String?
        public let etag: String?
        public let expiration: String?
        public let key: String?
        public let location: String?
        public let requestcharged: RequestCharged?
        public let ssekmskeyid: String?
        public let serversideencryption: ServerSideEncryption?
        public let versionid: String?
        

        init(
            bucket: String?,
            etag: String?,
            expiration: String?,
            key: String?,
            location: String?,
            requestcharged: RequestCharged?,
            ssekmskeyid: String?,
            serversideencryption: ServerSideEncryption?,
            versionid: String?
            
        ) {
            self.bucket = bucket
            self.etag = etag
            self.expiration = expiration
            self.key = key
            self.location = location
            self.requestcharged = requestcharged
            self.ssekmskeyid = ssekmskeyid
            self.serversideencryption = serversideencryption
            self.versionid = versionid
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            element.addChild(bucket?.restXmlSerialize().node)
            
            element.addChild(etag?.restXmlSerialize().node)
            
            element.addChild(expiration?.restXmlSerialize().node)
            
            element.addChild(key?.restXmlSerialize().node)
            
            element.addChild(location?.restXmlSerialize().node)
            
            element.addChild(requestcharged?.restXmlSerialize().node)
            
            element.addChild(ssekmskeyid?.restXmlSerialize().node)
            
            element.addChild(serversideencryption?.restXmlSerialize().node)
            
            element.addChild(versionid?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> CompleteMultipartUploadOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let bucket = try! body.nodes(forXPath: "Bucket").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let etag = try! body.nodes(forXPath: "ETag").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let expiration = try! body.nodes(forXPath: "x-amz-expiration").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let key = try! body.nodes(forXPath: "Key").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let location = try! body.nodes(forXPath: "Location").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let requestcharged = try! body.nodes(forXPath: "x-amz-request-charged").first.flatMapNoNulls { v in
                return RequestCharged.deserialize(response: response, body: v)
            }
            
            let ssekmskeyid = try! body.nodes(forXPath: "x-amz-server-side-encryption-aws-kms-key-id").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let serversideencryption = try! body.nodes(forXPath: "x-amz-server-side-encryption").first.flatMapNoNulls { v in
                return ServerSideEncryption.deserialize(response: response, body: v)
            }
            
            let versionid = try! body.nodes(forXPath: "x-amz-version-id").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return CompleteMultipartUploadOutput(
                
                bucket: bucket,
                
                etag: etag,
                
                expiration: expiration,
                
                key: key,
                
                location: location,
                
                requestcharged: requestcharged,
                
                ssekmskeyid: ssekmskeyid,
                
                serversideencryption: serversideencryption,
                
                versionid: versionid
                
            )
        }
        
    }
    
    struct CompleteMultipartUploadRequest: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String
        public let key: String
        public let multipartupload: CompletedMultipartUpload?
        public let requestpayer: RequestPayer?
        public let uploadid: String
        

        init(
            bucket: String,
            key: String,
            multipartupload: CompletedMultipartUpload?,
            requestpayer: RequestPayer?,
            uploadid: String
            
        ) {
            self.bucket = bucket
            self.key = key
            self.multipartupload = multipartupload
            self.requestpayer = requestpayer
            self.uploadid = uploadid
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(bucket.restXmlSerialize().node)
            
            element.addChild(key.restXmlSerialize().node)
            
            element.addChild(multipartupload?.restXmlSerialize().node)
            
            element.addChild(requestpayer?.restXmlSerialize().node)
            
            element.addChild(uploadid.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> CompleteMultipartUploadRequest {
            fatalError()
        }
        
        
    }
    
    struct CompletedMultipartUpload: RestXmlSerializable, AwswiftDeserializable {
        public let parts: [CompletedPart]?
        

        init(
            parts: [CompletedPart]?
            
        ) {
            self.parts = parts
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(parts?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> CompletedMultipartUpload {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let parts = try! body.nodes(forXPath: "Part").first.flatMapNoNulls { v in
                return [CompletedPart].deserialize(response: response, body: v)
            }
            

            return CompletedMultipartUpload(
                
                parts: parts
                
            )
        }
        
    }
    
    struct CompletedPart: RestXmlSerializable, AwswiftDeserializable {
        public let etag: String?
        public let partnumber: Int?
        

        init(
            etag: String?,
            partnumber: Int?
            
        ) {
            self.etag = etag
            self.partnumber = partnumber
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(etag?.restXmlSerialize().node)
            
            element.addChild(partnumber?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> CompletedPart {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let etag = try! body.nodes(forXPath: "ETag").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let partnumber = try! body.nodes(forXPath: "PartNumber").first.flatMapNoNulls { v in
                return Int.deserialize(response: response, body: v)
            }
            

            return CompletedPart(
                
                etag: etag,
                
                partnumber: partnumber
                
            )
        }
        
    }
    
    struct Condition: RestXmlSerializable, AwswiftDeserializable {
        public let httperrorcodereturnedequals: String?
        public let keyprefixequals: String?
        

        init(
            httperrorcodereturnedequals: String?,
            keyprefixequals: String?
            
        ) {
            self.httperrorcodereturnedequals = httperrorcodereturnedequals
            self.keyprefixequals = keyprefixequals
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(httperrorcodereturnedequals?.restXmlSerialize().node)
            
            element.addChild(keyprefixequals?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> Condition {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let httperrorcodereturnedequals = try! body.nodes(forXPath: "HttpErrorCodeReturnedEquals").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let keyprefixequals = try! body.nodes(forXPath: "KeyPrefixEquals").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return Condition(
                
                httperrorcodereturnedequals: httperrorcodereturnedequals,
                
                keyprefixequals: keyprefixequals
                
            )
        }
        
    }
    
    struct CopyObjectOutput: RestXmlSerializable, AwswiftDeserializable {
        public let copyobjectresult: CopyObjectResult?
        public let copysourceversionid: String?
        public let expiration: String?
        public let requestcharged: RequestCharged?
        public let ssecustomeralgorithm: String?
        public let ssecustomerkeymd5: String?
        public let ssekmskeyid: String?
        public let serversideencryption: ServerSideEncryption?
        public let versionid: String?
        

        init(
            copyobjectresult: CopyObjectResult?,
            copysourceversionid: String?,
            expiration: String?,
            requestcharged: RequestCharged?,
            ssecustomeralgorithm: String?,
            ssecustomerkeymd5: String?,
            ssekmskeyid: String?,
            serversideencryption: ServerSideEncryption?,
            versionid: String?
            
        ) {
            self.copyobjectresult = copyobjectresult
            self.copysourceversionid = copysourceversionid
            self.expiration = expiration
            self.requestcharged = requestcharged
            self.ssecustomeralgorithm = ssecustomeralgorithm
            self.ssecustomerkeymd5 = ssecustomerkeymd5
            self.ssekmskeyid = ssekmskeyid
            self.serversideencryption = serversideencryption
            self.versionid = versionid
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            element.addChild(copyobjectresult?.restXmlSerialize().node)
            
            element.addChild(copysourceversionid?.restXmlSerialize().node)
            
            element.addChild(expiration?.restXmlSerialize().node)
            
            element.addChild(requestcharged?.restXmlSerialize().node)
            
            element.addChild(ssecustomeralgorithm?.restXmlSerialize().node)
            
            element.addChild(ssecustomerkeymd5?.restXmlSerialize().node)
            
            element.addChild(ssekmskeyid?.restXmlSerialize().node)
            
            element.addChild(serversideencryption?.restXmlSerialize().node)
            
            element.addChild(versionid?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> CopyObjectOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let copyobjectresult = try! body.nodes(forXPath: "CopyObjectResult").first.flatMapNoNulls { v in
                return CopyObjectResult.deserialize(response: response, body: v)
            }
            
            let copysourceversionid = try! body.nodes(forXPath: "x-amz-copy-source-version-id").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let expiration = try! body.nodes(forXPath: "x-amz-expiration").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let requestcharged = try! body.nodes(forXPath: "x-amz-request-charged").first.flatMapNoNulls { v in
                return RequestCharged.deserialize(response: response, body: v)
            }
            
            let ssecustomeralgorithm = try! body.nodes(forXPath: "x-amz-server-side-encryption-customer-algorithm").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let ssecustomerkeymd5 = try! body.nodes(forXPath: "x-amz-server-side-encryption-customer-key-MD5").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let ssekmskeyid = try! body.nodes(forXPath: "x-amz-server-side-encryption-aws-kms-key-id").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let serversideencryption = try! body.nodes(forXPath: "x-amz-server-side-encryption").first.flatMapNoNulls { v in
                return ServerSideEncryption.deserialize(response: response, body: v)
            }
            
            let versionid = try! body.nodes(forXPath: "x-amz-version-id").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return CopyObjectOutput(
                
                copyobjectresult: copyobjectresult,
                
                copysourceversionid: copysourceversionid,
                
                expiration: expiration,
                
                requestcharged: requestcharged,
                
                ssecustomeralgorithm: ssecustomeralgorithm,
                
                ssecustomerkeymd5: ssecustomerkeymd5,
                
                ssekmskeyid: ssekmskeyid,
                
                serversideencryption: serversideencryption,
                
                versionid: versionid
                
            )
        }
        
    }
    
    struct CopyObjectRequest: RestXmlSerializable, AwswiftDeserializable {
        public let acl: ObjectCannedACL?
        public let bucket: String
        public let cachecontrol: String?
        public let contentdisposition: String?
        public let contentencoding: String?
        public let contentlanguage: String?
        public let contenttype: String?
        public let copysource: String
        public let copysourceifmatch: String?
        public let copysourceifmodifiedsince: Date?
        public let copysourceifnonematch: String?
        public let copysourceifunmodifiedsince: Date?
        public let copysourcessecustomeralgorithm: String?
        public let copysourcessecustomerkey: String?
        public let copysourcessecustomerkeymd5: String?
        public let expires: Date?
        public let grantfullcontrol: String?
        public let grantread: String?
        public let grantreadacp: String?
        public let grantwriteacp: String?
        public let key: String
        public let metadata: [String: String]?
        public let metadatadirective: MetadataDirective?
        public let requestpayer: RequestPayer?
        public let ssecustomeralgorithm: String?
        public let ssecustomerkey: String?
        public let ssecustomerkeymd5: String?
        public let ssekmskeyid: String?
        public let serversideencryption: ServerSideEncryption?
        public let storageclass: StorageClass?
        public let websiteredirectlocation: String?
        

        init(
            acl: ObjectCannedACL?,
            bucket: String,
            cachecontrol: String?,
            contentdisposition: String?,
            contentencoding: String?,
            contentlanguage: String?,
            contenttype: String?,
            copysource: String,
            copysourceifmatch: String?,
            copysourceifmodifiedsince: Date?,
            copysourceifnonematch: String?,
            copysourceifunmodifiedsince: Date?,
            copysourcessecustomeralgorithm: String?,
            copysourcessecustomerkey: String?,
            copysourcessecustomerkeymd5: String?,
            expires: Date?,
            grantfullcontrol: String?,
            grantread: String?,
            grantreadacp: String?,
            grantwriteacp: String?,
            key: String,
            metadata: [String: String]?,
            metadatadirective: MetadataDirective?,
            requestpayer: RequestPayer?,
            ssecustomeralgorithm: String?,
            ssecustomerkey: String?,
            ssecustomerkeymd5: String?,
            ssekmskeyid: String?,
            serversideencryption: ServerSideEncryption?,
            storageclass: StorageClass?,
            websiteredirectlocation: String?
            
        ) {
            self.acl = acl
            self.bucket = bucket
            self.cachecontrol = cachecontrol
            self.contentdisposition = contentdisposition
            self.contentencoding = contentencoding
            self.contentlanguage = contentlanguage
            self.contenttype = contenttype
            self.copysource = copysource
            self.copysourceifmatch = copysourceifmatch
            self.copysourceifmodifiedsince = copysourceifmodifiedsince
            self.copysourceifnonematch = copysourceifnonematch
            self.copysourceifunmodifiedsince = copysourceifunmodifiedsince
            self.copysourcessecustomeralgorithm = copysourcessecustomeralgorithm
            self.copysourcessecustomerkey = copysourcessecustomerkey
            self.copysourcessecustomerkeymd5 = copysourcessecustomerkeymd5
            self.expires = expires
            self.grantfullcontrol = grantfullcontrol
            self.grantread = grantread
            self.grantreadacp = grantreadacp
            self.grantwriteacp = grantwriteacp
            self.key = key
            self.metadata = metadata
            self.metadatadirective = metadatadirective
            self.requestpayer = requestpayer
            self.ssecustomeralgorithm = ssecustomeralgorithm
            self.ssecustomerkey = ssecustomerkey
            self.ssecustomerkeymd5 = ssecustomerkeymd5
            self.ssekmskeyid = ssekmskeyid
            self.serversideencryption = serversideencryption
            self.storageclass = storageclass
            self.websiteredirectlocation = websiteredirectlocation
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(acl?.restXmlSerialize().node)
            
            element.addChild(bucket.restXmlSerialize().node)
            
            element.addChild(cachecontrol?.restXmlSerialize().node)
            
            element.addChild(contentdisposition?.restXmlSerialize().node)
            
            element.addChild(contentencoding?.restXmlSerialize().node)
            
            element.addChild(contentlanguage?.restXmlSerialize().node)
            
            element.addChild(contenttype?.restXmlSerialize().node)
            
            element.addChild(copysource.restXmlSerialize().node)
            
            element.addChild(copysourceifmatch?.restXmlSerialize().node)
            
            element.addChild(copysourceifmodifiedsince?.restXmlSerialize().node)
            
            element.addChild(copysourceifnonematch?.restXmlSerialize().node)
            
            element.addChild(copysourceifunmodifiedsince?.restXmlSerialize().node)
            
            element.addChild(copysourcessecustomeralgorithm?.restXmlSerialize().node)
            
            element.addChild(copysourcessecustomerkey?.restXmlSerialize().node)
            
            element.addChild(copysourcessecustomerkeymd5?.restXmlSerialize().node)
            
            element.addChild(expires?.restXmlSerialize().node)
            
            element.addChild(grantfullcontrol?.restXmlSerialize().node)
            
            element.addChild(grantread?.restXmlSerialize().node)
            
            element.addChild(grantreadacp?.restXmlSerialize().node)
            
            element.addChild(grantwriteacp?.restXmlSerialize().node)
            
            element.addChild(key.restXmlSerialize().node)
            
            element.addChild(metadata?.restXmlSerialize().node)
            
            element.addChild(metadatadirective?.restXmlSerialize().node)
            
            element.addChild(requestpayer?.restXmlSerialize().node)
            
            element.addChild(ssecustomeralgorithm?.restXmlSerialize().node)
            
            element.addChild(ssecustomerkey?.restXmlSerialize().node)
            
            element.addChild(ssecustomerkeymd5?.restXmlSerialize().node)
            
            element.addChild(ssekmskeyid?.restXmlSerialize().node)
            
            element.addChild(serversideencryption?.restXmlSerialize().node)
            
            element.addChild(storageclass?.restXmlSerialize().node)
            
            element.addChild(websiteredirectlocation?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> CopyObjectRequest {
            fatalError()
        }
        
        
    }
    
    struct CopyObjectResult: RestXmlSerializable, AwswiftDeserializable {
        public let etag: String?
        public let lastmodified: Date?
        

        init(
            etag: String?,
            lastmodified: Date?
            
        ) {
            self.etag = etag
            self.lastmodified = lastmodified
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(etag?.restXmlSerialize().node)
            
            element.addChild(lastmodified?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> CopyObjectResult {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let etag = try! body.nodes(forXPath: "ETag").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let lastmodified = try! body.nodes(forXPath: "LastModified").first.flatMapNoNulls { v in
                return Date.deserialize(response: response, body: v)
            }
            

            return CopyObjectResult(
                
                etag: etag,
                
                lastmodified: lastmodified
                
            )
        }
        
    }
    
    struct CopyPartResult: RestXmlSerializable, AwswiftDeserializable {
        public let etag: String?
        public let lastmodified: Date?
        

        init(
            etag: String?,
            lastmodified: Date?
            
        ) {
            self.etag = etag
            self.lastmodified = lastmodified
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(etag?.restXmlSerialize().node)
            
            element.addChild(lastmodified?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> CopyPartResult {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let etag = try! body.nodes(forXPath: "ETag").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let lastmodified = try! body.nodes(forXPath: "LastModified").first.flatMapNoNulls { v in
                return Date.deserialize(response: response, body: v)
            }
            

            return CopyPartResult(
                
                etag: etag,
                
                lastmodified: lastmodified
                
            )
        }
        
    }
    
    struct CreateBucketConfiguration: RestXmlSerializable, AwswiftDeserializable {
        public let locationconstraint: BucketLocationConstraint?
        

        init(
            locationconstraint: BucketLocationConstraint?
            
        ) {
            self.locationconstraint = locationconstraint
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(locationconstraint?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> CreateBucketConfiguration {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let locationconstraint = try! body.nodes(forXPath: "LocationConstraint").first.flatMapNoNulls { v in
                return BucketLocationConstraint.deserialize(response: response, body: v)
            }
            

            return CreateBucketConfiguration(
                
                locationconstraint: locationconstraint
                
            )
        }
        
    }
    
    struct CreateBucketOutput: RestXmlSerializable, AwswiftDeserializable {
        public let location: String?
        

        init(
            location: String?
            
        ) {
            self.location = location
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            element.addChild(location?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> CreateBucketOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let location = try! body.nodes(forXPath: "Location").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return CreateBucketOutput(
                
                location: location
                
            )
        }
        
    }
    
    struct CreateBucketRequest: RestXmlSerializable, AwswiftDeserializable {
        public let acl: BucketCannedACL?
        public let bucket: String
        public let createbucketconfiguration: CreateBucketConfiguration?
        public let grantfullcontrol: String?
        public let grantread: String?
        public let grantreadacp: String?
        public let grantwrite: String?
        public let grantwriteacp: String?
        

        init(
            acl: BucketCannedACL?,
            bucket: String,
            createbucketconfiguration: CreateBucketConfiguration?,
            grantfullcontrol: String?,
            grantread: String?,
            grantreadacp: String?,
            grantwrite: String?,
            grantwriteacp: String?
            
        ) {
            self.acl = acl
            self.bucket = bucket
            self.createbucketconfiguration = createbucketconfiguration
            self.grantfullcontrol = grantfullcontrol
            self.grantread = grantread
            self.grantreadacp = grantreadacp
            self.grantwrite = grantwrite
            self.grantwriteacp = grantwriteacp
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(acl?.restXmlSerialize().node)
            
            element.addChild(bucket.restXmlSerialize().node)
            
            element.addChild(createbucketconfiguration?.restXmlSerialize().node)
            
            element.addChild(grantfullcontrol?.restXmlSerialize().node)
            
            element.addChild(grantread?.restXmlSerialize().node)
            
            element.addChild(grantreadacp?.restXmlSerialize().node)
            
            element.addChild(grantwrite?.restXmlSerialize().node)
            
            element.addChild(grantwriteacp?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> CreateBucketRequest {
            fatalError()
        }
        
        
    }
    
    struct CreateMultipartUploadOutput: RestXmlSerializable, AwswiftDeserializable {
        public let abortdate: Date?
        public let abortruleid: String?
        public let bucket: String?
        public let key: String?
        public let requestcharged: RequestCharged?
        public let ssecustomeralgorithm: String?
        public let ssecustomerkeymd5: String?
        public let ssekmskeyid: String?
        public let serversideencryption: ServerSideEncryption?
        public let uploadid: String?
        

        init(
            abortdate: Date?,
            abortruleid: String?,
            bucket: String?,
            key: String?,
            requestcharged: RequestCharged?,
            ssecustomeralgorithm: String?,
            ssecustomerkeymd5: String?,
            ssekmskeyid: String?,
            serversideencryption: ServerSideEncryption?,
            uploadid: String?
            
        ) {
            self.abortdate = abortdate
            self.abortruleid = abortruleid
            self.bucket = bucket
            self.key = key
            self.requestcharged = requestcharged
            self.ssecustomeralgorithm = ssecustomeralgorithm
            self.ssecustomerkeymd5 = ssecustomerkeymd5
            self.ssekmskeyid = ssekmskeyid
            self.serversideencryption = serversideencryption
            self.uploadid = uploadid
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            element.addChild(abortdate?.restXmlSerialize().node)
            
            element.addChild(abortruleid?.restXmlSerialize().node)
            
            element.addChild(bucket?.restXmlSerialize().node)
            
            element.addChild(key?.restXmlSerialize().node)
            
            element.addChild(requestcharged?.restXmlSerialize().node)
            
            element.addChild(ssecustomeralgorithm?.restXmlSerialize().node)
            
            element.addChild(ssecustomerkeymd5?.restXmlSerialize().node)
            
            element.addChild(ssekmskeyid?.restXmlSerialize().node)
            
            element.addChild(serversideencryption?.restXmlSerialize().node)
            
            element.addChild(uploadid?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> CreateMultipartUploadOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let abortdate = try! body.nodes(forXPath: "x-amz-abort-date").first.flatMapNoNulls { v in
                return Date.deserialize(response: response, body: v)
            }
            
            let abortruleid = try! body.nodes(forXPath: "x-amz-abort-rule-id").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let bucket = try! body.nodes(forXPath: "Bucket").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let key = try! body.nodes(forXPath: "Key").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let requestcharged = try! body.nodes(forXPath: "x-amz-request-charged").first.flatMapNoNulls { v in
                return RequestCharged.deserialize(response: response, body: v)
            }
            
            let ssecustomeralgorithm = try! body.nodes(forXPath: "x-amz-server-side-encryption-customer-algorithm").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let ssecustomerkeymd5 = try! body.nodes(forXPath: "x-amz-server-side-encryption-customer-key-MD5").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let ssekmskeyid = try! body.nodes(forXPath: "x-amz-server-side-encryption-aws-kms-key-id").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let serversideencryption = try! body.nodes(forXPath: "x-amz-server-side-encryption").first.flatMapNoNulls { v in
                return ServerSideEncryption.deserialize(response: response, body: v)
            }
            
            let uploadid = try! body.nodes(forXPath: "UploadId").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return CreateMultipartUploadOutput(
                
                abortdate: abortdate,
                
                abortruleid: abortruleid,
                
                bucket: bucket,
                
                key: key,
                
                requestcharged: requestcharged,
                
                ssecustomeralgorithm: ssecustomeralgorithm,
                
                ssecustomerkeymd5: ssecustomerkeymd5,
                
                ssekmskeyid: ssekmskeyid,
                
                serversideencryption: serversideencryption,
                
                uploadid: uploadid
                
            )
        }
        
    }
    
    struct CreateMultipartUploadRequest: RestXmlSerializable, AwswiftDeserializable {
        public let acl: ObjectCannedACL?
        public let bucket: String
        public let cachecontrol: String?
        public let contentdisposition: String?
        public let contentencoding: String?
        public let contentlanguage: String?
        public let contenttype: String?
        public let expires: Date?
        public let grantfullcontrol: String?
        public let grantread: String?
        public let grantreadacp: String?
        public let grantwriteacp: String?
        public let key: String
        public let metadata: [String: String]?
        public let requestpayer: RequestPayer?
        public let ssecustomeralgorithm: String?
        public let ssecustomerkey: String?
        public let ssecustomerkeymd5: String?
        public let ssekmskeyid: String?
        public let serversideencryption: ServerSideEncryption?
        public let storageclass: StorageClass?
        public let websiteredirectlocation: String?
        

        init(
            acl: ObjectCannedACL?,
            bucket: String,
            cachecontrol: String?,
            contentdisposition: String?,
            contentencoding: String?,
            contentlanguage: String?,
            contenttype: String?,
            expires: Date?,
            grantfullcontrol: String?,
            grantread: String?,
            grantreadacp: String?,
            grantwriteacp: String?,
            key: String,
            metadata: [String: String]?,
            requestpayer: RequestPayer?,
            ssecustomeralgorithm: String?,
            ssecustomerkey: String?,
            ssecustomerkeymd5: String?,
            ssekmskeyid: String?,
            serversideencryption: ServerSideEncryption?,
            storageclass: StorageClass?,
            websiteredirectlocation: String?
            
        ) {
            self.acl = acl
            self.bucket = bucket
            self.cachecontrol = cachecontrol
            self.contentdisposition = contentdisposition
            self.contentencoding = contentencoding
            self.contentlanguage = contentlanguage
            self.contenttype = contenttype
            self.expires = expires
            self.grantfullcontrol = grantfullcontrol
            self.grantread = grantread
            self.grantreadacp = grantreadacp
            self.grantwriteacp = grantwriteacp
            self.key = key
            self.metadata = metadata
            self.requestpayer = requestpayer
            self.ssecustomeralgorithm = ssecustomeralgorithm
            self.ssecustomerkey = ssecustomerkey
            self.ssecustomerkeymd5 = ssecustomerkeymd5
            self.ssekmskeyid = ssekmskeyid
            self.serversideencryption = serversideencryption
            self.storageclass = storageclass
            self.websiteredirectlocation = websiteredirectlocation
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(acl?.restXmlSerialize().node)
            
            element.addChild(bucket.restXmlSerialize().node)
            
            element.addChild(cachecontrol?.restXmlSerialize().node)
            
            element.addChild(contentdisposition?.restXmlSerialize().node)
            
            element.addChild(contentencoding?.restXmlSerialize().node)
            
            element.addChild(contentlanguage?.restXmlSerialize().node)
            
            element.addChild(contenttype?.restXmlSerialize().node)
            
            element.addChild(expires?.restXmlSerialize().node)
            
            element.addChild(grantfullcontrol?.restXmlSerialize().node)
            
            element.addChild(grantread?.restXmlSerialize().node)
            
            element.addChild(grantreadacp?.restXmlSerialize().node)
            
            element.addChild(grantwriteacp?.restXmlSerialize().node)
            
            element.addChild(key.restXmlSerialize().node)
            
            element.addChild(metadata?.restXmlSerialize().node)
            
            element.addChild(requestpayer?.restXmlSerialize().node)
            
            element.addChild(ssecustomeralgorithm?.restXmlSerialize().node)
            
            element.addChild(ssecustomerkey?.restXmlSerialize().node)
            
            element.addChild(ssecustomerkeymd5?.restXmlSerialize().node)
            
            element.addChild(ssekmskeyid?.restXmlSerialize().node)
            
            element.addChild(serversideencryption?.restXmlSerialize().node)
            
            element.addChild(storageclass?.restXmlSerialize().node)
            
            element.addChild(websiteredirectlocation?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> CreateMultipartUploadRequest {
            fatalError()
        }
        
        
    }
    
    struct Delete: RestXmlSerializable, AwswiftDeserializable {
        public let objects: [ObjectIdentifier]
        public let quiet: Bool?
        

        init(
            objects: [ObjectIdentifier],
            quiet: Bool?
            
        ) {
            self.objects = objects
            self.quiet = quiet
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(objects.restXmlSerialize().node)
            
            element.addChild(quiet?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> Delete {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let objects = try! body.nodes(forXPath: "Object").first.flatMapNoNulls { v in
                return [ObjectIdentifier].deserialize(response: response, body: v)
            }
            
            let quiet = try! body.nodes(forXPath: "Quiet").first.flatMapNoNulls { v in
                return Bool.deserialize(response: response, body: v)
            }
            

            return Delete(
                
                objects: objects!,
                
                quiet: quiet
                
            )
        }
        
    }
    
    struct DeleteBucketCorsRequest: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String
        

        init(
            bucket: String
            
        ) {
            self.bucket = bucket
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(bucket.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> DeleteBucketCorsRequest {
            fatalError()
        }
        
        
    }
    
    struct DeleteBucketLifecycleRequest: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String
        

        init(
            bucket: String
            
        ) {
            self.bucket = bucket
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(bucket.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> DeleteBucketLifecycleRequest {
            fatalError()
        }
        
        
    }
    
    struct DeleteBucketPolicyRequest: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String
        

        init(
            bucket: String
            
        ) {
            self.bucket = bucket
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(bucket.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> DeleteBucketPolicyRequest {
            fatalError()
        }
        
        
    }
    
    struct DeleteBucketReplicationRequest: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String
        

        init(
            bucket: String
            
        ) {
            self.bucket = bucket
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(bucket.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> DeleteBucketReplicationRequest {
            fatalError()
        }
        
        
    }
    
    struct DeleteBucketRequest: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String
        

        init(
            bucket: String
            
        ) {
            self.bucket = bucket
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(bucket.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> DeleteBucketRequest {
            fatalError()
        }
        
        
    }
    
    struct DeleteBucketTaggingRequest: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String
        

        init(
            bucket: String
            
        ) {
            self.bucket = bucket
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(bucket.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> DeleteBucketTaggingRequest {
            fatalError()
        }
        
        
    }
    
    struct DeleteBucketWebsiteRequest: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String
        

        init(
            bucket: String
            
        ) {
            self.bucket = bucket
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(bucket.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> DeleteBucketWebsiteRequest {
            fatalError()
        }
        
        
    }
    
    struct DeleteMarkerEntry: RestXmlSerializable, AwswiftDeserializable {
        public let islatest: Bool?
        public let key: String?
        public let lastmodified: Date?
        public let owner: Owner?
        public let versionid: String?
        

        init(
            islatest: Bool?,
            key: String?,
            lastmodified: Date?,
            owner: Owner?,
            versionid: String?
            
        ) {
            self.islatest = islatest
            self.key = key
            self.lastmodified = lastmodified
            self.owner = owner
            self.versionid = versionid
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(islatest?.restXmlSerialize().node)
            
            element.addChild(key?.restXmlSerialize().node)
            
            element.addChild(lastmodified?.restXmlSerialize().node)
            
            element.addChild(owner?.restXmlSerialize().node)
            
            element.addChild(versionid?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> DeleteMarkerEntry {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let islatest = try! body.nodes(forXPath: "IsLatest").first.flatMapNoNulls { v in
                return Bool.deserialize(response: response, body: v)
            }
            
            let key = try! body.nodes(forXPath: "Key").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let lastmodified = try! body.nodes(forXPath: "LastModified").first.flatMapNoNulls { v in
                return Date.deserialize(response: response, body: v)
            }
            
            let owner = try! body.nodes(forXPath: "Owner").first.flatMapNoNulls { v in
                return Owner.deserialize(response: response, body: v)
            }
            
            let versionid = try! body.nodes(forXPath: "VersionId").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return DeleteMarkerEntry(
                
                islatest: islatest,
                
                key: key,
                
                lastmodified: lastmodified,
                
                owner: owner,
                
                versionid: versionid
                
            )
        }
        
    }
    
    struct DeleteObjectOutput: RestXmlSerializable, AwswiftDeserializable {
        public let deletemarker: Bool?
        public let requestcharged: RequestCharged?
        public let versionid: String?
        

        init(
            deletemarker: Bool?,
            requestcharged: RequestCharged?,
            versionid: String?
            
        ) {
            self.deletemarker = deletemarker
            self.requestcharged = requestcharged
            self.versionid = versionid
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            element.addChild(deletemarker?.restXmlSerialize().node)
            
            element.addChild(requestcharged?.restXmlSerialize().node)
            
            element.addChild(versionid?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> DeleteObjectOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let deletemarker = try! body.nodes(forXPath: "x-amz-delete-marker").first.flatMapNoNulls { v in
                return Bool.deserialize(response: response, body: v)
            }
            
            let requestcharged = try! body.nodes(forXPath: "x-amz-request-charged").first.flatMapNoNulls { v in
                return RequestCharged.deserialize(response: response, body: v)
            }
            
            let versionid = try! body.nodes(forXPath: "x-amz-version-id").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return DeleteObjectOutput(
                
                deletemarker: deletemarker,
                
                requestcharged: requestcharged,
                
                versionid: versionid
                
            )
        }
        
    }
    
    struct DeleteObjectRequest: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String
        public let key: String
        public let mfa: String?
        public let requestpayer: RequestPayer?
        public let versionid: String?
        

        init(
            bucket: String,
            key: String,
            mfa: String?,
            requestpayer: RequestPayer?,
            versionid: String?
            
        ) {
            self.bucket = bucket
            self.key = key
            self.mfa = mfa
            self.requestpayer = requestpayer
            self.versionid = versionid
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(bucket.restXmlSerialize().node)
            
            element.addChild(key.restXmlSerialize().node)
            
            element.addChild(mfa?.restXmlSerialize().node)
            
            element.addChild(requestpayer?.restXmlSerialize().node)
            
            element.addChild(versionid?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> DeleteObjectRequest {
            fatalError()
        }
        
        
    }
    
    struct DeleteObjectsOutput: RestXmlSerializable, AwswiftDeserializable {
        public let deleted: [DeletedObject]?
        public let errors: [S3Error]?
        public let requestcharged: RequestCharged?
        

        init(
            deleted: [DeletedObject]?,
            errors: [S3Error]?,
            requestcharged: RequestCharged?
            
        ) {
            self.deleted = deleted
            self.errors = errors
            self.requestcharged = requestcharged
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            element.addChild(deleted?.restXmlSerialize().node)
            
            element.addChild(errors?.restXmlSerialize().node)
            
            element.addChild(requestcharged?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> DeleteObjectsOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let deleted = try! body.nodes(forXPath: "Deleted").first.flatMapNoNulls { v in
                return [DeletedObject].deserialize(response: response, body: v)
            }
            
            let errors = try! body.nodes(forXPath: "Error").first.flatMapNoNulls { v in
                return [S3Error].deserialize(response: response, body: v)
            }
            
            let requestcharged = try! body.nodes(forXPath: "x-amz-request-charged").first.flatMapNoNulls { v in
                return RequestCharged.deserialize(response: response, body: v)
            }
            

            return DeleteObjectsOutput(
                
                deleted: deleted,
                
                errors: errors,
                
                requestcharged: requestcharged
                
            )
        }
        
    }
    
    struct DeleteObjectsRequest: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String
        public let delete: Delete
        public let mfa: String?
        public let requestpayer: RequestPayer?
        

        init(
            bucket: String,
            delete: Delete,
            mfa: String?,
            requestpayer: RequestPayer?
            
        ) {
            self.bucket = bucket
            self.delete = delete
            self.mfa = mfa
            self.requestpayer = requestpayer
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(bucket.restXmlSerialize().node)
            
            element.addChild(delete.restXmlSerialize().node)
            
            element.addChild(mfa?.restXmlSerialize().node)
            
            element.addChild(requestpayer?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> DeleteObjectsRequest {
            fatalError()
        }
        
        
    }
    
    struct DeletedObject: RestXmlSerializable, AwswiftDeserializable {
        public let deletemarker: Bool?
        public let deletemarkerversionid: String?
        public let key: String?
        public let versionid: String?
        

        init(
            deletemarker: Bool?,
            deletemarkerversionid: String?,
            key: String?,
            versionid: String?
            
        ) {
            self.deletemarker = deletemarker
            self.deletemarkerversionid = deletemarkerversionid
            self.key = key
            self.versionid = versionid
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(deletemarker?.restXmlSerialize().node)
            
            element.addChild(deletemarkerversionid?.restXmlSerialize().node)
            
            element.addChild(key?.restXmlSerialize().node)
            
            element.addChild(versionid?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> DeletedObject {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let deletemarker = try! body.nodes(forXPath: "DeleteMarker").first.flatMapNoNulls { v in
                return Bool.deserialize(response: response, body: v)
            }
            
            let deletemarkerversionid = try! body.nodes(forXPath: "DeleteMarkerVersionId").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let key = try! body.nodes(forXPath: "Key").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let versionid = try! body.nodes(forXPath: "VersionId").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return DeletedObject(
                
                deletemarker: deletemarker,
                
                deletemarkerversionid: deletemarkerversionid,
                
                key: key,
                
                versionid: versionid
                
            )
        }
        
    }
    
    struct Destination: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String
        public let storageclass: StorageClass?
        

        init(
            bucket: String,
            storageclass: StorageClass?
            
        ) {
            self.bucket = bucket
            self.storageclass = storageclass
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(bucket.restXmlSerialize().node)
            
            element.addChild(storageclass?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> Destination {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let bucket = try! body.nodes(forXPath: "Bucket").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let storageclass = try! body.nodes(forXPath: "StorageClass").first.flatMapNoNulls { v in
                return StorageClass.deserialize(response: response, body: v)
            }
            

            return Destination(
                
                bucket: bucket!,
                
                storageclass: storageclass
                
            )
        }
        
    }
    
    struct ErrorDocument: RestXmlSerializable, AwswiftDeserializable {
        public let key: String
        

        init(
            key: String
            
        ) {
            self.key = key
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(key.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> ErrorDocument {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let key = try! body.nodes(forXPath: "Key").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return ErrorDocument(
                
                key: key!
                
            )
        }
        
    }
    
    struct FilterRule: RestXmlSerializable, AwswiftDeserializable {
        public let name: FilterRuleName?
        public let value: String?
        

        init(
            name: FilterRuleName?,
            value: String?
            
        ) {
            self.name = name
            self.value = value
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(name?.restXmlSerialize().node)
            
            element.addChild(value?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> FilterRule {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let name = try! body.nodes(forXPath: "Name").first.flatMapNoNulls { v in
                return FilterRuleName.deserialize(response: response, body: v)
            }
            
            let value = try! body.nodes(forXPath: "Value").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return FilterRule(
                
                name: name,
                
                value: value
                
            )
        }
        
    }
    
    struct GetBucketAccelerateConfigurationOutput: RestXmlSerializable, AwswiftDeserializable {
        public let status: BucketAccelerateStatus?
        

        init(
            status: BucketAccelerateStatus?
            
        ) {
            self.status = status
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            element.addChild(status?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> GetBucketAccelerateConfigurationOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let status = try! body.nodes(forXPath: "Status").first.flatMapNoNulls { v in
                return BucketAccelerateStatus.deserialize(response: response, body: v)
            }
            

            return GetBucketAccelerateConfigurationOutput(
                
                status: status
                
            )
        }
        
    }
    
    struct GetBucketAccelerateConfigurationRequest: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String
        

        init(
            bucket: String
            
        ) {
            self.bucket = bucket
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(bucket.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> GetBucketAccelerateConfigurationRequest {
            fatalError()
        }
        
        
    }
    
    struct GetBucketAclOutput: RestXmlSerializable, AwswiftDeserializable {
        public let grants: [Grant]?
        public let owner: Owner?
        

        init(
            grants: [Grant]?,
            owner: Owner?
            
        ) {
            self.grants = grants
            self.owner = owner
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            element.addChild(grants?.restXmlSerialize().node)
            
            element.addChild(owner?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> GetBucketAclOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let grants = try! body.nodes(forXPath: "AccessControlList").first.flatMapNoNulls { v in
                return [Grant].deserialize(response: response, body: v)
            }
            
            let owner = try! body.nodes(forXPath: "Owner").first.flatMapNoNulls { v in
                return Owner.deserialize(response: response, body: v)
            }
            

            return GetBucketAclOutput(
                
                grants: grants,
                
                owner: owner
                
            )
        }
        
    }
    
    struct GetBucketAclRequest: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String
        

        init(
            bucket: String
            
        ) {
            self.bucket = bucket
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(bucket.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> GetBucketAclRequest {
            fatalError()
        }
        
        
    }
    
    struct GetBucketCorsOutput: RestXmlSerializable, AwswiftDeserializable {
        public let corsrules: [CORSRule]?
        

        init(
            corsrules: [CORSRule]?
            
        ) {
            self.corsrules = corsrules
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            element.addChild(corsrules?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> GetBucketCorsOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let corsrules = try! body.nodes(forXPath: "CORSRule").first.flatMapNoNulls { v in
                return [CORSRule].deserialize(response: response, body: v)
            }
            

            return GetBucketCorsOutput(
                
                corsrules: corsrules
                
            )
        }
        
    }
    
    struct GetBucketCorsRequest: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String
        

        init(
            bucket: String
            
        ) {
            self.bucket = bucket
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(bucket.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> GetBucketCorsRequest {
            fatalError()
        }
        
        
    }
    
    struct GetBucketLifecycleConfigurationOutput: RestXmlSerializable, AwswiftDeserializable {
        public let rules: [LifecycleRule]?
        

        init(
            rules: [LifecycleRule]?
            
        ) {
            self.rules = rules
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            element.addChild(rules?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> GetBucketLifecycleConfigurationOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let rules = try! body.nodes(forXPath: "Rule").first.flatMapNoNulls { v in
                return [LifecycleRule].deserialize(response: response, body: v)
            }
            

            return GetBucketLifecycleConfigurationOutput(
                
                rules: rules
                
            )
        }
        
    }
    
    struct GetBucketLifecycleConfigurationRequest: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String
        

        init(
            bucket: String
            
        ) {
            self.bucket = bucket
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(bucket.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> GetBucketLifecycleConfigurationRequest {
            fatalError()
        }
        
        
    }
    
    struct GetBucketLifecycleOutput: RestXmlSerializable, AwswiftDeserializable {
        public let rules: [Rule]?
        

        init(
            rules: [Rule]?
            
        ) {
            self.rules = rules
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            element.addChild(rules?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> GetBucketLifecycleOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let rules = try! body.nodes(forXPath: "Rule").first.flatMapNoNulls { v in
                return [Rule].deserialize(response: response, body: v)
            }
            

            return GetBucketLifecycleOutput(
                
                rules: rules
                
            )
        }
        
    }
    
    struct GetBucketLifecycleRequest: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String
        

        init(
            bucket: String
            
        ) {
            self.bucket = bucket
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(bucket.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> GetBucketLifecycleRequest {
            fatalError()
        }
        
        
    }
    
    struct GetBucketLocationOutput: RestXmlSerializable, AwswiftDeserializable {
        public let locationconstraint: BucketLocationConstraint?
        

        init(
            locationconstraint: BucketLocationConstraint?
            
        ) {
            self.locationconstraint = locationconstraint
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            element.addChild(locationconstraint?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> GetBucketLocationOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let locationconstraint = try! body.nodes(forXPath: "LocationConstraint").first.flatMapNoNulls { v in
                return BucketLocationConstraint.deserialize(response: response, body: v)
            }
            

            return GetBucketLocationOutput(
                
                locationconstraint: locationconstraint
                
            )
        }
        
    }
    
    struct GetBucketLocationRequest: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String
        

        init(
            bucket: String
            
        ) {
            self.bucket = bucket
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(bucket.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> GetBucketLocationRequest {
            fatalError()
        }
        
        
    }
    
    struct GetBucketLoggingOutput: RestXmlSerializable, AwswiftDeserializable {
        public let loggingenabled: LoggingEnabled?
        

        init(
            loggingenabled: LoggingEnabled?
            
        ) {
            self.loggingenabled = loggingenabled
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            element.addChild(loggingenabled?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> GetBucketLoggingOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let loggingenabled = try! body.nodes(forXPath: "LoggingEnabled").first.flatMapNoNulls { v in
                return LoggingEnabled.deserialize(response: response, body: v)
            }
            

            return GetBucketLoggingOutput(
                
                loggingenabled: loggingenabled
                
            )
        }
        
    }
    
    struct GetBucketLoggingRequest: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String
        

        init(
            bucket: String
            
        ) {
            self.bucket = bucket
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(bucket.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> GetBucketLoggingRequest {
            fatalError()
        }
        
        
    }
    
    struct GetBucketNotificationConfigurationRequest: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String
        

        init(
            bucket: String
            
        ) {
            self.bucket = bucket
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(bucket.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> GetBucketNotificationConfigurationRequest {
            fatalError()
        }
        
        
    }
    
    struct GetBucketPolicyOutput: RestXmlSerializable, AwswiftDeserializable {
        public let policy: String?
        

        init(
            policy: String?
            
        ) {
            self.policy = policy
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            element.addChild(policy?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> GetBucketPolicyOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let policy = try! body.nodes(forXPath: "Policy").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return GetBucketPolicyOutput(
                
                policy: policy
                
            )
        }
        
    }
    
    struct GetBucketPolicyRequest: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String
        

        init(
            bucket: String
            
        ) {
            self.bucket = bucket
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(bucket.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> GetBucketPolicyRequest {
            fatalError()
        }
        
        
    }
    
    struct GetBucketReplicationOutput: RestXmlSerializable, AwswiftDeserializable {
        public let replicationconfiguration: ReplicationConfiguration?
        

        init(
            replicationconfiguration: ReplicationConfiguration?
            
        ) {
            self.replicationconfiguration = replicationconfiguration
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            element.addChild(replicationconfiguration?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> GetBucketReplicationOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let replicationconfiguration = try! body.nodes(forXPath: "ReplicationConfiguration").first.flatMapNoNulls { v in
                return ReplicationConfiguration.deserialize(response: response, body: v)
            }
            

            return GetBucketReplicationOutput(
                
                replicationconfiguration: replicationconfiguration
                
            )
        }
        
    }
    
    struct GetBucketReplicationRequest: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String
        

        init(
            bucket: String
            
        ) {
            self.bucket = bucket
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(bucket.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> GetBucketReplicationRequest {
            fatalError()
        }
        
        
    }
    
    struct GetBucketRequestPaymentOutput: RestXmlSerializable, AwswiftDeserializable {
        public let payer: Payer?
        

        init(
            payer: Payer?
            
        ) {
            self.payer = payer
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            element.addChild(payer?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> GetBucketRequestPaymentOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let payer = try! body.nodes(forXPath: "Payer").first.flatMapNoNulls { v in
                return Payer.deserialize(response: response, body: v)
            }
            

            return GetBucketRequestPaymentOutput(
                
                payer: payer
                
            )
        }
        
    }
    
    struct GetBucketRequestPaymentRequest: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String
        

        init(
            bucket: String
            
        ) {
            self.bucket = bucket
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(bucket.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> GetBucketRequestPaymentRequest {
            fatalError()
        }
        
        
    }
    
    struct GetBucketTaggingOutput: RestXmlSerializable, AwswiftDeserializable {
        public let tagset: [Tag]
        

        init(
            tagset: [Tag]
            
        ) {
            self.tagset = tagset
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            element.addChild(tagset.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> GetBucketTaggingOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let tagset = try! body.nodes(forXPath: "TagSet").first.flatMapNoNulls { v in
                return [Tag].deserialize(response: response, body: v)
            }
            

            return GetBucketTaggingOutput(
                
                tagset: tagset!
                
            )
        }
        
    }
    
    struct GetBucketTaggingRequest: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String
        

        init(
            bucket: String
            
        ) {
            self.bucket = bucket
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(bucket.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> GetBucketTaggingRequest {
            fatalError()
        }
        
        
    }
    
    struct GetBucketVersioningOutput: RestXmlSerializable, AwswiftDeserializable {
        public let mfadelete: MFADeleteStatus?
        public let status: BucketVersioningStatus?
        

        init(
            mfadelete: MFADeleteStatus?,
            status: BucketVersioningStatus?
            
        ) {
            self.mfadelete = mfadelete
            self.status = status
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            element.addChild(mfadelete?.restXmlSerialize().node)
            
            element.addChild(status?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> GetBucketVersioningOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let mfadelete = try! body.nodes(forXPath: "MfaDelete").first.flatMapNoNulls { v in
                return MFADeleteStatus.deserialize(response: response, body: v)
            }
            
            let status = try! body.nodes(forXPath: "Status").first.flatMapNoNulls { v in
                return BucketVersioningStatus.deserialize(response: response, body: v)
            }
            

            return GetBucketVersioningOutput(
                
                mfadelete: mfadelete,
                
                status: status
                
            )
        }
        
    }
    
    struct GetBucketVersioningRequest: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String
        

        init(
            bucket: String
            
        ) {
            self.bucket = bucket
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(bucket.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> GetBucketVersioningRequest {
            fatalError()
        }
        
        
    }
    
    struct GetBucketWebsiteOutput: RestXmlSerializable, AwswiftDeserializable {
        public let errordocument: ErrorDocument?
        public let indexdocument: IndexDocument?
        public let redirectallrequeststo: RedirectAllRequestsTo?
        public let routingrules: [RoutingRule]?
        

        init(
            errordocument: ErrorDocument?,
            indexdocument: IndexDocument?,
            redirectallrequeststo: RedirectAllRequestsTo?,
            routingrules: [RoutingRule]?
            
        ) {
            self.errordocument = errordocument
            self.indexdocument = indexdocument
            self.redirectallrequeststo = redirectallrequeststo
            self.routingrules = routingrules
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            element.addChild(errordocument?.restXmlSerialize().node)
            
            element.addChild(indexdocument?.restXmlSerialize().node)
            
            element.addChild(redirectallrequeststo?.restXmlSerialize().node)
            
            element.addChild(routingrules?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> GetBucketWebsiteOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let errordocument = try! body.nodes(forXPath: "ErrorDocument").first.flatMapNoNulls { v in
                return ErrorDocument.deserialize(response: response, body: v)
            }
            
            let indexdocument = try! body.nodes(forXPath: "IndexDocument").first.flatMapNoNulls { v in
                return IndexDocument.deserialize(response: response, body: v)
            }
            
            let redirectallrequeststo = try! body.nodes(forXPath: "RedirectAllRequestsTo").first.flatMapNoNulls { v in
                return RedirectAllRequestsTo.deserialize(response: response, body: v)
            }
            
            let routingrules = try! body.nodes(forXPath: "RoutingRules").first.flatMapNoNulls { v in
                return [RoutingRule].deserialize(response: response, body: v)
            }
            

            return GetBucketWebsiteOutput(
                
                errordocument: errordocument,
                
                indexdocument: indexdocument,
                
                redirectallrequeststo: redirectallrequeststo,
                
                routingrules: routingrules
                
            )
        }
        
    }
    
    struct GetBucketWebsiteRequest: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String
        

        init(
            bucket: String
            
        ) {
            self.bucket = bucket
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(bucket.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> GetBucketWebsiteRequest {
            fatalError()
        }
        
        
    }
    
    struct GetObjectAclOutput: RestXmlSerializable, AwswiftDeserializable {
        public let grants: [Grant]?
        public let owner: Owner?
        public let requestcharged: RequestCharged?
        

        init(
            grants: [Grant]?,
            owner: Owner?,
            requestcharged: RequestCharged?
            
        ) {
            self.grants = grants
            self.owner = owner
            self.requestcharged = requestcharged
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            element.addChild(grants?.restXmlSerialize().node)
            
            element.addChild(owner?.restXmlSerialize().node)
            
            element.addChild(requestcharged?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> GetObjectAclOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let grants = try! body.nodes(forXPath: "AccessControlList").first.flatMapNoNulls { v in
                return [Grant].deserialize(response: response, body: v)
            }
            
            let owner = try! body.nodes(forXPath: "Owner").first.flatMapNoNulls { v in
                return Owner.deserialize(response: response, body: v)
            }
            
            let requestcharged = try! body.nodes(forXPath: "x-amz-request-charged").first.flatMapNoNulls { v in
                return RequestCharged.deserialize(response: response, body: v)
            }
            

            return GetObjectAclOutput(
                
                grants: grants,
                
                owner: owner,
                
                requestcharged: requestcharged
                
            )
        }
        
    }
    
    struct GetObjectAclRequest: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String
        public let key: String
        public let requestpayer: RequestPayer?
        public let versionid: String?
        

        init(
            bucket: String,
            key: String,
            requestpayer: RequestPayer?,
            versionid: String?
            
        ) {
            self.bucket = bucket
            self.key = key
            self.requestpayer = requestpayer
            self.versionid = versionid
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(bucket.restXmlSerialize().node)
            
            element.addChild(key.restXmlSerialize().node)
            
            element.addChild(requestpayer?.restXmlSerialize().node)
            
            element.addChild(versionid?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> GetObjectAclRequest {
            fatalError()
        }
        
        
    }
    
    struct GetObjectOutput: RestXmlSerializable, AwswiftDeserializable {
        public let acceptranges: String?
        public let s3body: Data?
        public let cachecontrol: String?
        public let contentdisposition: String?
        public let contentencoding: String?
        public let contentlanguage: String?
        public let contentlength: Int?
        public let contentrange: String?
        public let contenttype: String?
        public let deletemarker: Bool?
        public let etag: String?
        public let expiration: String?
        public let expires: Date?
        public let lastmodified: Date?
        public let metadata: [String: String]?
        public let missingmeta: Int?
        public let partscount: Int?
        public let replicationstatus: ReplicationStatus?
        public let requestcharged: RequestCharged?
        public let restore: String?
        public let ssecustomeralgorithm: String?
        public let ssecustomerkeymd5: String?
        public let ssekmskeyid: String?
        public let serversideencryption: ServerSideEncryption?
        public let storageclass: StorageClass?
        public let versionid: String?
        public let websiteredirectlocation: String?
        

        init(
            acceptranges: String?,
            s3body: Data?,
            cachecontrol: String?,
            contentdisposition: String?,
            contentencoding: String?,
            contentlanguage: String?,
            contentlength: Int?,
            contentrange: String?,
            contenttype: String?,
            deletemarker: Bool?,
            etag: String?,
            expiration: String?,
            expires: Date?,
            lastmodified: Date?,
            metadata: [String: String]?,
            missingmeta: Int?,
            partscount: Int?,
            replicationstatus: ReplicationStatus?,
            requestcharged: RequestCharged?,
            restore: String?,
            ssecustomeralgorithm: String?,
            ssecustomerkeymd5: String?,
            ssekmskeyid: String?,
            serversideencryption: ServerSideEncryption?,
            storageclass: StorageClass?,
            versionid: String?,
            websiteredirectlocation: String?
            
        ) {
            self.acceptranges = acceptranges
            self.s3body = s3body
            self.cachecontrol = cachecontrol
            self.contentdisposition = contentdisposition
            self.contentencoding = contentencoding
            self.contentlanguage = contentlanguage
            self.contentlength = contentlength
            self.contentrange = contentrange
            self.contenttype = contenttype
            self.deletemarker = deletemarker
            self.etag = etag
            self.expiration = expiration
            self.expires = expires
            self.lastmodified = lastmodified
            self.metadata = metadata
            self.missingmeta = missingmeta
            self.partscount = partscount
            self.replicationstatus = replicationstatus
            self.requestcharged = requestcharged
            self.restore = restore
            self.ssecustomeralgorithm = ssecustomeralgorithm
            self.ssecustomerkeymd5 = ssecustomerkeymd5
            self.ssekmskeyid = ssekmskeyid
            self.serversideencryption = serversideencryption
            self.storageclass = storageclass
            self.versionid = versionid
            self.websiteredirectlocation = websiteredirectlocation
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            element.addChild(acceptranges?.restXmlSerialize().node)
            
            element.addChild(s3body?.restXmlSerialize().node)
            
            element.addChild(cachecontrol?.restXmlSerialize().node)
            
            element.addChild(contentdisposition?.restXmlSerialize().node)
            
            element.addChild(contentencoding?.restXmlSerialize().node)
            
            element.addChild(contentlanguage?.restXmlSerialize().node)
            
            element.addChild(contentlength?.restXmlSerialize().node)
            
            element.addChild(contentrange?.restXmlSerialize().node)
            
            element.addChild(contenttype?.restXmlSerialize().node)
            
            element.addChild(deletemarker?.restXmlSerialize().node)
            
            element.addChild(etag?.restXmlSerialize().node)
            
            element.addChild(expiration?.restXmlSerialize().node)
            
            element.addChild(expires?.restXmlSerialize().node)
            
            element.addChild(lastmodified?.restXmlSerialize().node)
            
            element.addChild(metadata?.restXmlSerialize().node)
            
            element.addChild(missingmeta?.restXmlSerialize().node)
            
            element.addChild(partscount?.restXmlSerialize().node)
            
            element.addChild(replicationstatus?.restXmlSerialize().node)
            
            element.addChild(requestcharged?.restXmlSerialize().node)
            
            element.addChild(restore?.restXmlSerialize().node)
            
            element.addChild(ssecustomeralgorithm?.restXmlSerialize().node)
            
            element.addChild(ssecustomerkeymd5?.restXmlSerialize().node)
            
            element.addChild(ssekmskeyid?.restXmlSerialize().node)
            
            element.addChild(serversideencryption?.restXmlSerialize().node)
            
            element.addChild(storageclass?.restXmlSerialize().node)
            
            element.addChild(versionid?.restXmlSerialize().node)
            
            element.addChild(websiteredirectlocation?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> GetObjectOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let acceptranges = try! body.nodes(forXPath: "accept-ranges").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let s3body = try! body.nodes(forXPath: "Body").first.flatMapNoNulls { v in
                return Data.deserialize(response: response, body: v)
            }
            
            let cachecontrol = try! body.nodes(forXPath: "Cache-Control").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let contentdisposition = try! body.nodes(forXPath: "Content-Disposition").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let contentencoding = try! body.nodes(forXPath: "Content-Encoding").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let contentlanguage = try! body.nodes(forXPath: "Content-Language").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let contentlength = try! body.nodes(forXPath: "Content-Length").first.flatMapNoNulls { v in
                return Int.deserialize(response: response, body: v)
            }
            
            let contentrange = try! body.nodes(forXPath: "Content-Range").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let contenttype = try! body.nodes(forXPath: "Content-Type").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let deletemarker = try! body.nodes(forXPath: "x-amz-delete-marker").first.flatMapNoNulls { v in
                return Bool.deserialize(response: response, body: v)
            }
            
            let etag = try! body.nodes(forXPath: "ETag").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let expiration = try! body.nodes(forXPath: "x-amz-expiration").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let expires = try! body.nodes(forXPath: "Expires").first.flatMapNoNulls { v in
                return Date.deserialize(response: response, body: v)
            }
            
            let lastmodified = try! body.nodes(forXPath: "Last-Modified").first.flatMapNoNulls { v in
                return Date.deserialize(response: response, body: v)
            }
            
            let metadata = try! body.nodes(forXPath: "x-amz-meta-").first.flatMapNoNulls { v in
                return [String: String].deserialize(response: response, body: v)
            }
            
            let missingmeta = try! body.nodes(forXPath: "x-amz-missing-meta").first.flatMapNoNulls { v in
                return Int.deserialize(response: response, body: v)
            }
            
            let partscount = try! body.nodes(forXPath: "x-amz-mp-parts-count").first.flatMapNoNulls { v in
                return Int.deserialize(response: response, body: v)
            }
            
            let replicationstatus = try! body.nodes(forXPath: "x-amz-replication-status").first.flatMapNoNulls { v in
                return ReplicationStatus.deserialize(response: response, body: v)
            }
            
            let requestcharged = try! body.nodes(forXPath: "x-amz-request-charged").first.flatMapNoNulls { v in
                return RequestCharged.deserialize(response: response, body: v)
            }
            
            let restore = try! body.nodes(forXPath: "x-amz-restore").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let ssecustomeralgorithm = try! body.nodes(forXPath: "x-amz-server-side-encryption-customer-algorithm").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let ssecustomerkeymd5 = try! body.nodes(forXPath: "x-amz-server-side-encryption-customer-key-MD5").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let ssekmskeyid = try! body.nodes(forXPath: "x-amz-server-side-encryption-aws-kms-key-id").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let serversideencryption = try! body.nodes(forXPath: "x-amz-server-side-encryption").first.flatMapNoNulls { v in
                return ServerSideEncryption.deserialize(response: response, body: v)
            }
            
            let storageclass = try! body.nodes(forXPath: "x-amz-storage-class").first.flatMapNoNulls { v in
                return StorageClass.deserialize(response: response, body: v)
            }
            
            let versionid = try! body.nodes(forXPath: "x-amz-version-id").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let websiteredirectlocation = try! body.nodes(forXPath: "x-amz-website-redirect-location").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return GetObjectOutput(
                
                acceptranges: acceptranges,
                
                s3body: s3body,
                
                cachecontrol: cachecontrol,
                
                contentdisposition: contentdisposition,
                
                contentencoding: contentencoding,
                
                contentlanguage: contentlanguage,
                
                contentlength: contentlength,
                
                contentrange: contentrange,
                
                contenttype: contenttype,
                
                deletemarker: deletemarker,
                
                etag: etag,
                
                expiration: expiration,
                
                expires: expires,
                
                lastmodified: lastmodified,
                
                metadata: metadata,
                
                missingmeta: missingmeta,
                
                partscount: partscount,
                
                replicationstatus: replicationstatus,
                
                requestcharged: requestcharged,
                
                restore: restore,
                
                ssecustomeralgorithm: ssecustomeralgorithm,
                
                ssecustomerkeymd5: ssecustomerkeymd5,
                
                ssekmskeyid: ssekmskeyid,
                
                serversideencryption: serversideencryption,
                
                storageclass: storageclass,
                
                versionid: versionid,
                
                websiteredirectlocation: websiteredirectlocation
                
            )
        }
        
    }
    
    struct GetObjectRequest: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String
        public let ifmatch: String?
        public let ifmodifiedsince: Date?
        public let ifnonematch: String?
        public let ifunmodifiedsince: Date?
        public let key: String
        public let partnumber: Int?
        public let range: String?
        public let requestpayer: RequestPayer?
        public let responsecachecontrol: String?
        public let responsecontentdisposition: String?
        public let responsecontentencoding: String?
        public let responsecontentlanguage: String?
        public let responsecontenttype: String?
        public let responseexpires: Date?
        public let ssecustomeralgorithm: String?
        public let ssecustomerkey: String?
        public let ssecustomerkeymd5: String?
        public let versionid: String?
        

        init(
            bucket: String,
            ifmatch: String?,
            ifmodifiedsince: Date?,
            ifnonematch: String?,
            ifunmodifiedsince: Date?,
            key: String,
            partnumber: Int?,
            range: String?,
            requestpayer: RequestPayer?,
            responsecachecontrol: String?,
            responsecontentdisposition: String?,
            responsecontentencoding: String?,
            responsecontentlanguage: String?,
            responsecontenttype: String?,
            responseexpires: Date?,
            ssecustomeralgorithm: String?,
            ssecustomerkey: String?,
            ssecustomerkeymd5: String?,
            versionid: String?
            
        ) {
            self.bucket = bucket
            self.ifmatch = ifmatch
            self.ifmodifiedsince = ifmodifiedsince
            self.ifnonematch = ifnonematch
            self.ifunmodifiedsince = ifunmodifiedsince
            self.key = key
            self.partnumber = partnumber
            self.range = range
            self.requestpayer = requestpayer
            self.responsecachecontrol = responsecachecontrol
            self.responsecontentdisposition = responsecontentdisposition
            self.responsecontentencoding = responsecontentencoding
            self.responsecontentlanguage = responsecontentlanguage
            self.responsecontenttype = responsecontenttype
            self.responseexpires = responseexpires
            self.ssecustomeralgorithm = ssecustomeralgorithm
            self.ssecustomerkey = ssecustomerkey
            self.ssecustomerkeymd5 = ssecustomerkeymd5
            self.versionid = versionid
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(bucket.restXmlSerialize().node)
            
            element.addChild(ifmatch?.restXmlSerialize().node)
            
            element.addChild(ifmodifiedsince?.restXmlSerialize().node)
            
            element.addChild(ifnonematch?.restXmlSerialize().node)
            
            element.addChild(ifunmodifiedsince?.restXmlSerialize().node)
            
            element.addChild(key.restXmlSerialize().node)
            
            element.addChild(partnumber?.restXmlSerialize().node)
            
            element.addChild(range?.restXmlSerialize().node)
            
            element.addChild(requestpayer?.restXmlSerialize().node)
            
            element.addChild(responsecachecontrol?.restXmlSerialize().node)
            
            element.addChild(responsecontentdisposition?.restXmlSerialize().node)
            
            element.addChild(responsecontentencoding?.restXmlSerialize().node)
            
            element.addChild(responsecontentlanguage?.restXmlSerialize().node)
            
            element.addChild(responsecontenttype?.restXmlSerialize().node)
            
            element.addChild(responseexpires?.restXmlSerialize().node)
            
            element.addChild(ssecustomeralgorithm?.restXmlSerialize().node)
            
            element.addChild(ssecustomerkey?.restXmlSerialize().node)
            
            element.addChild(ssecustomerkeymd5?.restXmlSerialize().node)
            
            element.addChild(versionid?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> GetObjectRequest {
            fatalError()
        }
        
        
    }
    
    struct GetObjectTorrentOutput: RestXmlSerializable, AwswiftDeserializable {
        public let s3body: Data?
        public let requestcharged: RequestCharged?
        

        init(
            s3body: Data?,
            requestcharged: RequestCharged?
            
        ) {
            self.s3body = s3body
            self.requestcharged = requestcharged
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            element.addChild(s3body?.restXmlSerialize().node)
            
            element.addChild(requestcharged?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> GetObjectTorrentOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let s3body = try! body.nodes(forXPath: "Body").first.flatMapNoNulls { v in
                return Data.deserialize(response: response, body: v)
            }
            
            let requestcharged = try! body.nodes(forXPath: "x-amz-request-charged").first.flatMapNoNulls { v in
                return RequestCharged.deserialize(response: response, body: v)
            }
            

            return GetObjectTorrentOutput(
                
                s3body: s3body,
                
                requestcharged: requestcharged
                
            )
        }
        
    }
    
    struct GetObjectTorrentRequest: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String
        public let key: String
        public let requestpayer: RequestPayer?
        

        init(
            bucket: String,
            key: String,
            requestpayer: RequestPayer?
            
        ) {
            self.bucket = bucket
            self.key = key
            self.requestpayer = requestpayer
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(bucket.restXmlSerialize().node)
            
            element.addChild(key.restXmlSerialize().node)
            
            element.addChild(requestpayer?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> GetObjectTorrentRequest {
            fatalError()
        }
        
        
    }
    
    struct Grant: RestXmlSerializable, AwswiftDeserializable {
        public let grantee: Grantee?
        public let permission: Permission?
        

        init(
            grantee: Grantee?,
            permission: Permission?
            
        ) {
            self.grantee = grantee
            self.permission = permission
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(grantee?.restXmlSerialize().node)
            
            element.addChild(permission?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> Grant {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let grantee = try! body.nodes(forXPath: "Grantee").first.flatMapNoNulls { v in
                return Grantee.deserialize(response: response, body: v)
            }
            
            let permission = try! body.nodes(forXPath: "Permission").first.flatMapNoNulls { v in
                return Permission.deserialize(response: response, body: v)
            }
            

            return Grant(
                
                grantee: grantee,
                
                permission: permission
                
            )
        }
        
    }
    
    struct Grantee: RestXmlSerializable, AwswiftDeserializable {
        public let displayname: String?
        public let emailaddress: String?
        public let id: String?
        public let s3type: S3Type
        public let uri: String?
        

        init(
            displayname: String?,
            emailaddress: String?,
            id: String?,
            s3type: S3Type,
            uri: String?
            
        ) {
            self.displayname = displayname
            self.emailaddress = emailaddress
            self.id = id
            self.s3type = s3type
            self.uri = uri
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(displayname?.restXmlSerialize().node)
            
            element.addChild(emailaddress?.restXmlSerialize().node)
            
            element.addChild(id?.restXmlSerialize().node)
            
            element.addChild(s3type.restXmlSerialize().node)
            
            element.addChild(uri?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> Grantee {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let displayname = try! body.nodes(forXPath: "DisplayName").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let emailaddress = try! body.nodes(forXPath: "EmailAddress").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let id = try! body.nodes(forXPath: "ID").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let s3type = try! body.nodes(forXPath: "xsi:type").first.flatMapNoNulls { v in
                return S3Type.deserialize(response: response, body: v)
            }
            
            let uri = try! body.nodes(forXPath: "URI").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return Grantee(
                
                displayname: displayname,
                
                emailaddress: emailaddress,
                
                id: id,
                
                s3type: s3type!,
                
                uri: uri
                
            )
        }
        
    }
    
    struct HeadBucketRequest: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String
        

        init(
            bucket: String
            
        ) {
            self.bucket = bucket
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(bucket.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> HeadBucketRequest {
            fatalError()
        }
        
        
    }
    
    struct HeadObjectOutput: RestXmlSerializable, AwswiftDeserializable {
        public let acceptranges: String?
        public let cachecontrol: String?
        public let contentdisposition: String?
        public let contentencoding: String?
        public let contentlanguage: String?
        public let contentlength: Int?
        public let contenttype: String?
        public let deletemarker: Bool?
        public let etag: String?
        public let expiration: String?
        public let expires: Date?
        public let lastmodified: Date?
        public let metadata: [String: String]?
        public let missingmeta: Int?
        public let partscount: Int?
        public let replicationstatus: ReplicationStatus?
        public let requestcharged: RequestCharged?
        public let restore: String?
        public let ssecustomeralgorithm: String?
        public let ssecustomerkeymd5: String?
        public let ssekmskeyid: String?
        public let serversideencryption: ServerSideEncryption?
        public let storageclass: StorageClass?
        public let versionid: String?
        public let websiteredirectlocation: String?
        

        init(
            acceptranges: String?,
            cachecontrol: String?,
            contentdisposition: String?,
            contentencoding: String?,
            contentlanguage: String?,
            contentlength: Int?,
            contenttype: String?,
            deletemarker: Bool?,
            etag: String?,
            expiration: String?,
            expires: Date?,
            lastmodified: Date?,
            metadata: [String: String]?,
            missingmeta: Int?,
            partscount: Int?,
            replicationstatus: ReplicationStatus?,
            requestcharged: RequestCharged?,
            restore: String?,
            ssecustomeralgorithm: String?,
            ssecustomerkeymd5: String?,
            ssekmskeyid: String?,
            serversideencryption: ServerSideEncryption?,
            storageclass: StorageClass?,
            versionid: String?,
            websiteredirectlocation: String?
            
        ) {
            self.acceptranges = acceptranges
            self.cachecontrol = cachecontrol
            self.contentdisposition = contentdisposition
            self.contentencoding = contentencoding
            self.contentlanguage = contentlanguage
            self.contentlength = contentlength
            self.contenttype = contenttype
            self.deletemarker = deletemarker
            self.etag = etag
            self.expiration = expiration
            self.expires = expires
            self.lastmodified = lastmodified
            self.metadata = metadata
            self.missingmeta = missingmeta
            self.partscount = partscount
            self.replicationstatus = replicationstatus
            self.requestcharged = requestcharged
            self.restore = restore
            self.ssecustomeralgorithm = ssecustomeralgorithm
            self.ssecustomerkeymd5 = ssecustomerkeymd5
            self.ssekmskeyid = ssekmskeyid
            self.serversideencryption = serversideencryption
            self.storageclass = storageclass
            self.versionid = versionid
            self.websiteredirectlocation = websiteredirectlocation
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            element.addChild(acceptranges?.restXmlSerialize().node)
            
            element.addChild(cachecontrol?.restXmlSerialize().node)
            
            element.addChild(contentdisposition?.restXmlSerialize().node)
            
            element.addChild(contentencoding?.restXmlSerialize().node)
            
            element.addChild(contentlanguage?.restXmlSerialize().node)
            
            element.addChild(contentlength?.restXmlSerialize().node)
            
            element.addChild(contenttype?.restXmlSerialize().node)
            
            element.addChild(deletemarker?.restXmlSerialize().node)
            
            element.addChild(etag?.restXmlSerialize().node)
            
            element.addChild(expiration?.restXmlSerialize().node)
            
            element.addChild(expires?.restXmlSerialize().node)
            
            element.addChild(lastmodified?.restXmlSerialize().node)
            
            element.addChild(metadata?.restXmlSerialize().node)
            
            element.addChild(missingmeta?.restXmlSerialize().node)
            
            element.addChild(partscount?.restXmlSerialize().node)
            
            element.addChild(replicationstatus?.restXmlSerialize().node)
            
            element.addChild(requestcharged?.restXmlSerialize().node)
            
            element.addChild(restore?.restXmlSerialize().node)
            
            element.addChild(ssecustomeralgorithm?.restXmlSerialize().node)
            
            element.addChild(ssecustomerkeymd5?.restXmlSerialize().node)
            
            element.addChild(ssekmskeyid?.restXmlSerialize().node)
            
            element.addChild(serversideencryption?.restXmlSerialize().node)
            
            element.addChild(storageclass?.restXmlSerialize().node)
            
            element.addChild(versionid?.restXmlSerialize().node)
            
            element.addChild(websiteredirectlocation?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> HeadObjectOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let acceptranges = try! body.nodes(forXPath: "accept-ranges").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let cachecontrol = try! body.nodes(forXPath: "Cache-Control").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let contentdisposition = try! body.nodes(forXPath: "Content-Disposition").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let contentencoding = try! body.nodes(forXPath: "Content-Encoding").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let contentlanguage = try! body.nodes(forXPath: "Content-Language").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let contentlength = try! body.nodes(forXPath: "Content-Length").first.flatMapNoNulls { v in
                return Int.deserialize(response: response, body: v)
            }
            
            let contenttype = try! body.nodes(forXPath: "Content-Type").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let deletemarker = try! body.nodes(forXPath: "x-amz-delete-marker").first.flatMapNoNulls { v in
                return Bool.deserialize(response: response, body: v)
            }
            
            let etag = try! body.nodes(forXPath: "ETag").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let expiration = try! body.nodes(forXPath: "x-amz-expiration").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let expires = try! body.nodes(forXPath: "Expires").first.flatMapNoNulls { v in
                return Date.deserialize(response: response, body: v)
            }
            
            let lastmodified = try! body.nodes(forXPath: "Last-Modified").first.flatMapNoNulls { v in
                return Date.deserialize(response: response, body: v)
            }
            
            let metadata = try! body.nodes(forXPath: "x-amz-meta-").first.flatMapNoNulls { v in
                return [String: String].deserialize(response: response, body: v)
            }
            
            let missingmeta = try! body.nodes(forXPath: "x-amz-missing-meta").first.flatMapNoNulls { v in
                return Int.deserialize(response: response, body: v)
            }
            
            let partscount = try! body.nodes(forXPath: "x-amz-mp-parts-count").first.flatMapNoNulls { v in
                return Int.deserialize(response: response, body: v)
            }
            
            let replicationstatus = try! body.nodes(forXPath: "x-amz-replication-status").first.flatMapNoNulls { v in
                return ReplicationStatus.deserialize(response: response, body: v)
            }
            
            let requestcharged = try! body.nodes(forXPath: "x-amz-request-charged").first.flatMapNoNulls { v in
                return RequestCharged.deserialize(response: response, body: v)
            }
            
            let restore = try! body.nodes(forXPath: "x-amz-restore").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let ssecustomeralgorithm = try! body.nodes(forXPath: "x-amz-server-side-encryption-customer-algorithm").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let ssecustomerkeymd5 = try! body.nodes(forXPath: "x-amz-server-side-encryption-customer-key-MD5").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let ssekmskeyid = try! body.nodes(forXPath: "x-amz-server-side-encryption-aws-kms-key-id").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let serversideencryption = try! body.nodes(forXPath: "x-amz-server-side-encryption").first.flatMapNoNulls { v in
                return ServerSideEncryption.deserialize(response: response, body: v)
            }
            
            let storageclass = try! body.nodes(forXPath: "x-amz-storage-class").first.flatMapNoNulls { v in
                return StorageClass.deserialize(response: response, body: v)
            }
            
            let versionid = try! body.nodes(forXPath: "x-amz-version-id").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let websiteredirectlocation = try! body.nodes(forXPath: "x-amz-website-redirect-location").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return HeadObjectOutput(
                
                acceptranges: acceptranges,
                
                cachecontrol: cachecontrol,
                
                contentdisposition: contentdisposition,
                
                contentencoding: contentencoding,
                
                contentlanguage: contentlanguage,
                
                contentlength: contentlength,
                
                contenttype: contenttype,
                
                deletemarker: deletemarker,
                
                etag: etag,
                
                expiration: expiration,
                
                expires: expires,
                
                lastmodified: lastmodified,
                
                metadata: metadata,
                
                missingmeta: missingmeta,
                
                partscount: partscount,
                
                replicationstatus: replicationstatus,
                
                requestcharged: requestcharged,
                
                restore: restore,
                
                ssecustomeralgorithm: ssecustomeralgorithm,
                
                ssecustomerkeymd5: ssecustomerkeymd5,
                
                ssekmskeyid: ssekmskeyid,
                
                serversideencryption: serversideencryption,
                
                storageclass: storageclass,
                
                versionid: versionid,
                
                websiteredirectlocation: websiteredirectlocation
                
            )
        }
        
    }
    
    struct HeadObjectRequest: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String
        public let ifmatch: String?
        public let ifmodifiedsince: Date?
        public let ifnonematch: String?
        public let ifunmodifiedsince: Date?
        public let key: String
        public let partnumber: Int?
        public let range: String?
        public let requestpayer: RequestPayer?
        public let ssecustomeralgorithm: String?
        public let ssecustomerkey: String?
        public let ssecustomerkeymd5: String?
        public let versionid: String?
        

        init(
            bucket: String,
            ifmatch: String?,
            ifmodifiedsince: Date?,
            ifnonematch: String?,
            ifunmodifiedsince: Date?,
            key: String,
            partnumber: Int?,
            range: String?,
            requestpayer: RequestPayer?,
            ssecustomeralgorithm: String?,
            ssecustomerkey: String?,
            ssecustomerkeymd5: String?,
            versionid: String?
            
        ) {
            self.bucket = bucket
            self.ifmatch = ifmatch
            self.ifmodifiedsince = ifmodifiedsince
            self.ifnonematch = ifnonematch
            self.ifunmodifiedsince = ifunmodifiedsince
            self.key = key
            self.partnumber = partnumber
            self.range = range
            self.requestpayer = requestpayer
            self.ssecustomeralgorithm = ssecustomeralgorithm
            self.ssecustomerkey = ssecustomerkey
            self.ssecustomerkeymd5 = ssecustomerkeymd5
            self.versionid = versionid
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(bucket.restXmlSerialize().node)
            
            element.addChild(ifmatch?.restXmlSerialize().node)
            
            element.addChild(ifmodifiedsince?.restXmlSerialize().node)
            
            element.addChild(ifnonematch?.restXmlSerialize().node)
            
            element.addChild(ifunmodifiedsince?.restXmlSerialize().node)
            
            element.addChild(key.restXmlSerialize().node)
            
            element.addChild(partnumber?.restXmlSerialize().node)
            
            element.addChild(range?.restXmlSerialize().node)
            
            element.addChild(requestpayer?.restXmlSerialize().node)
            
            element.addChild(ssecustomeralgorithm?.restXmlSerialize().node)
            
            element.addChild(ssecustomerkey?.restXmlSerialize().node)
            
            element.addChild(ssecustomerkeymd5?.restXmlSerialize().node)
            
            element.addChild(versionid?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> HeadObjectRequest {
            fatalError()
        }
        
        
    }
    
    struct IndexDocument: RestXmlSerializable, AwswiftDeserializable {
        public let suffix: String
        

        init(
            suffix: String
            
        ) {
            self.suffix = suffix
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(suffix.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> IndexDocument {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let suffix = try! body.nodes(forXPath: "Suffix").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return IndexDocument(
                
                suffix: suffix!
                
            )
        }
        
    }
    
    struct Initiator: RestXmlSerializable, AwswiftDeserializable {
        public let displayname: String?
        public let id: String?
        

        init(
            displayname: String?,
            id: String?
            
        ) {
            self.displayname = displayname
            self.id = id
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(displayname?.restXmlSerialize().node)
            
            element.addChild(id?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> Initiator {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let displayname = try! body.nodes(forXPath: "DisplayName").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let id = try! body.nodes(forXPath: "ID").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return Initiator(
                
                displayname: displayname,
                
                id: id
                
            )
        }
        
    }
    
    struct LambdaFunctionConfiguration: RestXmlSerializable, AwswiftDeserializable {
        public let events: [Event]
        public let filter: NotificationConfigurationFilter?
        public let id: String?
        public let lambdafunctionarn: String
        

        init(
            events: [Event],
            filter: NotificationConfigurationFilter?,
            id: String?,
            lambdafunctionarn: String
            
        ) {
            self.events = events
            self.filter = filter
            self.id = id
            self.lambdafunctionarn = lambdafunctionarn
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(events.restXmlSerialize().node)
            
            element.addChild(filter?.restXmlSerialize().node)
            
            element.addChild(id?.restXmlSerialize().node)
            
            element.addChild(lambdafunctionarn.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> LambdaFunctionConfiguration {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let events = try! body.nodes(forXPath: "Event").first.flatMapNoNulls { v in
                return [Event].deserialize(response: response, body: v)
            }
            
            let filter = try! body.nodes(forXPath: "Filter").first.flatMapNoNulls { v in
                return NotificationConfigurationFilter.deserialize(response: response, body: v)
            }
            
            let id = try! body.nodes(forXPath: "Id").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let lambdafunctionarn = try! body.nodes(forXPath: "CloudFunction").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return LambdaFunctionConfiguration(
                
                events: events!,
                
                filter: filter,
                
                id: id,
                
                lambdafunctionarn: lambdafunctionarn!
                
            )
        }
        
    }
    
    struct LifecycleConfiguration: RestXmlSerializable, AwswiftDeserializable {
        public let rules: [Rule]
        

        init(
            rules: [Rule]
            
        ) {
            self.rules = rules
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(rules.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> LifecycleConfiguration {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let rules = try! body.nodes(forXPath: "Rule").first.flatMapNoNulls { v in
                return [Rule].deserialize(response: response, body: v)
            }
            

            return LifecycleConfiguration(
                
                rules: rules!
                
            )
        }
        
    }
    
    struct LifecycleExpiration: RestXmlSerializable, AwswiftDeserializable {
        public let date: Date?
        public let days: Int?
        public let expiredobjectdeletemarker: Bool?
        

        init(
            date: Date?,
            days: Int?,
            expiredobjectdeletemarker: Bool?
            
        ) {
            self.date = date
            self.days = days
            self.expiredobjectdeletemarker = expiredobjectdeletemarker
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(date?.restXmlSerialize().node)
            
            element.addChild(days?.restXmlSerialize().node)
            
            element.addChild(expiredobjectdeletemarker?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> LifecycleExpiration {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let date = try! body.nodes(forXPath: "Date").first.flatMapNoNulls { v in
                return Date.deserialize(response: response, body: v)
            }
            
            let days = try! body.nodes(forXPath: "Days").first.flatMapNoNulls { v in
                return Int.deserialize(response: response, body: v)
            }
            
            let expiredobjectdeletemarker = try! body.nodes(forXPath: "ExpiredObjectDeleteMarker").first.flatMapNoNulls { v in
                return Bool.deserialize(response: response, body: v)
            }
            

            return LifecycleExpiration(
                
                date: date,
                
                days: days,
                
                expiredobjectdeletemarker: expiredobjectdeletemarker
                
            )
        }
        
    }
    
    struct LifecycleRule: RestXmlSerializable, AwswiftDeserializable {
        public let abortincompletemultipartupload: AbortIncompleteMultipartUpload?
        public let expiration: LifecycleExpiration?
        public let id: String?
        public let noncurrentversionexpiration: NoncurrentVersionExpiration?
        public let noncurrentversiontransitions: [NoncurrentVersionTransition]?
        public let prefix: String
        public let status: ExpirationStatus
        public let transitions: [Transition]?
        

        init(
            abortincompletemultipartupload: AbortIncompleteMultipartUpload?,
            expiration: LifecycleExpiration?,
            id: String?,
            noncurrentversionexpiration: NoncurrentVersionExpiration?,
            noncurrentversiontransitions: [NoncurrentVersionTransition]?,
            prefix: String,
            status: ExpirationStatus,
            transitions: [Transition]?
            
        ) {
            self.abortincompletemultipartupload = abortincompletemultipartupload
            self.expiration = expiration
            self.id = id
            self.noncurrentversionexpiration = noncurrentversionexpiration
            self.noncurrentversiontransitions = noncurrentversiontransitions
            self.prefix = prefix
            self.status = status
            self.transitions = transitions
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(abortincompletemultipartupload?.restXmlSerialize().node)
            
            element.addChild(expiration?.restXmlSerialize().node)
            
            element.addChild(id?.restXmlSerialize().node)
            
            element.addChild(noncurrentversionexpiration?.restXmlSerialize().node)
            
            element.addChild(noncurrentversiontransitions?.restXmlSerialize().node)
            
            element.addChild(prefix.restXmlSerialize().node)
            
            element.addChild(status.restXmlSerialize().node)
            
            element.addChild(transitions?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> LifecycleRule {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let abortincompletemultipartupload = try! body.nodes(forXPath: "AbortIncompleteMultipartUpload").first.flatMapNoNulls { v in
                return AbortIncompleteMultipartUpload.deserialize(response: response, body: v)
            }
            
            let expiration = try! body.nodes(forXPath: "Expiration").first.flatMapNoNulls { v in
                return LifecycleExpiration.deserialize(response: response, body: v)
            }
            
            let id = try! body.nodes(forXPath: "ID").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let noncurrentversionexpiration = try! body.nodes(forXPath: "NoncurrentVersionExpiration").first.flatMapNoNulls { v in
                return NoncurrentVersionExpiration.deserialize(response: response, body: v)
            }
            
            let noncurrentversiontransitions = try! body.nodes(forXPath: "NoncurrentVersionTransition").first.flatMapNoNulls { v in
                return [NoncurrentVersionTransition].deserialize(response: response, body: v)
            }
            
            let prefix = try! body.nodes(forXPath: "Prefix").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let status = try! body.nodes(forXPath: "Status").first.flatMapNoNulls { v in
                return ExpirationStatus.deserialize(response: response, body: v)
            }
            
            let transitions = try! body.nodes(forXPath: "Transition").first.flatMapNoNulls { v in
                return [Transition].deserialize(response: response, body: v)
            }
            

            return LifecycleRule(
                
                abortincompletemultipartupload: abortincompletemultipartupload,
                
                expiration: expiration,
                
                id: id,
                
                noncurrentversionexpiration: noncurrentversionexpiration,
                
                noncurrentversiontransitions: noncurrentversiontransitions,
                
                prefix: prefix!,
                
                status: status!,
                
                transitions: transitions
                
            )
        }
        
    }
    
    struct ListBucketsOutput: RestXmlSerializable, AwswiftDeserializable {
        public let buckets: [Bucket]?
        public let owner: Owner?
        

        init(
            buckets: [Bucket]?,
            owner: Owner?
            
        ) {
            self.buckets = buckets
            self.owner = owner
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            element.addChild(buckets?.restXmlSerialize().node)
            
            element.addChild(owner?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> ListBucketsOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let buckets = try! body.nodes(forXPath: "Buckets").first.flatMapNoNulls { v in
                return [Bucket].deserialize(response: response, body: v)
            }
            
            let owner = try! body.nodes(forXPath: "Owner").first.flatMapNoNulls { v in
                return Owner.deserialize(response: response, body: v)
            }
            

            return ListBucketsOutput(
                
                buckets: buckets,
                
                owner: owner
                
            )
        }
        
    }
    
    struct ListMultipartUploadsOutput: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String?
        public let commonprefixes: [CommonPrefix]?
        public let delimiter: String?
        public let encodingtype: EncodingType?
        public let istruncated: Bool?
        public let keymarker: String?
        public let maxuploads: Int?
        public let nextkeymarker: String?
        public let nextuploadidmarker: String?
        public let prefix: String?
        public let uploadidmarker: String?
        public let uploads: [MultipartUpload]?
        

        init(
            bucket: String?,
            commonprefixes: [CommonPrefix]?,
            delimiter: String?,
            encodingtype: EncodingType?,
            istruncated: Bool?,
            keymarker: String?,
            maxuploads: Int?,
            nextkeymarker: String?,
            nextuploadidmarker: String?,
            prefix: String?,
            uploadidmarker: String?,
            uploads: [MultipartUpload]?
            
        ) {
            self.bucket = bucket
            self.commonprefixes = commonprefixes
            self.delimiter = delimiter
            self.encodingtype = encodingtype
            self.istruncated = istruncated
            self.keymarker = keymarker
            self.maxuploads = maxuploads
            self.nextkeymarker = nextkeymarker
            self.nextuploadidmarker = nextuploadidmarker
            self.prefix = prefix
            self.uploadidmarker = uploadidmarker
            self.uploads = uploads
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            element.addChild(bucket?.restXmlSerialize().node)
            
            element.addChild(commonprefixes?.restXmlSerialize().node)
            
            element.addChild(delimiter?.restXmlSerialize().node)
            
            element.addChild(encodingtype?.restXmlSerialize().node)
            
            element.addChild(istruncated?.restXmlSerialize().node)
            
            element.addChild(keymarker?.restXmlSerialize().node)
            
            element.addChild(maxuploads?.restXmlSerialize().node)
            
            element.addChild(nextkeymarker?.restXmlSerialize().node)
            
            element.addChild(nextuploadidmarker?.restXmlSerialize().node)
            
            element.addChild(prefix?.restXmlSerialize().node)
            
            element.addChild(uploadidmarker?.restXmlSerialize().node)
            
            element.addChild(uploads?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> ListMultipartUploadsOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let bucket = try! body.nodes(forXPath: "Bucket").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let commonprefixes = try! body.nodes(forXPath: "CommonPrefixes").first.flatMapNoNulls { v in
                return [CommonPrefix].deserialize(response: response, body: v)
            }
            
            let delimiter = try! body.nodes(forXPath: "Delimiter").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let encodingtype = try! body.nodes(forXPath: "EncodingType").first.flatMapNoNulls { v in
                return EncodingType.deserialize(response: response, body: v)
            }
            
            let istruncated = try! body.nodes(forXPath: "IsTruncated").first.flatMapNoNulls { v in
                return Bool.deserialize(response: response, body: v)
            }
            
            let keymarker = try! body.nodes(forXPath: "KeyMarker").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let maxuploads = try! body.nodes(forXPath: "MaxUploads").first.flatMapNoNulls { v in
                return Int.deserialize(response: response, body: v)
            }
            
            let nextkeymarker = try! body.nodes(forXPath: "NextKeyMarker").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let nextuploadidmarker = try! body.nodes(forXPath: "NextUploadIdMarker").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let prefix = try! body.nodes(forXPath: "Prefix").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let uploadidmarker = try! body.nodes(forXPath: "UploadIdMarker").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let uploads = try! body.nodes(forXPath: "Upload").first.flatMapNoNulls { v in
                return [MultipartUpload].deserialize(response: response, body: v)
            }
            

            return ListMultipartUploadsOutput(
                
                bucket: bucket,
                
                commonprefixes: commonprefixes,
                
                delimiter: delimiter,
                
                encodingtype: encodingtype,
                
                istruncated: istruncated,
                
                keymarker: keymarker,
                
                maxuploads: maxuploads,
                
                nextkeymarker: nextkeymarker,
                
                nextuploadidmarker: nextuploadidmarker,
                
                prefix: prefix,
                
                uploadidmarker: uploadidmarker,
                
                uploads: uploads
                
            )
        }
        
    }
    
    struct ListMultipartUploadsRequest: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String
        public let delimiter: String?
        public let encodingtype: EncodingType?
        public let keymarker: String?
        public let maxuploads: Int?
        public let prefix: String?
        public let uploadidmarker: String?
        

        init(
            bucket: String,
            delimiter: String?,
            encodingtype: EncodingType?,
            keymarker: String?,
            maxuploads: Int?,
            prefix: String?,
            uploadidmarker: String?
            
        ) {
            self.bucket = bucket
            self.delimiter = delimiter
            self.encodingtype = encodingtype
            self.keymarker = keymarker
            self.maxuploads = maxuploads
            self.prefix = prefix
            self.uploadidmarker = uploadidmarker
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(bucket.restXmlSerialize().node)
            
            element.addChild(delimiter?.restXmlSerialize().node)
            
            element.addChild(encodingtype?.restXmlSerialize().node)
            
            element.addChild(keymarker?.restXmlSerialize().node)
            
            element.addChild(maxuploads?.restXmlSerialize().node)
            
            element.addChild(prefix?.restXmlSerialize().node)
            
            element.addChild(uploadidmarker?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> ListMultipartUploadsRequest {
            fatalError()
        }
        
        
    }
    
    struct ListObjectVersionsOutput: RestXmlSerializable, AwswiftDeserializable {
        public let commonprefixes: [CommonPrefix]?
        public let deletemarkers: [DeleteMarkerEntry]?
        public let delimiter: String?
        public let encodingtype: EncodingType?
        public let istruncated: Bool?
        public let keymarker: String?
        public let maxkeys: Int?
        public let name: String?
        public let nextkeymarker: String?
        public let nextversionidmarker: String?
        public let prefix: String?
        public let versionidmarker: String?
        public let versions: [ObjectVersion]?
        

        init(
            commonprefixes: [CommonPrefix]?,
            deletemarkers: [DeleteMarkerEntry]?,
            delimiter: String?,
            encodingtype: EncodingType?,
            istruncated: Bool?,
            keymarker: String?,
            maxkeys: Int?,
            name: String?,
            nextkeymarker: String?,
            nextversionidmarker: String?,
            prefix: String?,
            versionidmarker: String?,
            versions: [ObjectVersion]?
            
        ) {
            self.commonprefixes = commonprefixes
            self.deletemarkers = deletemarkers
            self.delimiter = delimiter
            self.encodingtype = encodingtype
            self.istruncated = istruncated
            self.keymarker = keymarker
            self.maxkeys = maxkeys
            self.name = name
            self.nextkeymarker = nextkeymarker
            self.nextversionidmarker = nextversionidmarker
            self.prefix = prefix
            self.versionidmarker = versionidmarker
            self.versions = versions
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            element.addChild(commonprefixes?.restXmlSerialize().node)
            
            element.addChild(deletemarkers?.restXmlSerialize().node)
            
            element.addChild(delimiter?.restXmlSerialize().node)
            
            element.addChild(encodingtype?.restXmlSerialize().node)
            
            element.addChild(istruncated?.restXmlSerialize().node)
            
            element.addChild(keymarker?.restXmlSerialize().node)
            
            element.addChild(maxkeys?.restXmlSerialize().node)
            
            element.addChild(name?.restXmlSerialize().node)
            
            element.addChild(nextkeymarker?.restXmlSerialize().node)
            
            element.addChild(nextversionidmarker?.restXmlSerialize().node)
            
            element.addChild(prefix?.restXmlSerialize().node)
            
            element.addChild(versionidmarker?.restXmlSerialize().node)
            
            element.addChild(versions?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> ListObjectVersionsOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let commonprefixes = try! body.nodes(forXPath: "CommonPrefixes").first.flatMapNoNulls { v in
                return [CommonPrefix].deserialize(response: response, body: v)
            }
            
            let deletemarkers = try! body.nodes(forXPath: "DeleteMarker").first.flatMapNoNulls { v in
                return [DeleteMarkerEntry].deserialize(response: response, body: v)
            }
            
            let delimiter = try! body.nodes(forXPath: "Delimiter").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let encodingtype = try! body.nodes(forXPath: "EncodingType").first.flatMapNoNulls { v in
                return EncodingType.deserialize(response: response, body: v)
            }
            
            let istruncated = try! body.nodes(forXPath: "IsTruncated").first.flatMapNoNulls { v in
                return Bool.deserialize(response: response, body: v)
            }
            
            let keymarker = try! body.nodes(forXPath: "KeyMarker").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let maxkeys = try! body.nodes(forXPath: "MaxKeys").first.flatMapNoNulls { v in
                return Int.deserialize(response: response, body: v)
            }
            
            let name = try! body.nodes(forXPath: "Name").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let nextkeymarker = try! body.nodes(forXPath: "NextKeyMarker").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let nextversionidmarker = try! body.nodes(forXPath: "NextVersionIdMarker").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let prefix = try! body.nodes(forXPath: "Prefix").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let versionidmarker = try! body.nodes(forXPath: "VersionIdMarker").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let versions = try! body.nodes(forXPath: "Version").first.flatMapNoNulls { v in
                return [ObjectVersion].deserialize(response: response, body: v)
            }
            

            return ListObjectVersionsOutput(
                
                commonprefixes: commonprefixes,
                
                deletemarkers: deletemarkers,
                
                delimiter: delimiter,
                
                encodingtype: encodingtype,
                
                istruncated: istruncated,
                
                keymarker: keymarker,
                
                maxkeys: maxkeys,
                
                name: name,
                
                nextkeymarker: nextkeymarker,
                
                nextversionidmarker: nextversionidmarker,
                
                prefix: prefix,
                
                versionidmarker: versionidmarker,
                
                versions: versions
                
            )
        }
        
    }
    
    struct ListObjectVersionsRequest: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String
        public let delimiter: String?
        public let encodingtype: EncodingType?
        public let keymarker: String?
        public let maxkeys: Int?
        public let prefix: String?
        public let versionidmarker: String?
        

        init(
            bucket: String,
            delimiter: String?,
            encodingtype: EncodingType?,
            keymarker: String?,
            maxkeys: Int?,
            prefix: String?,
            versionidmarker: String?
            
        ) {
            self.bucket = bucket
            self.delimiter = delimiter
            self.encodingtype = encodingtype
            self.keymarker = keymarker
            self.maxkeys = maxkeys
            self.prefix = prefix
            self.versionidmarker = versionidmarker
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(bucket.restXmlSerialize().node)
            
            element.addChild(delimiter?.restXmlSerialize().node)
            
            element.addChild(encodingtype?.restXmlSerialize().node)
            
            element.addChild(keymarker?.restXmlSerialize().node)
            
            element.addChild(maxkeys?.restXmlSerialize().node)
            
            element.addChild(prefix?.restXmlSerialize().node)
            
            element.addChild(versionidmarker?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> ListObjectVersionsRequest {
            fatalError()
        }
        
        
    }
    
    struct ListObjectsOutput: RestXmlSerializable, AwswiftDeserializable {
        public let commonprefixes: [CommonPrefix]?
        public let contents: [Object]?
        public let delimiter: String?
        public let encodingtype: EncodingType?
        public let istruncated: Bool?
        public let marker: String?
        public let maxkeys: Int?
        public let name: String?
        public let nextmarker: String?
        public let prefix: String?
        

        init(
            commonprefixes: [CommonPrefix]?,
            contents: [Object]?,
            delimiter: String?,
            encodingtype: EncodingType?,
            istruncated: Bool?,
            marker: String?,
            maxkeys: Int?,
            name: String?,
            nextmarker: String?,
            prefix: String?
            
        ) {
            self.commonprefixes = commonprefixes
            self.contents = contents
            self.delimiter = delimiter
            self.encodingtype = encodingtype
            self.istruncated = istruncated
            self.marker = marker
            self.maxkeys = maxkeys
            self.name = name
            self.nextmarker = nextmarker
            self.prefix = prefix
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            element.addChild(commonprefixes?.restXmlSerialize().node)
            
            element.addChild(contents?.restXmlSerialize().node)
            
            element.addChild(delimiter?.restXmlSerialize().node)
            
            element.addChild(encodingtype?.restXmlSerialize().node)
            
            element.addChild(istruncated?.restXmlSerialize().node)
            
            element.addChild(marker?.restXmlSerialize().node)
            
            element.addChild(maxkeys?.restXmlSerialize().node)
            
            element.addChild(name?.restXmlSerialize().node)
            
            element.addChild(nextmarker?.restXmlSerialize().node)
            
            element.addChild(prefix?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> ListObjectsOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let commonprefixes = try! body.nodes(forXPath: "CommonPrefixes").first.flatMapNoNulls { v in
                return [CommonPrefix].deserialize(response: response, body: v)
            }
            
            let contents = try! body.nodes(forXPath: "Contents").first.flatMapNoNulls { v in
                return [Object].deserialize(response: response, body: v)
            }
            
            let delimiter = try! body.nodes(forXPath: "Delimiter").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let encodingtype = try! body.nodes(forXPath: "EncodingType").first.flatMapNoNulls { v in
                return EncodingType.deserialize(response: response, body: v)
            }
            
            let istruncated = try! body.nodes(forXPath: "IsTruncated").first.flatMapNoNulls { v in
                return Bool.deserialize(response: response, body: v)
            }
            
            let marker = try! body.nodes(forXPath: "Marker").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let maxkeys = try! body.nodes(forXPath: "MaxKeys").first.flatMapNoNulls { v in
                return Int.deserialize(response: response, body: v)
            }
            
            let name = try! body.nodes(forXPath: "Name").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let nextmarker = try! body.nodes(forXPath: "NextMarker").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let prefix = try! body.nodes(forXPath: "Prefix").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return ListObjectsOutput(
                
                commonprefixes: commonprefixes,
                
                contents: contents,
                
                delimiter: delimiter,
                
                encodingtype: encodingtype,
                
                istruncated: istruncated,
                
                marker: marker,
                
                maxkeys: maxkeys,
                
                name: name,
                
                nextmarker: nextmarker,
                
                prefix: prefix
                
            )
        }
        
    }
    
    struct ListObjectsRequest: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String
        public let delimiter: String?
        public let encodingtype: EncodingType?
        public let marker: String?
        public let maxkeys: Int?
        public let prefix: String?
        public let requestpayer: RequestPayer?
        

        init(
            bucket: String,
            delimiter: String?,
            encodingtype: EncodingType?,
            marker: String?,
            maxkeys: Int?,
            prefix: String?,
            requestpayer: RequestPayer?
            
        ) {
            self.bucket = bucket
            self.delimiter = delimiter
            self.encodingtype = encodingtype
            self.marker = marker
            self.maxkeys = maxkeys
            self.prefix = prefix
            self.requestpayer = requestpayer
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(bucket.restXmlSerialize().node)
            
            element.addChild(delimiter?.restXmlSerialize().node)
            
            element.addChild(encodingtype?.restXmlSerialize().node)
            
            element.addChild(marker?.restXmlSerialize().node)
            
            element.addChild(maxkeys?.restXmlSerialize().node)
            
            element.addChild(prefix?.restXmlSerialize().node)
            
            element.addChild(requestpayer?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> ListObjectsRequest {
            fatalError()
        }
        
        
    }
    
    struct ListObjectsV2Output: RestXmlSerializable, AwswiftDeserializable {
        public let commonprefixes: [CommonPrefix]?
        public let contents: [Object]?
        public let continuationtoken: String?
        public let delimiter: String?
        public let encodingtype: EncodingType?
        public let istruncated: Bool?
        public let keycount: Int?
        public let maxkeys: Int?
        public let name: String?
        public let nextcontinuationtoken: String?
        public let prefix: String?
        public let startafter: String?
        

        init(
            commonprefixes: [CommonPrefix]?,
            contents: [Object]?,
            continuationtoken: String?,
            delimiter: String?,
            encodingtype: EncodingType?,
            istruncated: Bool?,
            keycount: Int?,
            maxkeys: Int?,
            name: String?,
            nextcontinuationtoken: String?,
            prefix: String?,
            startafter: String?
            
        ) {
            self.commonprefixes = commonprefixes
            self.contents = contents
            self.continuationtoken = continuationtoken
            self.delimiter = delimiter
            self.encodingtype = encodingtype
            self.istruncated = istruncated
            self.keycount = keycount
            self.maxkeys = maxkeys
            self.name = name
            self.nextcontinuationtoken = nextcontinuationtoken
            self.prefix = prefix
            self.startafter = startafter
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            element.addChild(commonprefixes?.restXmlSerialize().node)
            
            element.addChild(contents?.restXmlSerialize().node)
            
            element.addChild(continuationtoken?.restXmlSerialize().node)
            
            element.addChild(delimiter?.restXmlSerialize().node)
            
            element.addChild(encodingtype?.restXmlSerialize().node)
            
            element.addChild(istruncated?.restXmlSerialize().node)
            
            element.addChild(keycount?.restXmlSerialize().node)
            
            element.addChild(maxkeys?.restXmlSerialize().node)
            
            element.addChild(name?.restXmlSerialize().node)
            
            element.addChild(nextcontinuationtoken?.restXmlSerialize().node)
            
            element.addChild(prefix?.restXmlSerialize().node)
            
            element.addChild(startafter?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> ListObjectsV2Output {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let commonprefixes = try! body.nodes(forXPath: "CommonPrefixes").first.flatMapNoNulls { v in
                return [CommonPrefix].deserialize(response: response, body: v)
            }
            
            let contents = try! body.nodes(forXPath: "Contents").first.flatMapNoNulls { v in
                return [Object].deserialize(response: response, body: v)
            }
            
            let continuationtoken = try! body.nodes(forXPath: "ContinuationToken").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let delimiter = try! body.nodes(forXPath: "Delimiter").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let encodingtype = try! body.nodes(forXPath: "EncodingType").first.flatMapNoNulls { v in
                return EncodingType.deserialize(response: response, body: v)
            }
            
            let istruncated = try! body.nodes(forXPath: "IsTruncated").first.flatMapNoNulls { v in
                return Bool.deserialize(response: response, body: v)
            }
            
            let keycount = try! body.nodes(forXPath: "KeyCount").first.flatMapNoNulls { v in
                return Int.deserialize(response: response, body: v)
            }
            
            let maxkeys = try! body.nodes(forXPath: "MaxKeys").first.flatMapNoNulls { v in
                return Int.deserialize(response: response, body: v)
            }
            
            let name = try! body.nodes(forXPath: "Name").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let nextcontinuationtoken = try! body.nodes(forXPath: "NextContinuationToken").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let prefix = try! body.nodes(forXPath: "Prefix").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let startafter = try! body.nodes(forXPath: "StartAfter").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return ListObjectsV2Output(
                
                commonprefixes: commonprefixes,
                
                contents: contents,
                
                continuationtoken: continuationtoken,
                
                delimiter: delimiter,
                
                encodingtype: encodingtype,
                
                istruncated: istruncated,
                
                keycount: keycount,
                
                maxkeys: maxkeys,
                
                name: name,
                
                nextcontinuationtoken: nextcontinuationtoken,
                
                prefix: prefix,
                
                startafter: startafter
                
            )
        }
        
    }
    
    struct ListObjectsV2Request: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String
        public let continuationtoken: String?
        public let delimiter: String?
        public let encodingtype: EncodingType?
        public let fetchowner: Bool?
        public let maxkeys: Int?
        public let prefix: String?
        public let requestpayer: RequestPayer?
        public let startafter: String?
        

        init(
            bucket: String,
            continuationtoken: String?,
            delimiter: String?,
            encodingtype: EncodingType?,
            fetchowner: Bool?,
            maxkeys: Int?,
            prefix: String?,
            requestpayer: RequestPayer?,
            startafter: String?
            
        ) {
            self.bucket = bucket
            self.continuationtoken = continuationtoken
            self.delimiter = delimiter
            self.encodingtype = encodingtype
            self.fetchowner = fetchowner
            self.maxkeys = maxkeys
            self.prefix = prefix
            self.requestpayer = requestpayer
            self.startafter = startafter
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(bucket.restXmlSerialize().node)
            
            element.addChild(continuationtoken?.restXmlSerialize().node)
            
            element.addChild(delimiter?.restXmlSerialize().node)
            
            element.addChild(encodingtype?.restXmlSerialize().node)
            
            element.addChild(fetchowner?.restXmlSerialize().node)
            
            element.addChild(maxkeys?.restXmlSerialize().node)
            
            element.addChild(prefix?.restXmlSerialize().node)
            
            element.addChild(requestpayer?.restXmlSerialize().node)
            
            element.addChild(startafter?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> ListObjectsV2Request {
            fatalError()
        }
        
        
    }
    
    struct ListPartsOutput: RestXmlSerializable, AwswiftDeserializable {
        public let abortdate: Date?
        public let abortruleid: String?
        public let bucket: String?
        public let initiator: Initiator?
        public let istruncated: Bool?
        public let key: String?
        public let maxparts: Int?
        public let nextpartnumbermarker: Int?
        public let owner: Owner?
        public let partnumbermarker: Int?
        public let parts: [Part]?
        public let requestcharged: RequestCharged?
        public let storageclass: StorageClass?
        public let uploadid: String?
        

        init(
            abortdate: Date?,
            abortruleid: String?,
            bucket: String?,
            initiator: Initiator?,
            istruncated: Bool?,
            key: String?,
            maxparts: Int?,
            nextpartnumbermarker: Int?,
            owner: Owner?,
            partnumbermarker: Int?,
            parts: [Part]?,
            requestcharged: RequestCharged?,
            storageclass: StorageClass?,
            uploadid: String?
            
        ) {
            self.abortdate = abortdate
            self.abortruleid = abortruleid
            self.bucket = bucket
            self.initiator = initiator
            self.istruncated = istruncated
            self.key = key
            self.maxparts = maxparts
            self.nextpartnumbermarker = nextpartnumbermarker
            self.owner = owner
            self.partnumbermarker = partnumbermarker
            self.parts = parts
            self.requestcharged = requestcharged
            self.storageclass = storageclass
            self.uploadid = uploadid
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            element.addChild(abortdate?.restXmlSerialize().node)
            
            element.addChild(abortruleid?.restXmlSerialize().node)
            
            element.addChild(bucket?.restXmlSerialize().node)
            
            element.addChild(initiator?.restXmlSerialize().node)
            
            element.addChild(istruncated?.restXmlSerialize().node)
            
            element.addChild(key?.restXmlSerialize().node)
            
            element.addChild(maxparts?.restXmlSerialize().node)
            
            element.addChild(nextpartnumbermarker?.restXmlSerialize().node)
            
            element.addChild(owner?.restXmlSerialize().node)
            
            element.addChild(partnumbermarker?.restXmlSerialize().node)
            
            element.addChild(parts?.restXmlSerialize().node)
            
            element.addChild(requestcharged?.restXmlSerialize().node)
            
            element.addChild(storageclass?.restXmlSerialize().node)
            
            element.addChild(uploadid?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> ListPartsOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let abortdate = try! body.nodes(forXPath: "x-amz-abort-date").first.flatMapNoNulls { v in
                return Date.deserialize(response: response, body: v)
            }
            
            let abortruleid = try! body.nodes(forXPath: "x-amz-abort-rule-id").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let bucket = try! body.nodes(forXPath: "Bucket").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let initiator = try! body.nodes(forXPath: "Initiator").first.flatMapNoNulls { v in
                return Initiator.deserialize(response: response, body: v)
            }
            
            let istruncated = try! body.nodes(forXPath: "IsTruncated").first.flatMapNoNulls { v in
                return Bool.deserialize(response: response, body: v)
            }
            
            let key = try! body.nodes(forXPath: "Key").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let maxparts = try! body.nodes(forXPath: "MaxParts").first.flatMapNoNulls { v in
                return Int.deserialize(response: response, body: v)
            }
            
            let nextpartnumbermarker = try! body.nodes(forXPath: "NextPartNumberMarker").first.flatMapNoNulls { v in
                return Int.deserialize(response: response, body: v)
            }
            
            let owner = try! body.nodes(forXPath: "Owner").first.flatMapNoNulls { v in
                return Owner.deserialize(response: response, body: v)
            }
            
            let partnumbermarker = try! body.nodes(forXPath: "PartNumberMarker").first.flatMapNoNulls { v in
                return Int.deserialize(response: response, body: v)
            }
            
            let parts = try! body.nodes(forXPath: "Part").first.flatMapNoNulls { v in
                return [Part].deserialize(response: response, body: v)
            }
            
            let requestcharged = try! body.nodes(forXPath: "x-amz-request-charged").first.flatMapNoNulls { v in
                return RequestCharged.deserialize(response: response, body: v)
            }
            
            let storageclass = try! body.nodes(forXPath: "StorageClass").first.flatMapNoNulls { v in
                return StorageClass.deserialize(response: response, body: v)
            }
            
            let uploadid = try! body.nodes(forXPath: "UploadId").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return ListPartsOutput(
                
                abortdate: abortdate,
                
                abortruleid: abortruleid,
                
                bucket: bucket,
                
                initiator: initiator,
                
                istruncated: istruncated,
                
                key: key,
                
                maxparts: maxparts,
                
                nextpartnumbermarker: nextpartnumbermarker,
                
                owner: owner,
                
                partnumbermarker: partnumbermarker,
                
                parts: parts,
                
                requestcharged: requestcharged,
                
                storageclass: storageclass,
                
                uploadid: uploadid
                
            )
        }
        
    }
    
    struct ListPartsRequest: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String
        public let key: String
        public let maxparts: Int?
        public let partnumbermarker: Int?
        public let requestpayer: RequestPayer?
        public let uploadid: String
        

        init(
            bucket: String,
            key: String,
            maxparts: Int?,
            partnumbermarker: Int?,
            requestpayer: RequestPayer?,
            uploadid: String
            
        ) {
            self.bucket = bucket
            self.key = key
            self.maxparts = maxparts
            self.partnumbermarker = partnumbermarker
            self.requestpayer = requestpayer
            self.uploadid = uploadid
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(bucket.restXmlSerialize().node)
            
            element.addChild(key.restXmlSerialize().node)
            
            element.addChild(maxparts?.restXmlSerialize().node)
            
            element.addChild(partnumbermarker?.restXmlSerialize().node)
            
            element.addChild(requestpayer?.restXmlSerialize().node)
            
            element.addChild(uploadid.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> ListPartsRequest {
            fatalError()
        }
        
        
    }
    
    struct LoggingEnabled: RestXmlSerializable, AwswiftDeserializable {
        public let targetbucket: String?
        public let targetgrants: [TargetGrant]?
        public let targetprefix: String?
        

        init(
            targetbucket: String?,
            targetgrants: [TargetGrant]?,
            targetprefix: String?
            
        ) {
            self.targetbucket = targetbucket
            self.targetgrants = targetgrants
            self.targetprefix = targetprefix
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(targetbucket?.restXmlSerialize().node)
            
            element.addChild(targetgrants?.restXmlSerialize().node)
            
            element.addChild(targetprefix?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> LoggingEnabled {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let targetbucket = try! body.nodes(forXPath: "TargetBucket").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let targetgrants = try! body.nodes(forXPath: "TargetGrants").first.flatMapNoNulls { v in
                return [TargetGrant].deserialize(response: response, body: v)
            }
            
            let targetprefix = try! body.nodes(forXPath: "TargetPrefix").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return LoggingEnabled(
                
                targetbucket: targetbucket,
                
                targetgrants: targetgrants,
                
                targetprefix: targetprefix
                
            )
        }
        
    }
    
    struct MultipartUpload: RestXmlSerializable, AwswiftDeserializable {
        public let initiated: Date?
        public let initiator: Initiator?
        public let key: String?
        public let owner: Owner?
        public let storageclass: StorageClass?
        public let uploadid: String?
        

        init(
            initiated: Date?,
            initiator: Initiator?,
            key: String?,
            owner: Owner?,
            storageclass: StorageClass?,
            uploadid: String?
            
        ) {
            self.initiated = initiated
            self.initiator = initiator
            self.key = key
            self.owner = owner
            self.storageclass = storageclass
            self.uploadid = uploadid
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(initiated?.restXmlSerialize().node)
            
            element.addChild(initiator?.restXmlSerialize().node)
            
            element.addChild(key?.restXmlSerialize().node)
            
            element.addChild(owner?.restXmlSerialize().node)
            
            element.addChild(storageclass?.restXmlSerialize().node)
            
            element.addChild(uploadid?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> MultipartUpload {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let initiated = try! body.nodes(forXPath: "Initiated").first.flatMapNoNulls { v in
                return Date.deserialize(response: response, body: v)
            }
            
            let initiator = try! body.nodes(forXPath: "Initiator").first.flatMapNoNulls { v in
                return Initiator.deserialize(response: response, body: v)
            }
            
            let key = try! body.nodes(forXPath: "Key").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let owner = try! body.nodes(forXPath: "Owner").first.flatMapNoNulls { v in
                return Owner.deserialize(response: response, body: v)
            }
            
            let storageclass = try! body.nodes(forXPath: "StorageClass").first.flatMapNoNulls { v in
                return StorageClass.deserialize(response: response, body: v)
            }
            
            let uploadid = try! body.nodes(forXPath: "UploadId").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return MultipartUpload(
                
                initiated: initiated,
                
                initiator: initiator,
                
                key: key,
                
                owner: owner,
                
                storageclass: storageclass,
                
                uploadid: uploadid
                
            )
        }
        
    }
    
    struct NoSuchBucket: RestXmlSerializable, AwswiftDeserializable {
        

        init(
            
        ) {
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            return .object([:])
            
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> NoSuchBucket {
            guard let body = body as? XMLElement else { fatalError() }
            
            

            return NoSuchBucket(
                
            )
        }
        
    }
    
    struct NoSuchKey: RestXmlSerializable, AwswiftDeserializable {
        

        init(
            
        ) {
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            return .object([:])
            
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> NoSuchKey {
            guard let body = body as? XMLElement else { fatalError() }
            
            

            return NoSuchKey(
                
            )
        }
        
    }
    
    struct NoSuchUpload: RestXmlSerializable, AwswiftDeserializable {
        

        init(
            
        ) {
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            return .object([:])
            
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> NoSuchUpload {
            guard let body = body as? XMLElement else { fatalError() }
            
            

            return NoSuchUpload(
                
            )
        }
        
    }
    
    struct NoncurrentVersionExpiration: RestXmlSerializable, AwswiftDeserializable {
        public let noncurrentdays: Int?
        

        init(
            noncurrentdays: Int?
            
        ) {
            self.noncurrentdays = noncurrentdays
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(noncurrentdays?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> NoncurrentVersionExpiration {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let noncurrentdays = try! body.nodes(forXPath: "NoncurrentDays").first.flatMapNoNulls { v in
                return Int.deserialize(response: response, body: v)
            }
            

            return NoncurrentVersionExpiration(
                
                noncurrentdays: noncurrentdays
                
            )
        }
        
    }
    
    struct NoncurrentVersionTransition: RestXmlSerializable, AwswiftDeserializable {
        public let noncurrentdays: Int?
        public let storageclass: TransitionStorageClass?
        

        init(
            noncurrentdays: Int?,
            storageclass: TransitionStorageClass?
            
        ) {
            self.noncurrentdays = noncurrentdays
            self.storageclass = storageclass
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(noncurrentdays?.restXmlSerialize().node)
            
            element.addChild(storageclass?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> NoncurrentVersionTransition {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let noncurrentdays = try! body.nodes(forXPath: "NoncurrentDays").first.flatMapNoNulls { v in
                return Int.deserialize(response: response, body: v)
            }
            
            let storageclass = try! body.nodes(forXPath: "StorageClass").first.flatMapNoNulls { v in
                return TransitionStorageClass.deserialize(response: response, body: v)
            }
            

            return NoncurrentVersionTransition(
                
                noncurrentdays: noncurrentdays,
                
                storageclass: storageclass
                
            )
        }
        
    }
    
    struct NotificationConfiguration: RestXmlSerializable, AwswiftDeserializable {
        public let lambdafunctionconfigurations: [LambdaFunctionConfiguration]?
        public let queueconfigurations: [QueueConfiguration]?
        public let topicconfigurations: [TopicConfiguration]?
        

        init(
            lambdafunctionconfigurations: [LambdaFunctionConfiguration]?,
            queueconfigurations: [QueueConfiguration]?,
            topicconfigurations: [TopicConfiguration]?
            
        ) {
            self.lambdafunctionconfigurations = lambdafunctionconfigurations
            self.queueconfigurations = queueconfigurations
            self.topicconfigurations = topicconfigurations
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            element.addChild(lambdafunctionconfigurations?.restXmlSerialize().node)
            
            element.addChild(queueconfigurations?.restXmlSerialize().node)
            
            element.addChild(topicconfigurations?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> NotificationConfiguration {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let lambdafunctionconfigurations = try! body.nodes(forXPath: "CloudFunctionConfiguration").first.flatMapNoNulls { v in
                return [LambdaFunctionConfiguration].deserialize(response: response, body: v)
            }
            
            let queueconfigurations = try! body.nodes(forXPath: "QueueConfiguration").first.flatMapNoNulls { v in
                return [QueueConfiguration].deserialize(response: response, body: v)
            }
            
            let topicconfigurations = try! body.nodes(forXPath: "TopicConfiguration").first.flatMapNoNulls { v in
                return [TopicConfiguration].deserialize(response: response, body: v)
            }
            

            return NotificationConfiguration(
                
                lambdafunctionconfigurations: lambdafunctionconfigurations,
                
                queueconfigurations: queueconfigurations,
                
                topicconfigurations: topicconfigurations
                
            )
        }
        
    }
    
    struct NotificationConfigurationDeprecated: RestXmlSerializable, AwswiftDeserializable {
        public let cloudfunctionconfiguration: CloudFunctionConfiguration?
        public let queueconfiguration: QueueConfigurationDeprecated?
        public let topicconfiguration: TopicConfigurationDeprecated?
        

        init(
            cloudfunctionconfiguration: CloudFunctionConfiguration?,
            queueconfiguration: QueueConfigurationDeprecated?,
            topicconfiguration: TopicConfigurationDeprecated?
            
        ) {
            self.cloudfunctionconfiguration = cloudfunctionconfiguration
            self.queueconfiguration = queueconfiguration
            self.topicconfiguration = topicconfiguration
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            element.addChild(cloudfunctionconfiguration?.restXmlSerialize().node)
            
            element.addChild(queueconfiguration?.restXmlSerialize().node)
            
            element.addChild(topicconfiguration?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> NotificationConfigurationDeprecated {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let cloudfunctionconfiguration = try! body.nodes(forXPath: "CloudFunctionConfiguration").first.flatMapNoNulls { v in
                return CloudFunctionConfiguration.deserialize(response: response, body: v)
            }
            
            let queueconfiguration = try! body.nodes(forXPath: "QueueConfiguration").first.flatMapNoNulls { v in
                return QueueConfigurationDeprecated.deserialize(response: response, body: v)
            }
            
            let topicconfiguration = try! body.nodes(forXPath: "TopicConfiguration").first.flatMapNoNulls { v in
                return TopicConfigurationDeprecated.deserialize(response: response, body: v)
            }
            

            return NotificationConfigurationDeprecated(
                
                cloudfunctionconfiguration: cloudfunctionconfiguration,
                
                queueconfiguration: queueconfiguration,
                
                topicconfiguration: topicconfiguration
                
            )
        }
        
    }
    
    struct NotificationConfigurationFilter: RestXmlSerializable, AwswiftDeserializable {
        public let key: S3KeyFilter?
        

        init(
            key: S3KeyFilter?
            
        ) {
            self.key = key
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(key?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> NotificationConfigurationFilter {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let key = try! body.nodes(forXPath: "S3Key").first.flatMapNoNulls { v in
                return S3KeyFilter.deserialize(response: response, body: v)
            }
            

            return NotificationConfigurationFilter(
                
                key: key
                
            )
        }
        
    }
    
    struct Object: RestXmlSerializable, AwswiftDeserializable {
        public let etag: String?
        public let key: String?
        public let lastmodified: Date?
        public let owner: Owner?
        public let size: Int?
        public let storageclass: ObjectStorageClass?
        

        init(
            etag: String?,
            key: String?,
            lastmodified: Date?,
            owner: Owner?,
            size: Int?,
            storageclass: ObjectStorageClass?
            
        ) {
            self.etag = etag
            self.key = key
            self.lastmodified = lastmodified
            self.owner = owner
            self.size = size
            self.storageclass = storageclass
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(etag?.restXmlSerialize().node)
            
            element.addChild(key?.restXmlSerialize().node)
            
            element.addChild(lastmodified?.restXmlSerialize().node)
            
            element.addChild(owner?.restXmlSerialize().node)
            
            element.addChild(size?.restXmlSerialize().node)
            
            element.addChild(storageclass?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> Object {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let etag = try! body.nodes(forXPath: "ETag").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let key = try! body.nodes(forXPath: "Key").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let lastmodified = try! body.nodes(forXPath: "LastModified").first.flatMapNoNulls { v in
                return Date.deserialize(response: response, body: v)
            }
            
            let owner = try! body.nodes(forXPath: "Owner").first.flatMapNoNulls { v in
                return Owner.deserialize(response: response, body: v)
            }
            
            let size = try! body.nodes(forXPath: "Size").first.flatMapNoNulls { v in
                return Int.deserialize(response: response, body: v)
            }
            
            let storageclass = try! body.nodes(forXPath: "StorageClass").first.flatMapNoNulls { v in
                return ObjectStorageClass.deserialize(response: response, body: v)
            }
            

            return Object(
                
                etag: etag,
                
                key: key,
                
                lastmodified: lastmodified,
                
                owner: owner,
                
                size: size,
                
                storageclass: storageclass
                
            )
        }
        
    }
    
    struct ObjectAlreadyInActiveTierError: RestXmlSerializable, AwswiftDeserializable {
        

        init(
            
        ) {
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            return .object([:])
            
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> ObjectAlreadyInActiveTierError {
            guard let body = body as? XMLElement else { fatalError() }
            
            

            return ObjectAlreadyInActiveTierError(
                
            )
        }
        
    }
    
    struct ObjectIdentifier: RestXmlSerializable, AwswiftDeserializable {
        public let key: String
        public let versionid: String?
        

        init(
            key: String,
            versionid: String?
            
        ) {
            self.key = key
            self.versionid = versionid
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(key.restXmlSerialize().node)
            
            element.addChild(versionid?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> ObjectIdentifier {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let key = try! body.nodes(forXPath: "Key").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let versionid = try! body.nodes(forXPath: "VersionId").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return ObjectIdentifier(
                
                key: key!,
                
                versionid: versionid
                
            )
        }
        
    }
    
    struct ObjectNotInActiveTierError: RestXmlSerializable, AwswiftDeserializable {
        

        init(
            
        ) {
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            return .object([:])
            
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> ObjectNotInActiveTierError {
            guard let body = body as? XMLElement else { fatalError() }
            
            

            return ObjectNotInActiveTierError(
                
            )
        }
        
    }
    
    struct ObjectVersion: RestXmlSerializable, AwswiftDeserializable {
        public let etag: String?
        public let islatest: Bool?
        public let key: String?
        public let lastmodified: Date?
        public let owner: Owner?
        public let size: Int?
        public let storageclass: ObjectVersionStorageClass?
        public let versionid: String?
        

        init(
            etag: String?,
            islatest: Bool?,
            key: String?,
            lastmodified: Date?,
            owner: Owner?,
            size: Int?,
            storageclass: ObjectVersionStorageClass?,
            versionid: String?
            
        ) {
            self.etag = etag
            self.islatest = islatest
            self.key = key
            self.lastmodified = lastmodified
            self.owner = owner
            self.size = size
            self.storageclass = storageclass
            self.versionid = versionid
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(etag?.restXmlSerialize().node)
            
            element.addChild(islatest?.restXmlSerialize().node)
            
            element.addChild(key?.restXmlSerialize().node)
            
            element.addChild(lastmodified?.restXmlSerialize().node)
            
            element.addChild(owner?.restXmlSerialize().node)
            
            element.addChild(size?.restXmlSerialize().node)
            
            element.addChild(storageclass?.restXmlSerialize().node)
            
            element.addChild(versionid?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> ObjectVersion {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let etag = try! body.nodes(forXPath: "ETag").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let islatest = try! body.nodes(forXPath: "IsLatest").first.flatMapNoNulls { v in
                return Bool.deserialize(response: response, body: v)
            }
            
            let key = try! body.nodes(forXPath: "Key").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let lastmodified = try! body.nodes(forXPath: "LastModified").first.flatMapNoNulls { v in
                return Date.deserialize(response: response, body: v)
            }
            
            let owner = try! body.nodes(forXPath: "Owner").first.flatMapNoNulls { v in
                return Owner.deserialize(response: response, body: v)
            }
            
            let size = try! body.nodes(forXPath: "Size").first.flatMapNoNulls { v in
                return Int.deserialize(response: response, body: v)
            }
            
            let storageclass = try! body.nodes(forXPath: "StorageClass").first.flatMapNoNulls { v in
                return ObjectVersionStorageClass.deserialize(response: response, body: v)
            }
            
            let versionid = try! body.nodes(forXPath: "VersionId").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return ObjectVersion(
                
                etag: etag,
                
                islatest: islatest,
                
                key: key,
                
                lastmodified: lastmodified,
                
                owner: owner,
                
                size: size,
                
                storageclass: storageclass,
                
                versionid: versionid
                
            )
        }
        
    }
    
    struct Owner: RestXmlSerializable, AwswiftDeserializable {
        public let displayname: String?
        public let id: String?
        

        init(
            displayname: String?,
            id: String?
            
        ) {
            self.displayname = displayname
            self.id = id
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(displayname?.restXmlSerialize().node)
            
            element.addChild(id?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> Owner {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let displayname = try! body.nodes(forXPath: "DisplayName").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let id = try! body.nodes(forXPath: "ID").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return Owner(
                
                displayname: displayname,
                
                id: id
                
            )
        }
        
    }
    
    struct Part: RestXmlSerializable, AwswiftDeserializable {
        public let etag: String?
        public let lastmodified: Date?
        public let partnumber: Int?
        public let size: Int?
        

        init(
            etag: String?,
            lastmodified: Date?,
            partnumber: Int?,
            size: Int?
            
        ) {
            self.etag = etag
            self.lastmodified = lastmodified
            self.partnumber = partnumber
            self.size = size
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(etag?.restXmlSerialize().node)
            
            element.addChild(lastmodified?.restXmlSerialize().node)
            
            element.addChild(partnumber?.restXmlSerialize().node)
            
            element.addChild(size?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> Part {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let etag = try! body.nodes(forXPath: "ETag").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let lastmodified = try! body.nodes(forXPath: "LastModified").first.flatMapNoNulls { v in
                return Date.deserialize(response: response, body: v)
            }
            
            let partnumber = try! body.nodes(forXPath: "PartNumber").first.flatMapNoNulls { v in
                return Int.deserialize(response: response, body: v)
            }
            
            let size = try! body.nodes(forXPath: "Size").first.flatMapNoNulls { v in
                return Int.deserialize(response: response, body: v)
            }
            

            return Part(
                
                etag: etag,
                
                lastmodified: lastmodified,
                
                partnumber: partnumber,
                
                size: size
                
            )
        }
        
    }
    
    struct PutBucketAccelerateConfigurationRequest: RestXmlSerializable, AwswiftDeserializable {
        public let accelerateconfiguration: AccelerateConfiguration
        public let bucket: String
        

        init(
            accelerateconfiguration: AccelerateConfiguration,
            bucket: String
            
        ) {
            self.accelerateconfiguration = accelerateconfiguration
            self.bucket = bucket
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(accelerateconfiguration.restXmlSerialize().node)
            
            element.addChild(bucket.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> PutBucketAccelerateConfigurationRequest {
            fatalError()
        }
        
        
    }
    
    struct PutBucketAclRequest: RestXmlSerializable, AwswiftDeserializable {
        public let acl: BucketCannedACL?
        public let accesscontrolpolicy: AccessControlPolicy?
        public let bucket: String
        public let contentmd5: String?
        public let grantfullcontrol: String?
        public let grantread: String?
        public let grantreadacp: String?
        public let grantwrite: String?
        public let grantwriteacp: String?
        

        init(
            acl: BucketCannedACL?,
            accesscontrolpolicy: AccessControlPolicy?,
            bucket: String,
            contentmd5: String?,
            grantfullcontrol: String?,
            grantread: String?,
            grantreadacp: String?,
            grantwrite: String?,
            grantwriteacp: String?
            
        ) {
            self.acl = acl
            self.accesscontrolpolicy = accesscontrolpolicy
            self.bucket = bucket
            self.contentmd5 = contentmd5
            self.grantfullcontrol = grantfullcontrol
            self.grantread = grantread
            self.grantreadacp = grantreadacp
            self.grantwrite = grantwrite
            self.grantwriteacp = grantwriteacp
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(acl?.restXmlSerialize().node)
            
            element.addChild(accesscontrolpolicy?.restXmlSerialize().node)
            
            element.addChild(bucket.restXmlSerialize().node)
            
            element.addChild(contentmd5?.restXmlSerialize().node)
            
            element.addChild(grantfullcontrol?.restXmlSerialize().node)
            
            element.addChild(grantread?.restXmlSerialize().node)
            
            element.addChild(grantreadacp?.restXmlSerialize().node)
            
            element.addChild(grantwrite?.restXmlSerialize().node)
            
            element.addChild(grantwriteacp?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> PutBucketAclRequest {
            fatalError()
        }
        
        
    }
    
    struct PutBucketCorsRequest: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String
        public let corsconfiguration: CORSConfiguration
        public let contentmd5: String?
        

        init(
            bucket: String,
            corsconfiguration: CORSConfiguration,
            contentmd5: String?
            
        ) {
            self.bucket = bucket
            self.corsconfiguration = corsconfiguration
            self.contentmd5 = contentmd5
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(bucket.restXmlSerialize().node)
            
            element.addChild(corsconfiguration.restXmlSerialize().node)
            
            element.addChild(contentmd5?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> PutBucketCorsRequest {
            fatalError()
        }
        
        
    }
    
    struct PutBucketLifecycleConfigurationRequest: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String
        public let lifecycleconfiguration: BucketLifecycleConfiguration?
        

        init(
            bucket: String,
            lifecycleconfiguration: BucketLifecycleConfiguration?
            
        ) {
            self.bucket = bucket
            self.lifecycleconfiguration = lifecycleconfiguration
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(bucket.restXmlSerialize().node)
            
            element.addChild(lifecycleconfiguration?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> PutBucketLifecycleConfigurationRequest {
            fatalError()
        }
        
        
    }
    
    struct PutBucketLifecycleRequest: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String
        public let contentmd5: String?
        public let lifecycleconfiguration: LifecycleConfiguration?
        

        init(
            bucket: String,
            contentmd5: String?,
            lifecycleconfiguration: LifecycleConfiguration?
            
        ) {
            self.bucket = bucket
            self.contentmd5 = contentmd5
            self.lifecycleconfiguration = lifecycleconfiguration
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(bucket.restXmlSerialize().node)
            
            element.addChild(contentmd5?.restXmlSerialize().node)
            
            element.addChild(lifecycleconfiguration?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> PutBucketLifecycleRequest {
            fatalError()
        }
        
        
    }
    
    struct PutBucketLoggingRequest: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String
        public let bucketloggingstatus: BucketLoggingStatus
        public let contentmd5: String?
        

        init(
            bucket: String,
            bucketloggingstatus: BucketLoggingStatus,
            contentmd5: String?
            
        ) {
            self.bucket = bucket
            self.bucketloggingstatus = bucketloggingstatus
            self.contentmd5 = contentmd5
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(bucket.restXmlSerialize().node)
            
            element.addChild(bucketloggingstatus.restXmlSerialize().node)
            
            element.addChild(contentmd5?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> PutBucketLoggingRequest {
            fatalError()
        }
        
        
    }
    
    struct PutBucketNotificationConfigurationRequest: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String
        public let notificationconfiguration: NotificationConfiguration
        

        init(
            bucket: String,
            notificationconfiguration: NotificationConfiguration
            
        ) {
            self.bucket = bucket
            self.notificationconfiguration = notificationconfiguration
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(bucket.restXmlSerialize().node)
            
            element.addChild(notificationconfiguration.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> PutBucketNotificationConfigurationRequest {
            fatalError()
        }
        
        
    }
    
    struct PutBucketNotificationRequest: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String
        public let contentmd5: String?
        public let notificationconfiguration: NotificationConfigurationDeprecated
        

        init(
            bucket: String,
            contentmd5: String?,
            notificationconfiguration: NotificationConfigurationDeprecated
            
        ) {
            self.bucket = bucket
            self.contentmd5 = contentmd5
            self.notificationconfiguration = notificationconfiguration
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(bucket.restXmlSerialize().node)
            
            element.addChild(contentmd5?.restXmlSerialize().node)
            
            element.addChild(notificationconfiguration.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> PutBucketNotificationRequest {
            fatalError()
        }
        
        
    }
    
    struct PutBucketPolicyRequest: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String
        public let contentmd5: String?
        public let policy: String
        

        init(
            bucket: String,
            contentmd5: String?,
            policy: String
            
        ) {
            self.bucket = bucket
            self.contentmd5 = contentmd5
            self.policy = policy
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(bucket.restXmlSerialize().node)
            
            element.addChild(contentmd5?.restXmlSerialize().node)
            
            element.addChild(policy.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> PutBucketPolicyRequest {
            fatalError()
        }
        
        
    }
    
    struct PutBucketReplicationRequest: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String
        public let contentmd5: String?
        public let replicationconfiguration: ReplicationConfiguration
        

        init(
            bucket: String,
            contentmd5: String?,
            replicationconfiguration: ReplicationConfiguration
            
        ) {
            self.bucket = bucket
            self.contentmd5 = contentmd5
            self.replicationconfiguration = replicationconfiguration
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(bucket.restXmlSerialize().node)
            
            element.addChild(contentmd5?.restXmlSerialize().node)
            
            element.addChild(replicationconfiguration.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> PutBucketReplicationRequest {
            fatalError()
        }
        
        
    }
    
    struct PutBucketRequestPaymentRequest: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String
        public let contentmd5: String?
        public let requestpaymentconfiguration: RequestPaymentConfiguration
        

        init(
            bucket: String,
            contentmd5: String?,
            requestpaymentconfiguration: RequestPaymentConfiguration
            
        ) {
            self.bucket = bucket
            self.contentmd5 = contentmd5
            self.requestpaymentconfiguration = requestpaymentconfiguration
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(bucket.restXmlSerialize().node)
            
            element.addChild(contentmd5?.restXmlSerialize().node)
            
            element.addChild(requestpaymentconfiguration.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> PutBucketRequestPaymentRequest {
            fatalError()
        }
        
        
    }
    
    struct PutBucketTaggingRequest: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String
        public let contentmd5: String?
        public let tagging: Tagging
        

        init(
            bucket: String,
            contentmd5: String?,
            tagging: Tagging
            
        ) {
            self.bucket = bucket
            self.contentmd5 = contentmd5
            self.tagging = tagging
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(bucket.restXmlSerialize().node)
            
            element.addChild(contentmd5?.restXmlSerialize().node)
            
            element.addChild(tagging.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> PutBucketTaggingRequest {
            fatalError()
        }
        
        
    }
    
    struct PutBucketVersioningRequest: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String
        public let contentmd5: String?
        public let mfa: String?
        public let versioningconfiguration: VersioningConfiguration
        

        init(
            bucket: String,
            contentmd5: String?,
            mfa: String?,
            versioningconfiguration: VersioningConfiguration
            
        ) {
            self.bucket = bucket
            self.contentmd5 = contentmd5
            self.mfa = mfa
            self.versioningconfiguration = versioningconfiguration
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(bucket.restXmlSerialize().node)
            
            element.addChild(contentmd5?.restXmlSerialize().node)
            
            element.addChild(mfa?.restXmlSerialize().node)
            
            element.addChild(versioningconfiguration.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> PutBucketVersioningRequest {
            fatalError()
        }
        
        
    }
    
    struct PutBucketWebsiteRequest: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String
        public let contentmd5: String?
        public let websiteconfiguration: WebsiteConfiguration
        

        init(
            bucket: String,
            contentmd5: String?,
            websiteconfiguration: WebsiteConfiguration
            
        ) {
            self.bucket = bucket
            self.contentmd5 = contentmd5
            self.websiteconfiguration = websiteconfiguration
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(bucket.restXmlSerialize().node)
            
            element.addChild(contentmd5?.restXmlSerialize().node)
            
            element.addChild(websiteconfiguration.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> PutBucketWebsiteRequest {
            fatalError()
        }
        
        
    }
    
    struct PutObjectAclOutput: RestXmlSerializable, AwswiftDeserializable {
        public let requestcharged: RequestCharged?
        

        init(
            requestcharged: RequestCharged?
            
        ) {
            self.requestcharged = requestcharged
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            element.addChild(requestcharged?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> PutObjectAclOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let requestcharged = try! body.nodes(forXPath: "x-amz-request-charged").first.flatMapNoNulls { v in
                return RequestCharged.deserialize(response: response, body: v)
            }
            

            return PutObjectAclOutput(
                
                requestcharged: requestcharged
                
            )
        }
        
    }
    
    struct PutObjectAclRequest: RestXmlSerializable, AwswiftDeserializable {
        public let acl: ObjectCannedACL?
        public let accesscontrolpolicy: AccessControlPolicy?
        public let bucket: String
        public let contentmd5: String?
        public let grantfullcontrol: String?
        public let grantread: String?
        public let grantreadacp: String?
        public let grantwrite: String?
        public let grantwriteacp: String?
        public let key: String
        public let requestpayer: RequestPayer?
        public let versionid: String?
        

        init(
            acl: ObjectCannedACL?,
            accesscontrolpolicy: AccessControlPolicy?,
            bucket: String,
            contentmd5: String?,
            grantfullcontrol: String?,
            grantread: String?,
            grantreadacp: String?,
            grantwrite: String?,
            grantwriteacp: String?,
            key: String,
            requestpayer: RequestPayer?,
            versionid: String?
            
        ) {
            self.acl = acl
            self.accesscontrolpolicy = accesscontrolpolicy
            self.bucket = bucket
            self.contentmd5 = contentmd5
            self.grantfullcontrol = grantfullcontrol
            self.grantread = grantread
            self.grantreadacp = grantreadacp
            self.grantwrite = grantwrite
            self.grantwriteacp = grantwriteacp
            self.key = key
            self.requestpayer = requestpayer
            self.versionid = versionid
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(acl?.restXmlSerialize().node)
            
            element.addChild(accesscontrolpolicy?.restXmlSerialize().node)
            
            element.addChild(bucket.restXmlSerialize().node)
            
            element.addChild(contentmd5?.restXmlSerialize().node)
            
            element.addChild(grantfullcontrol?.restXmlSerialize().node)
            
            element.addChild(grantread?.restXmlSerialize().node)
            
            element.addChild(grantreadacp?.restXmlSerialize().node)
            
            element.addChild(grantwrite?.restXmlSerialize().node)
            
            element.addChild(grantwriteacp?.restXmlSerialize().node)
            
            element.addChild(key.restXmlSerialize().node)
            
            element.addChild(requestpayer?.restXmlSerialize().node)
            
            element.addChild(versionid?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> PutObjectAclRequest {
            fatalError()
        }
        
        
    }
    
    struct PutObjectOutput: RestXmlSerializable, AwswiftDeserializable {
        public let etag: String?
        public let expiration: String?
        public let requestcharged: RequestCharged?
        public let ssecustomeralgorithm: String?
        public let ssecustomerkeymd5: String?
        public let ssekmskeyid: String?
        public let serversideencryption: ServerSideEncryption?
        public let versionid: String?
        

        init(
            etag: String?,
            expiration: String?,
            requestcharged: RequestCharged?,
            ssecustomeralgorithm: String?,
            ssecustomerkeymd5: String?,
            ssekmskeyid: String?,
            serversideencryption: ServerSideEncryption?,
            versionid: String?
            
        ) {
            self.etag = etag
            self.expiration = expiration
            self.requestcharged = requestcharged
            self.ssecustomeralgorithm = ssecustomeralgorithm
            self.ssecustomerkeymd5 = ssecustomerkeymd5
            self.ssekmskeyid = ssekmskeyid
            self.serversideencryption = serversideencryption
            self.versionid = versionid
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            element.addChild(etag?.restXmlSerialize().node)
            
            element.addChild(expiration?.restXmlSerialize().node)
            
            element.addChild(requestcharged?.restXmlSerialize().node)
            
            element.addChild(ssecustomeralgorithm?.restXmlSerialize().node)
            
            element.addChild(ssecustomerkeymd5?.restXmlSerialize().node)
            
            element.addChild(ssekmskeyid?.restXmlSerialize().node)
            
            element.addChild(serversideencryption?.restXmlSerialize().node)
            
            element.addChild(versionid?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> PutObjectOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let etag = try! body.nodes(forXPath: "ETag").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let expiration = try! body.nodes(forXPath: "x-amz-expiration").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let requestcharged = try! body.nodes(forXPath: "x-amz-request-charged").first.flatMapNoNulls { v in
                return RequestCharged.deserialize(response: response, body: v)
            }
            
            let ssecustomeralgorithm = try! body.nodes(forXPath: "x-amz-server-side-encryption-customer-algorithm").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let ssecustomerkeymd5 = try! body.nodes(forXPath: "x-amz-server-side-encryption-customer-key-MD5").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let ssekmskeyid = try! body.nodes(forXPath: "x-amz-server-side-encryption-aws-kms-key-id").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let serversideencryption = try! body.nodes(forXPath: "x-amz-server-side-encryption").first.flatMapNoNulls { v in
                return ServerSideEncryption.deserialize(response: response, body: v)
            }
            
            let versionid = try! body.nodes(forXPath: "x-amz-version-id").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return PutObjectOutput(
                
                etag: etag,
                
                expiration: expiration,
                
                requestcharged: requestcharged,
                
                ssecustomeralgorithm: ssecustomeralgorithm,
                
                ssecustomerkeymd5: ssecustomerkeymd5,
                
                ssekmskeyid: ssekmskeyid,
                
                serversideencryption: serversideencryption,
                
                versionid: versionid
                
            )
        }
        
    }
    
    struct PutObjectRequest: RestXmlSerializable, AwswiftDeserializable {
        public let acl: ObjectCannedACL?
        public let s3body: Data?
        public let bucket: String
        public let cachecontrol: String?
        public let contentdisposition: String?
        public let contentencoding: String?
        public let contentlanguage: String?
        public let contentlength: Int?
        public let contentmd5: String?
        public let contenttype: String?
        public let expires: Date?
        public let grantfullcontrol: String?
        public let grantread: String?
        public let grantreadacp: String?
        public let grantwriteacp: String?
        public let key: String
        public let metadata: [String: String]?
        public let requestpayer: RequestPayer?
        public let ssecustomeralgorithm: String?
        public let ssecustomerkey: String?
        public let ssecustomerkeymd5: String?
        public let ssekmskeyid: String?
        public let serversideencryption: ServerSideEncryption?
        public let storageclass: StorageClass?
        public let websiteredirectlocation: String?
        

        init(
            acl: ObjectCannedACL?,
            s3body: Data?,
            bucket: String,
            cachecontrol: String?,
            contentdisposition: String?,
            contentencoding: String?,
            contentlanguage: String?,
            contentlength: Int?,
            contentmd5: String?,
            contenttype: String?,
            expires: Date?,
            grantfullcontrol: String?,
            grantread: String?,
            grantreadacp: String?,
            grantwriteacp: String?,
            key: String,
            metadata: [String: String]?,
            requestpayer: RequestPayer?,
            ssecustomeralgorithm: String?,
            ssecustomerkey: String?,
            ssecustomerkeymd5: String?,
            ssekmskeyid: String?,
            serversideencryption: ServerSideEncryption?,
            storageclass: StorageClass?,
            websiteredirectlocation: String?
            
        ) {
            self.acl = acl
            self.s3body = s3body
            self.bucket = bucket
            self.cachecontrol = cachecontrol
            self.contentdisposition = contentdisposition
            self.contentencoding = contentencoding
            self.contentlanguage = contentlanguage
            self.contentlength = contentlength
            self.contentmd5 = contentmd5
            self.contenttype = contenttype
            self.expires = expires
            self.grantfullcontrol = grantfullcontrol
            self.grantread = grantread
            self.grantreadacp = grantreadacp
            self.grantwriteacp = grantwriteacp
            self.key = key
            self.metadata = metadata
            self.requestpayer = requestpayer
            self.ssecustomeralgorithm = ssecustomeralgorithm
            self.ssecustomerkey = ssecustomerkey
            self.ssecustomerkeymd5 = ssecustomerkeymd5
            self.ssekmskeyid = ssekmskeyid
            self.serversideencryption = serversideencryption
            self.storageclass = storageclass
            self.websiteredirectlocation = websiteredirectlocation
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(acl?.restXmlSerialize().node)
            
            element.addChild(s3body?.restXmlSerialize().node)
            
            element.addChild(bucket.restXmlSerialize().node)
            
            element.addChild(cachecontrol?.restXmlSerialize().node)
            
            element.addChild(contentdisposition?.restXmlSerialize().node)
            
            element.addChild(contentencoding?.restXmlSerialize().node)
            
            element.addChild(contentlanguage?.restXmlSerialize().node)
            
            element.addChild(contentlength?.restXmlSerialize().node)
            
            element.addChild(contentmd5?.restXmlSerialize().node)
            
            element.addChild(contenttype?.restXmlSerialize().node)
            
            element.addChild(expires?.restXmlSerialize().node)
            
            element.addChild(grantfullcontrol?.restXmlSerialize().node)
            
            element.addChild(grantread?.restXmlSerialize().node)
            
            element.addChild(grantreadacp?.restXmlSerialize().node)
            
            element.addChild(grantwriteacp?.restXmlSerialize().node)
            
            element.addChild(key.restXmlSerialize().node)
            
            element.addChild(metadata?.restXmlSerialize().node)
            
            element.addChild(requestpayer?.restXmlSerialize().node)
            
            element.addChild(ssecustomeralgorithm?.restXmlSerialize().node)
            
            element.addChild(ssecustomerkey?.restXmlSerialize().node)
            
            element.addChild(ssecustomerkeymd5?.restXmlSerialize().node)
            
            element.addChild(ssekmskeyid?.restXmlSerialize().node)
            
            element.addChild(serversideencryption?.restXmlSerialize().node)
            
            element.addChild(storageclass?.restXmlSerialize().node)
            
            element.addChild(websiteredirectlocation?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> PutObjectRequest {
            fatalError()
        }
        
        
    }
    
    struct QueueConfiguration: RestXmlSerializable, AwswiftDeserializable {
        public let events: [Event]
        public let filter: NotificationConfigurationFilter?
        public let id: String?
        public let queuearn: String
        

        init(
            events: [Event],
            filter: NotificationConfigurationFilter?,
            id: String?,
            queuearn: String
            
        ) {
            self.events = events
            self.filter = filter
            self.id = id
            self.queuearn = queuearn
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(events.restXmlSerialize().node)
            
            element.addChild(filter?.restXmlSerialize().node)
            
            element.addChild(id?.restXmlSerialize().node)
            
            element.addChild(queuearn.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> QueueConfiguration {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let events = try! body.nodes(forXPath: "Event").first.flatMapNoNulls { v in
                return [Event].deserialize(response: response, body: v)
            }
            
            let filter = try! body.nodes(forXPath: "Filter").first.flatMapNoNulls { v in
                return NotificationConfigurationFilter.deserialize(response: response, body: v)
            }
            
            let id = try! body.nodes(forXPath: "Id").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let queuearn = try! body.nodes(forXPath: "Queue").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return QueueConfiguration(
                
                events: events!,
                
                filter: filter,
                
                id: id,
                
                queuearn: queuearn!
                
            )
        }
        
    }
    
    struct QueueConfigurationDeprecated: RestXmlSerializable, AwswiftDeserializable {
        public let event: Event?
        public let events: [Event]?
        public let id: String?
        public let queue: String?
        

        init(
            event: Event?,
            events: [Event]?,
            id: String?,
            queue: String?
            
        ) {
            self.event = event
            self.events = events
            self.id = id
            self.queue = queue
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(event?.restXmlSerialize().node)
            
            element.addChild(events?.restXmlSerialize().node)
            
            element.addChild(id?.restXmlSerialize().node)
            
            element.addChild(queue?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> QueueConfigurationDeprecated {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let event = try! body.nodes(forXPath: "Event").first.flatMapNoNulls { v in
                return Event.deserialize(response: response, body: v)
            }
            
            let events = try! body.nodes(forXPath: "Event").first.flatMapNoNulls { v in
                return [Event].deserialize(response: response, body: v)
            }
            
            let id = try! body.nodes(forXPath: "Id").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let queue = try! body.nodes(forXPath: "Queue").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return QueueConfigurationDeprecated(
                
                event: event,
                
                events: events,
                
                id: id,
                
                queue: queue
                
            )
        }
        
    }
    
    struct Redirect: RestXmlSerializable, AwswiftDeserializable {
        public let hostname: String?
        public let httpredirectcode: String?
        public let s3protocol: S3Protocol?
        public let replacekeyprefixwith: String?
        public let replacekeywith: String?
        

        init(
            hostname: String?,
            httpredirectcode: String?,
            s3protocol: S3Protocol?,
            replacekeyprefixwith: String?,
            replacekeywith: String?
            
        ) {
            self.hostname = hostname
            self.httpredirectcode = httpredirectcode
            self.s3protocol = s3protocol
            self.replacekeyprefixwith = replacekeyprefixwith
            self.replacekeywith = replacekeywith
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(hostname?.restXmlSerialize().node)
            
            element.addChild(httpredirectcode?.restXmlSerialize().node)
            
            element.addChild(s3protocol?.restXmlSerialize().node)
            
            element.addChild(replacekeyprefixwith?.restXmlSerialize().node)
            
            element.addChild(replacekeywith?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> Redirect {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let hostname = try! body.nodes(forXPath: "HostName").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let httpredirectcode = try! body.nodes(forXPath: "HttpRedirectCode").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let s3protocol = try! body.nodes(forXPath: "Protocol").first.flatMapNoNulls { v in
                return S3Protocol.deserialize(response: response, body: v)
            }
            
            let replacekeyprefixwith = try! body.nodes(forXPath: "ReplaceKeyPrefixWith").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let replacekeywith = try! body.nodes(forXPath: "ReplaceKeyWith").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return Redirect(
                
                hostname: hostname,
                
                httpredirectcode: httpredirectcode,
                
                s3protocol: s3protocol,
                
                replacekeyprefixwith: replacekeyprefixwith,
                
                replacekeywith: replacekeywith
                
            )
        }
        
    }
    
    struct RedirectAllRequestsTo: RestXmlSerializable, AwswiftDeserializable {
        public let hostname: String
        public let s3protocol: S3Protocol?
        

        init(
            hostname: String,
            s3protocol: S3Protocol?
            
        ) {
            self.hostname = hostname
            self.s3protocol = s3protocol
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(hostname.restXmlSerialize().node)
            
            element.addChild(s3protocol?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> RedirectAllRequestsTo {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let hostname = try! body.nodes(forXPath: "HostName").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let s3protocol = try! body.nodes(forXPath: "Protocol").first.flatMapNoNulls { v in
                return S3Protocol.deserialize(response: response, body: v)
            }
            

            return RedirectAllRequestsTo(
                
                hostname: hostname!,
                
                s3protocol: s3protocol
                
            )
        }
        
    }
    
    struct ReplicationConfiguration: RestXmlSerializable, AwswiftDeserializable {
        public let role: String
        public let rules: [ReplicationRule]
        

        init(
            role: String,
            rules: [ReplicationRule]
            
        ) {
            self.role = role
            self.rules = rules
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(role.restXmlSerialize().node)
            
            element.addChild(rules.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> ReplicationConfiguration {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let role = try! body.nodes(forXPath: "Role").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let rules = try! body.nodes(forXPath: "Rule").first.flatMapNoNulls { v in
                return [ReplicationRule].deserialize(response: response, body: v)
            }
            

            return ReplicationConfiguration(
                
                role: role!,
                
                rules: rules!
                
            )
        }
        
    }
    
    struct ReplicationRule: RestXmlSerializable, AwswiftDeserializable {
        public let destination: Destination
        public let id: String?
        public let prefix: String
        public let status: ReplicationRuleStatus
        

        init(
            destination: Destination,
            id: String?,
            prefix: String,
            status: ReplicationRuleStatus
            
        ) {
            self.destination = destination
            self.id = id
            self.prefix = prefix
            self.status = status
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(destination.restXmlSerialize().node)
            
            element.addChild(id?.restXmlSerialize().node)
            
            element.addChild(prefix.restXmlSerialize().node)
            
            element.addChild(status.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> ReplicationRule {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let destination = try! body.nodes(forXPath: "Destination").first.flatMapNoNulls { v in
                return Destination.deserialize(response: response, body: v)
            }
            
            let id = try! body.nodes(forXPath: "ID").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let prefix = try! body.nodes(forXPath: "Prefix").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let status = try! body.nodes(forXPath: "Status").first.flatMapNoNulls { v in
                return ReplicationRuleStatus.deserialize(response: response, body: v)
            }
            

            return ReplicationRule(
                
                destination: destination!,
                
                id: id,
                
                prefix: prefix!,
                
                status: status!
                
            )
        }
        
    }
    
    struct RequestPaymentConfiguration: RestXmlSerializable, AwswiftDeserializable {
        public let payer: Payer
        

        init(
            payer: Payer
            
        ) {
            self.payer = payer
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(payer.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> RequestPaymentConfiguration {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let payer = try! body.nodes(forXPath: "Payer").first.flatMapNoNulls { v in
                return Payer.deserialize(response: response, body: v)
            }
            

            return RequestPaymentConfiguration(
                
                payer: payer!
                
            )
        }
        
    }
    
    struct RestoreObjectOutput: RestXmlSerializable, AwswiftDeserializable {
        public let requestcharged: RequestCharged?
        

        init(
            requestcharged: RequestCharged?
            
        ) {
            self.requestcharged = requestcharged
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            element.addChild(requestcharged?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> RestoreObjectOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let requestcharged = try! body.nodes(forXPath: "x-amz-request-charged").first.flatMapNoNulls { v in
                return RequestCharged.deserialize(response: response, body: v)
            }
            

            return RestoreObjectOutput(
                
                requestcharged: requestcharged
                
            )
        }
        
    }
    
    struct RestoreObjectRequest: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String
        public let key: String
        public let requestpayer: RequestPayer?
        public let restorerequest: RestoreRequest?
        public let versionid: String?
        

        init(
            bucket: String,
            key: String,
            requestpayer: RequestPayer?,
            restorerequest: RestoreRequest?,
            versionid: String?
            
        ) {
            self.bucket = bucket
            self.key = key
            self.requestpayer = requestpayer
            self.restorerequest = restorerequest
            self.versionid = versionid
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(bucket.restXmlSerialize().node)
            
            element.addChild(key.restXmlSerialize().node)
            
            element.addChild(requestpayer?.restXmlSerialize().node)
            
            element.addChild(restorerequest?.restXmlSerialize().node)
            
            element.addChild(versionid?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> RestoreObjectRequest {
            fatalError()
        }
        
        
    }
    
    struct RestoreRequest: RestXmlSerializable, AwswiftDeserializable {
        public let days: Int
        

        init(
            days: Int
            
        ) {
            self.days = days
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(days.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> RestoreRequest {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let days = try! body.nodes(forXPath: "Days").first.flatMapNoNulls { v in
                return Int.deserialize(response: response, body: v)
            }
            

            return RestoreRequest(
                
                days: days!
                
            )
        }
        
    }
    
    struct RoutingRule: RestXmlSerializable, AwswiftDeserializable {
        public let condition: Condition?
        public let redirect: Redirect
        

        init(
            condition: Condition?,
            redirect: Redirect
            
        ) {
            self.condition = condition
            self.redirect = redirect
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(condition?.restXmlSerialize().node)
            
            element.addChild(redirect.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> RoutingRule {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let condition = try! body.nodes(forXPath: "Condition").first.flatMapNoNulls { v in
                return Condition.deserialize(response: response, body: v)
            }
            
            let redirect = try! body.nodes(forXPath: "Redirect").first.flatMapNoNulls { v in
                return Redirect.deserialize(response: response, body: v)
            }
            

            return RoutingRule(
                
                condition: condition,
                
                redirect: redirect!
                
            )
        }
        
    }
    
    struct Rule: RestXmlSerializable, AwswiftDeserializable {
        public let abortincompletemultipartupload: AbortIncompleteMultipartUpload?
        public let expiration: LifecycleExpiration?
        public let id: String?
        public let noncurrentversionexpiration: NoncurrentVersionExpiration?
        public let noncurrentversiontransition: NoncurrentVersionTransition?
        public let prefix: String
        public let status: ExpirationStatus
        public let transition: Transition?
        

        init(
            abortincompletemultipartupload: AbortIncompleteMultipartUpload?,
            expiration: LifecycleExpiration?,
            id: String?,
            noncurrentversionexpiration: NoncurrentVersionExpiration?,
            noncurrentversiontransition: NoncurrentVersionTransition?,
            prefix: String,
            status: ExpirationStatus,
            transition: Transition?
            
        ) {
            self.abortincompletemultipartupload = abortincompletemultipartupload
            self.expiration = expiration
            self.id = id
            self.noncurrentversionexpiration = noncurrentversionexpiration
            self.noncurrentversiontransition = noncurrentversiontransition
            self.prefix = prefix
            self.status = status
            self.transition = transition
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(abortincompletemultipartupload?.restXmlSerialize().node)
            
            element.addChild(expiration?.restXmlSerialize().node)
            
            element.addChild(id?.restXmlSerialize().node)
            
            element.addChild(noncurrentversionexpiration?.restXmlSerialize().node)
            
            element.addChild(noncurrentversiontransition?.restXmlSerialize().node)
            
            element.addChild(prefix.restXmlSerialize().node)
            
            element.addChild(status.restXmlSerialize().node)
            
            element.addChild(transition?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> Rule {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let abortincompletemultipartupload = try! body.nodes(forXPath: "AbortIncompleteMultipartUpload").first.flatMapNoNulls { v in
                return AbortIncompleteMultipartUpload.deserialize(response: response, body: v)
            }
            
            let expiration = try! body.nodes(forXPath: "Expiration").first.flatMapNoNulls { v in
                return LifecycleExpiration.deserialize(response: response, body: v)
            }
            
            let id = try! body.nodes(forXPath: "ID").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let noncurrentversionexpiration = try! body.nodes(forXPath: "NoncurrentVersionExpiration").first.flatMapNoNulls { v in
                return NoncurrentVersionExpiration.deserialize(response: response, body: v)
            }
            
            let noncurrentversiontransition = try! body.nodes(forXPath: "NoncurrentVersionTransition").first.flatMapNoNulls { v in
                return NoncurrentVersionTransition.deserialize(response: response, body: v)
            }
            
            let prefix = try! body.nodes(forXPath: "Prefix").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let status = try! body.nodes(forXPath: "Status").first.flatMapNoNulls { v in
                return ExpirationStatus.deserialize(response: response, body: v)
            }
            
            let transition = try! body.nodes(forXPath: "Transition").first.flatMapNoNulls { v in
                return Transition.deserialize(response: response, body: v)
            }
            

            return Rule(
                
                abortincompletemultipartupload: abortincompletemultipartupload,
                
                expiration: expiration,
                
                id: id,
                
                noncurrentversionexpiration: noncurrentversionexpiration,
                
                noncurrentversiontransition: noncurrentversiontransition,
                
                prefix: prefix!,
                
                status: status!,
                
                transition: transition
                
            )
        }
        
    }
    
    struct S3Error: RestXmlSerializable, AwswiftDeserializable {
        public let code: String?
        public let key: String?
        public let message: String?
        public let versionid: String?
        

        init(
            code: String?,
            key: String?,
            message: String?,
            versionid: String?
            
        ) {
            self.code = code
            self.key = key
            self.message = message
            self.versionid = versionid
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(code?.restXmlSerialize().node)
            
            element.addChild(key?.restXmlSerialize().node)
            
            element.addChild(message?.restXmlSerialize().node)
            
            element.addChild(versionid?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> S3Error {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let code = try! body.nodes(forXPath: "Code").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let key = try! body.nodes(forXPath: "Key").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let message = try! body.nodes(forXPath: "Message").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let versionid = try! body.nodes(forXPath: "VersionId").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return S3Error(
                
                code: code,
                
                key: key,
                
                message: message,
                
                versionid: versionid
                
            )
        }
        
    }
    
    struct S3KeyFilter: RestXmlSerializable, AwswiftDeserializable {
        public let filterrules: [FilterRule]?
        

        init(
            filterrules: [FilterRule]?
            
        ) {
            self.filterrules = filterrules
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(filterrules?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> S3KeyFilter {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let filterrules = try! body.nodes(forXPath: "FilterRule").first.flatMapNoNulls { v in
                return [FilterRule].deserialize(response: response, body: v)
            }
            

            return S3KeyFilter(
                
                filterrules: filterrules
                
            )
        }
        
    }
    
    struct Tag: RestXmlSerializable, AwswiftDeserializable {
        public let key: String
        public let value: String
        

        init(
            key: String,
            value: String
            
        ) {
            self.key = key
            self.value = value
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(key.restXmlSerialize().node)
            
            element.addChild(value.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> Tag {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let key = try! body.nodes(forXPath: "Key").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let value = try! body.nodes(forXPath: "Value").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return Tag(
                
                key: key!,
                
                value: value!
                
            )
        }
        
    }
    
    struct Tagging: RestXmlSerializable, AwswiftDeserializable {
        public let tagset: [Tag]
        

        init(
            tagset: [Tag]
            
        ) {
            self.tagset = tagset
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(tagset.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> Tagging {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let tagset = try! body.nodes(forXPath: "TagSet").first.flatMapNoNulls { v in
                return [Tag].deserialize(response: response, body: v)
            }
            

            return Tagging(
                
                tagset: tagset!
                
            )
        }
        
    }
    
    struct TargetGrant: RestXmlSerializable, AwswiftDeserializable {
        public let grantee: Grantee?
        public let permission: BucketLogsPermission?
        

        init(
            grantee: Grantee?,
            permission: BucketLogsPermission?
            
        ) {
            self.grantee = grantee
            self.permission = permission
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(grantee?.restXmlSerialize().node)
            
            element.addChild(permission?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> TargetGrant {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let grantee = try! body.nodes(forXPath: "Grantee").first.flatMapNoNulls { v in
                return Grantee.deserialize(response: response, body: v)
            }
            
            let permission = try! body.nodes(forXPath: "Permission").first.flatMapNoNulls { v in
                return BucketLogsPermission.deserialize(response: response, body: v)
            }
            

            return TargetGrant(
                
                grantee: grantee,
                
                permission: permission
                
            )
        }
        
    }
    
    struct TopicConfiguration: RestXmlSerializable, AwswiftDeserializable {
        public let events: [Event]
        public let filter: NotificationConfigurationFilter?
        public let id: String?
        public let topicarn: String
        

        init(
            events: [Event],
            filter: NotificationConfigurationFilter?,
            id: String?,
            topicarn: String
            
        ) {
            self.events = events
            self.filter = filter
            self.id = id
            self.topicarn = topicarn
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(events.restXmlSerialize().node)
            
            element.addChild(filter?.restXmlSerialize().node)
            
            element.addChild(id?.restXmlSerialize().node)
            
            element.addChild(topicarn.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> TopicConfiguration {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let events = try! body.nodes(forXPath: "Event").first.flatMapNoNulls { v in
                return [Event].deserialize(response: response, body: v)
            }
            
            let filter = try! body.nodes(forXPath: "Filter").first.flatMapNoNulls { v in
                return NotificationConfigurationFilter.deserialize(response: response, body: v)
            }
            
            let id = try! body.nodes(forXPath: "Id").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let topicarn = try! body.nodes(forXPath: "Topic").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return TopicConfiguration(
                
                events: events!,
                
                filter: filter,
                
                id: id,
                
                topicarn: topicarn!
                
            )
        }
        
    }
    
    struct TopicConfigurationDeprecated: RestXmlSerializable, AwswiftDeserializable {
        public let event: Event?
        public let events: [Event]?
        public let id: String?
        public let topic: String?
        

        init(
            event: Event?,
            events: [Event]?,
            id: String?,
            topic: String?
            
        ) {
            self.event = event
            self.events = events
            self.id = id
            self.topic = topic
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(event?.restXmlSerialize().node)
            
            element.addChild(events?.restXmlSerialize().node)
            
            element.addChild(id?.restXmlSerialize().node)
            
            element.addChild(topic?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> TopicConfigurationDeprecated {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let event = try! body.nodes(forXPath: "Event").first.flatMapNoNulls { v in
                return Event.deserialize(response: response, body: v)
            }
            
            let events = try! body.nodes(forXPath: "Event").first.flatMapNoNulls { v in
                return [Event].deserialize(response: response, body: v)
            }
            
            let id = try! body.nodes(forXPath: "Id").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let topic = try! body.nodes(forXPath: "Topic").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return TopicConfigurationDeprecated(
                
                event: event,
                
                events: events,
                
                id: id,
                
                topic: topic
                
            )
        }
        
    }
    
    struct Transition: RestXmlSerializable, AwswiftDeserializable {
        public let date: Date?
        public let days: Int?
        public let storageclass: TransitionStorageClass?
        

        init(
            date: Date?,
            days: Int?,
            storageclass: TransitionStorageClass?
            
        ) {
            self.date = date
            self.days = days
            self.storageclass = storageclass
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(date?.restXmlSerialize().node)
            
            element.addChild(days?.restXmlSerialize().node)
            
            element.addChild(storageclass?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> Transition {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let date = try! body.nodes(forXPath: "Date").first.flatMapNoNulls { v in
                return Date.deserialize(response: response, body: v)
            }
            
            let days = try! body.nodes(forXPath: "Days").first.flatMapNoNulls { v in
                return Int.deserialize(response: response, body: v)
            }
            
            let storageclass = try! body.nodes(forXPath: "StorageClass").first.flatMapNoNulls { v in
                return TransitionStorageClass.deserialize(response: response, body: v)
            }
            

            return Transition(
                
                date: date,
                
                days: days,
                
                storageclass: storageclass
                
            )
        }
        
    }
    
    struct UploadPartCopyOutput: RestXmlSerializable, AwswiftDeserializable {
        public let copypartresult: CopyPartResult?
        public let copysourceversionid: String?
        public let requestcharged: RequestCharged?
        public let ssecustomeralgorithm: String?
        public let ssecustomerkeymd5: String?
        public let ssekmskeyid: String?
        public let serversideencryption: ServerSideEncryption?
        

        init(
            copypartresult: CopyPartResult?,
            copysourceversionid: String?,
            requestcharged: RequestCharged?,
            ssecustomeralgorithm: String?,
            ssecustomerkeymd5: String?,
            ssekmskeyid: String?,
            serversideencryption: ServerSideEncryption?
            
        ) {
            self.copypartresult = copypartresult
            self.copysourceversionid = copysourceversionid
            self.requestcharged = requestcharged
            self.ssecustomeralgorithm = ssecustomeralgorithm
            self.ssecustomerkeymd5 = ssecustomerkeymd5
            self.ssekmskeyid = ssekmskeyid
            self.serversideencryption = serversideencryption
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            element.addChild(copypartresult?.restXmlSerialize().node)
            
            element.addChild(copysourceversionid?.restXmlSerialize().node)
            
            element.addChild(requestcharged?.restXmlSerialize().node)
            
            element.addChild(ssecustomeralgorithm?.restXmlSerialize().node)
            
            element.addChild(ssecustomerkeymd5?.restXmlSerialize().node)
            
            element.addChild(ssekmskeyid?.restXmlSerialize().node)
            
            element.addChild(serversideencryption?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> UploadPartCopyOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let copypartresult = try! body.nodes(forXPath: "CopyPartResult").first.flatMapNoNulls { v in
                return CopyPartResult.deserialize(response: response, body: v)
            }
            
            let copysourceversionid = try! body.nodes(forXPath: "x-amz-copy-source-version-id").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let requestcharged = try! body.nodes(forXPath: "x-amz-request-charged").first.flatMapNoNulls { v in
                return RequestCharged.deserialize(response: response, body: v)
            }
            
            let ssecustomeralgorithm = try! body.nodes(forXPath: "x-amz-server-side-encryption-customer-algorithm").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let ssecustomerkeymd5 = try! body.nodes(forXPath: "x-amz-server-side-encryption-customer-key-MD5").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let ssekmskeyid = try! body.nodes(forXPath: "x-amz-server-side-encryption-aws-kms-key-id").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let serversideencryption = try! body.nodes(forXPath: "x-amz-server-side-encryption").first.flatMapNoNulls { v in
                return ServerSideEncryption.deserialize(response: response, body: v)
            }
            

            return UploadPartCopyOutput(
                
                copypartresult: copypartresult,
                
                copysourceversionid: copysourceversionid,
                
                requestcharged: requestcharged,
                
                ssecustomeralgorithm: ssecustomeralgorithm,
                
                ssecustomerkeymd5: ssecustomerkeymd5,
                
                ssekmskeyid: ssekmskeyid,
                
                serversideencryption: serversideencryption
                
            )
        }
        
    }
    
    struct UploadPartCopyRequest: RestXmlSerializable, AwswiftDeserializable {
        public let bucket: String
        public let copysource: String
        public let copysourceifmatch: String?
        public let copysourceifmodifiedsince: Date?
        public let copysourceifnonematch: String?
        public let copysourceifunmodifiedsince: Date?
        public let copysourcerange: String?
        public let copysourcessecustomeralgorithm: String?
        public let copysourcessecustomerkey: String?
        public let copysourcessecustomerkeymd5: String?
        public let key: String
        public let partnumber: Int
        public let requestpayer: RequestPayer?
        public let ssecustomeralgorithm: String?
        public let ssecustomerkey: String?
        public let ssecustomerkeymd5: String?
        public let uploadid: String
        

        init(
            bucket: String,
            copysource: String,
            copysourceifmatch: String?,
            copysourceifmodifiedsince: Date?,
            copysourceifnonematch: String?,
            copysourceifunmodifiedsince: Date?,
            copysourcerange: String?,
            copysourcessecustomeralgorithm: String?,
            copysourcessecustomerkey: String?,
            copysourcessecustomerkeymd5: String?,
            key: String,
            partnumber: Int,
            requestpayer: RequestPayer?,
            ssecustomeralgorithm: String?,
            ssecustomerkey: String?,
            ssecustomerkeymd5: String?,
            uploadid: String
            
        ) {
            self.bucket = bucket
            self.copysource = copysource
            self.copysourceifmatch = copysourceifmatch
            self.copysourceifmodifiedsince = copysourceifmodifiedsince
            self.copysourceifnonematch = copysourceifnonematch
            self.copysourceifunmodifiedsince = copysourceifunmodifiedsince
            self.copysourcerange = copysourcerange
            self.copysourcessecustomeralgorithm = copysourcessecustomeralgorithm
            self.copysourcessecustomerkey = copysourcessecustomerkey
            self.copysourcessecustomerkeymd5 = copysourcessecustomerkeymd5
            self.key = key
            self.partnumber = partnumber
            self.requestpayer = requestpayer
            self.ssecustomeralgorithm = ssecustomeralgorithm
            self.ssecustomerkey = ssecustomerkey
            self.ssecustomerkeymd5 = ssecustomerkeymd5
            self.uploadid = uploadid
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(bucket.restXmlSerialize().node)
            
            element.addChild(copysource.restXmlSerialize().node)
            
            element.addChild(copysourceifmatch?.restXmlSerialize().node)
            
            element.addChild(copysourceifmodifiedsince?.restXmlSerialize().node)
            
            element.addChild(copysourceifnonematch?.restXmlSerialize().node)
            
            element.addChild(copysourceifunmodifiedsince?.restXmlSerialize().node)
            
            element.addChild(copysourcerange?.restXmlSerialize().node)
            
            element.addChild(copysourcessecustomeralgorithm?.restXmlSerialize().node)
            
            element.addChild(copysourcessecustomerkey?.restXmlSerialize().node)
            
            element.addChild(copysourcessecustomerkeymd5?.restXmlSerialize().node)
            
            element.addChild(key.restXmlSerialize().node)
            
            element.addChild(partnumber.restXmlSerialize().node)
            
            element.addChild(requestpayer?.restXmlSerialize().node)
            
            element.addChild(ssecustomeralgorithm?.restXmlSerialize().node)
            
            element.addChild(ssecustomerkey?.restXmlSerialize().node)
            
            element.addChild(ssecustomerkeymd5?.restXmlSerialize().node)
            
            element.addChild(uploadid.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> UploadPartCopyRequest {
            fatalError()
        }
        
        
    }
    
    struct UploadPartOutput: RestXmlSerializable, AwswiftDeserializable {
        public let etag: String?
        public let requestcharged: RequestCharged?
        public let ssecustomeralgorithm: String?
        public let ssecustomerkeymd5: String?
        public let ssekmskeyid: String?
        public let serversideencryption: ServerSideEncryption?
        

        init(
            etag: String?,
            requestcharged: RequestCharged?,
            ssecustomeralgorithm: String?,
            ssecustomerkeymd5: String?,
            ssekmskeyid: String?,
            serversideencryption: ServerSideEncryption?
            
        ) {
            self.etag = etag
            self.requestcharged = requestcharged
            self.ssecustomeralgorithm = ssecustomeralgorithm
            self.ssecustomerkeymd5 = ssecustomerkeymd5
            self.ssekmskeyid = ssekmskeyid
            self.serversideencryption = serversideencryption
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            element.addChild(etag?.restXmlSerialize().node)
            
            element.addChild(requestcharged?.restXmlSerialize().node)
            
            element.addChild(ssecustomeralgorithm?.restXmlSerialize().node)
            
            element.addChild(ssecustomerkeymd5?.restXmlSerialize().node)
            
            element.addChild(ssekmskeyid?.restXmlSerialize().node)
            
            element.addChild(serversideencryption?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> UploadPartOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let etag = try! body.nodes(forXPath: "ETag").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let requestcharged = try! body.nodes(forXPath: "x-amz-request-charged").first.flatMapNoNulls { v in
                return RequestCharged.deserialize(response: response, body: v)
            }
            
            let ssecustomeralgorithm = try! body.nodes(forXPath: "x-amz-server-side-encryption-customer-algorithm").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let ssecustomerkeymd5 = try! body.nodes(forXPath: "x-amz-server-side-encryption-customer-key-MD5").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let ssekmskeyid = try! body.nodes(forXPath: "x-amz-server-side-encryption-aws-kms-key-id").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let serversideencryption = try! body.nodes(forXPath: "x-amz-server-side-encryption").first.flatMapNoNulls { v in
                return ServerSideEncryption.deserialize(response: response, body: v)
            }
            

            return UploadPartOutput(
                
                etag: etag,
                
                requestcharged: requestcharged,
                
                ssecustomeralgorithm: ssecustomeralgorithm,
                
                ssecustomerkeymd5: ssecustomerkeymd5,
                
                ssekmskeyid: ssekmskeyid,
                
                serversideencryption: serversideencryption
                
            )
        }
        
    }
    
    struct UploadPartRequest: RestXmlSerializable, AwswiftDeserializable {
        public let s3body: Data?
        public let bucket: String
        public let contentlength: Int?
        public let contentmd5: String?
        public let key: String
        public let partnumber: Int
        public let requestpayer: RequestPayer?
        public let ssecustomeralgorithm: String?
        public let ssecustomerkey: String?
        public let ssecustomerkeymd5: String?
        public let uploadid: String
        

        init(
            s3body: Data?,
            bucket: String,
            contentlength: Int?,
            contentmd5: String?,
            key: String,
            partnumber: Int,
            requestpayer: RequestPayer?,
            ssecustomeralgorithm: String?,
            ssecustomerkey: String?,
            ssecustomerkeymd5: String?,
            uploadid: String
            
        ) {
            self.s3body = s3body
            self.bucket = bucket
            self.contentlength = contentlength
            self.contentmd5 = contentmd5
            self.key = key
            self.partnumber = partnumber
            self.requestpayer = requestpayer
            self.ssecustomeralgorithm = ssecustomeralgorithm
            self.ssecustomerkey = ssecustomerkey
            self.ssecustomerkeymd5 = ssecustomerkeymd5
            self.uploadid = uploadid
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            element.addChild(s3body?.restXmlSerialize().node)
            
            element.addChild(bucket.restXmlSerialize().node)
            
            element.addChild(contentlength?.restXmlSerialize().node)
            
            element.addChild(contentmd5?.restXmlSerialize().node)
            
            element.addChild(key.restXmlSerialize().node)
            
            element.addChild(partnumber.restXmlSerialize().node)
            
            element.addChild(requestpayer?.restXmlSerialize().node)
            
            element.addChild(ssecustomeralgorithm?.restXmlSerialize().node)
            
            element.addChild(ssecustomerkey?.restXmlSerialize().node)
            
            element.addChild(ssecustomerkeymd5?.restXmlSerialize().node)
            
            element.addChild(uploadid.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> UploadPartRequest {
            fatalError()
        }
        
        
    }
    
    struct VersioningConfiguration: RestXmlSerializable, AwswiftDeserializable {
        public let mfadelete: MFADelete?
        public let status: BucketVersioningStatus?
        

        init(
            mfadelete: MFADelete?,
            status: BucketVersioningStatus?
            
        ) {
            self.mfadelete = mfadelete
            self.status = status
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(mfadelete?.restXmlSerialize().node)
            
            element.addChild(status?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> VersioningConfiguration {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let mfadelete = try! body.nodes(forXPath: "MfaDelete").first.flatMapNoNulls { v in
                return MFADelete.deserialize(response: response, body: v)
            }
            
            let status = try! body.nodes(forXPath: "Status").first.flatMapNoNulls { v in
                return BucketVersioningStatus.deserialize(response: response, body: v)
            }
            

            return VersioningConfiguration(
                
                mfadelete: mfadelete,
                
                status: status
                
            )
        }
        
    }
    
    struct WebsiteConfiguration: RestXmlSerializable, AwswiftDeserializable {
        public let errordocument: ErrorDocument?
        public let indexdocument: IndexDocument?
        public let redirectallrequeststo: RedirectAllRequestsTo?
        public let routingrules: [RoutingRule]?
        

        init(
            errordocument: ErrorDocument?,
            indexdocument: IndexDocument?,
            redirectallrequeststo: RedirectAllRequestsTo?,
            routingrules: [RoutingRule]?
            
        ) {
            self.errordocument = errordocument
            self.indexdocument = indexdocument
            self.redirectallrequeststo = redirectallrequeststo
            self.routingrules = routingrules
            
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            
            
            let element = XMLElement(name: "")
            
            
            
            
            
            
            element.addChild(errordocument?.restXmlSerialize().node)
            
            element.addChild(indexdocument?.restXmlSerialize().node)
            
            element.addChild(redirectallrequeststo?.restXmlSerialize().node)
            
            element.addChild(routingrules?.restXmlSerialize().node)
            
            return RestXmlFieldValue(node: element)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> WebsiteConfiguration {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let errordocument = try! body.nodes(forXPath: "ErrorDocument").first.flatMapNoNulls { v in
                return ErrorDocument.deserialize(response: response, body: v)
            }
            
            let indexdocument = try! body.nodes(forXPath: "IndexDocument").first.flatMapNoNulls { v in
                return IndexDocument.deserialize(response: response, body: v)
            }
            
            let redirectallrequeststo = try! body.nodes(forXPath: "RedirectAllRequestsTo").first.flatMapNoNulls { v in
                return RedirectAllRequestsTo.deserialize(response: response, body: v)
            }
            
            let routingrules = try! body.nodes(forXPath: "RoutingRules").first.flatMapNoNulls { v in
                return [RoutingRule].deserialize(response: response, body: v)
            }
            

            return WebsiteConfiguration(
                
                errordocument: errordocument,
                
                indexdocument: indexdocument,
                
                redirectallrequeststo: redirectallrequeststo,
                
                routingrules: routingrules
                
            )
        }
        
    }
    

    
    enum BucketAccelerateStatus: String, RestXmlSerializable, AwswiftDeserializable {
        case enabled = "Enabled"
        case suspended = "Suspended"
        

        static func deserialize(response: HTTPURLResponse, body: Any?) -> BucketAccelerateStatus {
            guard let body = body as? XMLNode else { fatalError() }

            if let e = BucketAccelerateStatus(rawValue: body.stringValue!) {
                return e
            } else {
                fatalError()
            }
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            return RestXmlFieldValue(node: XMLNode.text(withStringValue: rawValue) as! XMLNode)
        }
    }
    
    enum BucketCannedACL: String, RestXmlSerializable, AwswiftDeserializable {
        case s3private = "private"
        case publicRead = "public-read"
        case publicReadWrite = "public-read-write"
        case authenticatedRead = "authenticated-read"
        

        static func deserialize(response: HTTPURLResponse, body: Any?) -> BucketCannedACL {
            guard let body = body as? XMLNode else { fatalError() }

            if let e = BucketCannedACL(rawValue: body.stringValue!) {
                return e
            } else {
                fatalError()
            }
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            return RestXmlFieldValue(node: XMLNode.text(withStringValue: rawValue) as! XMLNode)
        }
    }
    
    enum BucketLocationConstraint: String, RestXmlSerializable, AwswiftDeserializable {
        case eu = "EU"
        case euWest1 = "eu-west-1"
        case usWest1 = "us-west-1"
        case usWest2 = "us-west-2"
        case apSouth1 = "ap-south-1"
        case apSoutheast1 = "ap-southeast-1"
        case apSoutheast2 = "ap-southeast-2"
        case apNortheast1 = "ap-northeast-1"
        case saEast1 = "sa-east-1"
        case cnNorth1 = "cn-north-1"
        case euCentral1 = "eu-central-1"
        

        static func deserialize(response: HTTPURLResponse, body: Any?) -> BucketLocationConstraint {
            guard let body = body as? XMLNode else { fatalError() }

            if let e = BucketLocationConstraint(rawValue: body.stringValue!) {
                return e
            } else {
                fatalError()
            }
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            return RestXmlFieldValue(node: XMLNode.text(withStringValue: rawValue) as! XMLNode)
        }
    }
    
    enum BucketLogsPermission: String, RestXmlSerializable, AwswiftDeserializable {
        case fullControl = "FULL_CONTROL"
        case read = "READ"
        case write = "WRITE"
        

        static func deserialize(response: HTTPURLResponse, body: Any?) -> BucketLogsPermission {
            guard let body = body as? XMLNode else { fatalError() }

            if let e = BucketLogsPermission(rawValue: body.stringValue!) {
                return e
            } else {
                fatalError()
            }
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            return RestXmlFieldValue(node: XMLNode.text(withStringValue: rawValue) as! XMLNode)
        }
    }
    
    enum BucketVersioningStatus: String, RestXmlSerializable, AwswiftDeserializable {
        case enabled = "Enabled"
        case suspended = "Suspended"
        

        static func deserialize(response: HTTPURLResponse, body: Any?) -> BucketVersioningStatus {
            guard let body = body as? XMLNode else { fatalError() }

            if let e = BucketVersioningStatus(rawValue: body.stringValue!) {
                return e
            } else {
                fatalError()
            }
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            return RestXmlFieldValue(node: XMLNode.text(withStringValue: rawValue) as! XMLNode)
        }
    }
    
    enum EncodingType: String, RestXmlSerializable, AwswiftDeserializable {
        case url = "url"
        

        static func deserialize(response: HTTPURLResponse, body: Any?) -> EncodingType {
            guard let body = body as? XMLNode else { fatalError() }

            if let e = EncodingType(rawValue: body.stringValue!) {
                return e
            } else {
                fatalError()
            }
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            return RestXmlFieldValue(node: XMLNode.text(withStringValue: rawValue) as! XMLNode)
        }
    }
    
    enum Event: String, RestXmlSerializable, AwswiftDeserializable {
        case s3Reducedredundancylostobject = "s3:ReducedRedundancyLostObject"
        case s3Objectcreated = "s3:ObjectCreated:*"
        case s3ObjectcreatedPut = "s3:ObjectCreated:Put"
        case s3ObjectcreatedPost = "s3:ObjectCreated:Post"
        case s3ObjectcreatedCopy = "s3:ObjectCreated:Copy"
        case s3ObjectcreatedCompletemultipartupload = "s3:ObjectCreated:CompleteMultipartUpload"
        case s3Objectremoved = "s3:ObjectRemoved:*"
        case s3ObjectremovedDelete = "s3:ObjectRemoved:Delete"
        case s3ObjectremovedDeletemarkercreated = "s3:ObjectRemoved:DeleteMarkerCreated"
        

        static func deserialize(response: HTTPURLResponse, body: Any?) -> Event {
            guard let body = body as? XMLNode else { fatalError() }

            if let e = Event(rawValue: body.stringValue!) {
                return e
            } else {
                fatalError()
            }
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            return RestXmlFieldValue(node: XMLNode.text(withStringValue: rawValue) as! XMLNode)
        }
    }
    
    enum ExpirationStatus: String, RestXmlSerializable, AwswiftDeserializable {
        case enabled = "Enabled"
        case disabled = "Disabled"
        

        static func deserialize(response: HTTPURLResponse, body: Any?) -> ExpirationStatus {
            guard let body = body as? XMLNode else { fatalError() }

            if let e = ExpirationStatus(rawValue: body.stringValue!) {
                return e
            } else {
                fatalError()
            }
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            return RestXmlFieldValue(node: XMLNode.text(withStringValue: rawValue) as! XMLNode)
        }
    }
    
    enum FilterRuleName: String, RestXmlSerializable, AwswiftDeserializable {
        case prefix = "prefix"
        case suffix = "suffix"
        

        static func deserialize(response: HTTPURLResponse, body: Any?) -> FilterRuleName {
            guard let body = body as? XMLNode else { fatalError() }

            if let e = FilterRuleName(rawValue: body.stringValue!) {
                return e
            } else {
                fatalError()
            }
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            return RestXmlFieldValue(node: XMLNode.text(withStringValue: rawValue) as! XMLNode)
        }
    }
    
    enum MFADelete: String, RestXmlSerializable, AwswiftDeserializable {
        case enabled = "Enabled"
        case disabled = "Disabled"
        

        static func deserialize(response: HTTPURLResponse, body: Any?) -> MFADelete {
            guard let body = body as? XMLNode else { fatalError() }

            if let e = MFADelete(rawValue: body.stringValue!) {
                return e
            } else {
                fatalError()
            }
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            return RestXmlFieldValue(node: XMLNode.text(withStringValue: rawValue) as! XMLNode)
        }
    }
    
    enum MFADeleteStatus: String, RestXmlSerializable, AwswiftDeserializable {
        case enabled = "Enabled"
        case disabled = "Disabled"
        

        static func deserialize(response: HTTPURLResponse, body: Any?) -> MFADeleteStatus {
            guard let body = body as? XMLNode else { fatalError() }

            if let e = MFADeleteStatus(rawValue: body.stringValue!) {
                return e
            } else {
                fatalError()
            }
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            return RestXmlFieldValue(node: XMLNode.text(withStringValue: rawValue) as! XMLNode)
        }
    }
    
    enum MetadataDirective: String, RestXmlSerializable, AwswiftDeserializable {
        case copy = "COPY"
        case replace = "REPLACE"
        

        static func deserialize(response: HTTPURLResponse, body: Any?) -> MetadataDirective {
            guard let body = body as? XMLNode else { fatalError() }

            if let e = MetadataDirective(rawValue: body.stringValue!) {
                return e
            } else {
                fatalError()
            }
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            return RestXmlFieldValue(node: XMLNode.text(withStringValue: rawValue) as! XMLNode)
        }
    }
    
    enum ObjectCannedACL: String, RestXmlSerializable, AwswiftDeserializable {
        case s3private = "private"
        case publicRead = "public-read"
        case publicReadWrite = "public-read-write"
        case authenticatedRead = "authenticated-read"
        case awsExecRead = "aws-exec-read"
        case bucketOwnerRead = "bucket-owner-read"
        case bucketOwnerFullControl = "bucket-owner-full-control"
        

        static func deserialize(response: HTTPURLResponse, body: Any?) -> ObjectCannedACL {
            guard let body = body as? XMLNode else { fatalError() }

            if let e = ObjectCannedACL(rawValue: body.stringValue!) {
                return e
            } else {
                fatalError()
            }
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            return RestXmlFieldValue(node: XMLNode.text(withStringValue: rawValue) as! XMLNode)
        }
    }
    
    enum ObjectStorageClass: String, RestXmlSerializable, AwswiftDeserializable {
        case standard = "STANDARD"
        case reducedRedundancy = "REDUCED_REDUNDANCY"
        case glacier = "GLACIER"
        

        static func deserialize(response: HTTPURLResponse, body: Any?) -> ObjectStorageClass {
            guard let body = body as? XMLNode else { fatalError() }

            if let e = ObjectStorageClass(rawValue: body.stringValue!) {
                return e
            } else {
                fatalError()
            }
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            return RestXmlFieldValue(node: XMLNode.text(withStringValue: rawValue) as! XMLNode)
        }
    }
    
    enum ObjectVersionStorageClass: String, RestXmlSerializable, AwswiftDeserializable {
        case standard = "STANDARD"
        

        static func deserialize(response: HTTPURLResponse, body: Any?) -> ObjectVersionStorageClass {
            guard let body = body as? XMLNode else { fatalError() }

            if let e = ObjectVersionStorageClass(rawValue: body.stringValue!) {
                return e
            } else {
                fatalError()
            }
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            return RestXmlFieldValue(node: XMLNode.text(withStringValue: rawValue) as! XMLNode)
        }
    }
    
    enum Payer: String, RestXmlSerializable, AwswiftDeserializable {
        case requester = "Requester"
        case bucketowner = "BucketOwner"
        

        static func deserialize(response: HTTPURLResponse, body: Any?) -> Payer {
            guard let body = body as? XMLNode else { fatalError() }

            if let e = Payer(rawValue: body.stringValue!) {
                return e
            } else {
                fatalError()
            }
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            return RestXmlFieldValue(node: XMLNode.text(withStringValue: rawValue) as! XMLNode)
        }
    }
    
    enum Permission: String, RestXmlSerializable, AwswiftDeserializable {
        case fullControl = "FULL_CONTROL"
        case write = "WRITE"
        case writeAcp = "WRITE_ACP"
        case read = "READ"
        case readAcp = "READ_ACP"
        

        static func deserialize(response: HTTPURLResponse, body: Any?) -> Permission {
            guard let body = body as? XMLNode else { fatalError() }

            if let e = Permission(rawValue: body.stringValue!) {
                return e
            } else {
                fatalError()
            }
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            return RestXmlFieldValue(node: XMLNode.text(withStringValue: rawValue) as! XMLNode)
        }
    }
    
    enum ReplicationRuleStatus: String, RestXmlSerializable, AwswiftDeserializable {
        case enabled = "Enabled"
        case disabled = "Disabled"
        

        static func deserialize(response: HTTPURLResponse, body: Any?) -> ReplicationRuleStatus {
            guard let body = body as? XMLNode else { fatalError() }

            if let e = ReplicationRuleStatus(rawValue: body.stringValue!) {
                return e
            } else {
                fatalError()
            }
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            return RestXmlFieldValue(node: XMLNode.text(withStringValue: rawValue) as! XMLNode)
        }
    }
    
    enum ReplicationStatus: String, RestXmlSerializable, AwswiftDeserializable {
        case complete = "COMPLETE"
        case pending = "PENDING"
        case failed = "FAILED"
        case replica = "REPLICA"
        

        static func deserialize(response: HTTPURLResponse, body: Any?) -> ReplicationStatus {
            guard let body = body as? XMLNode else { fatalError() }

            if let e = ReplicationStatus(rawValue: body.stringValue!) {
                return e
            } else {
                fatalError()
            }
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            return RestXmlFieldValue(node: XMLNode.text(withStringValue: rawValue) as! XMLNode)
        }
    }
    
    enum RequestCharged: String, RestXmlSerializable, AwswiftDeserializable {
        case requester = "requester"
        

        static func deserialize(response: HTTPURLResponse, body: Any?) -> RequestCharged {
            guard let body = body as? XMLNode else { fatalError() }

            if let e = RequestCharged(rawValue: body.stringValue!) {
                return e
            } else {
                fatalError()
            }
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            return RestXmlFieldValue(node: XMLNode.text(withStringValue: rawValue) as! XMLNode)
        }
    }
    
    enum RequestPayer: String, RestXmlSerializable, AwswiftDeserializable {
        case requester = "requester"
        

        static func deserialize(response: HTTPURLResponse, body: Any?) -> RequestPayer {
            guard let body = body as? XMLNode else { fatalError() }

            if let e = RequestPayer(rawValue: body.stringValue!) {
                return e
            } else {
                fatalError()
            }
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            return RestXmlFieldValue(node: XMLNode.text(withStringValue: rawValue) as! XMLNode)
        }
    }
    
    enum S3Protocol: String, RestXmlSerializable, AwswiftDeserializable {
        case http = "http"
        case https = "https"
        

        static func deserialize(response: HTTPURLResponse, body: Any?) -> S3Protocol {
            guard let body = body as? XMLNode else { fatalError() }

            if let e = S3Protocol(rawValue: body.stringValue!) {
                return e
            } else {
                fatalError()
            }
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            return RestXmlFieldValue(node: XMLNode.text(withStringValue: rawValue) as! XMLNode)
        }
    }
    
    enum S3Type: String, RestXmlSerializable, AwswiftDeserializable {
        case canonicaluser = "CanonicalUser"
        case amazoncustomerbyemail = "AmazonCustomerByEmail"
        case group = "Group"
        

        static func deserialize(response: HTTPURLResponse, body: Any?) -> S3Type {
            guard let body = body as? XMLNode else { fatalError() }

            if let e = S3Type(rawValue: body.stringValue!) {
                return e
            } else {
                fatalError()
            }
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            return RestXmlFieldValue(node: XMLNode.text(withStringValue: rawValue) as! XMLNode)
        }
    }
    
    enum ServerSideEncryption: String, RestXmlSerializable, AwswiftDeserializable {
        case aes256 = "AES256"
        case awsKms = "aws:kms"
        

        static func deserialize(response: HTTPURLResponse, body: Any?) -> ServerSideEncryption {
            guard let body = body as? XMLNode else { fatalError() }

            if let e = ServerSideEncryption(rawValue: body.stringValue!) {
                return e
            } else {
                fatalError()
            }
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            return RestXmlFieldValue(node: XMLNode.text(withStringValue: rawValue) as! XMLNode)
        }
    }
    
    enum StorageClass: String, RestXmlSerializable, AwswiftDeserializable {
        case standard = "STANDARD"
        case reducedRedundancy = "REDUCED_REDUNDANCY"
        case standardIa = "STANDARD_IA"
        

        static func deserialize(response: HTTPURLResponse, body: Any?) -> StorageClass {
            guard let body = body as? XMLNode else { fatalError() }

            if let e = StorageClass(rawValue: body.stringValue!) {
                return e
            } else {
                fatalError()
            }
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            return RestXmlFieldValue(node: XMLNode.text(withStringValue: rawValue) as! XMLNode)
        }
    }
    
    enum TransitionStorageClass: String, RestXmlSerializable, AwswiftDeserializable {
        case glacier = "GLACIER"
        case standardIa = "STANDARD_IA"
        

        static func deserialize(response: HTTPURLResponse, body: Any?) -> TransitionStorageClass {
            guard let body = body as? XMLNode else { fatalError() }

            if let e = TransitionStorageClass(rawValue: body.stringValue!) {
                return e
            } else {
                fatalError()
            }
        }

        func restXmlSerialize() -> RestXmlFieldValue {
            return RestXmlFieldValue(node: XMLNode.text(withStringValue: rawValue) as! XMLNode)
        }
    }
    
}
