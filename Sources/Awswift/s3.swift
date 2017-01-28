import Foundation
import Signer
struct S3 {
  struct Client {
    let region: String
    let credentialsProvider: AwsCredentialsProvider
    let session: URLSession
    let queue: DispatchQueue

    init(region: String) {
      self.region = region
      self.credentialsProvider = DefaultChainProvider()
      self.session = URLSession(configuration: URLSessionConfiguration.default)
      self.queue = DispatchQueue(label: "awswift.S3.Client.queue")
    }

    func scope() -> AwsCredentialsScope {
      return AwsCredentialsScope(date: Date(), region: region, service: "s3")
    }

/**
<p>Aborts a multipart upload.</p><p>To verify that all parts have been removed, so you don't get charged for the part storage, you should call the List Parts operation and ensure the parts list is empty.</p>
 */
func abortMultipartUpload(input: AbortMultipartUploadRequest) -> ApiCallTask<AbortMultipartUploadOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}/{Key+}", 
      httpMethod: "DELETE", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
Completes a multipart upload by assembling previously uploaded parts.
 */
func completeMultipartUpload(input: CompleteMultipartUploadRequest) -> ApiCallTask<CompleteMultipartUploadOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}/{Key+}", 
      httpMethod: "POST", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
Creates a copy of an object that is already stored in Amazon S3.
 */
func copyObject(input: CopyObjectRequest) -> ApiCallTask<CopyObjectOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}/{Key+}", 
      httpMethod: "PUT", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
Creates a new bucket.
 */
func createBucket(input: CreateBucketRequest) -> ApiCallTask<CreateBucketOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}", 
      httpMethod: "PUT", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p>Initiates a multipart upload and returns an upload ID.</p><p><b>Note:</b> After you initiate multipart upload and upload one or more parts, you must either complete or abort multipart upload in order to stop getting charged for storage of the uploaded parts. Only after you either complete or abort multipart upload, Amazon S3 frees up the parts storage and stops charging you for the parts storage.</p>
 */
func createMultipartUpload(input: CreateMultipartUploadRequest) -> ApiCallTask<CreateMultipartUploadOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}/{Key+}?uploads", 
      httpMethod: "POST", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
Deletes the bucket. All objects (including all object versions and Delete Markers) in the bucket must be deleted before the bucket itself can be deleted.
 */
func deleteBucket(input: DeleteBucketRequest) -> ApiCallTask<AwsApiVoidOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}", 
      httpMethod: "DELETE", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
Deletes the cors configuration information set for the bucket.
 */
func deleteBucketCors(input: DeleteBucketCorsRequest) -> ApiCallTask<AwsApiVoidOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}?cors", 
      httpMethod: "DELETE", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
Deletes the lifecycle configuration from the bucket.
 */
func deleteBucketLifecycle(input: DeleteBucketLifecycleRequest) -> ApiCallTask<AwsApiVoidOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}?lifecycle", 
      httpMethod: "DELETE", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
Deletes the policy from the bucket.
 */
func deleteBucketPolicy(input: DeleteBucketPolicyRequest) -> ApiCallTask<AwsApiVoidOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}?policy", 
      httpMethod: "DELETE", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
Deletes the replication configuration from the bucket.
 */
func deleteBucketReplication(input: DeleteBucketReplicationRequest) -> ApiCallTask<AwsApiVoidOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}?replication", 
      httpMethod: "DELETE", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
Deletes the tags from the bucket.
 */
func deleteBucketTagging(input: DeleteBucketTaggingRequest) -> ApiCallTask<AwsApiVoidOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}?tagging", 
      httpMethod: "DELETE", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
This operation removes the website configuration from the bucket.
 */
func deleteBucketWebsite(input: DeleteBucketWebsiteRequest) -> ApiCallTask<AwsApiVoidOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}?website", 
      httpMethod: "DELETE", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
Removes the null version (if there is one) of an object and inserts a delete marker, which becomes the latest version of the object. If there isn't a null version, Amazon S3 does not remove any objects.
 */
func deleteObject(input: DeleteObjectRequest) -> ApiCallTask<DeleteObjectOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}/{Key+}", 
      httpMethod: "DELETE", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
This operation enables you to delete multiple objects from a bucket using a single HTTP request. You may specify up to 1000 keys.
 */
func deleteObjects(input: DeleteObjectsRequest) -> ApiCallTask<DeleteObjectsOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}?delete", 
      httpMethod: "POST", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
Returns the accelerate configuration of a bucket.
 */
func getBucketAccelerateConfiguration(input: GetBucketAccelerateConfigurationRequest) -> ApiCallTask<GetBucketAccelerateConfigurationOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}?accelerate", 
      httpMethod: "GET", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
Gets the access control policy for the bucket.
 */
func getBucketAcl(input: GetBucketAclRequest) -> ApiCallTask<GetBucketAclOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}?acl", 
      httpMethod: "GET", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
Returns the cors configuration for the bucket.
 */
func getBucketCors(input: GetBucketCorsRequest) -> ApiCallTask<GetBucketCorsOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}?cors", 
      httpMethod: "GET", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
Deprecated, see the GetBucketLifecycleConfiguration operation.
 */
func getBucketLifecycle(input: GetBucketLifecycleRequest) -> ApiCallTask<GetBucketLifecycleOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}?lifecycle", 
      httpMethod: "GET", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
Returns the lifecycle configuration information set on the bucket.
 */
func getBucketLifecycleConfiguration(input: GetBucketLifecycleConfigurationRequest) -> ApiCallTask<GetBucketLifecycleConfigurationOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}?lifecycle", 
      httpMethod: "GET", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
Returns the region the bucket resides in.
 */
func getBucketLocation(input: GetBucketLocationRequest) -> ApiCallTask<GetBucketLocationOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}?location", 
      httpMethod: "GET", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
Returns the logging status of a bucket and the permissions users have to view and modify that status. To use GET, you must be the bucket owner.
 */
func getBucketLogging(input: GetBucketLoggingRequest) -> ApiCallTask<GetBucketLoggingOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}?logging", 
      httpMethod: "GET", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
Deprecated, see the GetBucketNotificationConfiguration operation.
 */
func getBucketNotification(input: GetBucketNotificationConfigurationRequest) -> ApiCallTask<NotificationConfigurationDeprecated> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}?notification", 
      httpMethod: "GET", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
Returns the notification configuration of a bucket.
 */
func getBucketNotificationConfiguration(input: GetBucketNotificationConfigurationRequest) -> ApiCallTask<NotificationConfiguration> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}?notification", 
      httpMethod: "GET", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
Returns the policy of a specified bucket.
 */
func getBucketPolicy(input: GetBucketPolicyRequest) -> ApiCallTask<GetBucketPolicyOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}?policy", 
      httpMethod: "GET", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
Returns the replication configuration of a bucket.
 */
func getBucketReplication(input: GetBucketReplicationRequest) -> ApiCallTask<GetBucketReplicationOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}?replication", 
      httpMethod: "GET", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
Returns the request payment configuration of a bucket.
 */
func getBucketRequestPayment(input: GetBucketRequestPaymentRequest) -> ApiCallTask<GetBucketRequestPaymentOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}?requestPayment", 
      httpMethod: "GET", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
Returns the tag set associated with the bucket.
 */
func getBucketTagging(input: GetBucketTaggingRequest) -> ApiCallTask<GetBucketTaggingOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}?tagging", 
      httpMethod: "GET", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
Returns the versioning state of a bucket.
 */
func getBucketVersioning(input: GetBucketVersioningRequest) -> ApiCallTask<GetBucketVersioningOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}?versioning", 
      httpMethod: "GET", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
Returns the website configuration for a bucket.
 */
func getBucketWebsite(input: GetBucketWebsiteRequest) -> ApiCallTask<GetBucketWebsiteOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}?website", 
      httpMethod: "GET", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
Retrieves objects from Amazon S3.
 */
func getObject(input: GetObjectRequest) -> ApiCallTask<GetObjectOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}/{Key+}", 
      httpMethod: "GET", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
Returns the access control list (ACL) of an object.
 */
func getObjectAcl(input: GetObjectAclRequest) -> ApiCallTask<GetObjectAclOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}/{Key+}?acl", 
      httpMethod: "GET", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
Return torrent files from a bucket.
 */
func getObjectTorrent(input: GetObjectTorrentRequest) -> ApiCallTask<GetObjectTorrentOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}/{Key+}?torrent", 
      httpMethod: "GET", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
This operation is useful to determine if a bucket exists and you have permission to access it.
 */
func headBucket(input: HeadBucketRequest) -> ApiCallTask<AwsApiVoidOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}", 
      httpMethod: "HEAD", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
The HEAD operation retrieves metadata from an object without returning the object itself. This operation is useful if you're only interested in an object's metadata. To use HEAD, you must have READ access to the object.
 */
func headObject(input: HeadObjectRequest) -> ApiCallTask<HeadObjectOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}/{Key+}", 
      httpMethod: "HEAD", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
Returns a list of all buckets owned by the authenticated sender of the request.
 */
func listBuckets(input: AwsApiVoidInput) -> ApiCallTask<ListBucketsOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/", 
      httpMethod: "GET", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
This operation lists in-progress multipart uploads.
 */
func listMultipartUploads(input: ListMultipartUploadsRequest) -> ApiCallTask<ListMultipartUploadsOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}?uploads", 
      httpMethod: "GET", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
Returns metadata about all of the versions of objects in a bucket.
 */
func listObjectVersions(input: ListObjectVersionsRequest) -> ApiCallTask<ListObjectVersionsOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}?versions", 
      httpMethod: "GET", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
Returns some or all (up to 1000) of the objects in a bucket. You can use the request parameters as selection criteria to return a subset of the objects in a bucket.
 */
func listObjects(input: ListObjectsRequest) -> ApiCallTask<ListObjectsOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}", 
      httpMethod: "GET", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
Returns some or all (up to 1000) of the objects in a bucket. You can use the request parameters as selection criteria to return a subset of the objects in a bucket. Note: ListObjectsV2 is the revised List Objects API and we recommend you use this revised API for new application development.
 */
func listObjectsV2(input: ListObjectsV2Request) -> ApiCallTask<ListObjectsV2Output> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}?list-type=2", 
      httpMethod: "GET", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
Lists the parts that have been uploaded for a specific multipart upload.
 */
func listParts(input: ListPartsRequest) -> ApiCallTask<ListPartsOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}/{Key+}", 
      httpMethod: "GET", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
Sets the accelerate configuration of an existing bucket.
 */
func putBucketAccelerateConfiguration(input: PutBucketAccelerateConfigurationRequest) -> ApiCallTask<AwsApiVoidOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}?accelerate", 
      httpMethod: "PUT", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
Sets the permissions on a bucket using access control lists (ACL).
 */
func putBucketAcl(input: PutBucketAclRequest) -> ApiCallTask<AwsApiVoidOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}?acl", 
      httpMethod: "PUT", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
Sets the cors configuration for a bucket.
 */
func putBucketCors(input: PutBucketCorsRequest) -> ApiCallTask<AwsApiVoidOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}?cors", 
      httpMethod: "PUT", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
Deprecated, see the PutBucketLifecycleConfiguration operation.
 */
func putBucketLifecycle(input: PutBucketLifecycleRequest) -> ApiCallTask<AwsApiVoidOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}?lifecycle", 
      httpMethod: "PUT", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
Sets lifecycle configuration for your bucket. If a lifecycle configuration exists, it replaces it.
 */
func putBucketLifecycleConfiguration(input: PutBucketLifecycleConfigurationRequest) -> ApiCallTask<AwsApiVoidOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}?lifecycle", 
      httpMethod: "PUT", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
Set the logging parameters for a bucket and to specify permissions for who can view and modify the logging parameters. To set the logging status of a bucket, you must be the bucket owner.
 */
func putBucketLogging(input: PutBucketLoggingRequest) -> ApiCallTask<AwsApiVoidOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}?logging", 
      httpMethod: "PUT", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
Deprecated, see the PutBucketNotificationConfiguraiton operation.
 */
func putBucketNotification(input: PutBucketNotificationRequest) -> ApiCallTask<AwsApiVoidOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}?notification", 
      httpMethod: "PUT", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
Enables notifications of specified events for a bucket.
 */
func putBucketNotificationConfiguration(input: PutBucketNotificationConfigurationRequest) -> ApiCallTask<AwsApiVoidOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}?notification", 
      httpMethod: "PUT", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
Replaces a policy on a bucket. If the bucket already has a policy, the one in this request completely replaces it.
 */
func putBucketPolicy(input: PutBucketPolicyRequest) -> ApiCallTask<AwsApiVoidOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}?policy", 
      httpMethod: "PUT", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
Creates a new replication configuration (or replaces an existing one, if present).
 */
func putBucketReplication(input: PutBucketReplicationRequest) -> ApiCallTask<AwsApiVoidOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}?replication", 
      httpMethod: "PUT", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
Sets the request payment configuration for a bucket. By default, the bucket owner pays for downloads from the bucket. This configuration parameter enables the bucket owner (only) to specify that the person requesting the download will be charged for the download. Documentation on requester pays buckets can be found at http://docs.aws.amazon.com/AmazonS3/latest/dev/RequesterPaysBuckets.html
 */
func putBucketRequestPayment(input: PutBucketRequestPaymentRequest) -> ApiCallTask<AwsApiVoidOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}?requestPayment", 
      httpMethod: "PUT", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
Sets the tags for a bucket.
 */
func putBucketTagging(input: PutBucketTaggingRequest) -> ApiCallTask<AwsApiVoidOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}?tagging", 
      httpMethod: "PUT", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
Sets the versioning state of an existing bucket. To set the versioning state, you must be the bucket owner.
 */
func putBucketVersioning(input: PutBucketVersioningRequest) -> ApiCallTask<AwsApiVoidOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}?versioning", 
      httpMethod: "PUT", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
Set the website configuration for a bucket.
 */
func putBucketWebsite(input: PutBucketWebsiteRequest) -> ApiCallTask<AwsApiVoidOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}?website", 
      httpMethod: "PUT", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
Adds an object to a bucket.
 */
func putObject(input: PutObjectRequest) -> ApiCallTask<PutObjectOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}/{Key+}", 
      httpMethod: "PUT", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
uses the acl subresource to set the access control list (ACL) permissions for an object that already exists in a bucket
 */
func putObjectAcl(input: PutObjectAclRequest) -> ApiCallTask<PutObjectAclOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}/{Key+}?acl", 
      httpMethod: "PUT", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
Restores an archived copy of an object back into Amazon S3
 */
func restoreObject(input: RestoreObjectRequest) -> ApiCallTask<RestoreObjectOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}/{Key+}?restore", 
      httpMethod: "POST", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p>Uploads a part in a multipart upload.</p><p><b>Note:</b> After you initiate multipart upload and upload one or more parts, you must either complete or abort multipart upload in order to stop getting charged for storage of the uploaded parts. Only after you either complete or abort multipart upload, Amazon S3 frees up the parts storage and stops charging you for the parts storage.</p>
 */
func uploadPart(input: UploadPartRequest) -> ApiCallTask<UploadPartOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}/{Key+}", 
      httpMethod: "PUT", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
Uploads a part by copying data from an existing object as data source.
 */
func uploadPartCopy(input: UploadPartCopyRequest) -> ApiCallTask<UploadPartCopyOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3.dualstack.\(self.region).amazonaws.com/{Bucket}/{Key+}", 
      httpMethod: "PUT", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


  }

/**
Specifies the days since the initiation of an Incomplete Multipart Upload that Lifecycle will wait before permanently removing all parts of the upload.
 */
public struct AbortIncompleteMultipartUpload: AwswiftSerializable, AwswiftDeserializable {
/**
Indicates the number of days that must pass since initiation for Lifecycle to abort an Incomplete Multipart Upload.
 */
  public let daysAfterInitiation: Int?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if daysAfterInitiation != nil { body["DaysAfterInitiation"] = daysAfterInitiation! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> AbortIncompleteMultipartUpload {
    guard case let .xml(node) = body else { fatalError() }
    return AbortIncompleteMultipartUpload(
        daysAfterInitiation: try! node.nodes(forXPath: "DaysAfterInitiation").first.map { Int.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - daysAfterInitiation: Indicates the number of days that must pass since initiation for Lifecycle to abort an Incomplete Multipart Upload.
 */
  public init(daysAfterInitiation: Int?) {
self.daysAfterInitiation = daysAfterInitiation
  }
}

public struct AbortMultipartUploadOutput: AwswiftDeserializable {
/**

 */
  public let requestCharged: Requestcharged?


  static func deserializableBody(data: Data) -> DeserializableBody {
    fatalError()
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> AbortMultipartUploadOutput {
  
    return AbortMultipartUploadOutput(
        requestCharged: response.allHeaderFields["x-amz-request-charged"].flatMap { ($0 is NSNull) ? nil : Requestcharged.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - requestCharged: 
 */
  public init(requestCharged: Requestcharged?) {
self.requestCharged = requestCharged
  }
}

public struct AbortMultipartUploadRequest: AwswiftSerializable {
/**

 */
  public let bucket: String
/**

 */
  public let key: String
/**

 */
  public let requestPayer: Requestpayer?
/**

 */
  public let uploadId: String

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    var querystring: [String: String] = [:]
    var header: [String: String] = [:]
    
  
    uri["Bucket"] = "\(bucket)"
    uri["Key"] = "\(key)"
    querystring["uploadId"] = "\(uploadId)"
    if requestPayer != nil { header["x-amz-request-payer"] = "\(requestPayer!)" }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - bucket: 
      - key: 
      - requestPayer: 
      - uploadId: 
 */
  public init(bucket: String, key: String, requestPayer: Requestpayer?, uploadId: String) {
self.bucket = bucket
self.key = key
self.requestPayer = requestPayer
self.uploadId = uploadId
  }
}


public struct AccelerateConfiguration: AwswiftSerializable, AwswiftDeserializable {
/**
The accelerate configuration of the bucket.
 */
  public let status: Bucketacceleratestatus?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if status != nil { body["Status"] = status! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> AccelerateConfiguration {
    guard case let .xml(node) = body else { fatalError() }
    return AccelerateConfiguration(
        status: try! node.nodes(forXPath: "Status").first.map { Bucketacceleratestatus.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - status: The accelerate configuration of the bucket.
 */
  public init(status: Bucketacceleratestatus?) {
self.status = status
  }
}


public struct AccessControlPolicy: AwswiftSerializable, AwswiftDeserializable {
/**
A list of grants.
 */
  public let grants: [Grant]?
/**

 */
  public let owner: Owner?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if grants != nil { body["AccessControlList"] = grants! }
    if owner != nil { body["Owner"] = owner! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> AccessControlPolicy {
    guard case let .xml(node) = body else { fatalError() }
    return AccessControlPolicy(
        grants: try! node.nodes(forXPath: "AccessControlList").map { Grant.deserialize(response: response, body: .xml($0)) },
      owner: try! node.nodes(forXPath: "Owner").first.map { Owner.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - grants: A list of grants.
      - owner: 
 */
  public init(grants: [Grant]?, owner: Owner?) {
self.grants = grants
self.owner = owner
  }
}








public struct Bucket: AwswiftSerializable, AwswiftDeserializable {
/**
Date the bucket was created.
 */
  public let creationDate: Date?
/**
The name of the bucket.
 */
  public let name: String?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if creationDate != nil { body["CreationDate"] = creationDate! }
    if name != nil { body["Name"] = name! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Bucket {
    guard case let .xml(node) = body else { fatalError() }
    return Bucket(
        creationDate: try! node.nodes(forXPath: "CreationDate").first.map { Date.deserialize(response: response, body: .xml($0)) },
      name: try! node.nodes(forXPath: "Name").first.map { String.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - creationDate: Date the bucket was created.
      - name: The name of the bucket.
 */
  public init(creationDate: Date?, name: String?) {
self.creationDate = creationDate
self.name = name
  }
}

enum Bucketacceleratestatus: String, AwswiftDeserializable, AwswiftSerializable {
  case `enabled` = "Enabled"
  case `suspended` = "Suspended"

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Bucketacceleratestatus {
    switch body { 
    case .json(let json): return Bucketacceleratestatus(rawValue: json as! String)!
    case .xml(let node): return Bucketacceleratestatus(rawValue: node.stringValue!)!
    }
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}

/**
The requested bucket name is not available. The bucket namespace is shared by all users of the system. Please select a different name and try again.
 */
public struct BucketAlreadyExists: AwswiftSerializable, AwswiftDeserializable {

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    fatalError()
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> BucketAlreadyExists {
  
    return BucketAlreadyExists(
  
    )
  }

/**
    - parameters:
 */
  public init() {
  }
}

public struct BucketAlreadyOwnedByYou: AwswiftSerializable, AwswiftDeserializable {

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    fatalError()
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> BucketAlreadyOwnedByYou {
  
    return BucketAlreadyOwnedByYou(
  
    )
  }

/**
    - parameters:
 */
  public init() {
  }
}

enum Bucketcannedacl: String, AwswiftDeserializable, AwswiftSerializable {
  case `private` = "private"
  case `publicread` = "public-read"
  case `publicreadwrite` = "public-read-write"
  case `authenticatedread` = "authenticated-read"

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Bucketcannedacl {
    switch body { 
    case .json(let json): return Bucketcannedacl(rawValue: json as! String)!
    case .xml(let node): return Bucketcannedacl(rawValue: node.stringValue!)!
    }
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}

public struct BucketLifecycleConfiguration: AwswiftSerializable, AwswiftDeserializable {
/**

 */
  public let rules: [LifecycleRule]

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["Rule"] = rules
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> BucketLifecycleConfiguration {
    guard case let .xml(node) = body else { fatalError() }
    return BucketLifecycleConfiguration(
        rules: try! node.nodes(forXPath: "Rule").map { LifecycleRule.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - rules: 
 */
  public init(rules: [LifecycleRule]) {
self.rules = rules
  }
}

enum Bucketlocationconstraint: String, AwswiftDeserializable, AwswiftSerializable {
  case `eU` = "EU"
  case `euwest1` = "eu-west-1"
  case `uswest1` = "us-west-1"
  case `uswest2` = "us-west-2"
  case `apsouth1` = "ap-south-1"
  case `apsoutheast1` = "ap-southeast-1"
  case `apsoutheast2` = "ap-southeast-2"
  case `apnortheast1` = "ap-northeast-1"
  case `saeast1` = "sa-east-1"
  case `cnnorth1` = "cn-north-1"
  case `eucentral1` = "eu-central-1"

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Bucketlocationconstraint {
    switch body { 
    case .json(let json): return Bucketlocationconstraint(rawValue: json as! String)!
    case .xml(let node): return Bucketlocationconstraint(rawValue: node.stringValue!)!
    }
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}

public struct BucketLoggingStatus: AwswiftSerializable, AwswiftDeserializable {
/**

 */
  public let loggingEnabled: LoggingEnabled?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if loggingEnabled != nil { body["LoggingEnabled"] = loggingEnabled! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> BucketLoggingStatus {
    guard case let .xml(node) = body else { fatalError() }
    return BucketLoggingStatus(
        loggingEnabled: try! node.nodes(forXPath: "LoggingEnabled").first.map { LoggingEnabled.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - loggingEnabled: 
 */
  public init(loggingEnabled: LoggingEnabled?) {
self.loggingEnabled = loggingEnabled
  }
}

enum Bucketlogspermission: String, AwswiftDeserializable, AwswiftSerializable {
  case `fULL_CONTROL` = "FULL_CONTROL"
  case `rEAD` = "READ"
  case `wRITE` = "WRITE"

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Bucketlogspermission {
    switch body { 
    case .json(let json): return Bucketlogspermission(rawValue: json as! String)!
    case .xml(let node): return Bucketlogspermission(rawValue: node.stringValue!)!
    }
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}


enum Bucketversioningstatus: String, AwswiftDeserializable, AwswiftSerializable {
  case `enabled` = "Enabled"
  case `suspended` = "Suspended"

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Bucketversioningstatus {
    switch body { 
    case .json(let json): return Bucketversioningstatus(rawValue: json as! String)!
    case .xml(let node): return Bucketversioningstatus(rawValue: node.stringValue!)!
    }
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}


public struct CORSConfiguration: AwswiftSerializable, AwswiftDeserializable {
/**

 */
  public let cORSRules: [CORSRule]

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["CORSRule"] = cORSRules
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> CORSConfiguration {
    guard case let .xml(node) = body else { fatalError() }
    return CORSConfiguration(
        cORSRules: try! node.nodes(forXPath: "CORSRule").map { CORSRule.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - cORSRules: 
 */
  public init(cORSRules: [CORSRule]) {
self.cORSRules = cORSRules
  }
}

public struct CORSRule: AwswiftSerializable, AwswiftDeserializable {
/**
Specifies which headers are allowed in a pre-flight OPTIONS request.
 */
  public let allowedHeaders: [String]?
/**
Identifies HTTP methods that the domain/origin specified in the rule is allowed to execute.
 */
  public let allowedMethods: [String]
/**
One or more origins you want customers to be able to access the bucket from.
 */
  public let allowedOrigins: [String]
/**
One or more headers in the response that you want customers to be able to access from their applications (for example, from a JavaScript XMLHttpRequest object).
 */
  public let exposeHeaders: [String]?
/**
The time in seconds that your browser is to cache the preflight response for the specified resource.
 */
  public let maxAgeSeconds: Int?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if allowedHeaders != nil { body["AllowedHeader"] = allowedHeaders! }
    body["AllowedMethod"] = allowedMethods
    body["AllowedOrigin"] = allowedOrigins
    if exposeHeaders != nil { body["ExposeHeader"] = exposeHeaders! }
    if maxAgeSeconds != nil { body["MaxAgeSeconds"] = maxAgeSeconds! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> CORSRule {
    guard case let .xml(node) = body else { fatalError() }
    return CORSRule(
        allowedHeaders: try! node.nodes(forXPath: "AllowedHeader").map { String.deserialize(response: response, body: .xml($0)) },
      allowedMethods: try! node.nodes(forXPath: "AllowedMethod").map { String.deserialize(response: response, body: .xml($0)) },
      allowedOrigins: try! node.nodes(forXPath: "AllowedOrigin").map { String.deserialize(response: response, body: .xml($0)) },
      exposeHeaders: try! node.nodes(forXPath: "ExposeHeader").map { String.deserialize(response: response, body: .xml($0)) },
      maxAgeSeconds: try! node.nodes(forXPath: "MaxAgeSeconds").first.map { Int.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - allowedHeaders: Specifies which headers are allowed in a pre-flight OPTIONS request.
      - allowedMethods: Identifies HTTP methods that the domain/origin specified in the rule is allowed to execute.
      - allowedOrigins: One or more origins you want customers to be able to access the bucket from.
      - exposeHeaders: One or more headers in the response that you want customers to be able to access from their applications (for example, from a JavaScript XMLHttpRequest object).
      - maxAgeSeconds: The time in seconds that your browser is to cache the preflight response for the specified resource.
 */
  public init(allowedHeaders: [String]?, allowedMethods: [String], allowedOrigins: [String], exposeHeaders: [String]?, maxAgeSeconds: Int?) {
self.allowedHeaders = allowedHeaders
self.allowedMethods = allowedMethods
self.allowedOrigins = allowedOrigins
self.exposeHeaders = exposeHeaders
self.maxAgeSeconds = maxAgeSeconds
  }
}




public struct CloudFunctionConfiguration: AwswiftSerializable, AwswiftDeserializable {
/**

 */
  public let cloudFunction: String?
/**

 */
  public let event: Event?
/**

 */
  public let events: [Event]?
/**

 */
  public let id: String?
/**

 */
  public let invocationRole: String?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if cloudFunction != nil { body["CloudFunction"] = cloudFunction! }
    if event != nil { body["Event"] = event! }
    if events != nil { body["Event"] = events! }
    if id != nil { body["Id"] = id! }
    if invocationRole != nil { body["InvocationRole"] = invocationRole! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> CloudFunctionConfiguration {
    guard case let .xml(node) = body else { fatalError() }
    return CloudFunctionConfiguration(
        cloudFunction: try! node.nodes(forXPath: "CloudFunction").first.map { String.deserialize(response: response, body: .xml($0)) },
      event: try! node.nodes(forXPath: "Event").first.map { Event.deserialize(response: response, body: .xml($0)) },
      events: try! node.nodes(forXPath: "Event").map { Event.deserialize(response: response, body: .xml($0)) },
      id: try! node.nodes(forXPath: "Id").first.map { String.deserialize(response: response, body: .xml($0)) },
      invocationRole: try! node.nodes(forXPath: "InvocationRole").first.map { String.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - cloudFunction: 
      - event: 
      - events: 
      - id: 
      - invocationRole: 
 */
  public init(cloudFunction: String?, event: Event?, events: [Event]?, id: String?, invocationRole: String?) {
self.cloudFunction = cloudFunction
self.event = event
self.events = events
self.id = id
self.invocationRole = invocationRole
  }
}



public struct CommonPrefix: AwswiftSerializable, AwswiftDeserializable {
/**

 */
  public let prefix: String?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if prefix != nil { body["Prefix"] = prefix! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> CommonPrefix {
    guard case let .xml(node) = body else { fatalError() }
    return CommonPrefix(
        prefix: try! node.nodes(forXPath: "Prefix").first.map { String.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - prefix: 
 */
  public init(prefix: String?) {
self.prefix = prefix
  }
}


public struct CompleteMultipartUploadOutput: AwswiftDeserializable {
/**

 */
  public let bucket: String?
/**
Entity tag of the object.
 */
  public let eTag: String?
/**
If the object expiration is configured, this will contain the expiration date (expiry-date) and rule ID (rule-id). The value of rule-id is URL encoded.
 */
  public let expiration: String?
/**

 */
  public let key: String?
/**

 */
  public let location: String?
/**

 */
  public let requestCharged: Requestcharged?
/**
If present, specifies the ID of the AWS Key Management Service (KMS) master encryption key that was used for the object.
 */
  public let sSEKMSKeyId: String?
/**
The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).
 */
  public let serverSideEncryption: Serversideencryption?
/**
Version of the object.
 */
  public let versionId: String?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> CompleteMultipartUploadOutput {
    guard case let .xml(node) = body else { fatalError() }
    return CompleteMultipartUploadOutput(
        bucket: try! node.nodes(forXPath: "Bucket").first.map { String.deserialize(response: response, body: .xml($0)) },
      eTag: try! node.nodes(forXPath: "ETag").first.map { String.deserialize(response: response, body: .xml($0)) },
      expiration: response.allHeaderFields["x-amz-expiration"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      key: try! node.nodes(forXPath: "Key").first.map { String.deserialize(response: response, body: .xml($0)) },
      location: try! node.nodes(forXPath: "Location").first.map { String.deserialize(response: response, body: .xml($0)) },
      requestCharged: response.allHeaderFields["x-amz-request-charged"].flatMap { ($0 is NSNull) ? nil : Requestcharged.deserialize(response: response, body: .json($0)) },
      sSEKMSKeyId: response.allHeaderFields["x-amz-server-side-encryption-aws-kms-key-id"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      serverSideEncryption: response.allHeaderFields["x-amz-server-side-encryption"].flatMap { ($0 is NSNull) ? nil : Serversideencryption.deserialize(response: response, body: .json($0)) },
      versionId: response.allHeaderFields["x-amz-version-id"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - bucket: 
      - eTag: Entity tag of the object.
      - expiration: If the object expiration is configured, this will contain the expiration date (expiry-date) and rule ID (rule-id). The value of rule-id is URL encoded.
      - key: 
      - location: 
      - requestCharged: 
      - sSEKMSKeyId: If present, specifies the ID of the AWS Key Management Service (KMS) master encryption key that was used for the object.
      - serverSideEncryption: The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).
      - versionId: Version of the object.
 */
  public init(bucket: String?, eTag: String?, expiration: String?, key: String?, location: String?, requestCharged: Requestcharged?, sSEKMSKeyId: String?, serverSideEncryption: Serversideencryption?, versionId: String?) {
self.bucket = bucket
self.eTag = eTag
self.expiration = expiration
self.key = key
self.location = location
self.requestCharged = requestCharged
self.sSEKMSKeyId = sSEKMSKeyId
self.serverSideEncryption = serverSideEncryption
self.versionId = versionId
  }
}

public struct CompleteMultipartUploadRequest: AwswiftSerializable {
/**

 */
  public let bucket: String
/**

 */
  public let key: String
/**

 */
  public let multipartUpload: CompletedMultipartUpload?
/**

 */
  public let requestPayer: Requestpayer?
/**

 */
  public let uploadId: String

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    var querystring: [String: String] = [:]
    var header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    uri["Bucket"] = "\(bucket)"
    uri["Key"] = "\(key)"
    querystring["uploadId"] = "\(uploadId)"
    if requestPayer != nil { header["x-amz-request-payer"] = "\(requestPayer!)" }
    if multipartUpload != nil { body["CompleteMultipartUpload"] = multipartUpload! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - bucket: 
      - key: 
      - multipartUpload: 
      - requestPayer: 
      - uploadId: 
 */
  public init(bucket: String, key: String, multipartUpload: CompletedMultipartUpload?, requestPayer: Requestpayer?, uploadId: String) {
self.bucket = bucket
self.key = key
self.multipartUpload = multipartUpload
self.requestPayer = requestPayer
self.uploadId = uploadId
  }
}

public struct CompletedMultipartUpload: AwswiftSerializable, AwswiftDeserializable {
/**

 */
  public let parts: [CompletedPart]?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if parts != nil { body["Part"] = parts! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> CompletedMultipartUpload {
    guard case let .xml(node) = body else { fatalError() }
    return CompletedMultipartUpload(
        parts: try! node.nodes(forXPath: "Part").map { CompletedPart.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - parts: 
 */
  public init(parts: [CompletedPart]?) {
self.parts = parts
  }
}

public struct CompletedPart: AwswiftSerializable, AwswiftDeserializable {
/**
Entity tag returned when the part was uploaded.
 */
  public let eTag: String?
/**
Part number that identifies the part. This is a positive integer between 1 and 10,000.
 */
  public let partNumber: Int?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if eTag != nil { body["ETag"] = eTag! }
    if partNumber != nil { body["PartNumber"] = partNumber! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> CompletedPart {
    guard case let .xml(node) = body else { fatalError() }
    return CompletedPart(
        eTag: try! node.nodes(forXPath: "ETag").first.map { String.deserialize(response: response, body: .xml($0)) },
      partNumber: try! node.nodes(forXPath: "PartNumber").first.map { Int.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - eTag: Entity tag returned when the part was uploaded.
      - partNumber: Part number that identifies the part. This is a positive integer between 1 and 10,000.
 */
  public init(eTag: String?, partNumber: Int?) {
self.eTag = eTag
self.partNumber = partNumber
  }
}


public struct Condition: AwswiftSerializable, AwswiftDeserializable {
/**
The HTTP error code when the redirect is applied. In the event of an error, if the error code equals this value, then the specified redirect is applied. Required when parent element Condition is specified and sibling KeyPrefixEquals is not specified. If both are specified, then both must be true for the redirect to be applied.
 */
  public let httpErrorCodeReturnedEquals: String?
/**
The object key name prefix when the redirect is applied. For example, to redirect requests for ExamplePage.html, the key prefix will be ExamplePage.html. To redirect request for all pages with the prefix docs/, the key prefix will be /docs, which identifies all objects in the docs/ folder. Required when the parent element Condition is specified and sibling HttpErrorCodeReturnedEquals is not specified. If both conditions are specified, both must be true for the redirect to be applied.
 */
  public let keyPrefixEquals: String?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if httpErrorCodeReturnedEquals != nil { body["HttpErrorCodeReturnedEquals"] = httpErrorCodeReturnedEquals! }
    if keyPrefixEquals != nil { body["KeyPrefixEquals"] = keyPrefixEquals! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Condition {
    guard case let .xml(node) = body else { fatalError() }
    return Condition(
        httpErrorCodeReturnedEquals: try! node.nodes(forXPath: "HttpErrorCodeReturnedEquals").first.map { String.deserialize(response: response, body: .xml($0)) },
      keyPrefixEquals: try! node.nodes(forXPath: "KeyPrefixEquals").first.map { String.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - httpErrorCodeReturnedEquals: The HTTP error code when the redirect is applied. In the event of an error, if the error code equals this value, then the specified redirect is applied. Required when parent element Condition is specified and sibling KeyPrefixEquals is not specified. If both are specified, then both must be true for the redirect to be applied.
      - keyPrefixEquals: The object key name prefix when the redirect is applied. For example, to redirect requests for ExamplePage.html, the key prefix will be ExamplePage.html. To redirect request for all pages with the prefix docs/, the key prefix will be /docs, which identifies all objects in the docs/ folder. Required when the parent element Condition is specified and sibling HttpErrorCodeReturnedEquals is not specified. If both conditions are specified, both must be true for the redirect to be applied.
 */
  public init(httpErrorCodeReturnedEquals: String?, keyPrefixEquals: String?) {
self.httpErrorCodeReturnedEquals = httpErrorCodeReturnedEquals
self.keyPrefixEquals = keyPrefixEquals
  }
}








public struct CopyObjectOutput: AwswiftDeserializable {
/**

 */
  public let copyObjectResult: CopyObjectResult?
/**

 */
  public let copySourceVersionId: String?
/**
If the object expiration is configured, the response includes this header.
 */
  public let expiration: String?
/**

 */
  public let requestCharged: Requestcharged?
/**
If server-side encryption with a customer-provided encryption key was requested, the response will include this header confirming the encryption algorithm used.
 */
  public let sSECustomerAlgorithm: String?
/**
If server-side encryption with a customer-provided encryption key was requested, the response will include this header to provide round trip message integrity verification of the customer-provided encryption key.
 */
  public let sSECustomerKeyMD5: String?
/**
If present, specifies the ID of the AWS Key Management Service (KMS) master encryption key that was used for the object.
 */
  public let sSEKMSKeyId: String?
/**
The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).
 */
  public let serverSideEncryption: Serversideencryption?
/**
Version ID of the newly created copy.
 */
  public let versionId: String?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> CopyObjectOutput {
    guard case let .xml(node) = body else { fatalError() }
    return CopyObjectOutput(
        copyObjectResult: try! node.nodes(forXPath: "CopyObjectResult").first.map { CopyObjectResult.deserialize(response: response, body: .xml($0)) },
      copySourceVersionId: response.allHeaderFields["x-amz-copy-source-version-id"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      expiration: response.allHeaderFields["x-amz-expiration"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      requestCharged: response.allHeaderFields["x-amz-request-charged"].flatMap { ($0 is NSNull) ? nil : Requestcharged.deserialize(response: response, body: .json($0)) },
      sSECustomerAlgorithm: response.allHeaderFields["x-amz-server-side-encryption-customer-algorithm"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      sSECustomerKeyMD5: response.allHeaderFields["x-amz-server-side-encryption-customer-key-MD5"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      sSEKMSKeyId: response.allHeaderFields["x-amz-server-side-encryption-aws-kms-key-id"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      serverSideEncryption: response.allHeaderFields["x-amz-server-side-encryption"].flatMap { ($0 is NSNull) ? nil : Serversideencryption.deserialize(response: response, body: .json($0)) },
      versionId: response.allHeaderFields["x-amz-version-id"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - copyObjectResult: 
      - copySourceVersionId: 
      - expiration: If the object expiration is configured, the response includes this header.
      - requestCharged: 
      - sSECustomerAlgorithm: If server-side encryption with a customer-provided encryption key was requested, the response will include this header confirming the encryption algorithm used.
      - sSECustomerKeyMD5: If server-side encryption with a customer-provided encryption key was requested, the response will include this header to provide round trip message integrity verification of the customer-provided encryption key.
      - sSEKMSKeyId: If present, specifies the ID of the AWS Key Management Service (KMS) master encryption key that was used for the object.
      - serverSideEncryption: The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).
      - versionId: Version ID of the newly created copy.
 */
  public init(copyObjectResult: CopyObjectResult?, copySourceVersionId: String?, expiration: String?, requestCharged: Requestcharged?, sSECustomerAlgorithm: String?, sSECustomerKeyMD5: String?, sSEKMSKeyId: String?, serverSideEncryption: Serversideencryption?, versionId: String?) {
self.copyObjectResult = copyObjectResult
self.copySourceVersionId = copySourceVersionId
self.expiration = expiration
self.requestCharged = requestCharged
self.sSECustomerAlgorithm = sSECustomerAlgorithm
self.sSECustomerKeyMD5 = sSECustomerKeyMD5
self.sSEKMSKeyId = sSEKMSKeyId
self.serverSideEncryption = serverSideEncryption
self.versionId = versionId
  }
}

public struct CopyObjectRequest: AwswiftSerializable {
/**
The canned ACL to apply to the object.
 */
  public let aCL: Objectcannedacl?
/**

 */
  public let bucket: String
/**
Specifies caching behavior along the request/reply chain.
 */
  public let cacheControl: String?
/**
Specifies presentational information for the object.
 */
  public let contentDisposition: String?
/**
Specifies what content encodings have been applied to the object and thus what decoding mechanisms must be applied to obtain the media-type referenced by the Content-Type header field.
 */
  public let contentEncoding: String?
/**
The language the content is in.
 */
  public let contentLanguage: String?
/**
A standard MIME type describing the format of the object data.
 */
  public let contentType: String?
/**
The name of the source bucket and key name of the source object, separated by a slash (/). Must be URL-encoded.
 */
  public let copySource: String
/**
Copies the object if its entity tag (ETag) matches the specified tag.
 */
  public let copySourceIfMatch: String?
/**
Copies the object if it has been modified since the specified time.
 */
  public let copySourceIfModifiedSince: Date?
/**
Copies the object if its entity tag (ETag) is different than the specified ETag.
 */
  public let copySourceIfNoneMatch: String?
/**
Copies the object if it hasn't been modified since the specified time.
 */
  public let copySourceIfUnmodifiedSince: Date?
/**
Specifies the algorithm to use when decrypting the source object (e.g., AES256).
 */
  public let copySourceSSECustomerAlgorithm: String?
/**
Specifies the customer-provided encryption key for Amazon S3 to use to decrypt the source object. The encryption key provided in this header must be one that was used when the source object was created.
 */
  public let copySourceSSECustomerKey: String?
/**
Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure the encryption key was transmitted without error.
 */
  public let copySourceSSECustomerKeyMD5: String?
/**
The date and time at which the object is no longer cacheable.
 */
  public let expires: Date?
/**
Gives the grantee READ, READ_ACP, and WRITE_ACP permissions on the object.
 */
  public let grantFullControl: String?
/**
Allows grantee to read the object data and its metadata.
 */
  public let grantRead: String?
/**
Allows grantee to read the object ACL.
 */
  public let grantReadACP: String?
/**
Allows grantee to write the ACL for the applicable object.
 */
  public let grantWriteACP: String?
/**

 */
  public let key: String
/**
A map of metadata to store with the object in S3.
 */
  public let metadata: [String: String]?
/**
Specifies whether the metadata is copied from the source object or replaced with metadata provided in the request.
 */
  public let metadataDirective: Metadatadirective?
/**

 */
  public let requestPayer: Requestpayer?
/**
Specifies the algorithm to use to when encrypting the object (e.g., AES256).
 */
  public let sSECustomerAlgorithm: String?
/**
Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data. This value is used to store the object and then it is discarded; Amazon does not store the encryption key. The key must be appropriate for use with the algorithm specified in the x-amz-server-side​-encryption​-customer-algorithm header.
 */
  public let sSECustomerKey: String?
/**
Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure the encryption key was transmitted without error.
 */
  public let sSECustomerKeyMD5: String?
/**
Specifies the AWS KMS key ID to use for object encryption. All GET and PUT requests for an object protected by AWS KMS will fail if not made via SSL or using SigV4. Documentation on configuring any of the officially supported AWS SDKs and CLI can be found at http://docs.aws.amazon.com/AmazonS3/latest/dev/UsingAWSSDK.html#specify-signature-version
 */
  public let sSEKMSKeyId: String?
/**
The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).
 */
  public let serverSideEncryption: Serversideencryption?
/**
The type of storage to use for the object. Defaults to 'STANDARD'.
 */
  public let storageClass: Storageclass?
/**
If the bucket is configured as a website, redirects requests for this object to another object in the same bucket or to an external URL. Amazon S3 stores the value of this header in the object metadata.
 */
  public let websiteRedirectLocation: String?

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    var header: [String: String] = [:]
    
  
    uri["Bucket"] = "\(bucket)"
    uri["Key"] = "\(key)"
    if aCL != nil { header["x-amz-acl"] = "\(aCL!)" }
    if cacheControl != nil { header["Cache-Control"] = "\(cacheControl!)" }
    if contentDisposition != nil { header["Content-Disposition"] = "\(contentDisposition!)" }
    if contentEncoding != nil { header["Content-Encoding"] = "\(contentEncoding!)" }
    if contentLanguage != nil { header["Content-Language"] = "\(contentLanguage!)" }
    if contentType != nil { header["Content-Type"] = "\(contentType!)" }
    header["x-amz-copy-source"] = "\(copySource)"
    if copySourceIfMatch != nil { header["x-amz-copy-source-if-match"] = "\(copySourceIfMatch!)" }
    if copySourceIfModifiedSince != nil { header["x-amz-copy-source-if-modified-since"] = "\(copySourceIfModifiedSince!)" }
    if copySourceIfNoneMatch != nil { header["x-amz-copy-source-if-none-match"] = "\(copySourceIfNoneMatch!)" }
    if copySourceIfUnmodifiedSince != nil { header["x-amz-copy-source-if-unmodified-since"] = "\(copySourceIfUnmodifiedSince!)" }
    if copySourceSSECustomerAlgorithm != nil { header["x-amz-copy-source-server-side-encryption-customer-algorithm"] = "\(copySourceSSECustomerAlgorithm!)" }
    if copySourceSSECustomerKey != nil { header["x-amz-copy-source-server-side-encryption-customer-key"] = "\(copySourceSSECustomerKey!)" }
    if copySourceSSECustomerKeyMD5 != nil { header["x-amz-copy-source-server-side-encryption-customer-key-MD5"] = "\(copySourceSSECustomerKeyMD5!)" }
    if expires != nil { header["Expires"] = "\(expires!)" }
    if grantFullControl != nil { header["x-amz-grant-full-control"] = "\(grantFullControl!)" }
    if grantRead != nil { header["x-amz-grant-read"] = "\(grantRead!)" }
    if grantReadACP != nil { header["x-amz-grant-read-acp"] = "\(grantReadACP!)" }
    if grantWriteACP != nil { header["x-amz-grant-write-acp"] = "\(grantWriteACP!)" }
    if metadataDirective != nil { header["x-amz-metadata-directive"] = "\(metadataDirective!)" }
    if requestPayer != nil { header["x-amz-request-payer"] = "\(requestPayer!)" }
    if sSECustomerAlgorithm != nil { header["x-amz-server-side-encryption-customer-algorithm"] = "\(sSECustomerAlgorithm!)" }
    if sSECustomerKey != nil { header["x-amz-server-side-encryption-customer-key"] = "\(sSECustomerKey!)" }
    if sSECustomerKeyMD5 != nil { header["x-amz-server-side-encryption-customer-key-MD5"] = "\(sSECustomerKeyMD5!)" }
    if sSEKMSKeyId != nil { header["x-amz-server-side-encryption-aws-kms-key-id"] = "\(sSEKMSKeyId!)" }
    if serverSideEncryption != nil { header["x-amz-server-side-encryption"] = "\(serverSideEncryption!)" }
    if storageClass != nil { header["x-amz-storage-class"] = "\(storageClass!)" }
    if websiteRedirectLocation != nil { header["x-amz-website-redirect-location"] = "\(websiteRedirectLocation!)" }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - aCL: The canned ACL to apply to the object.
      - bucket: 
      - cacheControl: Specifies caching behavior along the request/reply chain.
      - contentDisposition: Specifies presentational information for the object.
      - contentEncoding: Specifies what content encodings have been applied to the object and thus what decoding mechanisms must be applied to obtain the media-type referenced by the Content-Type header field.
      - contentLanguage: The language the content is in.
      - contentType: A standard MIME type describing the format of the object data.
      - copySource: The name of the source bucket and key name of the source object, separated by a slash (/). Must be URL-encoded.
      - copySourceIfMatch: Copies the object if its entity tag (ETag) matches the specified tag.
      - copySourceIfModifiedSince: Copies the object if it has been modified since the specified time.
      - copySourceIfNoneMatch: Copies the object if its entity tag (ETag) is different than the specified ETag.
      - copySourceIfUnmodifiedSince: Copies the object if it hasn't been modified since the specified time.
      - copySourceSSECustomerAlgorithm: Specifies the algorithm to use when decrypting the source object (e.g., AES256).
      - copySourceSSECustomerKey: Specifies the customer-provided encryption key for Amazon S3 to use to decrypt the source object. The encryption key provided in this header must be one that was used when the source object was created.
      - copySourceSSECustomerKeyMD5: Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure the encryption key was transmitted without error.
      - expires: The date and time at which the object is no longer cacheable.
      - grantFullControl: Gives the grantee READ, READ_ACP, and WRITE_ACP permissions on the object.
      - grantRead: Allows grantee to read the object data and its metadata.
      - grantReadACP: Allows grantee to read the object ACL.
      - grantWriteACP: Allows grantee to write the ACL for the applicable object.
      - key: 
      - metadata: A map of metadata to store with the object in S3.
      - metadataDirective: Specifies whether the metadata is copied from the source object or replaced with metadata provided in the request.
      - requestPayer: 
      - sSECustomerAlgorithm: Specifies the algorithm to use to when encrypting the object (e.g., AES256).
      - sSECustomerKey: Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data. This value is used to store the object and then it is discarded; Amazon does not store the encryption key. The key must be appropriate for use with the algorithm specified in the x-amz-server-side​-encryption​-customer-algorithm header.
      - sSECustomerKeyMD5: Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure the encryption key was transmitted without error.
      - sSEKMSKeyId: Specifies the AWS KMS key ID to use for object encryption. All GET and PUT requests for an object protected by AWS KMS will fail if not made via SSL or using SigV4. Documentation on configuring any of the officially supported AWS SDKs and CLI can be found at http://docs.aws.amazon.com/AmazonS3/latest/dev/UsingAWSSDK.html#specify-signature-version
      - serverSideEncryption: The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).
      - storageClass: The type of storage to use for the object. Defaults to 'STANDARD'.
      - websiteRedirectLocation: If the bucket is configured as a website, redirects requests for this object to another object in the same bucket or to an external URL. Amazon S3 stores the value of this header in the object metadata.
 */
  public init(aCL: Objectcannedacl?, bucket: String, cacheControl: String?, contentDisposition: String?, contentEncoding: String?, contentLanguage: String?, contentType: String?, copySource: String, copySourceIfMatch: String?, copySourceIfModifiedSince: Date?, copySourceIfNoneMatch: String?, copySourceIfUnmodifiedSince: Date?, copySourceSSECustomerAlgorithm: String?, copySourceSSECustomerKey: String?, copySourceSSECustomerKeyMD5: String?, expires: Date?, grantFullControl: String?, grantRead: String?, grantReadACP: String?, grantWriteACP: String?, key: String, metadata: [String: String]?, metadataDirective: Metadatadirective?, requestPayer: Requestpayer?, sSECustomerAlgorithm: String?, sSECustomerKey: String?, sSECustomerKeyMD5: String?, sSEKMSKeyId: String?, serverSideEncryption: Serversideencryption?, storageClass: Storageclass?, websiteRedirectLocation: String?) {
self.aCL = aCL
self.bucket = bucket
self.cacheControl = cacheControl
self.contentDisposition = contentDisposition
self.contentEncoding = contentEncoding
self.contentLanguage = contentLanguage
self.contentType = contentType
self.copySource = copySource
self.copySourceIfMatch = copySourceIfMatch
self.copySourceIfModifiedSince = copySourceIfModifiedSince
self.copySourceIfNoneMatch = copySourceIfNoneMatch
self.copySourceIfUnmodifiedSince = copySourceIfUnmodifiedSince
self.copySourceSSECustomerAlgorithm = copySourceSSECustomerAlgorithm
self.copySourceSSECustomerKey = copySourceSSECustomerKey
self.copySourceSSECustomerKeyMD5 = copySourceSSECustomerKeyMD5
self.expires = expires
self.grantFullControl = grantFullControl
self.grantRead = grantRead
self.grantReadACP = grantReadACP
self.grantWriteACP = grantWriteACP
self.key = key
self.metadata = metadata
self.metadataDirective = metadataDirective
self.requestPayer = requestPayer
self.sSECustomerAlgorithm = sSECustomerAlgorithm
self.sSECustomerKey = sSECustomerKey
self.sSECustomerKeyMD5 = sSECustomerKeyMD5
self.sSEKMSKeyId = sSEKMSKeyId
self.serverSideEncryption = serverSideEncryption
self.storageClass = storageClass
self.websiteRedirectLocation = websiteRedirectLocation
  }
}

public struct CopyObjectResult: AwswiftSerializable, AwswiftDeserializable {
/**

 */
  public let eTag: String?
/**

 */
  public let lastModified: Date?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if eTag != nil { body["ETag"] = eTag! }
    if lastModified != nil { body["LastModified"] = lastModified! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> CopyObjectResult {
    guard case let .xml(node) = body else { fatalError() }
    return CopyObjectResult(
        eTag: try! node.nodes(forXPath: "ETag").first.map { String.deserialize(response: response, body: .xml($0)) },
      lastModified: try! node.nodes(forXPath: "LastModified").first.map { Date.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - eTag: 
      - lastModified: 
 */
  public init(eTag: String?, lastModified: Date?) {
self.eTag = eTag
self.lastModified = lastModified
  }
}

public struct CopyPartResult: AwswiftSerializable, AwswiftDeserializable {
/**
Entity tag of the object.
 */
  public let eTag: String?
/**
Date and time at which the object was uploaded.
 */
  public let lastModified: Date?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if eTag != nil { body["ETag"] = eTag! }
    if lastModified != nil { body["LastModified"] = lastModified! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> CopyPartResult {
    guard case let .xml(node) = body else { fatalError() }
    return CopyPartResult(
        eTag: try! node.nodes(forXPath: "ETag").first.map { String.deserialize(response: response, body: .xml($0)) },
      lastModified: try! node.nodes(forXPath: "LastModified").first.map { Date.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - eTag: Entity tag of the object.
      - lastModified: Date and time at which the object was uploaded.
 */
  public init(eTag: String?, lastModified: Date?) {
self.eTag = eTag
self.lastModified = lastModified
  }
}











public struct CreateBucketConfiguration: AwswiftSerializable, AwswiftDeserializable {
/**
Specifies the region where the bucket will be created. If you don't specify a region, the bucket will be created in US Standard.
 */
  public let locationConstraint: Bucketlocationconstraint?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if locationConstraint != nil { body["LocationConstraint"] = locationConstraint! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> CreateBucketConfiguration {
    guard case let .xml(node) = body else { fatalError() }
    return CreateBucketConfiguration(
        locationConstraint: try! node.nodes(forXPath: "LocationConstraint").first.map { Bucketlocationconstraint.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - locationConstraint: Specifies the region where the bucket will be created. If you don't specify a region, the bucket will be created in US Standard.
 */
  public init(locationConstraint: Bucketlocationconstraint?) {
self.locationConstraint = locationConstraint
  }
}

public struct CreateBucketOutput: AwswiftDeserializable {
/**

 */
  public let location: String?


  static func deserializableBody(data: Data) -> DeserializableBody {
    fatalError()
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> CreateBucketOutput {
  
    return CreateBucketOutput(
        location: response.allHeaderFields["Location"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - location: 
 */
  public init(location: String?) {
self.location = location
  }
}

public struct CreateBucketRequest: AwswiftSerializable {
/**
The canned ACL to apply to the bucket.
 */
  public let aCL: Bucketcannedacl?
/**

 */
  public let bucket: String
/**

 */
  public let createBucketConfiguration: CreateBucketConfiguration?
/**
Allows grantee the read, write, read ACP, and write ACP permissions on the bucket.
 */
  public let grantFullControl: String?
/**
Allows grantee to list the objects in the bucket.
 */
  public let grantRead: String?
/**
Allows grantee to read the bucket ACL.
 */
  public let grantReadACP: String?
/**
Allows grantee to create, overwrite, and delete any object in the bucket.
 */
  public let grantWrite: String?
/**
Allows grantee to write the ACL for the applicable bucket.
 */
  public let grantWriteACP: String?

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    var header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    uri["Bucket"] = "\(bucket)"
    if aCL != nil { header["x-amz-acl"] = "\(aCL!)" }
    if grantFullControl != nil { header["x-amz-grant-full-control"] = "\(grantFullControl!)" }
    if grantRead != nil { header["x-amz-grant-read"] = "\(grantRead!)" }
    if grantReadACP != nil { header["x-amz-grant-read-acp"] = "\(grantReadACP!)" }
    if grantWrite != nil { header["x-amz-grant-write"] = "\(grantWrite!)" }
    if grantWriteACP != nil { header["x-amz-grant-write-acp"] = "\(grantWriteACP!)" }
    if createBucketConfiguration != nil { body["CreateBucketConfiguration"] = createBucketConfiguration! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - aCL: The canned ACL to apply to the bucket.
      - bucket: 
      - createBucketConfiguration: 
      - grantFullControl: Allows grantee the read, write, read ACP, and write ACP permissions on the bucket.
      - grantRead: Allows grantee to list the objects in the bucket.
      - grantReadACP: Allows grantee to read the bucket ACL.
      - grantWrite: Allows grantee to create, overwrite, and delete any object in the bucket.
      - grantWriteACP: Allows grantee to write the ACL for the applicable bucket.
 */
  public init(aCL: Bucketcannedacl?, bucket: String, createBucketConfiguration: CreateBucketConfiguration?, grantFullControl: String?, grantRead: String?, grantReadACP: String?, grantWrite: String?, grantWriteACP: String?) {
self.aCL = aCL
self.bucket = bucket
self.createBucketConfiguration = createBucketConfiguration
self.grantFullControl = grantFullControl
self.grantRead = grantRead
self.grantReadACP = grantReadACP
self.grantWrite = grantWrite
self.grantWriteACP = grantWriteACP
  }
}

public struct CreateMultipartUploadOutput: AwswiftDeserializable {
/**
Date when multipart upload will become eligible for abort operation by lifecycle.
 */
  public let abortDate: Date?
/**
Id of the lifecycle rule that makes a multipart upload eligible for abort operation.
 */
  public let abortRuleId: String?
/**
Name of the bucket to which the multipart upload was initiated.
 */
  public let bucket: String?
/**
Object key for which the multipart upload was initiated.
 */
  public let key: String?
/**

 */
  public let requestCharged: Requestcharged?
/**
If server-side encryption with a customer-provided encryption key was requested, the response will include this header confirming the encryption algorithm used.
 */
  public let sSECustomerAlgorithm: String?
/**
If server-side encryption with a customer-provided encryption key was requested, the response will include this header to provide round trip message integrity verification of the customer-provided encryption key.
 */
  public let sSECustomerKeyMD5: String?
/**
If present, specifies the ID of the AWS Key Management Service (KMS) master encryption key that was used for the object.
 */
  public let sSEKMSKeyId: String?
/**
The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).
 */
  public let serverSideEncryption: Serversideencryption?
/**
ID for the initiated multipart upload.
 */
  public let uploadId: String?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> CreateMultipartUploadOutput {
    guard case let .xml(node) = body else { fatalError() }
    return CreateMultipartUploadOutput(
        abortDate: response.allHeaderFields["x-amz-abort-date"].flatMap { ($0 is NSNull) ? nil : Date.deserialize(response: response, body: .json($0)) },
      abortRuleId: response.allHeaderFields["x-amz-abort-rule-id"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      bucket: try! node.nodes(forXPath: "Bucket").first.map { String.deserialize(response: response, body: .xml($0)) },
      key: try! node.nodes(forXPath: "Key").first.map { String.deserialize(response: response, body: .xml($0)) },
      requestCharged: response.allHeaderFields["x-amz-request-charged"].flatMap { ($0 is NSNull) ? nil : Requestcharged.deserialize(response: response, body: .json($0)) },
      sSECustomerAlgorithm: response.allHeaderFields["x-amz-server-side-encryption-customer-algorithm"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      sSECustomerKeyMD5: response.allHeaderFields["x-amz-server-side-encryption-customer-key-MD5"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      sSEKMSKeyId: response.allHeaderFields["x-amz-server-side-encryption-aws-kms-key-id"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      serverSideEncryption: response.allHeaderFields["x-amz-server-side-encryption"].flatMap { ($0 is NSNull) ? nil : Serversideencryption.deserialize(response: response, body: .json($0)) },
      uploadId: try! node.nodes(forXPath: "UploadId").first.map { String.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - abortDate: Date when multipart upload will become eligible for abort operation by lifecycle.
      - abortRuleId: Id of the lifecycle rule that makes a multipart upload eligible for abort operation.
      - bucket: Name of the bucket to which the multipart upload was initiated.
      - key: Object key for which the multipart upload was initiated.
      - requestCharged: 
      - sSECustomerAlgorithm: If server-side encryption with a customer-provided encryption key was requested, the response will include this header confirming the encryption algorithm used.
      - sSECustomerKeyMD5: If server-side encryption with a customer-provided encryption key was requested, the response will include this header to provide round trip message integrity verification of the customer-provided encryption key.
      - sSEKMSKeyId: If present, specifies the ID of the AWS Key Management Service (KMS) master encryption key that was used for the object.
      - serverSideEncryption: The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).
      - uploadId: ID for the initiated multipart upload.
 */
  public init(abortDate: Date?, abortRuleId: String?, bucket: String?, key: String?, requestCharged: Requestcharged?, sSECustomerAlgorithm: String?, sSECustomerKeyMD5: String?, sSEKMSKeyId: String?, serverSideEncryption: Serversideencryption?, uploadId: String?) {
self.abortDate = abortDate
self.abortRuleId = abortRuleId
self.bucket = bucket
self.key = key
self.requestCharged = requestCharged
self.sSECustomerAlgorithm = sSECustomerAlgorithm
self.sSECustomerKeyMD5 = sSECustomerKeyMD5
self.sSEKMSKeyId = sSEKMSKeyId
self.serverSideEncryption = serverSideEncryption
self.uploadId = uploadId
  }
}

public struct CreateMultipartUploadRequest: AwswiftSerializable {
/**
The canned ACL to apply to the object.
 */
  public let aCL: Objectcannedacl?
/**

 */
  public let bucket: String
/**
Specifies caching behavior along the request/reply chain.
 */
  public let cacheControl: String?
/**
Specifies presentational information for the object.
 */
  public let contentDisposition: String?
/**
Specifies what content encodings have been applied to the object and thus what decoding mechanisms must be applied to obtain the media-type referenced by the Content-Type header field.
 */
  public let contentEncoding: String?
/**
The language the content is in.
 */
  public let contentLanguage: String?
/**
A standard MIME type describing the format of the object data.
 */
  public let contentType: String?
/**
The date and time at which the object is no longer cacheable.
 */
  public let expires: Date?
/**
Gives the grantee READ, READ_ACP, and WRITE_ACP permissions on the object.
 */
  public let grantFullControl: String?
/**
Allows grantee to read the object data and its metadata.
 */
  public let grantRead: String?
/**
Allows grantee to read the object ACL.
 */
  public let grantReadACP: String?
/**
Allows grantee to write the ACL for the applicable object.
 */
  public let grantWriteACP: String?
/**

 */
  public let key: String
/**
A map of metadata to store with the object in S3.
 */
  public let metadata: [String: String]?
/**

 */
  public let requestPayer: Requestpayer?
/**
Specifies the algorithm to use to when encrypting the object (e.g., AES256).
 */
  public let sSECustomerAlgorithm: String?
/**
Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data. This value is used to store the object and then it is discarded; Amazon does not store the encryption key. The key must be appropriate for use with the algorithm specified in the x-amz-server-side​-encryption​-customer-algorithm header.
 */
  public let sSECustomerKey: String?
/**
Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure the encryption key was transmitted without error.
 */
  public let sSECustomerKeyMD5: String?
/**
Specifies the AWS KMS key ID to use for object encryption. All GET and PUT requests for an object protected by AWS KMS will fail if not made via SSL or using SigV4. Documentation on configuring any of the officially supported AWS SDKs and CLI can be found at http://docs.aws.amazon.com/AmazonS3/latest/dev/UsingAWSSDK.html#specify-signature-version
 */
  public let sSEKMSKeyId: String?
/**
The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).
 */
  public let serverSideEncryption: Serversideencryption?
/**
The type of storage to use for the object. Defaults to 'STANDARD'.
 */
  public let storageClass: Storageclass?
/**
If the bucket is configured as a website, redirects requests for this object to another object in the same bucket or to an external URL. Amazon S3 stores the value of this header in the object metadata.
 */
  public let websiteRedirectLocation: String?

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    var header: [String: String] = [:]
    
  
    uri["Bucket"] = "\(bucket)"
    uri["Key"] = "\(key)"
    if aCL != nil { header["x-amz-acl"] = "\(aCL!)" }
    if cacheControl != nil { header["Cache-Control"] = "\(cacheControl!)" }
    if contentDisposition != nil { header["Content-Disposition"] = "\(contentDisposition!)" }
    if contentEncoding != nil { header["Content-Encoding"] = "\(contentEncoding!)" }
    if contentLanguage != nil { header["Content-Language"] = "\(contentLanguage!)" }
    if contentType != nil { header["Content-Type"] = "\(contentType!)" }
    if expires != nil { header["Expires"] = "\(expires!)" }
    if grantFullControl != nil { header["x-amz-grant-full-control"] = "\(grantFullControl!)" }
    if grantRead != nil { header["x-amz-grant-read"] = "\(grantRead!)" }
    if grantReadACP != nil { header["x-amz-grant-read-acp"] = "\(grantReadACP!)" }
    if grantWriteACP != nil { header["x-amz-grant-write-acp"] = "\(grantWriteACP!)" }
    if requestPayer != nil { header["x-amz-request-payer"] = "\(requestPayer!)" }
    if sSECustomerAlgorithm != nil { header["x-amz-server-side-encryption-customer-algorithm"] = "\(sSECustomerAlgorithm!)" }
    if sSECustomerKey != nil { header["x-amz-server-side-encryption-customer-key"] = "\(sSECustomerKey!)" }
    if sSECustomerKeyMD5 != nil { header["x-amz-server-side-encryption-customer-key-MD5"] = "\(sSECustomerKeyMD5!)" }
    if sSEKMSKeyId != nil { header["x-amz-server-side-encryption-aws-kms-key-id"] = "\(sSEKMSKeyId!)" }
    if serverSideEncryption != nil { header["x-amz-server-side-encryption"] = "\(serverSideEncryption!)" }
    if storageClass != nil { header["x-amz-storage-class"] = "\(storageClass!)" }
    if websiteRedirectLocation != nil { header["x-amz-website-redirect-location"] = "\(websiteRedirectLocation!)" }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - aCL: The canned ACL to apply to the object.
      - bucket: 
      - cacheControl: Specifies caching behavior along the request/reply chain.
      - contentDisposition: Specifies presentational information for the object.
      - contentEncoding: Specifies what content encodings have been applied to the object and thus what decoding mechanisms must be applied to obtain the media-type referenced by the Content-Type header field.
      - contentLanguage: The language the content is in.
      - contentType: A standard MIME type describing the format of the object data.
      - expires: The date and time at which the object is no longer cacheable.
      - grantFullControl: Gives the grantee READ, READ_ACP, and WRITE_ACP permissions on the object.
      - grantRead: Allows grantee to read the object data and its metadata.
      - grantReadACP: Allows grantee to read the object ACL.
      - grantWriteACP: Allows grantee to write the ACL for the applicable object.
      - key: 
      - metadata: A map of metadata to store with the object in S3.
      - requestPayer: 
      - sSECustomerAlgorithm: Specifies the algorithm to use to when encrypting the object (e.g., AES256).
      - sSECustomerKey: Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data. This value is used to store the object and then it is discarded; Amazon does not store the encryption key. The key must be appropriate for use with the algorithm specified in the x-amz-server-side​-encryption​-customer-algorithm header.
      - sSECustomerKeyMD5: Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure the encryption key was transmitted without error.
      - sSEKMSKeyId: Specifies the AWS KMS key ID to use for object encryption. All GET and PUT requests for an object protected by AWS KMS will fail if not made via SSL or using SigV4. Documentation on configuring any of the officially supported AWS SDKs and CLI can be found at http://docs.aws.amazon.com/AmazonS3/latest/dev/UsingAWSSDK.html#specify-signature-version
      - serverSideEncryption: The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).
      - storageClass: The type of storage to use for the object. Defaults to 'STANDARD'.
      - websiteRedirectLocation: If the bucket is configured as a website, redirects requests for this object to another object in the same bucket or to an external URL. Amazon S3 stores the value of this header in the object metadata.
 */
  public init(aCL: Objectcannedacl?, bucket: String, cacheControl: String?, contentDisposition: String?, contentEncoding: String?, contentLanguage: String?, contentType: String?, expires: Date?, grantFullControl: String?, grantRead: String?, grantReadACP: String?, grantWriteACP: String?, key: String, metadata: [String: String]?, requestPayer: Requestpayer?, sSECustomerAlgorithm: String?, sSECustomerKey: String?, sSECustomerKeyMD5: String?, sSEKMSKeyId: String?, serverSideEncryption: Serversideencryption?, storageClass: Storageclass?, websiteRedirectLocation: String?) {
self.aCL = aCL
self.bucket = bucket
self.cacheControl = cacheControl
self.contentDisposition = contentDisposition
self.contentEncoding = contentEncoding
self.contentLanguage = contentLanguage
self.contentType = contentType
self.expires = expires
self.grantFullControl = grantFullControl
self.grantRead = grantRead
self.grantReadACP = grantReadACP
self.grantWriteACP = grantWriteACP
self.key = key
self.metadata = metadata
self.requestPayer = requestPayer
self.sSECustomerAlgorithm = sSECustomerAlgorithm
self.sSECustomerKey = sSECustomerKey
self.sSECustomerKeyMD5 = sSECustomerKeyMD5
self.sSEKMSKeyId = sSEKMSKeyId
self.serverSideEncryption = serverSideEncryption
self.storageClass = storageClass
self.websiteRedirectLocation = websiteRedirectLocation
  }
}





public struct Delete: AwswiftSerializable, AwswiftDeserializable {
/**

 */
  public let objects: [ObjectIdentifier]
/**
Element to enable quiet mode for the request. When you add this element, you must set its value to true.
 */
  public let quiet: Bool?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["Object"] = objects
    if quiet != nil { body["Quiet"] = quiet! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Delete {
    guard case let .xml(node) = body else { fatalError() }
    return Delete(
        objects: try! node.nodes(forXPath: "Object").map { ObjectIdentifier.deserialize(response: response, body: .xml($0)) },
      quiet: try! node.nodes(forXPath: "Quiet").first.map { Bool.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - objects: 
      - quiet: Element to enable quiet mode for the request. When you add this element, you must set its value to true.
 */
  public init(objects: [ObjectIdentifier], quiet: Bool?) {
self.objects = objects
self.quiet = quiet
  }
}

public struct DeleteBucketCorsRequest: AwswiftSerializable {
/**

 */
  public let bucket: String

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
    uri["Bucket"] = "\(bucket)"
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - bucket: 
 */
  public init(bucket: String) {
self.bucket = bucket
  }
}

public struct DeleteBucketLifecycleRequest: AwswiftSerializable {
/**

 */
  public let bucket: String

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
    uri["Bucket"] = "\(bucket)"
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - bucket: 
 */
  public init(bucket: String) {
self.bucket = bucket
  }
}

public struct DeleteBucketPolicyRequest: AwswiftSerializable {
/**

 */
  public let bucket: String

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
    uri["Bucket"] = "\(bucket)"
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - bucket: 
 */
  public init(bucket: String) {
self.bucket = bucket
  }
}

public struct DeleteBucketReplicationRequest: AwswiftSerializable {
/**

 */
  public let bucket: String

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
    uri["Bucket"] = "\(bucket)"
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - bucket: 
 */
  public init(bucket: String) {
self.bucket = bucket
  }
}

public struct DeleteBucketRequest: AwswiftSerializable {
/**

 */
  public let bucket: String

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
    uri["Bucket"] = "\(bucket)"
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - bucket: 
 */
  public init(bucket: String) {
self.bucket = bucket
  }
}

public struct DeleteBucketTaggingRequest: AwswiftSerializable {
/**

 */
  public let bucket: String

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
    uri["Bucket"] = "\(bucket)"
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - bucket: 
 */
  public init(bucket: String) {
self.bucket = bucket
  }
}

public struct DeleteBucketWebsiteRequest: AwswiftSerializable {
/**

 */
  public let bucket: String

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
    uri["Bucket"] = "\(bucket)"
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - bucket: 
 */
  public init(bucket: String) {
self.bucket = bucket
  }
}


public struct DeleteMarkerEntry: AwswiftSerializable, AwswiftDeserializable {
/**
Specifies whether the object is (true) or is not (false) the latest version of an object.
 */
  public let isLatest: Bool?
/**
The object key.
 */
  public let key: String?
/**
Date and time the object was last modified.
 */
  public let lastModified: Date?
/**

 */
  public let owner: Owner?
/**
Version ID of an object.
 */
  public let versionId: String?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if isLatest != nil { body["IsLatest"] = isLatest! }
    if key != nil { body["Key"] = key! }
    if lastModified != nil { body["LastModified"] = lastModified! }
    if owner != nil { body["Owner"] = owner! }
    if versionId != nil { body["VersionId"] = versionId! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> DeleteMarkerEntry {
    guard case let .xml(node) = body else { fatalError() }
    return DeleteMarkerEntry(
        isLatest: try! node.nodes(forXPath: "IsLatest").first.map { Bool.deserialize(response: response, body: .xml($0)) },
      key: try! node.nodes(forXPath: "Key").first.map { String.deserialize(response: response, body: .xml($0)) },
      lastModified: try! node.nodes(forXPath: "LastModified").first.map { Date.deserialize(response: response, body: .xml($0)) },
      owner: try! node.nodes(forXPath: "Owner").first.map { Owner.deserialize(response: response, body: .xml($0)) },
      versionId: try! node.nodes(forXPath: "VersionId").first.map { String.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - isLatest: Specifies whether the object is (true) or is not (false) the latest version of an object.
      - key: The object key.
      - lastModified: Date and time the object was last modified.
      - owner: 
      - versionId: Version ID of an object.
 */
  public init(isLatest: Bool?, key: String?, lastModified: Date?, owner: Owner?, versionId: String?) {
self.isLatest = isLatest
self.key = key
self.lastModified = lastModified
self.owner = owner
self.versionId = versionId
  }
}



public struct DeleteObjectOutput: AwswiftDeserializable {
/**
Specifies whether the versioned object that was permanently deleted was (true) or was not (false) a delete marker.
 */
  public let deleteMarker: Bool?
/**

 */
  public let requestCharged: Requestcharged?
/**
Returns the version ID of the delete marker created as a result of the DELETE operation.
 */
  public let versionId: String?


  static func deserializableBody(data: Data) -> DeserializableBody {
    fatalError()
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> DeleteObjectOutput {
  
    return DeleteObjectOutput(
        deleteMarker: response.allHeaderFields["x-amz-delete-marker"].flatMap { ($0 is NSNull) ? nil : Bool.deserialize(response: response, body: .json($0)) },
      requestCharged: response.allHeaderFields["x-amz-request-charged"].flatMap { ($0 is NSNull) ? nil : Requestcharged.deserialize(response: response, body: .json($0)) },
      versionId: response.allHeaderFields["x-amz-version-id"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - deleteMarker: Specifies whether the versioned object that was permanently deleted was (true) or was not (false) a delete marker.
      - requestCharged: 
      - versionId: Returns the version ID of the delete marker created as a result of the DELETE operation.
 */
  public init(deleteMarker: Bool?, requestCharged: Requestcharged?, versionId: String?) {
self.deleteMarker = deleteMarker
self.requestCharged = requestCharged
self.versionId = versionId
  }
}

public struct DeleteObjectRequest: AwswiftSerializable {
/**

 */
  public let bucket: String
/**

 */
  public let key: String
/**
The concatenation of the authentication device's serial number, a space, and the value that is displayed on your authentication device.
 */
  public let mFA: String?
/**

 */
  public let requestPayer: Requestpayer?
/**
VersionId used to reference a specific version of the object.
 */
  public let versionId: String?

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    var querystring: [String: String] = [:]
    var header: [String: String] = [:]
    
  
    uri["Bucket"] = "\(bucket)"
    uri["Key"] = "\(key)"
    if versionId != nil { querystring["versionId"] = "\(versionId!)" }
    if mFA != nil { header["x-amz-mfa"] = "\(mFA!)" }
    if requestPayer != nil { header["x-amz-request-payer"] = "\(requestPayer!)" }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - bucket: 
      - key: 
      - mFA: The concatenation of the authentication device's serial number, a space, and the value that is displayed on your authentication device.
      - requestPayer: 
      - versionId: VersionId used to reference a specific version of the object.
 */
  public init(bucket: String, key: String, mFA: String?, requestPayer: Requestpayer?, versionId: String?) {
self.bucket = bucket
self.key = key
self.mFA = mFA
self.requestPayer = requestPayer
self.versionId = versionId
  }
}

public struct DeleteObjectsOutput: AwswiftDeserializable {
/**

 */
  public let deleted: [DeletedObject]?
/**

 */
  public let errors: [S3Error]?
/**

 */
  public let requestCharged: Requestcharged?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> DeleteObjectsOutput {
    guard case let .xml(node) = body else { fatalError() }
    return DeleteObjectsOutput(
        deleted: try! node.nodes(forXPath: "Deleted").map { DeletedObject.deserialize(response: response, body: .xml($0)) },
      errors: try! node.nodes(forXPath: "Error").map { S3Error.deserialize(response: response, body: .xml($0)) },
      requestCharged: response.allHeaderFields["x-amz-request-charged"].flatMap { ($0 is NSNull) ? nil : Requestcharged.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - deleted: 
      - errors: 
      - requestCharged: 
 */
  public init(deleted: [DeletedObject]?, errors: [S3Error]?, requestCharged: Requestcharged?) {
self.deleted = deleted
self.errors = errors
self.requestCharged = requestCharged
  }
}

public struct DeleteObjectsRequest: AwswiftSerializable {
/**

 */
  public let bucket: String
/**

 */
  public let delete: Delete
/**
The concatenation of the authentication device's serial number, a space, and the value that is displayed on your authentication device.
 */
  public let mFA: String?
/**

 */
  public let requestPayer: Requestpayer?

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    var header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    uri["Bucket"] = "\(bucket)"
    if mFA != nil { header["x-amz-mfa"] = "\(mFA!)" }
    if requestPayer != nil { header["x-amz-request-payer"] = "\(requestPayer!)" }
    body["Delete"] = delete
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - bucket: 
      - delete: 
      - mFA: The concatenation of the authentication device's serial number, a space, and the value that is displayed on your authentication device.
      - requestPayer: 
 */
  public init(bucket: String, delete: Delete, mFA: String?, requestPayer: Requestpayer?) {
self.bucket = bucket
self.delete = delete
self.mFA = mFA
self.requestPayer = requestPayer
  }
}

public struct DeletedObject: AwswiftSerializable, AwswiftDeserializable {
/**

 */
  public let deleteMarker: Bool?
/**

 */
  public let deleteMarkerVersionId: String?
/**

 */
  public let key: String?
/**

 */
  public let versionId: String?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if deleteMarker != nil { body["DeleteMarker"] = deleteMarker! }
    if deleteMarkerVersionId != nil { body["DeleteMarkerVersionId"] = deleteMarkerVersionId! }
    if key != nil { body["Key"] = key! }
    if versionId != nil { body["VersionId"] = versionId! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> DeletedObject {
    guard case let .xml(node) = body else { fatalError() }
    return DeletedObject(
        deleteMarker: try! node.nodes(forXPath: "DeleteMarker").first.map { Bool.deserialize(response: response, body: .xml($0)) },
      deleteMarkerVersionId: try! node.nodes(forXPath: "DeleteMarkerVersionId").first.map { String.deserialize(response: response, body: .xml($0)) },
      key: try! node.nodes(forXPath: "Key").first.map { String.deserialize(response: response, body: .xml($0)) },
      versionId: try! node.nodes(forXPath: "VersionId").first.map { String.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - deleteMarker: 
      - deleteMarkerVersionId: 
      - key: 
      - versionId: 
 */
  public init(deleteMarker: Bool?, deleteMarkerVersionId: String?, key: String?, versionId: String?) {
self.deleteMarker = deleteMarker
self.deleteMarkerVersionId = deleteMarkerVersionId
self.key = key
self.versionId = versionId
  }
}



public struct Destination: AwswiftSerializable, AwswiftDeserializable {
/**
Amazon resource name (ARN) of the bucket where you want Amazon S3 to store replicas of the object identified by the rule.
 */
  public let bucket: String
/**
The class of storage used to store the object.
 */
  public let storageClass: Storageclass?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["Bucket"] = bucket
    if storageClass != nil { body["StorageClass"] = storageClass! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Destination {
    guard case let .xml(node) = body else { fatalError() }
    return Destination(
        bucket: try! node.nodes(forXPath: "Bucket").first.map { String.deserialize(response: response, body: .xml($0)) }!,
      storageClass: try! node.nodes(forXPath: "StorageClass").first.map { Storageclass.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - bucket: Amazon resource name (ARN) of the bucket where you want Amazon S3 to store replicas of the object identified by the rule.
      - storageClass: The class of storage used to store the object.
 */
  public init(bucket: String, storageClass: Storageclass?) {
self.bucket = bucket
self.storageClass = storageClass
  }
}




/**
Requests Amazon S3 to encode the object keys in the response and specifies the encoding method to use. An object key may contain any Unicode character; however, XML 1.0 parser cannot parse some characters, such as characters with an ASCII value from 0 to 10. For characters that are not supported in XML 1.0, you can add this parameter to request that Amazon S3 encode the keys in the response.
 */
enum Encodingtype: String, AwswiftDeserializable, AwswiftSerializable {
  case `url` = "url"

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Encodingtype {
    switch body { 
    case .json(let json): return Encodingtype(rawValue: json as! String)!
    case .xml(let node): return Encodingtype(rawValue: node.stringValue!)!
    }
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}

public struct S3Error: AwswiftSerializable, AwswiftDeserializable {
/**

 */
  public let code: String?
/**

 */
  public let key: String?
/**

 */
  public let message: String?
/**

 */
  public let versionId: String?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if code != nil { body["Code"] = code! }
    if key != nil { body["Key"] = key! }
    if message != nil { body["Message"] = message! }
    if versionId != nil { body["VersionId"] = versionId! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> S3Error {
    guard case let .xml(node) = body else { fatalError() }
    return S3Error(
        code: try! node.nodes(forXPath: "Code").first.map { String.deserialize(response: response, body: .xml($0)) },
      key: try! node.nodes(forXPath: "Key").first.map { String.deserialize(response: response, body: .xml($0)) },
      message: try! node.nodes(forXPath: "Message").first.map { String.deserialize(response: response, body: .xml($0)) },
      versionId: try! node.nodes(forXPath: "VersionId").first.map { String.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - code: 
      - key: 
      - message: 
      - versionId: 
 */
  public init(code: String?, key: String?, message: String?, versionId: String?) {
self.code = code
self.key = key
self.message = message
self.versionId = versionId
  }
}

public struct ErrorDocument: AwswiftSerializable, AwswiftDeserializable {
/**
The object key name to use when a 4XX class error occurs.
 */
  public let key: String

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["Key"] = key
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> ErrorDocument {
    guard case let .xml(node) = body else { fatalError() }
    return ErrorDocument(
        key: try! node.nodes(forXPath: "Key").first.map { String.deserialize(response: response, body: .xml($0)) }!
    )
  }

/**
    - parameters:
      - key: The object key name to use when a 4XX class error occurs.
 */
  public init(key: String) {
self.key = key
  }
}


/**
Bucket event for which to send notifications.
 */
enum Event: String, AwswiftDeserializable, AwswiftSerializable {
  case `s3ReducedRedundancyLostObject` = "s3:ReducedRedundancyLostObject"
  case `s3ObjectCreated` = "s3:ObjectCreated:*"
  case `s3ObjectCreatedPut` = "s3:ObjectCreated:Put"
  case `s3ObjectCreatedPost` = "s3:ObjectCreated:Post"
  case `s3ObjectCreatedCopy` = "s3:ObjectCreated:Copy"
  case `s3ObjectCreatedCompleteMultipartUpload` = "s3:ObjectCreated:CompleteMultipartUpload"
  case `s3ObjectRemoved` = "s3:ObjectRemoved:*"
  case `s3ObjectRemovedDelete` = "s3:ObjectRemoved:Delete"
  case `s3ObjectRemovedDeleteMarkerCreated` = "s3:ObjectRemoved:DeleteMarkerCreated"

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Event {
    switch body { 
    case .json(let json): return Event(rawValue: json as! String)!
    case .xml(let node): return Event(rawValue: node.stringValue!)!
    }
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}



enum Expirationstatus: String, AwswiftDeserializable, AwswiftSerializable {
  case `enabled` = "Enabled"
  case `disabled` = "Disabled"

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Expirationstatus {
    switch body { 
    case .json(let json): return Expirationstatus(rawValue: json as! String)!
    case .xml(let node): return Expirationstatus(rawValue: node.stringValue!)!
    }
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}






/**
Container for key value pair that defines the criteria for the filter rule.
 */
public struct FilterRule: AwswiftSerializable, AwswiftDeserializable {
/**
Object key name prefix or suffix identifying one or more objects to which the filtering rule applies. Maximum prefix length can be up to 1,024 characters. Overlapping prefixes and suffixes are not supported. For more information, go to <a href="http://docs.aws.amazon.com/AmazonS3/latest/dev/NotificationHowTo.html">Configuring Event Notifications</a> in the Amazon Simple Storage Service Developer Guide.
 */
  public let name: Filterrulename?
/**

 */
  public let value: String?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if name != nil { body["Name"] = name! }
    if value != nil { body["Value"] = value! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> FilterRule {
    guard case let .xml(node) = body else { fatalError() }
    return FilterRule(
        name: try! node.nodes(forXPath: "Name").first.map { Filterrulename.deserialize(response: response, body: .xml($0)) },
      value: try! node.nodes(forXPath: "Value").first.map { String.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - name: Object key name prefix or suffix identifying one or more objects to which the filtering rule applies. Maximum prefix length can be up to 1,024 characters. Overlapping prefixes and suffixes are not supported. For more information, go to <a href="http://docs.aws.amazon.com/AmazonS3/latest/dev/NotificationHowTo.html">Configuring Event Notifications</a> in the Amazon Simple Storage Service Developer Guide.
      - value: 
 */
  public init(name: Filterrulename?, value: String?) {
self.name = name
self.value = value
  }
}

/**
A list of containers for key value pair that defines the criteria for the filter rule.
 */

enum Filterrulename: String, AwswiftDeserializable, AwswiftSerializable {
  case `prefix` = "prefix"
  case `suffix` = "suffix"

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Filterrulename {
    switch body { 
    case .json(let json): return Filterrulename(rawValue: json as! String)!
    case .xml(let node): return Filterrulename(rawValue: node.stringValue!)!
    }
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}


public struct GetBucketAccelerateConfigurationOutput: AwswiftDeserializable {
/**
The accelerate configuration of the bucket.
 */
  public let status: Bucketacceleratestatus?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> GetBucketAccelerateConfigurationOutput {
    guard case let .xml(node) = body else { fatalError() }
    return GetBucketAccelerateConfigurationOutput(
        status: try! node.nodes(forXPath: "Status").first.map { Bucketacceleratestatus.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - status: The accelerate configuration of the bucket.
 */
  public init(status: Bucketacceleratestatus?) {
self.status = status
  }
}

public struct GetBucketAccelerateConfigurationRequest: AwswiftSerializable {
/**
Name of the bucket for which the accelerate configuration is retrieved.
 */
  public let bucket: String

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
    uri["Bucket"] = "\(bucket)"
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - bucket: Name of the bucket for which the accelerate configuration is retrieved.
 */
  public init(bucket: String) {
self.bucket = bucket
  }
}

public struct GetBucketAclOutput: AwswiftDeserializable {
/**
A list of grants.
 */
  public let grants: [Grant]?
/**

 */
  public let owner: Owner?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> GetBucketAclOutput {
    guard case let .xml(node) = body else { fatalError() }
    return GetBucketAclOutput(
        grants: try! node.nodes(forXPath: "AccessControlList").map { Grant.deserialize(response: response, body: .xml($0)) },
      owner: try! node.nodes(forXPath: "Owner").first.map { Owner.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - grants: A list of grants.
      - owner: 
 */
  public init(grants: [Grant]?, owner: Owner?) {
self.grants = grants
self.owner = owner
  }
}

public struct GetBucketAclRequest: AwswiftSerializable {
/**

 */
  public let bucket: String

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
    uri["Bucket"] = "\(bucket)"
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - bucket: 
 */
  public init(bucket: String) {
self.bucket = bucket
  }
}

public struct GetBucketCorsOutput: AwswiftDeserializable {
/**

 */
  public let cORSRules: [CORSRule]?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> GetBucketCorsOutput {
    guard case let .xml(node) = body else { fatalError() }
    return GetBucketCorsOutput(
        cORSRules: try! node.nodes(forXPath: "CORSRule").map { CORSRule.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - cORSRules: 
 */
  public init(cORSRules: [CORSRule]?) {
self.cORSRules = cORSRules
  }
}

public struct GetBucketCorsRequest: AwswiftSerializable {
/**

 */
  public let bucket: String

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
    uri["Bucket"] = "\(bucket)"
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - bucket: 
 */
  public init(bucket: String) {
self.bucket = bucket
  }
}

public struct GetBucketLifecycleConfigurationOutput: AwswiftDeserializable {
/**

 */
  public let rules: [LifecycleRule]?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> GetBucketLifecycleConfigurationOutput {
    guard case let .xml(node) = body else { fatalError() }
    return GetBucketLifecycleConfigurationOutput(
        rules: try! node.nodes(forXPath: "Rule").map { LifecycleRule.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - rules: 
 */
  public init(rules: [LifecycleRule]?) {
self.rules = rules
  }
}

public struct GetBucketLifecycleConfigurationRequest: AwswiftSerializable {
/**

 */
  public let bucket: String

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
    uri["Bucket"] = "\(bucket)"
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - bucket: 
 */
  public init(bucket: String) {
self.bucket = bucket
  }
}

public struct GetBucketLifecycleOutput: AwswiftDeserializable {
/**

 */
  public let rules: [Rule]?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> GetBucketLifecycleOutput {
    guard case let .xml(node) = body else { fatalError() }
    return GetBucketLifecycleOutput(
        rules: try! node.nodes(forXPath: "Rule").map { Rule.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - rules: 
 */
  public init(rules: [Rule]?) {
self.rules = rules
  }
}

public struct GetBucketLifecycleRequest: AwswiftSerializable {
/**

 */
  public let bucket: String

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
    uri["Bucket"] = "\(bucket)"
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - bucket: 
 */
  public init(bucket: String) {
self.bucket = bucket
  }
}

public struct GetBucketLocationOutput: AwswiftDeserializable {
/**

 */
  public let locationConstraint: Bucketlocationconstraint?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> GetBucketLocationOutput {
    guard case let .xml(node) = body else { fatalError() }
    return GetBucketLocationOutput(
        locationConstraint: try! node.nodes(forXPath: "LocationConstraint").first.map { Bucketlocationconstraint.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - locationConstraint: 
 */
  public init(locationConstraint: Bucketlocationconstraint?) {
self.locationConstraint = locationConstraint
  }
}

public struct GetBucketLocationRequest: AwswiftSerializable {
/**

 */
  public let bucket: String

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
    uri["Bucket"] = "\(bucket)"
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - bucket: 
 */
  public init(bucket: String) {
self.bucket = bucket
  }
}

public struct GetBucketLoggingOutput: AwswiftDeserializable {
/**

 */
  public let loggingEnabled: LoggingEnabled?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> GetBucketLoggingOutput {
    guard case let .xml(node) = body else { fatalError() }
    return GetBucketLoggingOutput(
        loggingEnabled: try! node.nodes(forXPath: "LoggingEnabled").first.map { LoggingEnabled.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - loggingEnabled: 
 */
  public init(loggingEnabled: LoggingEnabled?) {
self.loggingEnabled = loggingEnabled
  }
}

public struct GetBucketLoggingRequest: AwswiftSerializable {
/**

 */
  public let bucket: String

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
    uri["Bucket"] = "\(bucket)"
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - bucket: 
 */
  public init(bucket: String) {
self.bucket = bucket
  }
}

public struct GetBucketNotificationConfigurationRequest: AwswiftSerializable {
/**
Name of the bucket to get the notification configuration for.
 */
  public let bucket: String

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
    uri["Bucket"] = "\(bucket)"
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - bucket: Name of the bucket to get the notification configuration for.
 */
  public init(bucket: String) {
self.bucket = bucket
  }
}

public struct GetBucketPolicyOutput: AwswiftDeserializable {
/**
The bucket policy as a JSON document.
 */
  public let policy: String?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> GetBucketPolicyOutput {
    guard case let .xml(node) = body else { fatalError() }
    return GetBucketPolicyOutput(
        policy: try! node.nodes(forXPath: "Policy").first.map { String.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - policy: The bucket policy as a JSON document.
 */
  public init(policy: String?) {
self.policy = policy
  }
}

public struct GetBucketPolicyRequest: AwswiftSerializable {
/**

 */
  public let bucket: String

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
    uri["Bucket"] = "\(bucket)"
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - bucket: 
 */
  public init(bucket: String) {
self.bucket = bucket
  }
}

public struct GetBucketReplicationOutput: AwswiftDeserializable {
/**

 */
  public let replicationConfiguration: ReplicationConfiguration?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> GetBucketReplicationOutput {
    guard case let .xml(node) = body else { fatalError() }
    return GetBucketReplicationOutput(
        replicationConfiguration: try! node.nodes(forXPath: "ReplicationConfiguration").first.map { ReplicationConfiguration.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - replicationConfiguration: 
 */
  public init(replicationConfiguration: ReplicationConfiguration?) {
self.replicationConfiguration = replicationConfiguration
  }
}

public struct GetBucketReplicationRequest: AwswiftSerializable {
/**

 */
  public let bucket: String

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
    uri["Bucket"] = "\(bucket)"
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - bucket: 
 */
  public init(bucket: String) {
self.bucket = bucket
  }
}

public struct GetBucketRequestPaymentOutput: AwswiftDeserializable {
/**
Specifies who pays for the download and request fees.
 */
  public let payer: Payer?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> GetBucketRequestPaymentOutput {
    guard case let .xml(node) = body else { fatalError() }
    return GetBucketRequestPaymentOutput(
        payer: try! node.nodes(forXPath: "Payer").first.map { Payer.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - payer: Specifies who pays for the download and request fees.
 */
  public init(payer: Payer?) {
self.payer = payer
  }
}

public struct GetBucketRequestPaymentRequest: AwswiftSerializable {
/**

 */
  public let bucket: String

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
    uri["Bucket"] = "\(bucket)"
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - bucket: 
 */
  public init(bucket: String) {
self.bucket = bucket
  }
}

public struct GetBucketTaggingOutput: AwswiftDeserializable {
/**

 */
  public let tagSet: [Tag]


  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> GetBucketTaggingOutput {
    guard case let .xml(node) = body else { fatalError() }
    return GetBucketTaggingOutput(
        tagSet: try! node.nodes(forXPath: "TagSet").map { Tag.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - tagSet: 
 */
  public init(tagSet: [Tag]) {
self.tagSet = tagSet
  }
}

public struct GetBucketTaggingRequest: AwswiftSerializable {
/**

 */
  public let bucket: String

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
    uri["Bucket"] = "\(bucket)"
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - bucket: 
 */
  public init(bucket: String) {
self.bucket = bucket
  }
}

public struct GetBucketVersioningOutput: AwswiftDeserializable {
/**
Specifies whether MFA delete is enabled in the bucket versioning configuration. This element is only returned if the bucket has been configured with MFA delete. If the bucket has never been so configured, this element is not returned.
 */
  public let mFADelete: Mfadeletestatus?
/**
The versioning state of the bucket.
 */
  public let status: Bucketversioningstatus?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> GetBucketVersioningOutput {
    guard case let .xml(node) = body else { fatalError() }
    return GetBucketVersioningOutput(
        mFADelete: try! node.nodes(forXPath: "MfaDelete").first.map { Mfadeletestatus.deserialize(response: response, body: .xml($0)) },
      status: try! node.nodes(forXPath: "Status").first.map { Bucketversioningstatus.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - mFADelete: Specifies whether MFA delete is enabled in the bucket versioning configuration. This element is only returned if the bucket has been configured with MFA delete. If the bucket has never been so configured, this element is not returned.
      - status: The versioning state of the bucket.
 */
  public init(mFADelete: Mfadeletestatus?, status: Bucketversioningstatus?) {
self.mFADelete = mFADelete
self.status = status
  }
}

public struct GetBucketVersioningRequest: AwswiftSerializable {
/**

 */
  public let bucket: String

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
    uri["Bucket"] = "\(bucket)"
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - bucket: 
 */
  public init(bucket: String) {
self.bucket = bucket
  }
}

public struct GetBucketWebsiteOutput: AwswiftDeserializable {
/**

 */
  public let errorDocument: ErrorDocument?
/**

 */
  public let indexDocument: IndexDocument?
/**

 */
  public let redirectAllRequestsTo: RedirectAllRequestsTo?
/**

 */
  public let routingRules: [RoutingRule]?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> GetBucketWebsiteOutput {
    guard case let .xml(node) = body else { fatalError() }
    return GetBucketWebsiteOutput(
        errorDocument: try! node.nodes(forXPath: "ErrorDocument").first.map { ErrorDocument.deserialize(response: response, body: .xml($0)) },
      indexDocument: try! node.nodes(forXPath: "IndexDocument").first.map { IndexDocument.deserialize(response: response, body: .xml($0)) },
      redirectAllRequestsTo: try! node.nodes(forXPath: "RedirectAllRequestsTo").first.map { RedirectAllRequestsTo.deserialize(response: response, body: .xml($0)) },
      routingRules: try! node.nodes(forXPath: "RoutingRules").map { RoutingRule.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - errorDocument: 
      - indexDocument: 
      - redirectAllRequestsTo: 
      - routingRules: 
 */
  public init(errorDocument: ErrorDocument?, indexDocument: IndexDocument?, redirectAllRequestsTo: RedirectAllRequestsTo?, routingRules: [RoutingRule]?) {
self.errorDocument = errorDocument
self.indexDocument = indexDocument
self.redirectAllRequestsTo = redirectAllRequestsTo
self.routingRules = routingRules
  }
}

public struct GetBucketWebsiteRequest: AwswiftSerializable {
/**

 */
  public let bucket: String

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
    uri["Bucket"] = "\(bucket)"
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - bucket: 
 */
  public init(bucket: String) {
self.bucket = bucket
  }
}

public struct GetObjectAclOutput: AwswiftDeserializable {
/**
A list of grants.
 */
  public let grants: [Grant]?
/**

 */
  public let owner: Owner?
/**

 */
  public let requestCharged: Requestcharged?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> GetObjectAclOutput {
    guard case let .xml(node) = body else { fatalError() }
    return GetObjectAclOutput(
        grants: try! node.nodes(forXPath: "AccessControlList").map { Grant.deserialize(response: response, body: .xml($0)) },
      owner: try! node.nodes(forXPath: "Owner").first.map { Owner.deserialize(response: response, body: .xml($0)) },
      requestCharged: response.allHeaderFields["x-amz-request-charged"].flatMap { ($0 is NSNull) ? nil : Requestcharged.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - grants: A list of grants.
      - owner: 
      - requestCharged: 
 */
  public init(grants: [Grant]?, owner: Owner?, requestCharged: Requestcharged?) {
self.grants = grants
self.owner = owner
self.requestCharged = requestCharged
  }
}

public struct GetObjectAclRequest: AwswiftSerializable {
/**

 */
  public let bucket: String
/**

 */
  public let key: String
/**

 */
  public let requestPayer: Requestpayer?
/**
VersionId used to reference a specific version of the object.
 */
  public let versionId: String?

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    var querystring: [String: String] = [:]
    var header: [String: String] = [:]
    
  
    uri["Bucket"] = "\(bucket)"
    uri["Key"] = "\(key)"
    if versionId != nil { querystring["versionId"] = "\(versionId!)" }
    if requestPayer != nil { header["x-amz-request-payer"] = "\(requestPayer!)" }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - bucket: 
      - key: 
      - requestPayer: 
      - versionId: VersionId used to reference a specific version of the object.
 */
  public init(bucket: String, key: String, requestPayer: Requestpayer?, versionId: String?) {
self.bucket = bucket
self.key = key
self.requestPayer = requestPayer
self.versionId = versionId
  }
}

public struct GetObjectOutput: AwswiftDeserializable {
/**

 */
  public let acceptRanges: String?
/**
Object data.
 */
  public let s3Body: Data?
/**
Specifies caching behavior along the request/reply chain.
 */
  public let cacheControl: String?
/**
Specifies presentational information for the object.
 */
  public let contentDisposition: String?
/**
Specifies what content encodings have been applied to the object and thus what decoding mechanisms must be applied to obtain the media-type referenced by the Content-Type header field.
 */
  public let contentEncoding: String?
/**
The language the content is in.
 */
  public let contentLanguage: String?
/**
Size of the body in bytes.
 */
  public let contentLength: Int?
/**
The portion of the object returned in the response.
 */
  public let contentRange: String?
/**
A standard MIME type describing the format of the object data.
 */
  public let contentType: String?
/**
Specifies whether the object retrieved was (true) or was not (false) a Delete Marker. If false, this response header does not appear in the response.
 */
  public let deleteMarker: Bool?
/**
An ETag is an opaque identifier assigned by a web server to a specific version of a resource found at a URL
 */
  public let eTag: String?
/**
If the object expiration is configured (see PUT Bucket lifecycle), the response includes this header. It includes the expiry-date and rule-id key value pairs providing object expiration information. The value of the rule-id is URL encoded.
 */
  public let expiration: String?
/**
The date and time at which the object is no longer cacheable.
 */
  public let expires: Date?
/**
Last modified date of the object
 */
  public let lastModified: Date?
/**
A map of metadata to store with the object in S3.
 */
  public let metadata: [String: String]?
/**
This is set to the number of metadata entries not returned in x-amz-meta headers. This can happen if you create metadata using an API like SOAP that supports more flexible metadata than the REST API. For example, using SOAP, you can create metadata whose values are not legal HTTP headers.
 */
  public let missingMeta: Int?
/**
The count of parts this object has.
 */
  public let partsCount: Int?
/**

 */
  public let replicationStatus: Replicationstatus?
/**

 */
  public let requestCharged: Requestcharged?
/**
Provides information about object restoration operation and expiration time of the restored object copy.
 */
  public let restore: String?
/**
If server-side encryption with a customer-provided encryption key was requested, the response will include this header confirming the encryption algorithm used.
 */
  public let sSECustomerAlgorithm: String?
/**
If server-side encryption with a customer-provided encryption key was requested, the response will include this header to provide round trip message integrity verification of the customer-provided encryption key.
 */
  public let sSECustomerKeyMD5: String?
/**
If present, specifies the ID of the AWS Key Management Service (KMS) master encryption key that was used for the object.
 */
  public let sSEKMSKeyId: String?
/**
The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).
 */
  public let serverSideEncryption: Serversideencryption?
/**

 */
  public let storageClass: Storageclass?
/**
Version of the object.
 */
  public let versionId: String?
/**
If the bucket is configured as a website, redirects requests for this object to another object in the same bucket or to an external URL. Amazon S3 stores the value of this header in the object metadata.
 */
  public let websiteRedirectLocation: String?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> GetObjectOutput {
    guard case let .xml(node) = body else { fatalError() }
    return GetObjectOutput(
        acceptRanges: response.allHeaderFields["accept-ranges"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      s3Body: try! node.nodes(forXPath: "Body").first.map { Data.deserialize(response: response, body: .xml($0)) },
      cacheControl: response.allHeaderFields["Cache-Control"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      contentDisposition: response.allHeaderFields["Content-Disposition"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      contentEncoding: response.allHeaderFields["Content-Encoding"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      contentLanguage: response.allHeaderFields["Content-Language"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      contentLength: response.allHeaderFields["Content-Length"].flatMap { ($0 is NSNull) ? nil : Int.deserialize(response: response, body: .json($0)) },
      contentRange: response.allHeaderFields["Content-Range"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      contentType: response.allHeaderFields["Content-Type"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      deleteMarker: response.allHeaderFields["x-amz-delete-marker"].flatMap { ($0 is NSNull) ? nil : Bool.deserialize(response: response, body: .json($0)) },
      eTag: response.allHeaderFields["ETag"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      expiration: response.allHeaderFields["x-amz-expiration"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      expires: response.allHeaderFields["Expires"].flatMap { ($0 is NSNull) ? nil : Date.deserialize(response: response, body: .json($0)) },
      lastModified: response.allHeaderFields["Last-Modified"].flatMap { ($0 is NSNull) ? nil : Date.deserialize(response: response, body: .json($0)) },
      metadata: Dictionary(response.allHeaderFields.map { (key: $0 as! String, value: $1 as! String) }.filter { $0.key.lowercased().hasPrefix("x-amz-meta-") }),
      missingMeta: response.allHeaderFields["x-amz-missing-meta"].flatMap { ($0 is NSNull) ? nil : Int.deserialize(response: response, body: .json($0)) },
      partsCount: response.allHeaderFields["x-amz-mp-parts-count"].flatMap { ($0 is NSNull) ? nil : Int.deserialize(response: response, body: .json($0)) },
      replicationStatus: response.allHeaderFields["x-amz-replication-status"].flatMap { ($0 is NSNull) ? nil : Replicationstatus.deserialize(response: response, body: .json($0)) },
      requestCharged: response.allHeaderFields["x-amz-request-charged"].flatMap { ($0 is NSNull) ? nil : Requestcharged.deserialize(response: response, body: .json($0)) },
      restore: response.allHeaderFields["x-amz-restore"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      sSECustomerAlgorithm: response.allHeaderFields["x-amz-server-side-encryption-customer-algorithm"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      sSECustomerKeyMD5: response.allHeaderFields["x-amz-server-side-encryption-customer-key-MD5"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      sSEKMSKeyId: response.allHeaderFields["x-amz-server-side-encryption-aws-kms-key-id"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      serverSideEncryption: response.allHeaderFields["x-amz-server-side-encryption"].flatMap { ($0 is NSNull) ? nil : Serversideencryption.deserialize(response: response, body: .json($0)) },
      storageClass: response.allHeaderFields["x-amz-storage-class"].flatMap { ($0 is NSNull) ? nil : Storageclass.deserialize(response: response, body: .json($0)) },
      versionId: response.allHeaderFields["x-amz-version-id"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      websiteRedirectLocation: response.allHeaderFields["x-amz-website-redirect-location"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - acceptRanges: 
      - s3Body: Object data.
      - cacheControl: Specifies caching behavior along the request/reply chain.
      - contentDisposition: Specifies presentational information for the object.
      - contentEncoding: Specifies what content encodings have been applied to the object and thus what decoding mechanisms must be applied to obtain the media-type referenced by the Content-Type header field.
      - contentLanguage: The language the content is in.
      - contentLength: Size of the body in bytes.
      - contentRange: The portion of the object returned in the response.
      - contentType: A standard MIME type describing the format of the object data.
      - deleteMarker: Specifies whether the object retrieved was (true) or was not (false) a Delete Marker. If false, this response header does not appear in the response.
      - eTag: An ETag is an opaque identifier assigned by a web server to a specific version of a resource found at a URL
      - expiration: If the object expiration is configured (see PUT Bucket lifecycle), the response includes this header. It includes the expiry-date and rule-id key value pairs providing object expiration information. The value of the rule-id is URL encoded.
      - expires: The date and time at which the object is no longer cacheable.
      - lastModified: Last modified date of the object
      - metadata: A map of metadata to store with the object in S3.
      - missingMeta: This is set to the number of metadata entries not returned in x-amz-meta headers. This can happen if you create metadata using an API like SOAP that supports more flexible metadata than the REST API. For example, using SOAP, you can create metadata whose values are not legal HTTP headers.
      - partsCount: The count of parts this object has.
      - replicationStatus: 
      - requestCharged: 
      - restore: Provides information about object restoration operation and expiration time of the restored object copy.
      - sSECustomerAlgorithm: If server-side encryption with a customer-provided encryption key was requested, the response will include this header confirming the encryption algorithm used.
      - sSECustomerKeyMD5: If server-side encryption with a customer-provided encryption key was requested, the response will include this header to provide round trip message integrity verification of the customer-provided encryption key.
      - sSEKMSKeyId: If present, specifies the ID of the AWS Key Management Service (KMS) master encryption key that was used for the object.
      - serverSideEncryption: The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).
      - storageClass: 
      - versionId: Version of the object.
      - websiteRedirectLocation: If the bucket is configured as a website, redirects requests for this object to another object in the same bucket or to an external URL. Amazon S3 stores the value of this header in the object metadata.
 */
  public init(acceptRanges: String?, s3Body: Data?, cacheControl: String?, contentDisposition: String?, contentEncoding: String?, contentLanguage: String?, contentLength: Int?, contentRange: String?, contentType: String?, deleteMarker: Bool?, eTag: String?, expiration: String?, expires: Date?, lastModified: Date?, metadata: [String: String]?, missingMeta: Int?, partsCount: Int?, replicationStatus: Replicationstatus?, requestCharged: Requestcharged?, restore: String?, sSECustomerAlgorithm: String?, sSECustomerKeyMD5: String?, sSEKMSKeyId: String?, serverSideEncryption: Serversideencryption?, storageClass: Storageclass?, versionId: String?, websiteRedirectLocation: String?) {
self.acceptRanges = acceptRanges
self.s3Body = s3Body
self.cacheControl = cacheControl
self.contentDisposition = contentDisposition
self.contentEncoding = contentEncoding
self.contentLanguage = contentLanguage
self.contentLength = contentLength
self.contentRange = contentRange
self.contentType = contentType
self.deleteMarker = deleteMarker
self.eTag = eTag
self.expiration = expiration
self.expires = expires
self.lastModified = lastModified
self.metadata = metadata
self.missingMeta = missingMeta
self.partsCount = partsCount
self.replicationStatus = replicationStatus
self.requestCharged = requestCharged
self.restore = restore
self.sSECustomerAlgorithm = sSECustomerAlgorithm
self.sSECustomerKeyMD5 = sSECustomerKeyMD5
self.sSEKMSKeyId = sSEKMSKeyId
self.serverSideEncryption = serverSideEncryption
self.storageClass = storageClass
self.versionId = versionId
self.websiteRedirectLocation = websiteRedirectLocation
  }
}

public struct GetObjectRequest: AwswiftSerializable {
/**

 */
  public let bucket: String
/**
Return the object only if its entity tag (ETag) is the same as the one specified, otherwise return a 412 (precondition failed).
 */
  public let ifMatch: String?
/**
Return the object only if it has been modified since the specified time, otherwise return a 304 (not modified).
 */
  public let ifModifiedSince: Date?
/**
Return the object only if its entity tag (ETag) is different from the one specified, otherwise return a 304 (not modified).
 */
  public let ifNoneMatch: String?
/**
Return the object only if it has not been modified since the specified time, otherwise return a 412 (precondition failed).
 */
  public let ifUnmodifiedSince: Date?
/**

 */
  public let key: String
/**
Part number of the object being read. This is a positive integer between 1 and 10,000. Effectively performs a 'ranged' GET request for the part specified. Useful for downloading just a part of an object.
 */
  public let partNumber: Int?
/**
Downloads the specified range bytes of an object. For more information about the HTTP Range header, go to http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.35.
 */
  public let range: String?
/**

 */
  public let requestPayer: Requestpayer?
/**
Sets the Cache-Control header of the response.
 */
  public let responseCacheControl: String?
/**
Sets the Content-Disposition header of the response
 */
  public let responseContentDisposition: String?
/**
Sets the Content-Encoding header of the response.
 */
  public let responseContentEncoding: String?
/**
Sets the Content-Language header of the response.
 */
  public let responseContentLanguage: String?
/**
Sets the Content-Type header of the response.
 */
  public let responseContentType: String?
/**
Sets the Expires header of the response.
 */
  public let responseExpires: Date?
/**
Specifies the algorithm to use to when encrypting the object (e.g., AES256).
 */
  public let sSECustomerAlgorithm: String?
/**
Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data. This value is used to store the object and then it is discarded; Amazon does not store the encryption key. The key must be appropriate for use with the algorithm specified in the x-amz-server-side​-encryption​-customer-algorithm header.
 */
  public let sSECustomerKey: String?
/**
Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure the encryption key was transmitted without error.
 */
  public let sSECustomerKeyMD5: String?
/**
VersionId used to reference a specific version of the object.
 */
  public let versionId: String?

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    var querystring: [String: String] = [:]
    var header: [String: String] = [:]
    
  
    uri["Bucket"] = "\(bucket)"
    uri["Key"] = "\(key)"
    if partNumber != nil { querystring["partNumber"] = "\(partNumber!)" }
    if responseCacheControl != nil { querystring["response-cache-control"] = "\(responseCacheControl!)" }
    if responseContentDisposition != nil { querystring["response-content-disposition"] = "\(responseContentDisposition!)" }
    if responseContentEncoding != nil { querystring["response-content-encoding"] = "\(responseContentEncoding!)" }
    if responseContentLanguage != nil { querystring["response-content-language"] = "\(responseContentLanguage!)" }
    if responseContentType != nil { querystring["response-content-type"] = "\(responseContentType!)" }
    if responseExpires != nil { querystring["response-expires"] = "\(responseExpires!)" }
    if versionId != nil { querystring["versionId"] = "\(versionId!)" }
    if ifMatch != nil { header["If-Match"] = "\(ifMatch!)" }
    if ifModifiedSince != nil { header["If-Modified-Since"] = "\(ifModifiedSince!)" }
    if ifNoneMatch != nil { header["If-None-Match"] = "\(ifNoneMatch!)" }
    if ifUnmodifiedSince != nil { header["If-Unmodified-Since"] = "\(ifUnmodifiedSince!)" }
    if range != nil { header["Range"] = "\(range!)" }
    if requestPayer != nil { header["x-amz-request-payer"] = "\(requestPayer!)" }
    if sSECustomerAlgorithm != nil { header["x-amz-server-side-encryption-customer-algorithm"] = "\(sSECustomerAlgorithm!)" }
    if sSECustomerKey != nil { header["x-amz-server-side-encryption-customer-key"] = "\(sSECustomerKey!)" }
    if sSECustomerKeyMD5 != nil { header["x-amz-server-side-encryption-customer-key-MD5"] = "\(sSECustomerKeyMD5!)" }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - bucket: 
      - ifMatch: Return the object only if its entity tag (ETag) is the same as the one specified, otherwise return a 412 (precondition failed).
      - ifModifiedSince: Return the object only if it has been modified since the specified time, otherwise return a 304 (not modified).
      - ifNoneMatch: Return the object only if its entity tag (ETag) is different from the one specified, otherwise return a 304 (not modified).
      - ifUnmodifiedSince: Return the object only if it has not been modified since the specified time, otherwise return a 412 (precondition failed).
      - key: 
      - partNumber: Part number of the object being read. This is a positive integer between 1 and 10,000. Effectively performs a 'ranged' GET request for the part specified. Useful for downloading just a part of an object.
      - range: Downloads the specified range bytes of an object. For more information about the HTTP Range header, go to http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.35.
      - requestPayer: 
      - responseCacheControl: Sets the Cache-Control header of the response.
      - responseContentDisposition: Sets the Content-Disposition header of the response
      - responseContentEncoding: Sets the Content-Encoding header of the response.
      - responseContentLanguage: Sets the Content-Language header of the response.
      - responseContentType: Sets the Content-Type header of the response.
      - responseExpires: Sets the Expires header of the response.
      - sSECustomerAlgorithm: Specifies the algorithm to use to when encrypting the object (e.g., AES256).
      - sSECustomerKey: Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data. This value is used to store the object and then it is discarded; Amazon does not store the encryption key. The key must be appropriate for use with the algorithm specified in the x-amz-server-side​-encryption​-customer-algorithm header.
      - sSECustomerKeyMD5: Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure the encryption key was transmitted without error.
      - versionId: VersionId used to reference a specific version of the object.
 */
  public init(bucket: String, ifMatch: String?, ifModifiedSince: Date?, ifNoneMatch: String?, ifUnmodifiedSince: Date?, key: String, partNumber: Int?, range: String?, requestPayer: Requestpayer?, responseCacheControl: String?, responseContentDisposition: String?, responseContentEncoding: String?, responseContentLanguage: String?, responseContentType: String?, responseExpires: Date?, sSECustomerAlgorithm: String?, sSECustomerKey: String?, sSECustomerKeyMD5: String?, versionId: String?) {
self.bucket = bucket
self.ifMatch = ifMatch
self.ifModifiedSince = ifModifiedSince
self.ifNoneMatch = ifNoneMatch
self.ifUnmodifiedSince = ifUnmodifiedSince
self.key = key
self.partNumber = partNumber
self.range = range
self.requestPayer = requestPayer
self.responseCacheControl = responseCacheControl
self.responseContentDisposition = responseContentDisposition
self.responseContentEncoding = responseContentEncoding
self.responseContentLanguage = responseContentLanguage
self.responseContentType = responseContentType
self.responseExpires = responseExpires
self.sSECustomerAlgorithm = sSECustomerAlgorithm
self.sSECustomerKey = sSECustomerKey
self.sSECustomerKeyMD5 = sSECustomerKeyMD5
self.versionId = versionId
  }
}

public struct GetObjectTorrentOutput: AwswiftDeserializable {
/**

 */
  public let s3Body: Data?
/**

 */
  public let requestCharged: Requestcharged?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> GetObjectTorrentOutput {
    guard case let .xml(node) = body else { fatalError() }
    return GetObjectTorrentOutput(
        s3Body: try! node.nodes(forXPath: "Body").first.map { Data.deserialize(response: response, body: .xml($0)) },
      requestCharged: response.allHeaderFields["x-amz-request-charged"].flatMap { ($0 is NSNull) ? nil : Requestcharged.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - s3Body: 
      - requestCharged: 
 */
  public init(s3Body: Data?, requestCharged: Requestcharged?) {
self.s3Body = s3Body
self.requestCharged = requestCharged
  }
}

public struct GetObjectTorrentRequest: AwswiftSerializable {
/**

 */
  public let bucket: String
/**

 */
  public let key: String
/**

 */
  public let requestPayer: Requestpayer?

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    var header: [String: String] = [:]
    
  
    uri["Bucket"] = "\(bucket)"
    uri["Key"] = "\(key)"
    if requestPayer != nil { header["x-amz-request-payer"] = "\(requestPayer!)" }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - bucket: 
      - key: 
      - requestPayer: 
 */
  public init(bucket: String, key: String, requestPayer: Requestpayer?) {
self.bucket = bucket
self.key = key
self.requestPayer = requestPayer
  }
}

public struct Grant: AwswiftSerializable, AwswiftDeserializable {
/**

 */
  public let grantee: Grantee?
/**
Specifies the permission given to the grantee.
 */
  public let permission: Permission?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if grantee != nil { body["Grantee"] = grantee! }
    if permission != nil { body["Permission"] = permission! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Grant {
    guard case let .xml(node) = body else { fatalError() }
    return Grant(
        grantee: try! node.nodes(forXPath: "Grantee").first.map { Grantee.deserialize(response: response, body: .xml($0)) },
      permission: try! node.nodes(forXPath: "Permission").first.map { Permission.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - grantee: 
      - permission: Specifies the permission given to the grantee.
 */
  public init(grantee: Grantee?, permission: Permission?) {
self.grantee = grantee
self.permission = permission
  }
}






public struct Grantee: AwswiftSerializable, AwswiftDeserializable {
/**
Screen name of the grantee.
 */
  public let displayName: String?
/**
Email address of the grantee.
 */
  public let emailAddress: String?
/**
The canonical user ID of the grantee.
 */
  public let iD: String?
/**
Type of grantee
 */
  public let s3Type: S3Type
/**
URI of the grantee group.
 */
  public let uRI: String?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if displayName != nil { body["DisplayName"] = displayName! }
    if emailAddress != nil { body["EmailAddress"] = emailAddress! }
    if iD != nil { body["ID"] = iD! }
    body["xsi:type"] = s3Type
    if uRI != nil { body["URI"] = uRI! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Grantee {
    guard case let .xml(node) = body else { fatalError() }
    return Grantee(
        displayName: try! node.nodes(forXPath: "DisplayName").first.map { String.deserialize(response: response, body: .xml($0)) },
      emailAddress: try! node.nodes(forXPath: "EmailAddress").first.map { String.deserialize(response: response, body: .xml($0)) },
      iD: try! node.nodes(forXPath: "ID").first.map { String.deserialize(response: response, body: .xml($0)) },
      s3Type: try! node.nodes(forXPath: "xsi:type").first.map { S3Type.deserialize(response: response, body: .xml($0)) }!,
      uRI: try! node.nodes(forXPath: "URI").first.map { String.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - displayName: Screen name of the grantee.
      - emailAddress: Email address of the grantee.
      - iD: The canonical user ID of the grantee.
      - s3Type: Type of grantee
      - uRI: URI of the grantee group.
 */
  public init(displayName: String?, emailAddress: String?, iD: String?, s3Type: S3Type, uRI: String?) {
self.displayName = displayName
self.emailAddress = emailAddress
self.iD = iD
self.s3Type = s3Type
self.uRI = uRI
  }
}


public struct HeadBucketRequest: AwswiftSerializable {
/**

 */
  public let bucket: String

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
    uri["Bucket"] = "\(bucket)"
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - bucket: 
 */
  public init(bucket: String) {
self.bucket = bucket
  }
}

public struct HeadObjectOutput: AwswiftDeserializable {
/**

 */
  public let acceptRanges: String?
/**
Specifies caching behavior along the request/reply chain.
 */
  public let cacheControl: String?
/**
Specifies presentational information for the object.
 */
  public let contentDisposition: String?
/**
Specifies what content encodings have been applied to the object and thus what decoding mechanisms must be applied to obtain the media-type referenced by the Content-Type header field.
 */
  public let contentEncoding: String?
/**
The language the content is in.
 */
  public let contentLanguage: String?
/**
Size of the body in bytes.
 */
  public let contentLength: Int?
/**
A standard MIME type describing the format of the object data.
 */
  public let contentType: String?
/**
Specifies whether the object retrieved was (true) or was not (false) a Delete Marker. If false, this response header does not appear in the response.
 */
  public let deleteMarker: Bool?
/**
An ETag is an opaque identifier assigned by a web server to a specific version of a resource found at a URL
 */
  public let eTag: String?
/**
If the object expiration is configured (see PUT Bucket lifecycle), the response includes this header. It includes the expiry-date and rule-id key value pairs providing object expiration information. The value of the rule-id is URL encoded.
 */
  public let expiration: String?
/**
The date and time at which the object is no longer cacheable.
 */
  public let expires: Date?
/**
Last modified date of the object
 */
  public let lastModified: Date?
/**
A map of metadata to store with the object in S3.
 */
  public let metadata: [String: String]?
/**
This is set to the number of metadata entries not returned in x-amz-meta headers. This can happen if you create metadata using an API like SOAP that supports more flexible metadata than the REST API. For example, using SOAP, you can create metadata whose values are not legal HTTP headers.
 */
  public let missingMeta: Int?
/**
The count of parts this object has.
 */
  public let partsCount: Int?
/**

 */
  public let replicationStatus: Replicationstatus?
/**

 */
  public let requestCharged: Requestcharged?
/**
Provides information about object restoration operation and expiration time of the restored object copy.
 */
  public let restore: String?
/**
If server-side encryption with a customer-provided encryption key was requested, the response will include this header confirming the encryption algorithm used.
 */
  public let sSECustomerAlgorithm: String?
/**
If server-side encryption with a customer-provided encryption key was requested, the response will include this header to provide round trip message integrity verification of the customer-provided encryption key.
 */
  public let sSECustomerKeyMD5: String?
/**
If present, specifies the ID of the AWS Key Management Service (KMS) master encryption key that was used for the object.
 */
  public let sSEKMSKeyId: String?
/**
The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).
 */
  public let serverSideEncryption: Serversideencryption?
/**

 */
  public let storageClass: Storageclass?
/**
Version of the object.
 */
  public let versionId: String?
/**
If the bucket is configured as a website, redirects requests for this object to another object in the same bucket or to an external URL. Amazon S3 stores the value of this header in the object metadata.
 */
  public let websiteRedirectLocation: String?


  static func deserializableBody(data: Data) -> DeserializableBody {
    fatalError()
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> HeadObjectOutput {
  
    return HeadObjectOutput(
        acceptRanges: response.allHeaderFields["accept-ranges"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      cacheControl: response.allHeaderFields["Cache-Control"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      contentDisposition: response.allHeaderFields["Content-Disposition"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      contentEncoding: response.allHeaderFields["Content-Encoding"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      contentLanguage: response.allHeaderFields["Content-Language"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      contentLength: response.allHeaderFields["Content-Length"].flatMap { ($0 is NSNull) ? nil : Int.deserialize(response: response, body: .json($0)) },
      contentType: response.allHeaderFields["Content-Type"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      deleteMarker: response.allHeaderFields["x-amz-delete-marker"].flatMap { ($0 is NSNull) ? nil : Bool.deserialize(response: response, body: .json($0)) },
      eTag: response.allHeaderFields["ETag"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      expiration: response.allHeaderFields["x-amz-expiration"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      expires: response.allHeaderFields["Expires"].flatMap { ($0 is NSNull) ? nil : Date.deserialize(response: response, body: .json($0)) },
      lastModified: response.allHeaderFields["Last-Modified"].flatMap { ($0 is NSNull) ? nil : Date.deserialize(response: response, body: .json($0)) },
      metadata: Dictionary(response.allHeaderFields.map { (key: $0 as! String, value: $1 as! String) }.filter { $0.key.lowercased().hasPrefix("x-amz-meta-") }),
      missingMeta: response.allHeaderFields["x-amz-missing-meta"].flatMap { ($0 is NSNull) ? nil : Int.deserialize(response: response, body: .json($0)) },
      partsCount: response.allHeaderFields["x-amz-mp-parts-count"].flatMap { ($0 is NSNull) ? nil : Int.deserialize(response: response, body: .json($0)) },
      replicationStatus: response.allHeaderFields["x-amz-replication-status"].flatMap { ($0 is NSNull) ? nil : Replicationstatus.deserialize(response: response, body: .json($0)) },
      requestCharged: response.allHeaderFields["x-amz-request-charged"].flatMap { ($0 is NSNull) ? nil : Requestcharged.deserialize(response: response, body: .json($0)) },
      restore: response.allHeaderFields["x-amz-restore"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      sSECustomerAlgorithm: response.allHeaderFields["x-amz-server-side-encryption-customer-algorithm"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      sSECustomerKeyMD5: response.allHeaderFields["x-amz-server-side-encryption-customer-key-MD5"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      sSEKMSKeyId: response.allHeaderFields["x-amz-server-side-encryption-aws-kms-key-id"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      serverSideEncryption: response.allHeaderFields["x-amz-server-side-encryption"].flatMap { ($0 is NSNull) ? nil : Serversideencryption.deserialize(response: response, body: .json($0)) },
      storageClass: response.allHeaderFields["x-amz-storage-class"].flatMap { ($0 is NSNull) ? nil : Storageclass.deserialize(response: response, body: .json($0)) },
      versionId: response.allHeaderFields["x-amz-version-id"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      websiteRedirectLocation: response.allHeaderFields["x-amz-website-redirect-location"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - acceptRanges: 
      - cacheControl: Specifies caching behavior along the request/reply chain.
      - contentDisposition: Specifies presentational information for the object.
      - contentEncoding: Specifies what content encodings have been applied to the object and thus what decoding mechanisms must be applied to obtain the media-type referenced by the Content-Type header field.
      - contentLanguage: The language the content is in.
      - contentLength: Size of the body in bytes.
      - contentType: A standard MIME type describing the format of the object data.
      - deleteMarker: Specifies whether the object retrieved was (true) or was not (false) a Delete Marker. If false, this response header does not appear in the response.
      - eTag: An ETag is an opaque identifier assigned by a web server to a specific version of a resource found at a URL
      - expiration: If the object expiration is configured (see PUT Bucket lifecycle), the response includes this header. It includes the expiry-date and rule-id key value pairs providing object expiration information. The value of the rule-id is URL encoded.
      - expires: The date and time at which the object is no longer cacheable.
      - lastModified: Last modified date of the object
      - metadata: A map of metadata to store with the object in S3.
      - missingMeta: This is set to the number of metadata entries not returned in x-amz-meta headers. This can happen if you create metadata using an API like SOAP that supports more flexible metadata than the REST API. For example, using SOAP, you can create metadata whose values are not legal HTTP headers.
      - partsCount: The count of parts this object has.
      - replicationStatus: 
      - requestCharged: 
      - restore: Provides information about object restoration operation and expiration time of the restored object copy.
      - sSECustomerAlgorithm: If server-side encryption with a customer-provided encryption key was requested, the response will include this header confirming the encryption algorithm used.
      - sSECustomerKeyMD5: If server-side encryption with a customer-provided encryption key was requested, the response will include this header to provide round trip message integrity verification of the customer-provided encryption key.
      - sSEKMSKeyId: If present, specifies the ID of the AWS Key Management Service (KMS) master encryption key that was used for the object.
      - serverSideEncryption: The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).
      - storageClass: 
      - versionId: Version of the object.
      - websiteRedirectLocation: If the bucket is configured as a website, redirects requests for this object to another object in the same bucket or to an external URL. Amazon S3 stores the value of this header in the object metadata.
 */
  public init(acceptRanges: String?, cacheControl: String?, contentDisposition: String?, contentEncoding: String?, contentLanguage: String?, contentLength: Int?, contentType: String?, deleteMarker: Bool?, eTag: String?, expiration: String?, expires: Date?, lastModified: Date?, metadata: [String: String]?, missingMeta: Int?, partsCount: Int?, replicationStatus: Replicationstatus?, requestCharged: Requestcharged?, restore: String?, sSECustomerAlgorithm: String?, sSECustomerKeyMD5: String?, sSEKMSKeyId: String?, serverSideEncryption: Serversideencryption?, storageClass: Storageclass?, versionId: String?, websiteRedirectLocation: String?) {
self.acceptRanges = acceptRanges
self.cacheControl = cacheControl
self.contentDisposition = contentDisposition
self.contentEncoding = contentEncoding
self.contentLanguage = contentLanguage
self.contentLength = contentLength
self.contentType = contentType
self.deleteMarker = deleteMarker
self.eTag = eTag
self.expiration = expiration
self.expires = expires
self.lastModified = lastModified
self.metadata = metadata
self.missingMeta = missingMeta
self.partsCount = partsCount
self.replicationStatus = replicationStatus
self.requestCharged = requestCharged
self.restore = restore
self.sSECustomerAlgorithm = sSECustomerAlgorithm
self.sSECustomerKeyMD5 = sSECustomerKeyMD5
self.sSEKMSKeyId = sSEKMSKeyId
self.serverSideEncryption = serverSideEncryption
self.storageClass = storageClass
self.versionId = versionId
self.websiteRedirectLocation = websiteRedirectLocation
  }
}

public struct HeadObjectRequest: AwswiftSerializable {
/**

 */
  public let bucket: String
/**
Return the object only if its entity tag (ETag) is the same as the one specified, otherwise return a 412 (precondition failed).
 */
  public let ifMatch: String?
/**
Return the object only if it has been modified since the specified time, otherwise return a 304 (not modified).
 */
  public let ifModifiedSince: Date?
/**
Return the object only if its entity tag (ETag) is different from the one specified, otherwise return a 304 (not modified).
 */
  public let ifNoneMatch: String?
/**
Return the object only if it has not been modified since the specified time, otherwise return a 412 (precondition failed).
 */
  public let ifUnmodifiedSince: Date?
/**

 */
  public let key: String
/**
Part number of the object being read. This is a positive integer between 1 and 10,000. Effectively performs a 'ranged' HEAD request for the part specified. Useful querying about the size of the part and the number of parts in this object.
 */
  public let partNumber: Int?
/**
Downloads the specified range bytes of an object. For more information about the HTTP Range header, go to http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.35.
 */
  public let range: String?
/**

 */
  public let requestPayer: Requestpayer?
/**
Specifies the algorithm to use to when encrypting the object (e.g., AES256).
 */
  public let sSECustomerAlgorithm: String?
/**
Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data. This value is used to store the object and then it is discarded; Amazon does not store the encryption key. The key must be appropriate for use with the algorithm specified in the x-amz-server-side​-encryption​-customer-algorithm header.
 */
  public let sSECustomerKey: String?
/**
Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure the encryption key was transmitted without error.
 */
  public let sSECustomerKeyMD5: String?
/**
VersionId used to reference a specific version of the object.
 */
  public let versionId: String?

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    var querystring: [String: String] = [:]
    var header: [String: String] = [:]
    
  
    uri["Bucket"] = "\(bucket)"
    uri["Key"] = "\(key)"
    if partNumber != nil { querystring["partNumber"] = "\(partNumber!)" }
    if versionId != nil { querystring["versionId"] = "\(versionId!)" }
    if ifMatch != nil { header["If-Match"] = "\(ifMatch!)" }
    if ifModifiedSince != nil { header["If-Modified-Since"] = "\(ifModifiedSince!)" }
    if ifNoneMatch != nil { header["If-None-Match"] = "\(ifNoneMatch!)" }
    if ifUnmodifiedSince != nil { header["If-Unmodified-Since"] = "\(ifUnmodifiedSince!)" }
    if range != nil { header["Range"] = "\(range!)" }
    if requestPayer != nil { header["x-amz-request-payer"] = "\(requestPayer!)" }
    if sSECustomerAlgorithm != nil { header["x-amz-server-side-encryption-customer-algorithm"] = "\(sSECustomerAlgorithm!)" }
    if sSECustomerKey != nil { header["x-amz-server-side-encryption-customer-key"] = "\(sSECustomerKey!)" }
    if sSECustomerKeyMD5 != nil { header["x-amz-server-side-encryption-customer-key-MD5"] = "\(sSECustomerKeyMD5!)" }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - bucket: 
      - ifMatch: Return the object only if its entity tag (ETag) is the same as the one specified, otherwise return a 412 (precondition failed).
      - ifModifiedSince: Return the object only if it has been modified since the specified time, otherwise return a 304 (not modified).
      - ifNoneMatch: Return the object only if its entity tag (ETag) is different from the one specified, otherwise return a 304 (not modified).
      - ifUnmodifiedSince: Return the object only if it has not been modified since the specified time, otherwise return a 412 (precondition failed).
      - key: 
      - partNumber: Part number of the object being read. This is a positive integer between 1 and 10,000. Effectively performs a 'ranged' HEAD request for the part specified. Useful querying about the size of the part and the number of parts in this object.
      - range: Downloads the specified range bytes of an object. For more information about the HTTP Range header, go to http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.35.
      - requestPayer: 
      - sSECustomerAlgorithm: Specifies the algorithm to use to when encrypting the object (e.g., AES256).
      - sSECustomerKey: Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data. This value is used to store the object and then it is discarded; Amazon does not store the encryption key. The key must be appropriate for use with the algorithm specified in the x-amz-server-side​-encryption​-customer-algorithm header.
      - sSECustomerKeyMD5: Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure the encryption key was transmitted without error.
      - versionId: VersionId used to reference a specific version of the object.
 */
  public init(bucket: String, ifMatch: String?, ifModifiedSince: Date?, ifNoneMatch: String?, ifUnmodifiedSince: Date?, key: String, partNumber: Int?, range: String?, requestPayer: Requestpayer?, sSECustomerAlgorithm: String?, sSECustomerKey: String?, sSECustomerKeyMD5: String?, versionId: String?) {
self.bucket = bucket
self.ifMatch = ifMatch
self.ifModifiedSince = ifModifiedSince
self.ifNoneMatch = ifNoneMatch
self.ifUnmodifiedSince = ifUnmodifiedSince
self.key = key
self.partNumber = partNumber
self.range = range
self.requestPayer = requestPayer
self.sSECustomerAlgorithm = sSECustomerAlgorithm
self.sSECustomerKey = sSECustomerKey
self.sSECustomerKeyMD5 = sSECustomerKeyMD5
self.versionId = versionId
  }
}









public struct IndexDocument: AwswiftSerializable, AwswiftDeserializable {
/**
A suffix that is appended to a request that is for a directory on the website endpoint (e.g. if the suffix is index.html and you make a request to samplebucket/images/ the data that is returned will be for the object with the key name images/index.html) The suffix must not be empty and must not include a slash character.
 */
  public let suffix: String

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["Suffix"] = suffix
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> IndexDocument {
    guard case let .xml(node) = body else { fatalError() }
    return IndexDocument(
        suffix: try! node.nodes(forXPath: "Suffix").first.map { String.deserialize(response: response, body: .xml($0)) }!
    )
  }

/**
    - parameters:
      - suffix: A suffix that is appended to a request that is for a directory on the website endpoint (e.g. if the suffix is index.html and you make a request to samplebucket/images/ the data that is returned will be for the object with the key name images/index.html) The suffix must not be empty and must not include a slash character.
 */
  public init(suffix: String) {
self.suffix = suffix
  }
}


public struct Initiator: AwswiftSerializable, AwswiftDeserializable {
/**
Name of the Principal.
 */
  public let displayName: String?
/**
If the principal is an AWS account, it provides the Canonical User ID. If the principal is an IAM User, it provides a user ARN value.
 */
  public let iD: String?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if displayName != nil { body["DisplayName"] = displayName! }
    if iD != nil { body["ID"] = iD! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Initiator {
    guard case let .xml(node) = body else { fatalError() }
    return Initiator(
        displayName: try! node.nodes(forXPath: "DisplayName").first.map { String.deserialize(response: response, body: .xml($0)) },
      iD: try! node.nodes(forXPath: "ID").first.map { String.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - displayName: Name of the Principal.
      - iD: If the principal is an AWS account, it provides the Canonical User ID. If the principal is an IAM User, it provides a user ARN value.
 */
  public init(displayName: String?, iD: String?) {
self.displayName = displayName
self.iD = iD
  }
}







/**
Container for specifying the AWS Lambda notification configuration.
 */
public struct LambdaFunctionConfiguration: AwswiftSerializable, AwswiftDeserializable {
/**

 */
  public let events: [Event]
/**

 */
  public let filter: NotificationConfigurationFilter?
/**

 */
  public let id: String?
/**
Lambda cloud function ARN that Amazon S3 can invoke when it detects events of the specified type.
 */
  public let lambdaFunctionArn: String

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["Event"] = events
    if filter != nil { body["Filter"] = filter! }
    if id != nil { body["Id"] = id! }
    body["CloudFunction"] = lambdaFunctionArn
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> LambdaFunctionConfiguration {
    guard case let .xml(node) = body else { fatalError() }
    return LambdaFunctionConfiguration(
        events: try! node.nodes(forXPath: "Event").map { Event.deserialize(response: response, body: .xml($0)) },
      filter: try! node.nodes(forXPath: "Filter").first.map { NotificationConfigurationFilter.deserialize(response: response, body: .xml($0)) },
      id: try! node.nodes(forXPath: "Id").first.map { String.deserialize(response: response, body: .xml($0)) },
      lambdaFunctionArn: try! node.nodes(forXPath: "CloudFunction").first.map { String.deserialize(response: response, body: .xml($0)) }!
    )
  }

/**
    - parameters:
      - events: 
      - filter: 
      - id: 
      - lambdaFunctionArn: Lambda cloud function ARN that Amazon S3 can invoke when it detects events of the specified type.
 */
  public init(events: [Event], filter: NotificationConfigurationFilter?, id: String?, lambdaFunctionArn: String) {
self.events = events
self.filter = filter
self.id = id
self.lambdaFunctionArn = lambdaFunctionArn
  }
}



public struct LifecycleConfiguration: AwswiftSerializable, AwswiftDeserializable {
/**

 */
  public let rules: [Rule]

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["Rule"] = rules
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> LifecycleConfiguration {
    guard case let .xml(node) = body else { fatalError() }
    return LifecycleConfiguration(
        rules: try! node.nodes(forXPath: "Rule").map { Rule.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - rules: 
 */
  public init(rules: [Rule]) {
self.rules = rules
  }
}

public struct LifecycleExpiration: AwswiftSerializable, AwswiftDeserializable {
/**
Indicates at what date the object is to be moved or deleted. Should be in GMT ISO 8601 Format.
 */
  public let date: Date?
/**
Indicates the lifetime, in days, of the objects that are subject to the rule. The value must be a non-zero positive integer.
 */
  public let days: Int?
/**
Indicates whether Amazon S3 will remove a delete marker with no noncurrent versions. If set to true, the delete marker will be expired; if set to false the policy takes no action. This cannot be specified with Days or Date in a Lifecycle Expiration Policy.
 */
  public let expiredObjectDeleteMarker: Bool?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if date != nil { body["Date"] = date! }
    if days != nil { body["Days"] = days! }
    if expiredObjectDeleteMarker != nil { body["ExpiredObjectDeleteMarker"] = expiredObjectDeleteMarker! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> LifecycleExpiration {
    guard case let .xml(node) = body else { fatalError() }
    return LifecycleExpiration(
        date: try! node.nodes(forXPath: "Date").first.map { Date.deserialize(response: response, body: .xml($0)) },
      days: try! node.nodes(forXPath: "Days").first.map { Int.deserialize(response: response, body: .xml($0)) },
      expiredObjectDeleteMarker: try! node.nodes(forXPath: "ExpiredObjectDeleteMarker").first.map { Bool.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - date: Indicates at what date the object is to be moved or deleted. Should be in GMT ISO 8601 Format.
      - days: Indicates the lifetime, in days, of the objects that are subject to the rule. The value must be a non-zero positive integer.
      - expiredObjectDeleteMarker: Indicates whether Amazon S3 will remove a delete marker with no noncurrent versions. If set to true, the delete marker will be expired; if set to false the policy takes no action. This cannot be specified with Days or Date in a Lifecycle Expiration Policy.
 */
  public init(date: Date?, days: Int?, expiredObjectDeleteMarker: Bool?) {
self.date = date
self.days = days
self.expiredObjectDeleteMarker = expiredObjectDeleteMarker
  }
}

public struct LifecycleRule: AwswiftSerializable, AwswiftDeserializable {
/**

 */
  public let abortIncompleteMultipartUpload: AbortIncompleteMultipartUpload?
/**

 */
  public let expiration: LifecycleExpiration?
/**
Unique identifier for the rule. The value cannot be longer than 255 characters.
 */
  public let iD: String?
/**

 */
  public let noncurrentVersionExpiration: NoncurrentVersionExpiration?
/**

 */
  public let noncurrentVersionTransitions: [NoncurrentVersionTransition]?
/**
Prefix identifying one or more objects to which the rule applies.
 */
  public let prefix: String
/**
If 'Enabled', the rule is currently being applied. If 'Disabled', the rule is not currently being applied.
 */
  public let status: Expirationstatus
/**

 */
  public let transitions: [Transition]?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if abortIncompleteMultipartUpload != nil { body["AbortIncompleteMultipartUpload"] = abortIncompleteMultipartUpload! }
    if expiration != nil { body["Expiration"] = expiration! }
    if iD != nil { body["ID"] = iD! }
    if noncurrentVersionExpiration != nil { body["NoncurrentVersionExpiration"] = noncurrentVersionExpiration! }
    if noncurrentVersionTransitions != nil { body["NoncurrentVersionTransition"] = noncurrentVersionTransitions! }
    body["Prefix"] = prefix
    body["Status"] = status
    if transitions != nil { body["Transition"] = transitions! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> LifecycleRule {
    guard case let .xml(node) = body else { fatalError() }
    return LifecycleRule(
        abortIncompleteMultipartUpload: try! node.nodes(forXPath: "AbortIncompleteMultipartUpload").first.map { AbortIncompleteMultipartUpload.deserialize(response: response, body: .xml($0)) },
      expiration: try! node.nodes(forXPath: "Expiration").first.map { LifecycleExpiration.deserialize(response: response, body: .xml($0)) },
      iD: try! node.nodes(forXPath: "ID").first.map { String.deserialize(response: response, body: .xml($0)) },
      noncurrentVersionExpiration: try! node.nodes(forXPath: "NoncurrentVersionExpiration").first.map { NoncurrentVersionExpiration.deserialize(response: response, body: .xml($0)) },
      noncurrentVersionTransitions: try! node.nodes(forXPath: "NoncurrentVersionTransition").map { NoncurrentVersionTransition.deserialize(response: response, body: .xml($0)) },
      prefix: try! node.nodes(forXPath: "Prefix").first.map { String.deserialize(response: response, body: .xml($0)) }!,
      status: try! node.nodes(forXPath: "Status").first.map { Expirationstatus.deserialize(response: response, body: .xml($0)) }!,
      transitions: try! node.nodes(forXPath: "Transition").map { Transition.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - abortIncompleteMultipartUpload: 
      - expiration: 
      - iD: Unique identifier for the rule. The value cannot be longer than 255 characters.
      - noncurrentVersionExpiration: 
      - noncurrentVersionTransitions: 
      - prefix: Prefix identifying one or more objects to which the rule applies.
      - status: If 'Enabled', the rule is currently being applied. If 'Disabled', the rule is not currently being applied.
      - transitions: 
 */
  public init(abortIncompleteMultipartUpload: AbortIncompleteMultipartUpload?, expiration: LifecycleExpiration?, iD: String?, noncurrentVersionExpiration: NoncurrentVersionExpiration?, noncurrentVersionTransitions: [NoncurrentVersionTransition]?, prefix: String, status: Expirationstatus, transitions: [Transition]?) {
self.abortIncompleteMultipartUpload = abortIncompleteMultipartUpload
self.expiration = expiration
self.iD = iD
self.noncurrentVersionExpiration = noncurrentVersionExpiration
self.noncurrentVersionTransitions = noncurrentVersionTransitions
self.prefix = prefix
self.status = status
self.transitions = transitions
  }
}


public struct ListBucketsOutput: AwswiftDeserializable {
/**

 */
  public let buckets: [Bucket]?
/**

 */
  public let owner: Owner?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> ListBucketsOutput {
    guard case let .xml(node) = body else { fatalError() }
    return ListBucketsOutput(
        buckets: try! node.nodes(forXPath: "Buckets").map { Bucket.deserialize(response: response, body: .xml($0)) },
      owner: try! node.nodes(forXPath: "Owner").first.map { Owner.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - buckets: 
      - owner: 
 */
  public init(buckets: [Bucket]?, owner: Owner?) {
self.buckets = buckets
self.owner = owner
  }
}

public struct ListMultipartUploadsOutput: AwswiftDeserializable {
/**
Name of the bucket to which the multipart upload was initiated.
 */
  public let bucket: String?
/**

 */
  public let commonPrefixes: [CommonPrefix]?
/**

 */
  public let delimiter: String?
/**
Encoding type used by Amazon S3 to encode object keys in the response.
 */
  public let encodingType: Encodingtype?
/**
Indicates whether the returned list of multipart uploads is truncated. A value of true indicates that the list was truncated. The list can be truncated if the number of multipart uploads exceeds the limit allowed or specified by max uploads.
 */
  public let isTruncated: Bool?
/**
The key at or after which the listing began.
 */
  public let keyMarker: String?
/**
Maximum number of multipart uploads that could have been included in the response.
 */
  public let maxUploads: Int?
/**
When a list is truncated, this element specifies the value that should be used for the key-marker request parameter in a subsequent request.
 */
  public let nextKeyMarker: String?
/**
When a list is truncated, this element specifies the value that should be used for the upload-id-marker request parameter in a subsequent request.
 */
  public let nextUploadIdMarker: String?
/**
When a prefix is provided in the request, this field contains the specified prefix. The result contains only keys starting with the specified prefix.
 */
  public let prefix: String?
/**
Upload ID after which listing began.
 */
  public let uploadIdMarker: String?
/**

 */
  public let uploads: [MultipartUpload]?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> ListMultipartUploadsOutput {
    guard case let .xml(node) = body else { fatalError() }
    return ListMultipartUploadsOutput(
        bucket: try! node.nodes(forXPath: "Bucket").first.map { String.deserialize(response: response, body: .xml($0)) },
      commonPrefixes: try! node.nodes(forXPath: "CommonPrefixes").map { CommonPrefix.deserialize(response: response, body: .xml($0)) },
      delimiter: try! node.nodes(forXPath: "Delimiter").first.map { String.deserialize(response: response, body: .xml($0)) },
      encodingType: try! node.nodes(forXPath: "EncodingType").first.map { Encodingtype.deserialize(response: response, body: .xml($0)) },
      isTruncated: try! node.nodes(forXPath: "IsTruncated").first.map { Bool.deserialize(response: response, body: .xml($0)) },
      keyMarker: try! node.nodes(forXPath: "KeyMarker").first.map { String.deserialize(response: response, body: .xml($0)) },
      maxUploads: try! node.nodes(forXPath: "MaxUploads").first.map { Int.deserialize(response: response, body: .xml($0)) },
      nextKeyMarker: try! node.nodes(forXPath: "NextKeyMarker").first.map { String.deserialize(response: response, body: .xml($0)) },
      nextUploadIdMarker: try! node.nodes(forXPath: "NextUploadIdMarker").first.map { String.deserialize(response: response, body: .xml($0)) },
      prefix: try! node.nodes(forXPath: "Prefix").first.map { String.deserialize(response: response, body: .xml($0)) },
      uploadIdMarker: try! node.nodes(forXPath: "UploadIdMarker").first.map { String.deserialize(response: response, body: .xml($0)) },
      uploads: try! node.nodes(forXPath: "Upload").map { MultipartUpload.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - bucket: Name of the bucket to which the multipart upload was initiated.
      - commonPrefixes: 
      - delimiter: 
      - encodingType: Encoding type used by Amazon S3 to encode object keys in the response.
      - isTruncated: Indicates whether the returned list of multipart uploads is truncated. A value of true indicates that the list was truncated. The list can be truncated if the number of multipart uploads exceeds the limit allowed or specified by max uploads.
      - keyMarker: The key at or after which the listing began.
      - maxUploads: Maximum number of multipart uploads that could have been included in the response.
      - nextKeyMarker: When a list is truncated, this element specifies the value that should be used for the key-marker request parameter in a subsequent request.
      - nextUploadIdMarker: When a list is truncated, this element specifies the value that should be used for the upload-id-marker request parameter in a subsequent request.
      - prefix: When a prefix is provided in the request, this field contains the specified prefix. The result contains only keys starting with the specified prefix.
      - uploadIdMarker: Upload ID after which listing began.
      - uploads: 
 */
  public init(bucket: String?, commonPrefixes: [CommonPrefix]?, delimiter: String?, encodingType: Encodingtype?, isTruncated: Bool?, keyMarker: String?, maxUploads: Int?, nextKeyMarker: String?, nextUploadIdMarker: String?, prefix: String?, uploadIdMarker: String?, uploads: [MultipartUpload]?) {
self.bucket = bucket
self.commonPrefixes = commonPrefixes
self.delimiter = delimiter
self.encodingType = encodingType
self.isTruncated = isTruncated
self.keyMarker = keyMarker
self.maxUploads = maxUploads
self.nextKeyMarker = nextKeyMarker
self.nextUploadIdMarker = nextUploadIdMarker
self.prefix = prefix
self.uploadIdMarker = uploadIdMarker
self.uploads = uploads
  }
}

public struct ListMultipartUploadsRequest: AwswiftSerializable {
/**

 */
  public let bucket: String
/**
Character you use to group keys.
 */
  public let delimiter: String?
/**

 */
  public let encodingType: Encodingtype?
/**
Together with upload-id-marker, this parameter specifies the multipart upload after which listing should begin.
 */
  public let keyMarker: String?
/**
Sets the maximum number of multipart uploads, from 1 to 1,000, to return in the response body. 1,000 is the maximum number of uploads that can be returned in a response.
 */
  public let maxUploads: Int?
/**
Lists in-progress uploads only for those keys that begin with the specified prefix.
 */
  public let prefix: String?
/**
Together with key-marker, specifies the multipart upload after which listing should begin. If key-marker is not specified, the upload-id-marker parameter is ignored.
 */
  public let uploadIdMarker: String?

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    var querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
    uri["Bucket"] = "\(bucket)"
    if delimiter != nil { querystring["delimiter"] = "\(delimiter!)" }
    if encodingType != nil { querystring["encoding-type"] = "\(encodingType!)" }
    if keyMarker != nil { querystring["key-marker"] = "\(keyMarker!)" }
    if maxUploads != nil { querystring["max-uploads"] = "\(maxUploads!)" }
    if prefix != nil { querystring["prefix"] = "\(prefix!)" }
    if uploadIdMarker != nil { querystring["upload-id-marker"] = "\(uploadIdMarker!)" }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - bucket: 
      - delimiter: Character you use to group keys.
      - encodingType: 
      - keyMarker: Together with upload-id-marker, this parameter specifies the multipart upload after which listing should begin.
      - maxUploads: Sets the maximum number of multipart uploads, from 1 to 1,000, to return in the response body. 1,000 is the maximum number of uploads that can be returned in a response.
      - prefix: Lists in-progress uploads only for those keys that begin with the specified prefix.
      - uploadIdMarker: Together with key-marker, specifies the multipart upload after which listing should begin. If key-marker is not specified, the upload-id-marker parameter is ignored.
 */
  public init(bucket: String, delimiter: String?, encodingType: Encodingtype?, keyMarker: String?, maxUploads: Int?, prefix: String?, uploadIdMarker: String?) {
self.bucket = bucket
self.delimiter = delimiter
self.encodingType = encodingType
self.keyMarker = keyMarker
self.maxUploads = maxUploads
self.prefix = prefix
self.uploadIdMarker = uploadIdMarker
  }
}

public struct ListObjectVersionsOutput: AwswiftDeserializable {
/**

 */
  public let commonPrefixes: [CommonPrefix]?
/**

 */
  public let deleteMarkers: [DeleteMarkerEntry]?
/**

 */
  public let delimiter: String?
/**
Encoding type used by Amazon S3 to encode object keys in the response.
 */
  public let encodingType: Encodingtype?
/**
A flag that indicates whether or not Amazon S3 returned all of the results that satisfied the search criteria. If your results were truncated, you can make a follow-up paginated request using the NextKeyMarker and NextVersionIdMarker response parameters as a starting place in another request to return the rest of the results.
 */
  public let isTruncated: Bool?
/**
Marks the last Key returned in a truncated response.
 */
  public let keyMarker: String?
/**

 */
  public let maxKeys: Int?
/**

 */
  public let name: String?
/**
Use this value for the key marker request parameter in a subsequent request.
 */
  public let nextKeyMarker: String?
/**
Use this value for the next version id marker parameter in a subsequent request.
 */
  public let nextVersionIdMarker: String?
/**

 */
  public let prefix: String?
/**

 */
  public let versionIdMarker: String?
/**

 */
  public let versions: [ObjectVersion]?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> ListObjectVersionsOutput {
    guard case let .xml(node) = body else { fatalError() }
    return ListObjectVersionsOutput(
        commonPrefixes: try! node.nodes(forXPath: "CommonPrefixes").map { CommonPrefix.deserialize(response: response, body: .xml($0)) },
      deleteMarkers: try! node.nodes(forXPath: "DeleteMarker").map { DeleteMarkerEntry.deserialize(response: response, body: .xml($0)) },
      delimiter: try! node.nodes(forXPath: "Delimiter").first.map { String.deserialize(response: response, body: .xml($0)) },
      encodingType: try! node.nodes(forXPath: "EncodingType").first.map { Encodingtype.deserialize(response: response, body: .xml($0)) },
      isTruncated: try! node.nodes(forXPath: "IsTruncated").first.map { Bool.deserialize(response: response, body: .xml($0)) },
      keyMarker: try! node.nodes(forXPath: "KeyMarker").first.map { String.deserialize(response: response, body: .xml($0)) },
      maxKeys: try! node.nodes(forXPath: "MaxKeys").first.map { Int.deserialize(response: response, body: .xml($0)) },
      name: try! node.nodes(forXPath: "Name").first.map { String.deserialize(response: response, body: .xml($0)) },
      nextKeyMarker: try! node.nodes(forXPath: "NextKeyMarker").first.map { String.deserialize(response: response, body: .xml($0)) },
      nextVersionIdMarker: try! node.nodes(forXPath: "NextVersionIdMarker").first.map { String.deserialize(response: response, body: .xml($0)) },
      prefix: try! node.nodes(forXPath: "Prefix").first.map { String.deserialize(response: response, body: .xml($0)) },
      versionIdMarker: try! node.nodes(forXPath: "VersionIdMarker").first.map { String.deserialize(response: response, body: .xml($0)) },
      versions: try! node.nodes(forXPath: "Version").map { ObjectVersion.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - commonPrefixes: 
      - deleteMarkers: 
      - delimiter: 
      - encodingType: Encoding type used by Amazon S3 to encode object keys in the response.
      - isTruncated: A flag that indicates whether or not Amazon S3 returned all of the results that satisfied the search criteria. If your results were truncated, you can make a follow-up paginated request using the NextKeyMarker and NextVersionIdMarker response parameters as a starting place in another request to return the rest of the results.
      - keyMarker: Marks the last Key returned in a truncated response.
      - maxKeys: 
      - name: 
      - nextKeyMarker: Use this value for the key marker request parameter in a subsequent request.
      - nextVersionIdMarker: Use this value for the next version id marker parameter in a subsequent request.
      - prefix: 
      - versionIdMarker: 
      - versions: 
 */
  public init(commonPrefixes: [CommonPrefix]?, deleteMarkers: [DeleteMarkerEntry]?, delimiter: String?, encodingType: Encodingtype?, isTruncated: Bool?, keyMarker: String?, maxKeys: Int?, name: String?, nextKeyMarker: String?, nextVersionIdMarker: String?, prefix: String?, versionIdMarker: String?, versions: [ObjectVersion]?) {
self.commonPrefixes = commonPrefixes
self.deleteMarkers = deleteMarkers
self.delimiter = delimiter
self.encodingType = encodingType
self.isTruncated = isTruncated
self.keyMarker = keyMarker
self.maxKeys = maxKeys
self.name = name
self.nextKeyMarker = nextKeyMarker
self.nextVersionIdMarker = nextVersionIdMarker
self.prefix = prefix
self.versionIdMarker = versionIdMarker
self.versions = versions
  }
}

public struct ListObjectVersionsRequest: AwswiftSerializable {
/**

 */
  public let bucket: String
/**
A delimiter is a character you use to group keys.
 */
  public let delimiter: String?
/**

 */
  public let encodingType: Encodingtype?
/**
Specifies the key to start with when listing objects in a bucket.
 */
  public let keyMarker: String?
/**
Sets the maximum number of keys returned in the response. The response might contain fewer keys but will never contain more.
 */
  public let maxKeys: Int?
/**
Limits the response to keys that begin with the specified prefix.
 */
  public let prefix: String?
/**
Specifies the object version you want to start listing from.
 */
  public let versionIdMarker: String?

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    var querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
    uri["Bucket"] = "\(bucket)"
    if delimiter != nil { querystring["delimiter"] = "\(delimiter!)" }
    if encodingType != nil { querystring["encoding-type"] = "\(encodingType!)" }
    if keyMarker != nil { querystring["key-marker"] = "\(keyMarker!)" }
    if maxKeys != nil { querystring["max-keys"] = "\(maxKeys!)" }
    if prefix != nil { querystring["prefix"] = "\(prefix!)" }
    if versionIdMarker != nil { querystring["version-id-marker"] = "\(versionIdMarker!)" }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - bucket: 
      - delimiter: A delimiter is a character you use to group keys.
      - encodingType: 
      - keyMarker: Specifies the key to start with when listing objects in a bucket.
      - maxKeys: Sets the maximum number of keys returned in the response. The response might contain fewer keys but will never contain more.
      - prefix: Limits the response to keys that begin with the specified prefix.
      - versionIdMarker: Specifies the object version you want to start listing from.
 */
  public init(bucket: String, delimiter: String?, encodingType: Encodingtype?, keyMarker: String?, maxKeys: Int?, prefix: String?, versionIdMarker: String?) {
self.bucket = bucket
self.delimiter = delimiter
self.encodingType = encodingType
self.keyMarker = keyMarker
self.maxKeys = maxKeys
self.prefix = prefix
self.versionIdMarker = versionIdMarker
  }
}

public struct ListObjectsOutput: AwswiftDeserializable {
/**

 */
  public let commonPrefixes: [CommonPrefix]?
/**

 */
  public let contents: [Object]?
/**

 */
  public let delimiter: String?
/**
Encoding type used by Amazon S3 to encode object keys in the response.
 */
  public let encodingType: Encodingtype?
/**
A flag that indicates whether or not Amazon S3 returned all of the results that satisfied the search criteria.
 */
  public let isTruncated: Bool?
/**

 */
  public let marker: String?
/**

 */
  public let maxKeys: Int?
/**

 */
  public let name: String?
/**
When response is truncated (the IsTruncated element value in the response is true), you can use the key name in this field as marker in the subsequent request to get next set of objects. Amazon S3 lists objects in alphabetical order Note: This element is returned only if you have delimiter request parameter specified. If response does not include the NextMaker and it is truncated, you can use the value of the last Key in the response as the marker in the subsequent request to get the next set of object keys.
 */
  public let nextMarker: String?
/**

 */
  public let prefix: String?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> ListObjectsOutput {
    guard case let .xml(node) = body else { fatalError() }
    return ListObjectsOutput(
        commonPrefixes: try! node.nodes(forXPath: "CommonPrefixes").map { CommonPrefix.deserialize(response: response, body: .xml($0)) },
      contents: try! node.nodes(forXPath: "Contents").map { Object.deserialize(response: response, body: .xml($0)) },
      delimiter: try! node.nodes(forXPath: "Delimiter").first.map { String.deserialize(response: response, body: .xml($0)) },
      encodingType: try! node.nodes(forXPath: "EncodingType").first.map { Encodingtype.deserialize(response: response, body: .xml($0)) },
      isTruncated: try! node.nodes(forXPath: "IsTruncated").first.map { Bool.deserialize(response: response, body: .xml($0)) },
      marker: try! node.nodes(forXPath: "Marker").first.map { String.deserialize(response: response, body: .xml($0)) },
      maxKeys: try! node.nodes(forXPath: "MaxKeys").first.map { Int.deserialize(response: response, body: .xml($0)) },
      name: try! node.nodes(forXPath: "Name").first.map { String.deserialize(response: response, body: .xml($0)) },
      nextMarker: try! node.nodes(forXPath: "NextMarker").first.map { String.deserialize(response: response, body: .xml($0)) },
      prefix: try! node.nodes(forXPath: "Prefix").first.map { String.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - commonPrefixes: 
      - contents: 
      - delimiter: 
      - encodingType: Encoding type used by Amazon S3 to encode object keys in the response.
      - isTruncated: A flag that indicates whether or not Amazon S3 returned all of the results that satisfied the search criteria.
      - marker: 
      - maxKeys: 
      - name: 
      - nextMarker: When response is truncated (the IsTruncated element value in the response is true), you can use the key name in this field as marker in the subsequent request to get next set of objects. Amazon S3 lists objects in alphabetical order Note: This element is returned only if you have delimiter request parameter specified. If response does not include the NextMaker and it is truncated, you can use the value of the last Key in the response as the marker in the subsequent request to get the next set of object keys.
      - prefix: 
 */
  public init(commonPrefixes: [CommonPrefix]?, contents: [Object]?, delimiter: String?, encodingType: Encodingtype?, isTruncated: Bool?, marker: String?, maxKeys: Int?, name: String?, nextMarker: String?, prefix: String?) {
self.commonPrefixes = commonPrefixes
self.contents = contents
self.delimiter = delimiter
self.encodingType = encodingType
self.isTruncated = isTruncated
self.marker = marker
self.maxKeys = maxKeys
self.name = name
self.nextMarker = nextMarker
self.prefix = prefix
  }
}

public struct ListObjectsRequest: AwswiftSerializable {
/**

 */
  public let bucket: String
/**
A delimiter is a character you use to group keys.
 */
  public let delimiter: String?
/**

 */
  public let encodingType: Encodingtype?
/**
Specifies the key to start with when listing objects in a bucket.
 */
  public let marker: String?
/**
Sets the maximum number of keys returned in the response. The response might contain fewer keys but will never contain more.
 */
  public let maxKeys: Int?
/**
Limits the response to keys that begin with the specified prefix.
 */
  public let prefix: String?
/**
Confirms that the requester knows that she or he will be charged for the list objects request. Bucket owners need not specify this parameter in their requests.
 */
  public let requestPayer: Requestpayer?

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    var querystring: [String: String] = [:]
    var header: [String: String] = [:]
    
  
    uri["Bucket"] = "\(bucket)"
    if delimiter != nil { querystring["delimiter"] = "\(delimiter!)" }
    if encodingType != nil { querystring["encoding-type"] = "\(encodingType!)" }
    if marker != nil { querystring["marker"] = "\(marker!)" }
    if maxKeys != nil { querystring["max-keys"] = "\(maxKeys!)" }
    if prefix != nil { querystring["prefix"] = "\(prefix!)" }
    if requestPayer != nil { header["x-amz-request-payer"] = "\(requestPayer!)" }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - bucket: 
      - delimiter: A delimiter is a character you use to group keys.
      - encodingType: 
      - marker: Specifies the key to start with when listing objects in a bucket.
      - maxKeys: Sets the maximum number of keys returned in the response. The response might contain fewer keys but will never contain more.
      - prefix: Limits the response to keys that begin with the specified prefix.
      - requestPayer: Confirms that the requester knows that she or he will be charged for the list objects request. Bucket owners need not specify this parameter in their requests.
 */
  public init(bucket: String, delimiter: String?, encodingType: Encodingtype?, marker: String?, maxKeys: Int?, prefix: String?, requestPayer: Requestpayer?) {
self.bucket = bucket
self.delimiter = delimiter
self.encodingType = encodingType
self.marker = marker
self.maxKeys = maxKeys
self.prefix = prefix
self.requestPayer = requestPayer
  }
}

public struct ListObjectsV2Output: AwswiftDeserializable {
/**
CommonPrefixes contains all (if there are any) keys between Prefix and the next occurrence of the string specified by delimiter
 */
  public let commonPrefixes: [CommonPrefix]?
/**
Metadata about each object returned.
 */
  public let contents: [Object]?
/**
ContinuationToken indicates Amazon S3 that the list is being continued on this bucket with a token. ContinuationToken is obfuscated and is not a real key
 */
  public let continuationToken: String?
/**
A delimiter is a character you use to group keys.
 */
  public let delimiter: String?
/**
Encoding type used by Amazon S3 to encode object keys in the response.
 */
  public let encodingType: Encodingtype?
/**
A flag that indicates whether or not Amazon S3 returned all of the results that satisfied the search criteria.
 */
  public let isTruncated: Bool?
/**
KeyCount is the number of keys returned with this request. KeyCount will always be less than equals to MaxKeys field. Say you ask for 50 keys, your result will include less than equals 50 keys
 */
  public let keyCount: Int?
/**
Sets the maximum number of keys returned in the response. The response might contain fewer keys but will never contain more.
 */
  public let maxKeys: Int?
/**
Name of the bucket to list.
 */
  public let name: String?
/**
NextContinuationToken is sent when isTruncated is true which means there are more keys in the bucket that can be listed. The next list requests to Amazon S3 can be continued with this NextContinuationToken. NextContinuationToken is obfuscated and is not a real key
 */
  public let nextContinuationToken: String?
/**
Limits the response to keys that begin with the specified prefix.
 */
  public let prefix: String?
/**
StartAfter is where you want Amazon S3 to start listing from. Amazon S3 starts listing after this specified key. StartAfter can be any key in the bucket
 */
  public let startAfter: String?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> ListObjectsV2Output {
    guard case let .xml(node) = body else { fatalError() }
    return ListObjectsV2Output(
        commonPrefixes: try! node.nodes(forXPath: "CommonPrefixes").map { CommonPrefix.deserialize(response: response, body: .xml($0)) },
      contents: try! node.nodes(forXPath: "Contents").map { Object.deserialize(response: response, body: .xml($0)) },
      continuationToken: try! node.nodes(forXPath: "ContinuationToken").first.map { String.deserialize(response: response, body: .xml($0)) },
      delimiter: try! node.nodes(forXPath: "Delimiter").first.map { String.deserialize(response: response, body: .xml($0)) },
      encodingType: try! node.nodes(forXPath: "EncodingType").first.map { Encodingtype.deserialize(response: response, body: .xml($0)) },
      isTruncated: try! node.nodes(forXPath: "IsTruncated").first.map { Bool.deserialize(response: response, body: .xml($0)) },
      keyCount: try! node.nodes(forXPath: "KeyCount").first.map { Int.deserialize(response: response, body: .xml($0)) },
      maxKeys: try! node.nodes(forXPath: "MaxKeys").first.map { Int.deserialize(response: response, body: .xml($0)) },
      name: try! node.nodes(forXPath: "Name").first.map { String.deserialize(response: response, body: .xml($0)) },
      nextContinuationToken: try! node.nodes(forXPath: "NextContinuationToken").first.map { String.deserialize(response: response, body: .xml($0)) },
      prefix: try! node.nodes(forXPath: "Prefix").first.map { String.deserialize(response: response, body: .xml($0)) },
      startAfter: try! node.nodes(forXPath: "StartAfter").first.map { String.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - commonPrefixes: CommonPrefixes contains all (if there are any) keys between Prefix and the next occurrence of the string specified by delimiter
      - contents: Metadata about each object returned.
      - continuationToken: ContinuationToken indicates Amazon S3 that the list is being continued on this bucket with a token. ContinuationToken is obfuscated and is not a real key
      - delimiter: A delimiter is a character you use to group keys.
      - encodingType: Encoding type used by Amazon S3 to encode object keys in the response.
      - isTruncated: A flag that indicates whether or not Amazon S3 returned all of the results that satisfied the search criteria.
      - keyCount: KeyCount is the number of keys returned with this request. KeyCount will always be less than equals to MaxKeys field. Say you ask for 50 keys, your result will include less than equals 50 keys
      - maxKeys: Sets the maximum number of keys returned in the response. The response might contain fewer keys but will never contain more.
      - name: Name of the bucket to list.
      - nextContinuationToken: NextContinuationToken is sent when isTruncated is true which means there are more keys in the bucket that can be listed. The next list requests to Amazon S3 can be continued with this NextContinuationToken. NextContinuationToken is obfuscated and is not a real key
      - prefix: Limits the response to keys that begin with the specified prefix.
      - startAfter: StartAfter is where you want Amazon S3 to start listing from. Amazon S3 starts listing after this specified key. StartAfter can be any key in the bucket
 */
  public init(commonPrefixes: [CommonPrefix]?, contents: [Object]?, continuationToken: String?, delimiter: String?, encodingType: Encodingtype?, isTruncated: Bool?, keyCount: Int?, maxKeys: Int?, name: String?, nextContinuationToken: String?, prefix: String?, startAfter: String?) {
self.commonPrefixes = commonPrefixes
self.contents = contents
self.continuationToken = continuationToken
self.delimiter = delimiter
self.encodingType = encodingType
self.isTruncated = isTruncated
self.keyCount = keyCount
self.maxKeys = maxKeys
self.name = name
self.nextContinuationToken = nextContinuationToken
self.prefix = prefix
self.startAfter = startAfter
  }
}

public struct ListObjectsV2Request: AwswiftSerializable {
/**
Name of the bucket to list.
 */
  public let bucket: String
/**
ContinuationToken indicates Amazon S3 that the list is being continued on this bucket with a token. ContinuationToken is obfuscated and is not a real key
 */
  public let continuationToken: String?
/**
A delimiter is a character you use to group keys.
 */
  public let delimiter: String?
/**
Encoding type used by Amazon S3 to encode object keys in the response.
 */
  public let encodingType: Encodingtype?
/**
The owner field is not present in listV2 by default, if you want to return owner field with each key in the result then set the fetch owner field to true
 */
  public let fetchOwner: Bool?
/**
Sets the maximum number of keys returned in the response. The response might contain fewer keys but will never contain more.
 */
  public let maxKeys: Int?
/**
Limits the response to keys that begin with the specified prefix.
 */
  public let prefix: String?
/**
Confirms that the requester knows that she or he will be charged for the list objects request in V2 style. Bucket owners need not specify this parameter in their requests.
 */
  public let requestPayer: Requestpayer?
/**
StartAfter is where you want Amazon S3 to start listing from. Amazon S3 starts listing after this specified key. StartAfter can be any key in the bucket
 */
  public let startAfter: String?

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    var querystring: [String: String] = [:]
    var header: [String: String] = [:]
    
  
    uri["Bucket"] = "\(bucket)"
    if continuationToken != nil { querystring["continuation-token"] = "\(continuationToken!)" }
    if delimiter != nil { querystring["delimiter"] = "\(delimiter!)" }
    if encodingType != nil { querystring["encoding-type"] = "\(encodingType!)" }
    if fetchOwner != nil { querystring["fetch-owner"] = "\(fetchOwner!)" }
    if maxKeys != nil { querystring["max-keys"] = "\(maxKeys!)" }
    if prefix != nil { querystring["prefix"] = "\(prefix!)" }
    if startAfter != nil { querystring["start-after"] = "\(startAfter!)" }
    if requestPayer != nil { header["x-amz-request-payer"] = "\(requestPayer!)" }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - bucket: Name of the bucket to list.
      - continuationToken: ContinuationToken indicates Amazon S3 that the list is being continued on this bucket with a token. ContinuationToken is obfuscated and is not a real key
      - delimiter: A delimiter is a character you use to group keys.
      - encodingType: Encoding type used by Amazon S3 to encode object keys in the response.
      - fetchOwner: The owner field is not present in listV2 by default, if you want to return owner field with each key in the result then set the fetch owner field to true
      - maxKeys: Sets the maximum number of keys returned in the response. The response might contain fewer keys but will never contain more.
      - prefix: Limits the response to keys that begin with the specified prefix.
      - requestPayer: Confirms that the requester knows that she or he will be charged for the list objects request in V2 style. Bucket owners need not specify this parameter in their requests.
      - startAfter: StartAfter is where you want Amazon S3 to start listing from. Amazon S3 starts listing after this specified key. StartAfter can be any key in the bucket
 */
  public init(bucket: String, continuationToken: String?, delimiter: String?, encodingType: Encodingtype?, fetchOwner: Bool?, maxKeys: Int?, prefix: String?, requestPayer: Requestpayer?, startAfter: String?) {
self.bucket = bucket
self.continuationToken = continuationToken
self.delimiter = delimiter
self.encodingType = encodingType
self.fetchOwner = fetchOwner
self.maxKeys = maxKeys
self.prefix = prefix
self.requestPayer = requestPayer
self.startAfter = startAfter
  }
}

public struct ListPartsOutput: AwswiftDeserializable {
/**
Date when multipart upload will become eligible for abort operation by lifecycle.
 */
  public let abortDate: Date?
/**
Id of the lifecycle rule that makes a multipart upload eligible for abort operation.
 */
  public let abortRuleId: String?
/**
Name of the bucket to which the multipart upload was initiated.
 */
  public let bucket: String?
/**
Identifies who initiated the multipart upload.
 */
  public let initiator: Initiator?
/**
Indicates whether the returned list of parts is truncated.
 */
  public let isTruncated: Bool?
/**
Object key for which the multipart upload was initiated.
 */
  public let key: String?
/**
Maximum number of parts that were allowed in the response.
 */
  public let maxParts: Int?
/**
When a list is truncated, this element specifies the last part in the list, as well as the value to use for the part-number-marker request parameter in a subsequent request.
 */
  public let nextPartNumberMarker: Int?
/**

 */
  public let owner: Owner?
/**
Part number after which listing begins.
 */
  public let partNumberMarker: Int?
/**

 */
  public let parts: [Part]?
/**

 */
  public let requestCharged: Requestcharged?
/**
The class of storage used to store the object.
 */
  public let storageClass: Storageclass?
/**
Upload ID identifying the multipart upload whose parts are being listed.
 */
  public let uploadId: String?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> ListPartsOutput {
    guard case let .xml(node) = body else { fatalError() }
    return ListPartsOutput(
        abortDate: response.allHeaderFields["x-amz-abort-date"].flatMap { ($0 is NSNull) ? nil : Date.deserialize(response: response, body: .json($0)) },
      abortRuleId: response.allHeaderFields["x-amz-abort-rule-id"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      bucket: try! node.nodes(forXPath: "Bucket").first.map { String.deserialize(response: response, body: .xml($0)) },
      initiator: try! node.nodes(forXPath: "Initiator").first.map { Initiator.deserialize(response: response, body: .xml($0)) },
      isTruncated: try! node.nodes(forXPath: "IsTruncated").first.map { Bool.deserialize(response: response, body: .xml($0)) },
      key: try! node.nodes(forXPath: "Key").first.map { String.deserialize(response: response, body: .xml($0)) },
      maxParts: try! node.nodes(forXPath: "MaxParts").first.map { Int.deserialize(response: response, body: .xml($0)) },
      nextPartNumberMarker: try! node.nodes(forXPath: "NextPartNumberMarker").first.map { Int.deserialize(response: response, body: .xml($0)) },
      owner: try! node.nodes(forXPath: "Owner").first.map { Owner.deserialize(response: response, body: .xml($0)) },
      partNumberMarker: try! node.nodes(forXPath: "PartNumberMarker").first.map { Int.deserialize(response: response, body: .xml($0)) },
      parts: try! node.nodes(forXPath: "Part").map { Part.deserialize(response: response, body: .xml($0)) },
      requestCharged: response.allHeaderFields["x-amz-request-charged"].flatMap { ($0 is NSNull) ? nil : Requestcharged.deserialize(response: response, body: .json($0)) },
      storageClass: try! node.nodes(forXPath: "StorageClass").first.map { Storageclass.deserialize(response: response, body: .xml($0)) },
      uploadId: try! node.nodes(forXPath: "UploadId").first.map { String.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - abortDate: Date when multipart upload will become eligible for abort operation by lifecycle.
      - abortRuleId: Id of the lifecycle rule that makes a multipart upload eligible for abort operation.
      - bucket: Name of the bucket to which the multipart upload was initiated.
      - initiator: Identifies who initiated the multipart upload.
      - isTruncated: Indicates whether the returned list of parts is truncated.
      - key: Object key for which the multipart upload was initiated.
      - maxParts: Maximum number of parts that were allowed in the response.
      - nextPartNumberMarker: When a list is truncated, this element specifies the last part in the list, as well as the value to use for the part-number-marker request parameter in a subsequent request.
      - owner: 
      - partNumberMarker: Part number after which listing begins.
      - parts: 
      - requestCharged: 
      - storageClass: The class of storage used to store the object.
      - uploadId: Upload ID identifying the multipart upload whose parts are being listed.
 */
  public init(abortDate: Date?, abortRuleId: String?, bucket: String?, initiator: Initiator?, isTruncated: Bool?, key: String?, maxParts: Int?, nextPartNumberMarker: Int?, owner: Owner?, partNumberMarker: Int?, parts: [Part]?, requestCharged: Requestcharged?, storageClass: Storageclass?, uploadId: String?) {
self.abortDate = abortDate
self.abortRuleId = abortRuleId
self.bucket = bucket
self.initiator = initiator
self.isTruncated = isTruncated
self.key = key
self.maxParts = maxParts
self.nextPartNumberMarker = nextPartNumberMarker
self.owner = owner
self.partNumberMarker = partNumberMarker
self.parts = parts
self.requestCharged = requestCharged
self.storageClass = storageClass
self.uploadId = uploadId
  }
}

public struct ListPartsRequest: AwswiftSerializable {
/**

 */
  public let bucket: String
/**

 */
  public let key: String
/**
Sets the maximum number of parts to return.
 */
  public let maxParts: Int?
/**
Specifies the part after which listing should begin. Only parts with higher part numbers will be listed.
 */
  public let partNumberMarker: Int?
/**

 */
  public let requestPayer: Requestpayer?
/**
Upload ID identifying the multipart upload whose parts are being listed.
 */
  public let uploadId: String

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    var querystring: [String: String] = [:]
    var header: [String: String] = [:]
    
  
    uri["Bucket"] = "\(bucket)"
    uri["Key"] = "\(key)"
    if maxParts != nil { querystring["max-parts"] = "\(maxParts!)" }
    if partNumberMarker != nil { querystring["part-number-marker"] = "\(partNumberMarker!)" }
    querystring["uploadId"] = "\(uploadId)"
    if requestPayer != nil { header["x-amz-request-payer"] = "\(requestPayer!)" }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - bucket: 
      - key: 
      - maxParts: Sets the maximum number of parts to return.
      - partNumberMarker: Specifies the part after which listing should begin. Only parts with higher part numbers will be listed.
      - requestPayer: 
      - uploadId: Upload ID identifying the multipart upload whose parts are being listed.
 */
  public init(bucket: String, key: String, maxParts: Int?, partNumberMarker: Int?, requestPayer: Requestpayer?, uploadId: String) {
self.bucket = bucket
self.key = key
self.maxParts = maxParts
self.partNumberMarker = partNumberMarker
self.requestPayer = requestPayer
self.uploadId = uploadId
  }
}


public struct LoggingEnabled: AwswiftSerializable, AwswiftDeserializable {
/**
Specifies the bucket where you want Amazon S3 to store server access logs. You can have your logs delivered to any bucket that you own, including the same bucket that is being logged. You can also configure multiple buckets to deliver their logs to the same target bucket. In this case you should choose a different TargetPrefix for each source bucket so that the delivered log files can be distinguished by key.
 */
  public let targetBucket: String?
/**

 */
  public let targetGrants: [TargetGrant]?
/**
This element lets you specify a prefix for the keys that the log files will be stored under.
 */
  public let targetPrefix: String?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if targetBucket != nil { body["TargetBucket"] = targetBucket! }
    if targetGrants != nil { body["TargetGrants"] = targetGrants! }
    if targetPrefix != nil { body["TargetPrefix"] = targetPrefix! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> LoggingEnabled {
    guard case let .xml(node) = body else { fatalError() }
    return LoggingEnabled(
        targetBucket: try! node.nodes(forXPath: "TargetBucket").first.map { String.deserialize(response: response, body: .xml($0)) },
      targetGrants: try! node.nodes(forXPath: "TargetGrants").map { TargetGrant.deserialize(response: response, body: .xml($0)) },
      targetPrefix: try! node.nodes(forXPath: "TargetPrefix").first.map { String.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - targetBucket: Specifies the bucket where you want Amazon S3 to store server access logs. You can have your logs delivered to any bucket that you own, including the same bucket that is being logged. You can also configure multiple buckets to deliver their logs to the same target bucket. In this case you should choose a different TargetPrefix for each source bucket so that the delivered log files can be distinguished by key.
      - targetGrants: 
      - targetPrefix: This element lets you specify a prefix for the keys that the log files will be stored under.
 */
  public init(targetBucket: String?, targetGrants: [TargetGrant]?, targetPrefix: String?) {
self.targetBucket = targetBucket
self.targetGrants = targetGrants
self.targetPrefix = targetPrefix
  }
}


enum Mfadelete: String, AwswiftDeserializable, AwswiftSerializable {
  case `enabled` = "Enabled"
  case `disabled` = "Disabled"

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Mfadelete {
    switch body { 
    case .json(let json): return Mfadelete(rawValue: json as! String)!
    case .xml(let node): return Mfadelete(rawValue: node.stringValue!)!
    }
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}

enum Mfadeletestatus: String, AwswiftDeserializable, AwswiftSerializable {
  case `enabled` = "Enabled"
  case `disabled` = "Disabled"

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Mfadeletestatus {
    switch body { 
    case .json(let json): return Mfadeletestatus(rawValue: json as! String)!
    case .xml(let node): return Mfadeletestatus(rawValue: node.stringValue!)!
    }
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}








enum Metadatadirective: String, AwswiftDeserializable, AwswiftSerializable {
  case `cOPY` = "COPY"
  case `rEPLACE` = "REPLACE"

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Metadatadirective {
    switch body { 
    case .json(let json): return Metadatadirective(rawValue: json as! String)!
    case .xml(let node): return Metadatadirective(rawValue: node.stringValue!)!
    }
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}




public struct MultipartUpload: AwswiftSerializable, AwswiftDeserializable {
/**
Date and time at which the multipart upload was initiated.
 */
  public let initiated: Date?
/**
Identifies who initiated the multipart upload.
 */
  public let initiator: Initiator?
/**
Key of the object for which the multipart upload was initiated.
 */
  public let key: String?
/**

 */
  public let owner: Owner?
/**
The class of storage used to store the object.
 */
  public let storageClass: Storageclass?
/**
Upload ID that identifies the multipart upload.
 */
  public let uploadId: String?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if initiated != nil { body["Initiated"] = initiated! }
    if initiator != nil { body["Initiator"] = initiator! }
    if key != nil { body["Key"] = key! }
    if owner != nil { body["Owner"] = owner! }
    if storageClass != nil { body["StorageClass"] = storageClass! }
    if uploadId != nil { body["UploadId"] = uploadId! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> MultipartUpload {
    guard case let .xml(node) = body else { fatalError() }
    return MultipartUpload(
        initiated: try! node.nodes(forXPath: "Initiated").first.map { Date.deserialize(response: response, body: .xml($0)) },
      initiator: try! node.nodes(forXPath: "Initiator").first.map { Initiator.deserialize(response: response, body: .xml($0)) },
      key: try! node.nodes(forXPath: "Key").first.map { String.deserialize(response: response, body: .xml($0)) },
      owner: try! node.nodes(forXPath: "Owner").first.map { Owner.deserialize(response: response, body: .xml($0)) },
      storageClass: try! node.nodes(forXPath: "StorageClass").first.map { Storageclass.deserialize(response: response, body: .xml($0)) },
      uploadId: try! node.nodes(forXPath: "UploadId").first.map { String.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - initiated: Date and time at which the multipart upload was initiated.
      - initiator: Identifies who initiated the multipart upload.
      - key: Key of the object for which the multipart upload was initiated.
      - owner: 
      - storageClass: The class of storage used to store the object.
      - uploadId: Upload ID that identifies the multipart upload.
 */
  public init(initiated: Date?, initiator: Initiator?, key: String?, owner: Owner?, storageClass: Storageclass?, uploadId: String?) {
self.initiated = initiated
self.initiator = initiator
self.key = key
self.owner = owner
self.storageClass = storageClass
self.uploadId = uploadId
  }
}









/**
The specified bucket does not exist.
 */
public struct NoSuchBucket: AwswiftSerializable, AwswiftDeserializable {

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    fatalError()
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> NoSuchBucket {
  
    return NoSuchBucket(
  
    )
  }

/**
    - parameters:
 */
  public init() {
  }
}

/**
The specified key does not exist.
 */
public struct NoSuchKey: AwswiftSerializable, AwswiftDeserializable {

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    fatalError()
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> NoSuchKey {
  
    return NoSuchKey(
  
    )
  }

/**
    - parameters:
 */
  public init() {
  }
}

/**
The specified multipart upload does not exist.
 */
public struct NoSuchUpload: AwswiftSerializable, AwswiftDeserializable {

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    fatalError()
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> NoSuchUpload {
  
    return NoSuchUpload(
  
    )
  }

/**
    - parameters:
 */
  public init() {
  }
}

/**
Specifies when noncurrent object versions expire. Upon expiration, Amazon S3 permanently deletes the noncurrent object versions. You set this lifecycle configuration action on a bucket that has versioning enabled (or suspended) to request that Amazon S3 delete noncurrent object versions at a specific period in the object's lifetime.
 */
public struct NoncurrentVersionExpiration: AwswiftSerializable, AwswiftDeserializable {
/**
Specifies the number of days an object is noncurrent before Amazon S3 can perform the associated action. For information about the noncurrent days calculations, see <a href="http://docs.aws.amazon.com/AmazonS3/latest/dev/s3-access-control.html">How Amazon S3 Calculates When an Object Became Noncurrent</a> in the Amazon Simple Storage Service Developer Guide.
 */
  public let noncurrentDays: Int?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if noncurrentDays != nil { body["NoncurrentDays"] = noncurrentDays! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> NoncurrentVersionExpiration {
    guard case let .xml(node) = body else { fatalError() }
    return NoncurrentVersionExpiration(
        noncurrentDays: try! node.nodes(forXPath: "NoncurrentDays").first.map { Int.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - noncurrentDays: Specifies the number of days an object is noncurrent before Amazon S3 can perform the associated action. For information about the noncurrent days calculations, see <a href="http://docs.aws.amazon.com/AmazonS3/latest/dev/s3-access-control.html">How Amazon S3 Calculates When an Object Became Noncurrent</a> in the Amazon Simple Storage Service Developer Guide.
 */
  public init(noncurrentDays: Int?) {
self.noncurrentDays = noncurrentDays
  }
}

/**
Container for the transition rule that describes when noncurrent objects transition to the STANDARD_IA or GLACIER storage class. If your bucket is versioning-enabled (or versioning is suspended), you can set this action to request that Amazon S3 transition noncurrent object versions to the STANDARD_IA or GLACIER storage class at a specific period in the object's lifetime.
 */
public struct NoncurrentVersionTransition: AwswiftSerializable, AwswiftDeserializable {
/**
Specifies the number of days an object is noncurrent before Amazon S3 can perform the associated action. For information about the noncurrent days calculations, see <a href="http://docs.aws.amazon.com/AmazonS3/latest/dev/s3-access-control.html">How Amazon S3 Calculates When an Object Became Noncurrent</a> in the Amazon Simple Storage Service Developer Guide.
 */
  public let noncurrentDays: Int?
/**
The class of storage used to store the object.
 */
  public let storageClass: Transitionstorageclass?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if noncurrentDays != nil { body["NoncurrentDays"] = noncurrentDays! }
    if storageClass != nil { body["StorageClass"] = storageClass! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> NoncurrentVersionTransition {
    guard case let .xml(node) = body else { fatalError() }
    return NoncurrentVersionTransition(
        noncurrentDays: try! node.nodes(forXPath: "NoncurrentDays").first.map { Int.deserialize(response: response, body: .xml($0)) },
      storageClass: try! node.nodes(forXPath: "StorageClass").first.map { Transitionstorageclass.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - noncurrentDays: Specifies the number of days an object is noncurrent before Amazon S3 can perform the associated action. For information about the noncurrent days calculations, see <a href="http://docs.aws.amazon.com/AmazonS3/latest/dev/s3-access-control.html">How Amazon S3 Calculates When an Object Became Noncurrent</a> in the Amazon Simple Storage Service Developer Guide.
      - storageClass: The class of storage used to store the object.
 */
  public init(noncurrentDays: Int?, storageClass: Transitionstorageclass?) {
self.noncurrentDays = noncurrentDays
self.storageClass = storageClass
  }
}


/**
Container for specifying the notification configuration of the bucket. If this element is empty, notifications are turned off on the bucket.
 */
public struct NotificationConfiguration: AwswiftSerializable, AwswiftDeserializable {
/**

 */
  public let lambdaFunctionConfigurations: [LambdaFunctionConfiguration]?
/**

 */
  public let queueConfigurations: [QueueConfiguration]?
/**

 */
  public let topicConfigurations: [TopicConfiguration]?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if lambdaFunctionConfigurations != nil { body["CloudFunctionConfiguration"] = lambdaFunctionConfigurations! }
    if queueConfigurations != nil { body["QueueConfiguration"] = queueConfigurations! }
    if topicConfigurations != nil { body["TopicConfiguration"] = topicConfigurations! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> NotificationConfiguration {
    guard case let .xml(node) = body else { fatalError() }
    return NotificationConfiguration(
        lambdaFunctionConfigurations: try! node.nodes(forXPath: "CloudFunctionConfiguration").map { LambdaFunctionConfiguration.deserialize(response: response, body: .xml($0)) },
      queueConfigurations: try! node.nodes(forXPath: "QueueConfiguration").map { QueueConfiguration.deserialize(response: response, body: .xml($0)) },
      topicConfigurations: try! node.nodes(forXPath: "TopicConfiguration").map { TopicConfiguration.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - lambdaFunctionConfigurations: 
      - queueConfigurations: 
      - topicConfigurations: 
 */
  public init(lambdaFunctionConfigurations: [LambdaFunctionConfiguration]?, queueConfigurations: [QueueConfiguration]?, topicConfigurations: [TopicConfiguration]?) {
self.lambdaFunctionConfigurations = lambdaFunctionConfigurations
self.queueConfigurations = queueConfigurations
self.topicConfigurations = topicConfigurations
  }
}

public struct NotificationConfigurationDeprecated: AwswiftSerializable, AwswiftDeserializable {
/**

 */
  public let cloudFunctionConfiguration: CloudFunctionConfiguration?
/**

 */
  public let queueConfiguration: QueueConfigurationDeprecated?
/**

 */
  public let topicConfiguration: TopicConfigurationDeprecated?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if cloudFunctionConfiguration != nil { body["CloudFunctionConfiguration"] = cloudFunctionConfiguration! }
    if queueConfiguration != nil { body["QueueConfiguration"] = queueConfiguration! }
    if topicConfiguration != nil { body["TopicConfiguration"] = topicConfiguration! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> NotificationConfigurationDeprecated {
    guard case let .xml(node) = body else { fatalError() }
    return NotificationConfigurationDeprecated(
        cloudFunctionConfiguration: try! node.nodes(forXPath: "CloudFunctionConfiguration").first.map { CloudFunctionConfiguration.deserialize(response: response, body: .xml($0)) },
      queueConfiguration: try! node.nodes(forXPath: "QueueConfiguration").first.map { QueueConfigurationDeprecated.deserialize(response: response, body: .xml($0)) },
      topicConfiguration: try! node.nodes(forXPath: "TopicConfiguration").first.map { TopicConfigurationDeprecated.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - cloudFunctionConfiguration: 
      - queueConfiguration: 
      - topicConfiguration: 
 */
  public init(cloudFunctionConfiguration: CloudFunctionConfiguration?, queueConfiguration: QueueConfigurationDeprecated?, topicConfiguration: TopicConfigurationDeprecated?) {
self.cloudFunctionConfiguration = cloudFunctionConfiguration
self.queueConfiguration = queueConfiguration
self.topicConfiguration = topicConfiguration
  }
}

/**
Container for object key name filtering rules. For information about key name filtering, go to <a href="http://docs.aws.amazon.com/AmazonS3/latest/dev/NotificationHowTo.html">Configuring Event Notifications</a> in the Amazon Simple Storage Service Developer Guide.
 */
public struct NotificationConfigurationFilter: AwswiftSerializable, AwswiftDeserializable {
/**

 */
  public let key: S3KeyFilter?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if key != nil { body["S3Key"] = key! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> NotificationConfigurationFilter {
    guard case let .xml(node) = body else { fatalError() }
    return NotificationConfigurationFilter(
        key: try! node.nodes(forXPath: "S3Key").first.map { S3KeyFilter.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - key: 
 */
  public init(key: S3KeyFilter?) {
self.key = key
  }
}

/**
Optional unique identifier for configurations in a notification configuration. If you don't provide one, Amazon S3 will assign an ID.
 */

public struct Object: AwswiftSerializable, AwswiftDeserializable {
/**

 */
  public let eTag: String?
/**

 */
  public let key: String?
/**

 */
  public let lastModified: Date?
/**

 */
  public let owner: Owner?
/**

 */
  public let size: Int?
/**
The class of storage used to store the object.
 */
  public let storageClass: Objectstorageclass?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if eTag != nil { body["ETag"] = eTag! }
    if key != nil { body["Key"] = key! }
    if lastModified != nil { body["LastModified"] = lastModified! }
    if owner != nil { body["Owner"] = owner! }
    if size != nil { body["Size"] = size! }
    if storageClass != nil { body["StorageClass"] = storageClass! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Object {
    guard case let .xml(node) = body else { fatalError() }
    return Object(
        eTag: try! node.nodes(forXPath: "ETag").first.map { String.deserialize(response: response, body: .xml($0)) },
      key: try! node.nodes(forXPath: "Key").first.map { String.deserialize(response: response, body: .xml($0)) },
      lastModified: try! node.nodes(forXPath: "LastModified").first.map { Date.deserialize(response: response, body: .xml($0)) },
      owner: try! node.nodes(forXPath: "Owner").first.map { Owner.deserialize(response: response, body: .xml($0)) },
      size: try! node.nodes(forXPath: "Size").first.map { Int.deserialize(response: response, body: .xml($0)) },
      storageClass: try! node.nodes(forXPath: "StorageClass").first.map { Objectstorageclass.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - eTag: 
      - key: 
      - lastModified: 
      - owner: 
      - size: 
      - storageClass: The class of storage used to store the object.
 */
  public init(eTag: String?, key: String?, lastModified: Date?, owner: Owner?, size: Int?, storageClass: Objectstorageclass?) {
self.eTag = eTag
self.key = key
self.lastModified = lastModified
self.owner = owner
self.size = size
self.storageClass = storageClass
  }
}

/**
This operation is not allowed against this storage tier
 */
public struct ObjectAlreadyInActiveTierError: AwswiftSerializable, AwswiftDeserializable {

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    fatalError()
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> ObjectAlreadyInActiveTierError {
  
    return ObjectAlreadyInActiveTierError(
  
    )
  }

/**
    - parameters:
 */
  public init() {
  }
}

enum Objectcannedacl: String, AwswiftDeserializable, AwswiftSerializable {
  case `private` = "private"
  case `publicread` = "public-read"
  case `publicreadwrite` = "public-read-write"
  case `authenticatedread` = "authenticated-read"
  case `awsexecread` = "aws-exec-read"
  case `bucketownerread` = "bucket-owner-read"
  case `bucketownerfullcontrol` = "bucket-owner-full-control"

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Objectcannedacl {
    switch body { 
    case .json(let json): return Objectcannedacl(rawValue: json as! String)!
    case .xml(let node): return Objectcannedacl(rawValue: node.stringValue!)!
    }
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}

public struct ObjectIdentifier: AwswiftSerializable, AwswiftDeserializable {
/**
Key name of the object to delete.
 */
  public let key: String
/**
VersionId for the specific version of the object to delete.
 */
  public let versionId: String?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["Key"] = key
    if versionId != nil { body["VersionId"] = versionId! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> ObjectIdentifier {
    guard case let .xml(node) = body else { fatalError() }
    return ObjectIdentifier(
        key: try! node.nodes(forXPath: "Key").first.map { String.deserialize(response: response, body: .xml($0)) }!,
      versionId: try! node.nodes(forXPath: "VersionId").first.map { String.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - key: Key name of the object to delete.
      - versionId: VersionId for the specific version of the object to delete.
 */
  public init(key: String, versionId: String?) {
self.key = key
self.versionId = versionId
  }
}




/**
The source object of the COPY operation is not in the active tier and is only stored in Amazon Glacier.
 */
public struct ObjectNotInActiveTierError: AwswiftSerializable, AwswiftDeserializable {

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    fatalError()
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> ObjectNotInActiveTierError {
  
    return ObjectNotInActiveTierError(
  
    )
  }

/**
    - parameters:
 */
  public init() {
  }
}

enum Objectstorageclass: String, AwswiftDeserializable, AwswiftSerializable {
  case `sTANDARD` = "STANDARD"
  case `rEDUCED_REDUNDANCY` = "REDUCED_REDUNDANCY"
  case `gLACIER` = "GLACIER"

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Objectstorageclass {
    switch body { 
    case .json(let json): return Objectstorageclass(rawValue: json as! String)!
    case .xml(let node): return Objectstorageclass(rawValue: node.stringValue!)!
    }
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}

public struct ObjectVersion: AwswiftSerializable, AwswiftDeserializable {
/**

 */
  public let eTag: String?
/**
Specifies whether the object is (true) or is not (false) the latest version of an object.
 */
  public let isLatest: Bool?
/**
The object key.
 */
  public let key: String?
/**
Date and time the object was last modified.
 */
  public let lastModified: Date?
/**

 */
  public let owner: Owner?
/**
Size in bytes of the object.
 */
  public let size: Int?
/**
The class of storage used to store the object.
 */
  public let storageClass: Objectversionstorageclass?
/**
Version ID of an object.
 */
  public let versionId: String?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if eTag != nil { body["ETag"] = eTag! }
    if isLatest != nil { body["IsLatest"] = isLatest! }
    if key != nil { body["Key"] = key! }
    if lastModified != nil { body["LastModified"] = lastModified! }
    if owner != nil { body["Owner"] = owner! }
    if size != nil { body["Size"] = size! }
    if storageClass != nil { body["StorageClass"] = storageClass! }
    if versionId != nil { body["VersionId"] = versionId! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> ObjectVersion {
    guard case let .xml(node) = body else { fatalError() }
    return ObjectVersion(
        eTag: try! node.nodes(forXPath: "ETag").first.map { String.deserialize(response: response, body: .xml($0)) },
      isLatest: try! node.nodes(forXPath: "IsLatest").first.map { Bool.deserialize(response: response, body: .xml($0)) },
      key: try! node.nodes(forXPath: "Key").first.map { String.deserialize(response: response, body: .xml($0)) },
      lastModified: try! node.nodes(forXPath: "LastModified").first.map { Date.deserialize(response: response, body: .xml($0)) },
      owner: try! node.nodes(forXPath: "Owner").first.map { Owner.deserialize(response: response, body: .xml($0)) },
      size: try! node.nodes(forXPath: "Size").first.map { Int.deserialize(response: response, body: .xml($0)) },
      storageClass: try! node.nodes(forXPath: "StorageClass").first.map { Objectversionstorageclass.deserialize(response: response, body: .xml($0)) },
      versionId: try! node.nodes(forXPath: "VersionId").first.map { String.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - eTag: 
      - isLatest: Specifies whether the object is (true) or is not (false) the latest version of an object.
      - key: The object key.
      - lastModified: Date and time the object was last modified.
      - owner: 
      - size: Size in bytes of the object.
      - storageClass: The class of storage used to store the object.
      - versionId: Version ID of an object.
 */
  public init(eTag: String?, isLatest: Bool?, key: String?, lastModified: Date?, owner: Owner?, size: Int?, storageClass: Objectversionstorageclass?, versionId: String?) {
self.eTag = eTag
self.isLatest = isLatest
self.key = key
self.lastModified = lastModified
self.owner = owner
self.size = size
self.storageClass = storageClass
self.versionId = versionId
  }
}



enum Objectversionstorageclass: String, AwswiftDeserializable, AwswiftSerializable {
  case `sTANDARD` = "STANDARD"

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Objectversionstorageclass {
    switch body { 
    case .json(let json): return Objectversionstorageclass(rawValue: json as! String)!
    case .xml(let node): return Objectversionstorageclass(rawValue: node.stringValue!)!
    }
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}

public struct Owner: AwswiftSerializable, AwswiftDeserializable {
/**

 */
  public let displayName: String?
/**

 */
  public let iD: String?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if displayName != nil { body["DisplayName"] = displayName! }
    if iD != nil { body["ID"] = iD! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Owner {
    guard case let .xml(node) = body else { fatalError() }
    return Owner(
        displayName: try! node.nodes(forXPath: "DisplayName").first.map { String.deserialize(response: response, body: .xml($0)) },
      iD: try! node.nodes(forXPath: "ID").first.map { String.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - displayName: 
      - iD: 
 */
  public init(displayName: String?, iD: String?) {
self.displayName = displayName
self.iD = iD
  }
}

public struct Part: AwswiftSerializable, AwswiftDeserializable {
/**
Entity tag returned when the part was uploaded.
 */
  public let eTag: String?
/**
Date and time at which the part was uploaded.
 */
  public let lastModified: Date?
/**
Part number identifying the part. This is a positive integer between 1 and 10,000.
 */
  public let partNumber: Int?
/**
Size of the uploaded part data.
 */
  public let size: Int?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if eTag != nil { body["ETag"] = eTag! }
    if lastModified != nil { body["LastModified"] = lastModified! }
    if partNumber != nil { body["PartNumber"] = partNumber! }
    if size != nil { body["Size"] = size! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Part {
    guard case let .xml(node) = body else { fatalError() }
    return Part(
        eTag: try! node.nodes(forXPath: "ETag").first.map { String.deserialize(response: response, body: .xml($0)) },
      lastModified: try! node.nodes(forXPath: "LastModified").first.map { Date.deserialize(response: response, body: .xml($0)) },
      partNumber: try! node.nodes(forXPath: "PartNumber").first.map { Int.deserialize(response: response, body: .xml($0)) },
      size: try! node.nodes(forXPath: "Size").first.map { Int.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - eTag: Entity tag returned when the part was uploaded.
      - lastModified: Date and time at which the part was uploaded.
      - partNumber: Part number identifying the part. This is a positive integer between 1 and 10,000.
      - size: Size of the uploaded part data.
 */
  public init(eTag: String?, lastModified: Date?, partNumber: Int?, size: Int?) {
self.eTag = eTag
self.lastModified = lastModified
self.partNumber = partNumber
self.size = size
  }
}





enum Payer: String, AwswiftDeserializable, AwswiftSerializable {
  case `requester` = "Requester"
  case `bucketOwner` = "BucketOwner"

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Payer {
    switch body { 
    case .json(let json): return Payer(rawValue: json as! String)!
    case .xml(let node): return Payer(rawValue: node.stringValue!)!
    }
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}

enum Permission: String, AwswiftDeserializable, AwswiftSerializable {
  case `fULL_CONTROL` = "FULL_CONTROL"
  case `wRITE` = "WRITE"
  case `wRITE_ACP` = "WRITE_ACP"
  case `rEAD` = "READ"
  case `rEAD_ACP` = "READ_ACP"

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Permission {
    switch body { 
    case .json(let json): return Permission(rawValue: json as! String)!
    case .xml(let node): return Permission(rawValue: node.stringValue!)!
    }
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}



enum S3Protocol: String, AwswiftDeserializable, AwswiftSerializable {
  case `http` = "http"
  case `https` = "https"

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> S3Protocol {
    switch body { 
    case .json(let json): return S3Protocol(rawValue: json as! String)!
    case .xml(let node): return S3Protocol(rawValue: node.stringValue!)!
    }
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}

public struct PutBucketAccelerateConfigurationRequest: AwswiftSerializable {
/**
Specifies the Accelerate Configuration you want to set for the bucket.
 */
  public let accelerateConfiguration: AccelerateConfiguration
/**
Name of the bucket for which the accelerate configuration is set.
 */
  public let bucket: String

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    uri["Bucket"] = "\(bucket)"
    body["AccelerateConfiguration"] = accelerateConfiguration
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - accelerateConfiguration: Specifies the Accelerate Configuration you want to set for the bucket.
      - bucket: Name of the bucket for which the accelerate configuration is set.
 */
  public init(accelerateConfiguration: AccelerateConfiguration, bucket: String) {
self.accelerateConfiguration = accelerateConfiguration
self.bucket = bucket
  }
}

public struct PutBucketAclRequest: AwswiftSerializable {
/**
The canned ACL to apply to the bucket.
 */
  public let aCL: Bucketcannedacl?
/**

 */
  public let accessControlPolicy: AccessControlPolicy?
/**

 */
  public let bucket: String
/**

 */
  public let contentMD5: String?
/**
Allows grantee the read, write, read ACP, and write ACP permissions on the bucket.
 */
  public let grantFullControl: String?
/**
Allows grantee to list the objects in the bucket.
 */
  public let grantRead: String?
/**
Allows grantee to read the bucket ACL.
 */
  public let grantReadACP: String?
/**
Allows grantee to create, overwrite, and delete any object in the bucket.
 */
  public let grantWrite: String?
/**
Allows grantee to write the ACL for the applicable bucket.
 */
  public let grantWriteACP: String?

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    var header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    uri["Bucket"] = "\(bucket)"
    if aCL != nil { header["x-amz-acl"] = "\(aCL!)" }
    if contentMD5 != nil { header["Content-MD5"] = "\(contentMD5!)" }
    if grantFullControl != nil { header["x-amz-grant-full-control"] = "\(grantFullControl!)" }
    if grantRead != nil { header["x-amz-grant-read"] = "\(grantRead!)" }
    if grantReadACP != nil { header["x-amz-grant-read-acp"] = "\(grantReadACP!)" }
    if grantWrite != nil { header["x-amz-grant-write"] = "\(grantWrite!)" }
    if grantWriteACP != nil { header["x-amz-grant-write-acp"] = "\(grantWriteACP!)" }
    if accessControlPolicy != nil { body["AccessControlPolicy"] = accessControlPolicy! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - aCL: The canned ACL to apply to the bucket.
      - accessControlPolicy: 
      - bucket: 
      - contentMD5: 
      - grantFullControl: Allows grantee the read, write, read ACP, and write ACP permissions on the bucket.
      - grantRead: Allows grantee to list the objects in the bucket.
      - grantReadACP: Allows grantee to read the bucket ACL.
      - grantWrite: Allows grantee to create, overwrite, and delete any object in the bucket.
      - grantWriteACP: Allows grantee to write the ACL for the applicable bucket.
 */
  public init(aCL: Bucketcannedacl?, accessControlPolicy: AccessControlPolicy?, bucket: String, contentMD5: String?, grantFullControl: String?, grantRead: String?, grantReadACP: String?, grantWrite: String?, grantWriteACP: String?) {
self.aCL = aCL
self.accessControlPolicy = accessControlPolicy
self.bucket = bucket
self.contentMD5 = contentMD5
self.grantFullControl = grantFullControl
self.grantRead = grantRead
self.grantReadACP = grantReadACP
self.grantWrite = grantWrite
self.grantWriteACP = grantWriteACP
  }
}

public struct PutBucketCorsRequest: AwswiftSerializable {
/**

 */
  public let bucket: String
/**

 */
  public let cORSConfiguration: CORSConfiguration
/**

 */
  public let contentMD5: String?

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    var header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    uri["Bucket"] = "\(bucket)"
    if contentMD5 != nil { header["Content-MD5"] = "\(contentMD5!)" }
    body["CORSConfiguration"] = cORSConfiguration
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - bucket: 
      - cORSConfiguration: 
      - contentMD5: 
 */
  public init(bucket: String, cORSConfiguration: CORSConfiguration, contentMD5: String?) {
self.bucket = bucket
self.cORSConfiguration = cORSConfiguration
self.contentMD5 = contentMD5
  }
}

public struct PutBucketLifecycleConfigurationRequest: AwswiftSerializable {
/**

 */
  public let bucket: String
/**

 */
  public let lifecycleConfiguration: BucketLifecycleConfiguration?

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    uri["Bucket"] = "\(bucket)"
    if lifecycleConfiguration != nil { body["LifecycleConfiguration"] = lifecycleConfiguration! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - bucket: 
      - lifecycleConfiguration: 
 */
  public init(bucket: String, lifecycleConfiguration: BucketLifecycleConfiguration?) {
self.bucket = bucket
self.lifecycleConfiguration = lifecycleConfiguration
  }
}

public struct PutBucketLifecycleRequest: AwswiftSerializable {
/**

 */
  public let bucket: String
/**

 */
  public let contentMD5: String?
/**

 */
  public let lifecycleConfiguration: LifecycleConfiguration?

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    var header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    uri["Bucket"] = "\(bucket)"
    if contentMD5 != nil { header["Content-MD5"] = "\(contentMD5!)" }
    if lifecycleConfiguration != nil { body["LifecycleConfiguration"] = lifecycleConfiguration! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - bucket: 
      - contentMD5: 
      - lifecycleConfiguration: 
 */
  public init(bucket: String, contentMD5: String?, lifecycleConfiguration: LifecycleConfiguration?) {
self.bucket = bucket
self.contentMD5 = contentMD5
self.lifecycleConfiguration = lifecycleConfiguration
  }
}

public struct PutBucketLoggingRequest: AwswiftSerializable {
/**

 */
  public let bucket: String
/**

 */
  public let bucketLoggingStatus: BucketLoggingStatus
/**

 */
  public let contentMD5: String?

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    var header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    uri["Bucket"] = "\(bucket)"
    if contentMD5 != nil { header["Content-MD5"] = "\(contentMD5!)" }
    body["BucketLoggingStatus"] = bucketLoggingStatus
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - bucket: 
      - bucketLoggingStatus: 
      - contentMD5: 
 */
  public init(bucket: String, bucketLoggingStatus: BucketLoggingStatus, contentMD5: String?) {
self.bucket = bucket
self.bucketLoggingStatus = bucketLoggingStatus
self.contentMD5 = contentMD5
  }
}

public struct PutBucketNotificationConfigurationRequest: AwswiftSerializable {
/**

 */
  public let bucket: String
/**

 */
  public let notificationConfiguration: NotificationConfiguration

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    uri["Bucket"] = "\(bucket)"
    body["NotificationConfiguration"] = notificationConfiguration
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - bucket: 
      - notificationConfiguration: 
 */
  public init(bucket: String, notificationConfiguration: NotificationConfiguration) {
self.bucket = bucket
self.notificationConfiguration = notificationConfiguration
  }
}

public struct PutBucketNotificationRequest: AwswiftSerializable {
/**

 */
  public let bucket: String
/**

 */
  public let contentMD5: String?
/**

 */
  public let notificationConfiguration: NotificationConfigurationDeprecated

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    var header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    uri["Bucket"] = "\(bucket)"
    if contentMD5 != nil { header["Content-MD5"] = "\(contentMD5!)" }
    body["NotificationConfiguration"] = notificationConfiguration
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - bucket: 
      - contentMD5: 
      - notificationConfiguration: 
 */
  public init(bucket: String, contentMD5: String?, notificationConfiguration: NotificationConfigurationDeprecated) {
self.bucket = bucket
self.contentMD5 = contentMD5
self.notificationConfiguration = notificationConfiguration
  }
}

public struct PutBucketPolicyRequest: AwswiftSerializable {
/**

 */
  public let bucket: String
/**

 */
  public let contentMD5: String?
/**
The bucket policy as a JSON document.
 */
  public let policy: String

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    var header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    uri["Bucket"] = "\(bucket)"
    if contentMD5 != nil { header["Content-MD5"] = "\(contentMD5!)" }
    body["Policy"] = policy
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - bucket: 
      - contentMD5: 
      - policy: The bucket policy as a JSON document.
 */
  public init(bucket: String, contentMD5: String?, policy: String) {
self.bucket = bucket
self.contentMD5 = contentMD5
self.policy = policy
  }
}

public struct PutBucketReplicationRequest: AwswiftSerializable {
/**

 */
  public let bucket: String
/**

 */
  public let contentMD5: String?
/**

 */
  public let replicationConfiguration: ReplicationConfiguration

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    var header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    uri["Bucket"] = "\(bucket)"
    if contentMD5 != nil { header["Content-MD5"] = "\(contentMD5!)" }
    body["ReplicationConfiguration"] = replicationConfiguration
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - bucket: 
      - contentMD5: 
      - replicationConfiguration: 
 */
  public init(bucket: String, contentMD5: String?, replicationConfiguration: ReplicationConfiguration) {
self.bucket = bucket
self.contentMD5 = contentMD5
self.replicationConfiguration = replicationConfiguration
  }
}

public struct PutBucketRequestPaymentRequest: AwswiftSerializable {
/**

 */
  public let bucket: String
/**

 */
  public let contentMD5: String?
/**

 */
  public let requestPaymentConfiguration: RequestPaymentConfiguration

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    var header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    uri["Bucket"] = "\(bucket)"
    if contentMD5 != nil { header["Content-MD5"] = "\(contentMD5!)" }
    body["RequestPaymentConfiguration"] = requestPaymentConfiguration
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - bucket: 
      - contentMD5: 
      - requestPaymentConfiguration: 
 */
  public init(bucket: String, contentMD5: String?, requestPaymentConfiguration: RequestPaymentConfiguration) {
self.bucket = bucket
self.contentMD5 = contentMD5
self.requestPaymentConfiguration = requestPaymentConfiguration
  }
}

public struct PutBucketTaggingRequest: AwswiftSerializable {
/**

 */
  public let bucket: String
/**

 */
  public let contentMD5: String?
/**

 */
  public let tagging: Tagging

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    var header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    uri["Bucket"] = "\(bucket)"
    if contentMD5 != nil { header["Content-MD5"] = "\(contentMD5!)" }
    body["Tagging"] = tagging
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - bucket: 
      - contentMD5: 
      - tagging: 
 */
  public init(bucket: String, contentMD5: String?, tagging: Tagging) {
self.bucket = bucket
self.contentMD5 = contentMD5
self.tagging = tagging
  }
}

public struct PutBucketVersioningRequest: AwswiftSerializable {
/**

 */
  public let bucket: String
/**

 */
  public let contentMD5: String?
/**
The concatenation of the authentication device's serial number, a space, and the value that is displayed on your authentication device.
 */
  public let mFA: String?
/**

 */
  public let versioningConfiguration: VersioningConfiguration

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    var header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    uri["Bucket"] = "\(bucket)"
    if contentMD5 != nil { header["Content-MD5"] = "\(contentMD5!)" }
    if mFA != nil { header["x-amz-mfa"] = "\(mFA!)" }
    body["VersioningConfiguration"] = versioningConfiguration
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - bucket: 
      - contentMD5: 
      - mFA: The concatenation of the authentication device's serial number, a space, and the value that is displayed on your authentication device.
      - versioningConfiguration: 
 */
  public init(bucket: String, contentMD5: String?, mFA: String?, versioningConfiguration: VersioningConfiguration) {
self.bucket = bucket
self.contentMD5 = contentMD5
self.mFA = mFA
self.versioningConfiguration = versioningConfiguration
  }
}

public struct PutBucketWebsiteRequest: AwswiftSerializable {
/**

 */
  public let bucket: String
/**

 */
  public let contentMD5: String?
/**

 */
  public let websiteConfiguration: WebsiteConfiguration

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    var header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    uri["Bucket"] = "\(bucket)"
    if contentMD5 != nil { header["Content-MD5"] = "\(contentMD5!)" }
    body["WebsiteConfiguration"] = websiteConfiguration
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - bucket: 
      - contentMD5: 
      - websiteConfiguration: 
 */
  public init(bucket: String, contentMD5: String?, websiteConfiguration: WebsiteConfiguration) {
self.bucket = bucket
self.contentMD5 = contentMD5
self.websiteConfiguration = websiteConfiguration
  }
}

public struct PutObjectAclOutput: AwswiftDeserializable {
/**

 */
  public let requestCharged: Requestcharged?


  static func deserializableBody(data: Data) -> DeserializableBody {
    fatalError()
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> PutObjectAclOutput {
  
    return PutObjectAclOutput(
        requestCharged: response.allHeaderFields["x-amz-request-charged"].flatMap { ($0 is NSNull) ? nil : Requestcharged.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - requestCharged: 
 */
  public init(requestCharged: Requestcharged?) {
self.requestCharged = requestCharged
  }
}

public struct PutObjectAclRequest: AwswiftSerializable {
/**
The canned ACL to apply to the object.
 */
  public let aCL: Objectcannedacl?
/**

 */
  public let accessControlPolicy: AccessControlPolicy?
/**

 */
  public let bucket: String
/**

 */
  public let contentMD5: String?
/**
Allows grantee the read, write, read ACP, and write ACP permissions on the bucket.
 */
  public let grantFullControl: String?
/**
Allows grantee to list the objects in the bucket.
 */
  public let grantRead: String?
/**
Allows grantee to read the bucket ACL.
 */
  public let grantReadACP: String?
/**
Allows grantee to create, overwrite, and delete any object in the bucket.
 */
  public let grantWrite: String?
/**
Allows grantee to write the ACL for the applicable bucket.
 */
  public let grantWriteACP: String?
/**

 */
  public let key: String
/**

 */
  public let requestPayer: Requestpayer?
/**
VersionId used to reference a specific version of the object.
 */
  public let versionId: String?

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    var querystring: [String: String] = [:]
    var header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    uri["Bucket"] = "\(bucket)"
    uri["Key"] = "\(key)"
    if versionId != nil { querystring["versionId"] = "\(versionId!)" }
    if aCL != nil { header["x-amz-acl"] = "\(aCL!)" }
    if contentMD5 != nil { header["Content-MD5"] = "\(contentMD5!)" }
    if grantFullControl != nil { header["x-amz-grant-full-control"] = "\(grantFullControl!)" }
    if grantRead != nil { header["x-amz-grant-read"] = "\(grantRead!)" }
    if grantReadACP != nil { header["x-amz-grant-read-acp"] = "\(grantReadACP!)" }
    if grantWrite != nil { header["x-amz-grant-write"] = "\(grantWrite!)" }
    if grantWriteACP != nil { header["x-amz-grant-write-acp"] = "\(grantWriteACP!)" }
    if requestPayer != nil { header["x-amz-request-payer"] = "\(requestPayer!)" }
    if accessControlPolicy != nil { body["AccessControlPolicy"] = accessControlPolicy! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - aCL: The canned ACL to apply to the object.
      - accessControlPolicy: 
      - bucket: 
      - contentMD5: 
      - grantFullControl: Allows grantee the read, write, read ACP, and write ACP permissions on the bucket.
      - grantRead: Allows grantee to list the objects in the bucket.
      - grantReadACP: Allows grantee to read the bucket ACL.
      - grantWrite: Allows grantee to create, overwrite, and delete any object in the bucket.
      - grantWriteACP: Allows grantee to write the ACL for the applicable bucket.
      - key: 
      - requestPayer: 
      - versionId: VersionId used to reference a specific version of the object.
 */
  public init(aCL: Objectcannedacl?, accessControlPolicy: AccessControlPolicy?, bucket: String, contentMD5: String?, grantFullControl: String?, grantRead: String?, grantReadACP: String?, grantWrite: String?, grantWriteACP: String?, key: String, requestPayer: Requestpayer?, versionId: String?) {
self.aCL = aCL
self.accessControlPolicy = accessControlPolicy
self.bucket = bucket
self.contentMD5 = contentMD5
self.grantFullControl = grantFullControl
self.grantRead = grantRead
self.grantReadACP = grantReadACP
self.grantWrite = grantWrite
self.grantWriteACP = grantWriteACP
self.key = key
self.requestPayer = requestPayer
self.versionId = versionId
  }
}

public struct PutObjectOutput: AwswiftDeserializable {
/**
Entity tag for the uploaded object.
 */
  public let eTag: String?
/**
If the object expiration is configured, this will contain the expiration date (expiry-date) and rule ID (rule-id). The value of rule-id is URL encoded.
 */
  public let expiration: String?
/**

 */
  public let requestCharged: Requestcharged?
/**
If server-side encryption with a customer-provided encryption key was requested, the response will include this header confirming the encryption algorithm used.
 */
  public let sSECustomerAlgorithm: String?
/**
If server-side encryption with a customer-provided encryption key was requested, the response will include this header to provide round trip message integrity verification of the customer-provided encryption key.
 */
  public let sSECustomerKeyMD5: String?
/**
If present, specifies the ID of the AWS Key Management Service (KMS) master encryption key that was used for the object.
 */
  public let sSEKMSKeyId: String?
/**
The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).
 */
  public let serverSideEncryption: Serversideencryption?
/**
Version of the object.
 */
  public let versionId: String?


  static func deserializableBody(data: Data) -> DeserializableBody {
    fatalError()
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> PutObjectOutput {
  
    return PutObjectOutput(
        eTag: response.allHeaderFields["ETag"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      expiration: response.allHeaderFields["x-amz-expiration"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      requestCharged: response.allHeaderFields["x-amz-request-charged"].flatMap { ($0 is NSNull) ? nil : Requestcharged.deserialize(response: response, body: .json($0)) },
      sSECustomerAlgorithm: response.allHeaderFields["x-amz-server-side-encryption-customer-algorithm"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      sSECustomerKeyMD5: response.allHeaderFields["x-amz-server-side-encryption-customer-key-MD5"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      sSEKMSKeyId: response.allHeaderFields["x-amz-server-side-encryption-aws-kms-key-id"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      serverSideEncryption: response.allHeaderFields["x-amz-server-side-encryption"].flatMap { ($0 is NSNull) ? nil : Serversideencryption.deserialize(response: response, body: .json($0)) },
      versionId: response.allHeaderFields["x-amz-version-id"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - eTag: Entity tag for the uploaded object.
      - expiration: If the object expiration is configured, this will contain the expiration date (expiry-date) and rule ID (rule-id). The value of rule-id is URL encoded.
      - requestCharged: 
      - sSECustomerAlgorithm: If server-side encryption with a customer-provided encryption key was requested, the response will include this header confirming the encryption algorithm used.
      - sSECustomerKeyMD5: If server-side encryption with a customer-provided encryption key was requested, the response will include this header to provide round trip message integrity verification of the customer-provided encryption key.
      - sSEKMSKeyId: If present, specifies the ID of the AWS Key Management Service (KMS) master encryption key that was used for the object.
      - serverSideEncryption: The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).
      - versionId: Version of the object.
 */
  public init(eTag: String?, expiration: String?, requestCharged: Requestcharged?, sSECustomerAlgorithm: String?, sSECustomerKeyMD5: String?, sSEKMSKeyId: String?, serverSideEncryption: Serversideencryption?, versionId: String?) {
self.eTag = eTag
self.expiration = expiration
self.requestCharged = requestCharged
self.sSECustomerAlgorithm = sSECustomerAlgorithm
self.sSECustomerKeyMD5 = sSECustomerKeyMD5
self.sSEKMSKeyId = sSEKMSKeyId
self.serverSideEncryption = serverSideEncryption
self.versionId = versionId
  }
}

public struct PutObjectRequest: AwswiftSerializable {
/**
The canned ACL to apply to the object.
 */
  public let aCL: Objectcannedacl?
/**
Object data.
 */
  public let s3Body: Data?
/**
Name of the bucket to which the PUT operation was initiated.
 */
  public let bucket: String
/**
Specifies caching behavior along the request/reply chain.
 */
  public let cacheControl: String?
/**
Specifies presentational information for the object.
 */
  public let contentDisposition: String?
/**
Specifies what content encodings have been applied to the object and thus what decoding mechanisms must be applied to obtain the media-type referenced by the Content-Type header field.
 */
  public let contentEncoding: String?
/**
The language the content is in.
 */
  public let contentLanguage: String?
/**
Size of the body in bytes. This parameter is useful when the size of the body cannot be determined automatically.
 */
  public let contentLength: Int?
/**
The base64-encoded 128-bit MD5 digest of the part data.
 */
  public let contentMD5: String?
/**
A standard MIME type describing the format of the object data.
 */
  public let contentType: String?
/**
The date and time at which the object is no longer cacheable.
 */
  public let expires: Date?
/**
Gives the grantee READ, READ_ACP, and WRITE_ACP permissions on the object.
 */
  public let grantFullControl: String?
/**
Allows grantee to read the object data and its metadata.
 */
  public let grantRead: String?
/**
Allows grantee to read the object ACL.
 */
  public let grantReadACP: String?
/**
Allows grantee to write the ACL for the applicable object.
 */
  public let grantWriteACP: String?
/**
Object key for which the PUT operation was initiated.
 */
  public let key: String
/**
A map of metadata to store with the object in S3.
 */
  public let metadata: [String: String]?
/**

 */
  public let requestPayer: Requestpayer?
/**
Specifies the algorithm to use to when encrypting the object (e.g., AES256).
 */
  public let sSECustomerAlgorithm: String?
/**
Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data. This value is used to store the object and then it is discarded; Amazon does not store the encryption key. The key must be appropriate for use with the algorithm specified in the x-amz-server-side​-encryption​-customer-algorithm header.
 */
  public let sSECustomerKey: String?
/**
Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure the encryption key was transmitted without error.
 */
  public let sSECustomerKeyMD5: String?
/**
Specifies the AWS KMS key ID to use for object encryption. All GET and PUT requests for an object protected by AWS KMS will fail if not made via SSL or using SigV4. Documentation on configuring any of the officially supported AWS SDKs and CLI can be found at http://docs.aws.amazon.com/AmazonS3/latest/dev/UsingAWSSDK.html#specify-signature-version
 */
  public let sSEKMSKeyId: String?
/**
The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).
 */
  public let serverSideEncryption: Serversideencryption?
/**
The type of storage to use for the object. Defaults to 'STANDARD'.
 */
  public let storageClass: Storageclass?
/**
If the bucket is configured as a website, redirects requests for this object to another object in the same bucket or to an external URL. Amazon S3 stores the value of this header in the object metadata.
 */
  public let websiteRedirectLocation: String?

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    var header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    uri["Bucket"] = "\(bucket)"
    uri["Key"] = "\(key)"
    if aCL != nil { header["x-amz-acl"] = "\(aCL!)" }
    if cacheControl != nil { header["Cache-Control"] = "\(cacheControl!)" }
    if contentDisposition != nil { header["Content-Disposition"] = "\(contentDisposition!)" }
    if contentEncoding != nil { header["Content-Encoding"] = "\(contentEncoding!)" }
    if contentLanguage != nil { header["Content-Language"] = "\(contentLanguage!)" }
    if contentLength != nil { header["Content-Length"] = "\(contentLength!)" }
    if contentMD5 != nil { header["Content-MD5"] = "\(contentMD5!)" }
    if contentType != nil { header["Content-Type"] = "\(contentType!)" }
    if expires != nil { header["Expires"] = "\(expires!)" }
    if grantFullControl != nil { header["x-amz-grant-full-control"] = "\(grantFullControl!)" }
    if grantRead != nil { header["x-amz-grant-read"] = "\(grantRead!)" }
    if grantReadACP != nil { header["x-amz-grant-read-acp"] = "\(grantReadACP!)" }
    if grantWriteACP != nil { header["x-amz-grant-write-acp"] = "\(grantWriteACP!)" }
    if requestPayer != nil { header["x-amz-request-payer"] = "\(requestPayer!)" }
    if sSECustomerAlgorithm != nil { header["x-amz-server-side-encryption-customer-algorithm"] = "\(sSECustomerAlgorithm!)" }
    if sSECustomerKey != nil { header["x-amz-server-side-encryption-customer-key"] = "\(sSECustomerKey!)" }
    if sSECustomerKeyMD5 != nil { header["x-amz-server-side-encryption-customer-key-MD5"] = "\(sSECustomerKeyMD5!)" }
    if sSEKMSKeyId != nil { header["x-amz-server-side-encryption-aws-kms-key-id"] = "\(sSEKMSKeyId!)" }
    if serverSideEncryption != nil { header["x-amz-server-side-encryption"] = "\(serverSideEncryption!)" }
    if storageClass != nil { header["x-amz-storage-class"] = "\(storageClass!)" }
    if websiteRedirectLocation != nil { header["x-amz-website-redirect-location"] = "\(websiteRedirectLocation!)" }
    if s3Body != nil { body["Body"] = s3Body! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - aCL: The canned ACL to apply to the object.
      - s3Body: Object data.
      - bucket: Name of the bucket to which the PUT operation was initiated.
      - cacheControl: Specifies caching behavior along the request/reply chain.
      - contentDisposition: Specifies presentational information for the object.
      - contentEncoding: Specifies what content encodings have been applied to the object and thus what decoding mechanisms must be applied to obtain the media-type referenced by the Content-Type header field.
      - contentLanguage: The language the content is in.
      - contentLength: Size of the body in bytes. This parameter is useful when the size of the body cannot be determined automatically.
      - contentMD5: The base64-encoded 128-bit MD5 digest of the part data.
      - contentType: A standard MIME type describing the format of the object data.
      - expires: The date and time at which the object is no longer cacheable.
      - grantFullControl: Gives the grantee READ, READ_ACP, and WRITE_ACP permissions on the object.
      - grantRead: Allows grantee to read the object data and its metadata.
      - grantReadACP: Allows grantee to read the object ACL.
      - grantWriteACP: Allows grantee to write the ACL for the applicable object.
      - key: Object key for which the PUT operation was initiated.
      - metadata: A map of metadata to store with the object in S3.
      - requestPayer: 
      - sSECustomerAlgorithm: Specifies the algorithm to use to when encrypting the object (e.g., AES256).
      - sSECustomerKey: Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data. This value is used to store the object and then it is discarded; Amazon does not store the encryption key. The key must be appropriate for use with the algorithm specified in the x-amz-server-side​-encryption​-customer-algorithm header.
      - sSECustomerKeyMD5: Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure the encryption key was transmitted without error.
      - sSEKMSKeyId: Specifies the AWS KMS key ID to use for object encryption. All GET and PUT requests for an object protected by AWS KMS will fail if not made via SSL or using SigV4. Documentation on configuring any of the officially supported AWS SDKs and CLI can be found at http://docs.aws.amazon.com/AmazonS3/latest/dev/UsingAWSSDK.html#specify-signature-version
      - serverSideEncryption: The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).
      - storageClass: The type of storage to use for the object. Defaults to 'STANDARD'.
      - websiteRedirectLocation: If the bucket is configured as a website, redirects requests for this object to another object in the same bucket or to an external URL. Amazon S3 stores the value of this header in the object metadata.
 */
  public init(aCL: Objectcannedacl?, s3Body: Data?, bucket: String, cacheControl: String?, contentDisposition: String?, contentEncoding: String?, contentLanguage: String?, contentLength: Int?, contentMD5: String?, contentType: String?, expires: Date?, grantFullControl: String?, grantRead: String?, grantReadACP: String?, grantWriteACP: String?, key: String, metadata: [String: String]?, requestPayer: Requestpayer?, sSECustomerAlgorithm: String?, sSECustomerKey: String?, sSECustomerKeyMD5: String?, sSEKMSKeyId: String?, serverSideEncryption: Serversideencryption?, storageClass: Storageclass?, websiteRedirectLocation: String?) {
self.aCL = aCL
self.s3Body = s3Body
self.bucket = bucket
self.cacheControl = cacheControl
self.contentDisposition = contentDisposition
self.contentEncoding = contentEncoding
self.contentLanguage = contentLanguage
self.contentLength = contentLength
self.contentMD5 = contentMD5
self.contentType = contentType
self.expires = expires
self.grantFullControl = grantFullControl
self.grantRead = grantRead
self.grantReadACP = grantReadACP
self.grantWriteACP = grantWriteACP
self.key = key
self.metadata = metadata
self.requestPayer = requestPayer
self.sSECustomerAlgorithm = sSECustomerAlgorithm
self.sSECustomerKey = sSECustomerKey
self.sSECustomerKeyMD5 = sSECustomerKeyMD5
self.sSEKMSKeyId = sSEKMSKeyId
self.serverSideEncryption = serverSideEncryption
self.storageClass = storageClass
self.websiteRedirectLocation = websiteRedirectLocation
  }
}


/**
Container for specifying an configuration when you want Amazon S3 to publish events to an Amazon Simple Queue Service (Amazon SQS) queue.
 */
public struct QueueConfiguration: AwswiftSerializable, AwswiftDeserializable {
/**

 */
  public let events: [Event]
/**

 */
  public let filter: NotificationConfigurationFilter?
/**

 */
  public let id: String?
/**
Amazon SQS queue ARN to which Amazon S3 will publish a message when it detects events of specified type.
 */
  public let queueArn: String

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["Event"] = events
    if filter != nil { body["Filter"] = filter! }
    if id != nil { body["Id"] = id! }
    body["Queue"] = queueArn
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> QueueConfiguration {
    guard case let .xml(node) = body else { fatalError() }
    return QueueConfiguration(
        events: try! node.nodes(forXPath: "Event").map { Event.deserialize(response: response, body: .xml($0)) },
      filter: try! node.nodes(forXPath: "Filter").first.map { NotificationConfigurationFilter.deserialize(response: response, body: .xml($0)) },
      id: try! node.nodes(forXPath: "Id").first.map { String.deserialize(response: response, body: .xml($0)) },
      queueArn: try! node.nodes(forXPath: "Queue").first.map { String.deserialize(response: response, body: .xml($0)) }!
    )
  }

/**
    - parameters:
      - events: 
      - filter: 
      - id: 
      - queueArn: Amazon SQS queue ARN to which Amazon S3 will publish a message when it detects events of specified type.
 */
  public init(events: [Event], filter: NotificationConfigurationFilter?, id: String?, queueArn: String) {
self.events = events
self.filter = filter
self.id = id
self.queueArn = queueArn
  }
}

public struct QueueConfigurationDeprecated: AwswiftSerializable, AwswiftDeserializable {
/**

 */
  public let event: Event?
/**

 */
  public let events: [Event]?
/**

 */
  public let id: String?
/**

 */
  public let queue: String?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if event != nil { body["Event"] = event! }
    if events != nil { body["Event"] = events! }
    if id != nil { body["Id"] = id! }
    if queue != nil { body["Queue"] = queue! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> QueueConfigurationDeprecated {
    guard case let .xml(node) = body else { fatalError() }
    return QueueConfigurationDeprecated(
        event: try! node.nodes(forXPath: "Event").first.map { Event.deserialize(response: response, body: .xml($0)) },
      events: try! node.nodes(forXPath: "Event").map { Event.deserialize(response: response, body: .xml($0)) },
      id: try! node.nodes(forXPath: "Id").first.map { String.deserialize(response: response, body: .xml($0)) },
      queue: try! node.nodes(forXPath: "Queue").first.map { String.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - event: 
      - events: 
      - id: 
      - queue: 
 */
  public init(event: Event?, events: [Event]?, id: String?, queue: String?) {
self.event = event
self.events = events
self.id = id
self.queue = queue
  }
}




public struct Redirect: AwswiftSerializable, AwswiftDeserializable {
/**
The host name to use in the redirect request.
 */
  public let hostName: String?
/**
The HTTP redirect code to use on the response. Not required if one of the siblings is present.
 */
  public let httpRedirectCode: String?
/**
Protocol to use (http, https) when redirecting requests. The default is the protocol that is used in the original request.
 */
  public let s3Protocol: S3Protocol?
/**
The object key prefix to use in the redirect request. For example, to redirect requests for all pages with prefix docs/ (objects in the docs/ folder) to documents/, you can set a condition block with KeyPrefixEquals set to docs/ and in the Redirect set ReplaceKeyPrefixWith to /documents. Not required if one of the siblings is present. Can be present only if ReplaceKeyWith is not provided.
 */
  public let replaceKeyPrefixWith: String?
/**
The specific object key to use in the redirect request. For example, redirect request to error.html. Not required if one of the sibling is present. Can be present only if ReplaceKeyPrefixWith is not provided.
 */
  public let replaceKeyWith: String?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if hostName != nil { body["HostName"] = hostName! }
    if httpRedirectCode != nil { body["HttpRedirectCode"] = httpRedirectCode! }
    if s3Protocol != nil { body["Protocol"] = s3Protocol! }
    if replaceKeyPrefixWith != nil { body["ReplaceKeyPrefixWith"] = replaceKeyPrefixWith! }
    if replaceKeyWith != nil { body["ReplaceKeyWith"] = replaceKeyWith! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Redirect {
    guard case let .xml(node) = body else { fatalError() }
    return Redirect(
        hostName: try! node.nodes(forXPath: "HostName").first.map { String.deserialize(response: response, body: .xml($0)) },
      httpRedirectCode: try! node.nodes(forXPath: "HttpRedirectCode").first.map { String.deserialize(response: response, body: .xml($0)) },
      s3Protocol: try! node.nodes(forXPath: "Protocol").first.map { S3Protocol.deserialize(response: response, body: .xml($0)) },
      replaceKeyPrefixWith: try! node.nodes(forXPath: "ReplaceKeyPrefixWith").first.map { String.deserialize(response: response, body: .xml($0)) },
      replaceKeyWith: try! node.nodes(forXPath: "ReplaceKeyWith").first.map { String.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - hostName: The host name to use in the redirect request.
      - httpRedirectCode: The HTTP redirect code to use on the response. Not required if one of the siblings is present.
      - s3Protocol: Protocol to use (http, https) when redirecting requests. The default is the protocol that is used in the original request.
      - replaceKeyPrefixWith: The object key prefix to use in the redirect request. For example, to redirect requests for all pages with prefix docs/ (objects in the docs/ folder) to documents/, you can set a condition block with KeyPrefixEquals set to docs/ and in the Redirect set ReplaceKeyPrefixWith to /documents. Not required if one of the siblings is present. Can be present only if ReplaceKeyWith is not provided.
      - replaceKeyWith: The specific object key to use in the redirect request. For example, redirect request to error.html. Not required if one of the sibling is present. Can be present only if ReplaceKeyPrefixWith is not provided.
 */
  public init(hostName: String?, httpRedirectCode: String?, s3Protocol: S3Protocol?, replaceKeyPrefixWith: String?, replaceKeyWith: String?) {
self.hostName = hostName
self.httpRedirectCode = httpRedirectCode
self.s3Protocol = s3Protocol
self.replaceKeyPrefixWith = replaceKeyPrefixWith
self.replaceKeyWith = replaceKeyWith
  }
}

public struct RedirectAllRequestsTo: AwswiftSerializable, AwswiftDeserializable {
/**
Name of the host where requests will be redirected.
 */
  public let hostName: String
/**
Protocol to use (http, https) when redirecting requests. The default is the protocol that is used in the original request.
 */
  public let s3Protocol: S3Protocol?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["HostName"] = hostName
    if s3Protocol != nil { body["Protocol"] = s3Protocol! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> RedirectAllRequestsTo {
    guard case let .xml(node) = body else { fatalError() }
    return RedirectAllRequestsTo(
        hostName: try! node.nodes(forXPath: "HostName").first.map { String.deserialize(response: response, body: .xml($0)) }!,
      s3Protocol: try! node.nodes(forXPath: "Protocol").first.map { S3Protocol.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - hostName: Name of the host where requests will be redirected.
      - s3Protocol: Protocol to use (http, https) when redirecting requests. The default is the protocol that is used in the original request.
 */
  public init(hostName: String, s3Protocol: S3Protocol?) {
self.hostName = hostName
self.s3Protocol = s3Protocol
  }
}



/**
Container for replication rules. You can add as many as 1,000 rules. Total replication configuration size can be up to 2 MB.
 */
public struct ReplicationConfiguration: AwswiftSerializable, AwswiftDeserializable {
/**
Amazon Resource Name (ARN) of an IAM role for Amazon S3 to assume when replicating the objects.
 */
  public let role: String
/**
Container for information about a particular replication rule. Replication configuration must have at least one rule and can contain up to 1,000 rules.
 */
  public let rules: [ReplicationRule]

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["Role"] = role
    body["Rule"] = rules
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> ReplicationConfiguration {
    guard case let .xml(node) = body else { fatalError() }
    return ReplicationConfiguration(
        role: try! node.nodes(forXPath: "Role").first.map { String.deserialize(response: response, body: .xml($0)) }!,
      rules: try! node.nodes(forXPath: "Rule").map { ReplicationRule.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - role: Amazon Resource Name (ARN) of an IAM role for Amazon S3 to assume when replicating the objects.
      - rules: Container for information about a particular replication rule. Replication configuration must have at least one rule and can contain up to 1,000 rules.
 */
  public init(role: String, rules: [ReplicationRule]) {
self.role = role
self.rules = rules
  }
}

public struct ReplicationRule: AwswiftSerializable, AwswiftDeserializable {
/**

 */
  public let destination: Destination
/**
Unique identifier for the rule. The value cannot be longer than 255 characters.
 */
  public let iD: String?
/**
Object keyname prefix identifying one or more objects to which the rule applies. Maximum prefix length can be up to 1,024 characters. Overlapping prefixes are not supported.
 */
  public let prefix: String
/**
The rule is ignored if status is not Enabled.
 */
  public let status: Replicationrulestatus

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["Destination"] = destination
    if iD != nil { body["ID"] = iD! }
    body["Prefix"] = prefix
    body["Status"] = status
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> ReplicationRule {
    guard case let .xml(node) = body else { fatalError() }
    return ReplicationRule(
        destination: try! node.nodes(forXPath: "Destination").first.map { Destination.deserialize(response: response, body: .xml($0)) }!,
      iD: try! node.nodes(forXPath: "ID").first.map { String.deserialize(response: response, body: .xml($0)) },
      prefix: try! node.nodes(forXPath: "Prefix").first.map { String.deserialize(response: response, body: .xml($0)) }!,
      status: try! node.nodes(forXPath: "Status").first.map { Replicationrulestatus.deserialize(response: response, body: .xml($0)) }!
    )
  }

/**
    - parameters:
      - destination: 
      - iD: Unique identifier for the rule. The value cannot be longer than 255 characters.
      - prefix: Object keyname prefix identifying one or more objects to which the rule applies. Maximum prefix length can be up to 1,024 characters. Overlapping prefixes are not supported.
      - status: The rule is ignored if status is not Enabled.
 */
  public init(destination: Destination, iD: String?, prefix: String, status: Replicationrulestatus) {
self.destination = destination
self.iD = iD
self.prefix = prefix
self.status = status
  }
}

enum Replicationrulestatus: String, AwswiftDeserializable, AwswiftSerializable {
  case `enabled` = "Enabled"
  case `disabled` = "Disabled"

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Replicationrulestatus {
    switch body { 
    case .json(let json): return Replicationrulestatus(rawValue: json as! String)!
    case .xml(let node): return Replicationrulestatus(rawValue: node.stringValue!)!
    }
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}


enum Replicationstatus: String, AwswiftDeserializable, AwswiftSerializable {
  case `cOMPLETE` = "COMPLETE"
  case `pENDING` = "PENDING"
  case `fAILED` = "FAILED"
  case `rEPLICA` = "REPLICA"

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Replicationstatus {
    switch body { 
    case .json(let json): return Replicationstatus(rawValue: json as! String)!
    case .xml(let node): return Replicationstatus(rawValue: node.stringValue!)!
    }
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}

/**
If present, indicates that the requester was successfully charged for the request.
 */
enum Requestcharged: String, AwswiftDeserializable, AwswiftSerializable {
  case `requester` = "requester"

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Requestcharged {
    switch body { 
    case .json(let json): return Requestcharged(rawValue: json as! String)!
    case .xml(let node): return Requestcharged(rawValue: node.stringValue!)!
    }
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}

/**
Confirms that the requester knows that she or he will be charged for the request. Bucket owners need not specify this parameter in their requests. Documentation on downloading objects from requester pays buckets can be found at http://docs.aws.amazon.com/AmazonS3/latest/dev/ObjectsinRequesterPaysBuckets.html
 */
enum Requestpayer: String, AwswiftDeserializable, AwswiftSerializable {
  case `requester` = "requester"

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Requestpayer {
    switch body { 
    case .json(let json): return Requestpayer(rawValue: json as! String)!
    case .xml(let node): return Requestpayer(rawValue: node.stringValue!)!
    }
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}

public struct RequestPaymentConfiguration: AwswiftSerializable, AwswiftDeserializable {
/**
Specifies who pays for the download and request fees.
 */
  public let payer: Payer

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["Payer"] = payer
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> RequestPaymentConfiguration {
    guard case let .xml(node) = body else { fatalError() }
    return RequestPaymentConfiguration(
        payer: try! node.nodes(forXPath: "Payer").first.map { Payer.deserialize(response: response, body: .xml($0)) }!
    )
  }

/**
    - parameters:
      - payer: Specifies who pays for the download and request fees.
 */
  public init(payer: Payer) {
self.payer = payer
  }
}








public struct RestoreObjectOutput: AwswiftDeserializable {
/**

 */
  public let requestCharged: Requestcharged?


  static func deserializableBody(data: Data) -> DeserializableBody {
    fatalError()
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> RestoreObjectOutput {
  
    return RestoreObjectOutput(
        requestCharged: response.allHeaderFields["x-amz-request-charged"].flatMap { ($0 is NSNull) ? nil : Requestcharged.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - requestCharged: 
 */
  public init(requestCharged: Requestcharged?) {
self.requestCharged = requestCharged
  }
}

public struct RestoreObjectRequest: AwswiftSerializable {
/**

 */
  public let bucket: String
/**

 */
  public let key: String
/**

 */
  public let requestPayer: Requestpayer?
/**

 */
  public let restoreRequest: RestoreRequest?
/**

 */
  public let versionId: String?

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    var querystring: [String: String] = [:]
    var header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    uri["Bucket"] = "\(bucket)"
    uri["Key"] = "\(key)"
    if versionId != nil { querystring["versionId"] = "\(versionId!)" }
    if requestPayer != nil { header["x-amz-request-payer"] = "\(requestPayer!)" }
    if restoreRequest != nil { body["RestoreRequest"] = restoreRequest! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - bucket: 
      - key: 
      - requestPayer: 
      - restoreRequest: 
      - versionId: 
 */
  public init(bucket: String, key: String, requestPayer: Requestpayer?, restoreRequest: RestoreRequest?, versionId: String?) {
self.bucket = bucket
self.key = key
self.requestPayer = requestPayer
self.restoreRequest = restoreRequest
self.versionId = versionId
  }
}

public struct RestoreRequest: AwswiftSerializable {
/**
Lifetime of the active copy in days
 */
  public let days: Int

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["Days"] = days
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - days: Lifetime of the active copy in days
 */
  public init(days: Int) {
self.days = days
  }
}


public struct RoutingRule: AwswiftSerializable, AwswiftDeserializable {
/**
A container for describing a condition that must be met for the specified redirect to apply. For example, 1. If request is for pages in the /docs folder, redirect to the /documents folder. 2. If request results in HTTP error 4xx, redirect request to another host where you might process the error.
 */
  public let condition: Condition?
/**
Container for redirect information. You can redirect requests to another host, to another page, or with another protocol. In the event of an error, you can can specify a different error code to return.
 */
  public let redirect: Redirect

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if condition != nil { body["Condition"] = condition! }
    body["Redirect"] = redirect
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> RoutingRule {
    guard case let .xml(node) = body else { fatalError() }
    return RoutingRule(
        condition: try! node.nodes(forXPath: "Condition").first.map { Condition.deserialize(response: response, body: .xml($0)) },
      redirect: try! node.nodes(forXPath: "Redirect").first.map { Redirect.deserialize(response: response, body: .xml($0)) }!
    )
  }

/**
    - parameters:
      - condition: A container for describing a condition that must be met for the specified redirect to apply. For example, 1. If request is for pages in the /docs folder, redirect to the /documents folder. 2. If request results in HTTP error 4xx, redirect request to another host where you might process the error.
      - redirect: Container for redirect information. You can redirect requests to another host, to another page, or with another protocol. In the event of an error, you can can specify a different error code to return.
 */
  public init(condition: Condition?, redirect: Redirect) {
self.condition = condition
self.redirect = redirect
  }
}


public struct Rule: AwswiftSerializable, AwswiftDeserializable {
/**

 */
  public let abortIncompleteMultipartUpload: AbortIncompleteMultipartUpload?
/**

 */
  public let expiration: LifecycleExpiration?
/**
Unique identifier for the rule. The value cannot be longer than 255 characters.
 */
  public let iD: String?
/**

 */
  public let noncurrentVersionExpiration: NoncurrentVersionExpiration?
/**

 */
  public let noncurrentVersionTransition: NoncurrentVersionTransition?
/**
Prefix identifying one or more objects to which the rule applies.
 */
  public let prefix: String
/**
If 'Enabled', the rule is currently being applied. If 'Disabled', the rule is not currently being applied.
 */
  public let status: Expirationstatus
/**

 */
  public let transition: Transition?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if abortIncompleteMultipartUpload != nil { body["AbortIncompleteMultipartUpload"] = abortIncompleteMultipartUpload! }
    if expiration != nil { body["Expiration"] = expiration! }
    if iD != nil { body["ID"] = iD! }
    if noncurrentVersionExpiration != nil { body["NoncurrentVersionExpiration"] = noncurrentVersionExpiration! }
    if noncurrentVersionTransition != nil { body["NoncurrentVersionTransition"] = noncurrentVersionTransition! }
    body["Prefix"] = prefix
    body["Status"] = status
    if transition != nil { body["Transition"] = transition! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Rule {
    guard case let .xml(node) = body else { fatalError() }
    return Rule(
        abortIncompleteMultipartUpload: try! node.nodes(forXPath: "AbortIncompleteMultipartUpload").first.map { AbortIncompleteMultipartUpload.deserialize(response: response, body: .xml($0)) },
      expiration: try! node.nodes(forXPath: "Expiration").first.map { LifecycleExpiration.deserialize(response: response, body: .xml($0)) },
      iD: try! node.nodes(forXPath: "ID").first.map { String.deserialize(response: response, body: .xml($0)) },
      noncurrentVersionExpiration: try! node.nodes(forXPath: "NoncurrentVersionExpiration").first.map { NoncurrentVersionExpiration.deserialize(response: response, body: .xml($0)) },
      noncurrentVersionTransition: try! node.nodes(forXPath: "NoncurrentVersionTransition").first.map { NoncurrentVersionTransition.deserialize(response: response, body: .xml($0)) },
      prefix: try! node.nodes(forXPath: "Prefix").first.map { String.deserialize(response: response, body: .xml($0)) }!,
      status: try! node.nodes(forXPath: "Status").first.map { Expirationstatus.deserialize(response: response, body: .xml($0)) }!,
      transition: try! node.nodes(forXPath: "Transition").first.map { Transition.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - abortIncompleteMultipartUpload: 
      - expiration: 
      - iD: Unique identifier for the rule. The value cannot be longer than 255 characters.
      - noncurrentVersionExpiration: 
      - noncurrentVersionTransition: 
      - prefix: Prefix identifying one or more objects to which the rule applies.
      - status: If 'Enabled', the rule is currently being applied. If 'Disabled', the rule is not currently being applied.
      - transition: 
 */
  public init(abortIncompleteMultipartUpload: AbortIncompleteMultipartUpload?, expiration: LifecycleExpiration?, iD: String?, noncurrentVersionExpiration: NoncurrentVersionExpiration?, noncurrentVersionTransition: NoncurrentVersionTransition?, prefix: String, status: Expirationstatus, transition: Transition?) {
self.abortIncompleteMultipartUpload = abortIncompleteMultipartUpload
self.expiration = expiration
self.iD = iD
self.noncurrentVersionExpiration = noncurrentVersionExpiration
self.noncurrentVersionTransition = noncurrentVersionTransition
self.prefix = prefix
self.status = status
self.transition = transition
  }
}


/**
Container for object key name prefix and suffix filtering rules.
 */
public struct S3KeyFilter: AwswiftSerializable, AwswiftDeserializable {
/**

 */
  public let filterRules: [FilterRule]?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if filterRules != nil { body["FilterRule"] = filterRules! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> S3KeyFilter {
    guard case let .xml(node) = body else { fatalError() }
    return S3KeyFilter(
        filterRules: try! node.nodes(forXPath: "FilterRule").map { FilterRule.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - filterRules: 
 */
  public init(filterRules: [FilterRule]?) {
self.filterRules = filterRules
  }
}





enum Serversideencryption: String, AwswiftDeserializable, AwswiftSerializable {
  case `aES256` = "AES256"
  case `awskms` = "aws:kms"

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Serversideencryption {
    switch body { 
    case .json(let json): return Serversideencryption(rawValue: json as! String)!
    case .xml(let node): return Serversideencryption(rawValue: node.stringValue!)!
    }
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}



enum Storageclass: String, AwswiftDeserializable, AwswiftSerializable {
  case `sTANDARD` = "STANDARD"
  case `rEDUCED_REDUNDANCY` = "REDUCED_REDUNDANCY"
  case `sTANDARD_IA` = "STANDARD_IA"

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Storageclass {
    switch body { 
    case .json(let json): return Storageclass(rawValue: json as! String)!
    case .xml(let node): return Storageclass(rawValue: node.stringValue!)!
    }
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}


public struct Tag: AwswiftSerializable, AwswiftDeserializable {
/**
Name of the tag.
 */
  public let key: String
/**
Value of the tag.
 */
  public let value: String

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["Key"] = key
    body["Value"] = value
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Tag {
    guard case let .xml(node) = body else { fatalError() }
    return Tag(
        key: try! node.nodes(forXPath: "Key").first.map { String.deserialize(response: response, body: .xml($0)) }!,
      value: try! node.nodes(forXPath: "Value").first.map { String.deserialize(response: response, body: .xml($0)) }!
    )
  }

/**
    - parameters:
      - key: Name of the tag.
      - value: Value of the tag.
 */
  public init(key: String, value: String) {
self.key = key
self.value = value
  }
}


public struct Tagging: AwswiftSerializable, AwswiftDeserializable {
/**

 */
  public let tagSet: [Tag]

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["TagSet"] = tagSet
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Tagging {
    guard case let .xml(node) = body else { fatalError() }
    return Tagging(
        tagSet: try! node.nodes(forXPath: "TagSet").map { Tag.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - tagSet: 
 */
  public init(tagSet: [Tag]) {
self.tagSet = tagSet
  }
}


public struct TargetGrant: AwswiftSerializable, AwswiftDeserializable {
/**

 */
  public let grantee: Grantee?
/**
Logging permissions assigned to the Grantee for the bucket.
 */
  public let permission: Bucketlogspermission?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if grantee != nil { body["Grantee"] = grantee! }
    if permission != nil { body["Permission"] = permission! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> TargetGrant {
    guard case let .xml(node) = body else { fatalError() }
    return TargetGrant(
        grantee: try! node.nodes(forXPath: "Grantee").first.map { Grantee.deserialize(response: response, body: .xml($0)) },
      permission: try! node.nodes(forXPath: "Permission").first.map { Bucketlogspermission.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - grantee: 
      - permission: Logging permissions assigned to the Grantee for the bucket.
 */
  public init(grantee: Grantee?, permission: Bucketlogspermission?) {
self.grantee = grantee
self.permission = permission
  }
}





/**
Container for specifying the configuration when you want Amazon S3 to publish events to an Amazon Simple Notification Service (Amazon SNS) topic.
 */
public struct TopicConfiguration: AwswiftSerializable, AwswiftDeserializable {
/**

 */
  public let events: [Event]
/**

 */
  public let filter: NotificationConfigurationFilter?
/**

 */
  public let id: String?
/**
Amazon SNS topic ARN to which Amazon S3 will publish a message when it detects events of specified type.
 */
  public let topicArn: String

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["Event"] = events
    if filter != nil { body["Filter"] = filter! }
    if id != nil { body["Id"] = id! }
    body["Topic"] = topicArn
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> TopicConfiguration {
    guard case let .xml(node) = body else { fatalError() }
    return TopicConfiguration(
        events: try! node.nodes(forXPath: "Event").map { Event.deserialize(response: response, body: .xml($0)) },
      filter: try! node.nodes(forXPath: "Filter").first.map { NotificationConfigurationFilter.deserialize(response: response, body: .xml($0)) },
      id: try! node.nodes(forXPath: "Id").first.map { String.deserialize(response: response, body: .xml($0)) },
      topicArn: try! node.nodes(forXPath: "Topic").first.map { String.deserialize(response: response, body: .xml($0)) }!
    )
  }

/**
    - parameters:
      - events: 
      - filter: 
      - id: 
      - topicArn: Amazon SNS topic ARN to which Amazon S3 will publish a message when it detects events of specified type.
 */
  public init(events: [Event], filter: NotificationConfigurationFilter?, id: String?, topicArn: String) {
self.events = events
self.filter = filter
self.id = id
self.topicArn = topicArn
  }
}

public struct TopicConfigurationDeprecated: AwswiftSerializable, AwswiftDeserializable {
/**
Bucket event for which to send notifications.
 */
  public let event: Event?
/**

 */
  public let events: [Event]?
/**

 */
  public let id: String?
/**
Amazon SNS topic to which Amazon S3 will publish a message to report the specified events for the bucket.
 */
  public let topic: String?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if event != nil { body["Event"] = event! }
    if events != nil { body["Event"] = events! }
    if id != nil { body["Id"] = id! }
    if topic != nil { body["Topic"] = topic! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> TopicConfigurationDeprecated {
    guard case let .xml(node) = body else { fatalError() }
    return TopicConfigurationDeprecated(
        event: try! node.nodes(forXPath: "Event").first.map { Event.deserialize(response: response, body: .xml($0)) },
      events: try! node.nodes(forXPath: "Event").map { Event.deserialize(response: response, body: .xml($0)) },
      id: try! node.nodes(forXPath: "Id").first.map { String.deserialize(response: response, body: .xml($0)) },
      topic: try! node.nodes(forXPath: "Topic").first.map { String.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - event: Bucket event for which to send notifications.
      - events: 
      - id: 
      - topic: Amazon SNS topic to which Amazon S3 will publish a message to report the specified events for the bucket.
 */
  public init(event: Event?, events: [Event]?, id: String?, topic: String?) {
self.event = event
self.events = events
self.id = id
self.topic = topic
  }
}


public struct Transition: AwswiftSerializable, AwswiftDeserializable {
/**
Indicates at what date the object is to be moved or deleted. Should be in GMT ISO 8601 Format.
 */
  public let date: Date?
/**
Indicates the lifetime, in days, of the objects that are subject to the rule. The value must be a non-zero positive integer.
 */
  public let days: Int?
/**
The class of storage used to store the object.
 */
  public let storageClass: Transitionstorageclass?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if date != nil { body["Date"] = date! }
    if days != nil { body["Days"] = days! }
    if storageClass != nil { body["StorageClass"] = storageClass! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Transition {
    guard case let .xml(node) = body else { fatalError() }
    return Transition(
        date: try! node.nodes(forXPath: "Date").first.map { Date.deserialize(response: response, body: .xml($0)) },
      days: try! node.nodes(forXPath: "Days").first.map { Int.deserialize(response: response, body: .xml($0)) },
      storageClass: try! node.nodes(forXPath: "StorageClass").first.map { Transitionstorageclass.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - date: Indicates at what date the object is to be moved or deleted. Should be in GMT ISO 8601 Format.
      - days: Indicates the lifetime, in days, of the objects that are subject to the rule. The value must be a non-zero positive integer.
      - storageClass: The class of storage used to store the object.
 */
  public init(date: Date?, days: Int?, storageClass: Transitionstorageclass?) {
self.date = date
self.days = days
self.storageClass = storageClass
  }
}


enum Transitionstorageclass: String, AwswiftDeserializable, AwswiftSerializable {
  case `gLACIER` = "GLACIER"
  case `sTANDARD_IA` = "STANDARD_IA"

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Transitionstorageclass {
    switch body { 
    case .json(let json): return Transitionstorageclass(rawValue: json as! String)!
    case .xml(let node): return Transitionstorageclass(rawValue: node.stringValue!)!
    }
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}

enum S3Type: String, AwswiftDeserializable, AwswiftSerializable {
  case `canonicalUser` = "CanonicalUser"
  case `amazonCustomerByEmail` = "AmazonCustomerByEmail"
  case `group` = "Group"

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> S3Type {
    switch body { 
    case .json(let json): return S3Type(rawValue: json as! String)!
    case .xml(let node): return S3Type(rawValue: node.stringValue!)!
    }
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}



public struct UploadPartCopyOutput: AwswiftDeserializable {
/**

 */
  public let copyPartResult: CopyPartResult?
/**
The version of the source object that was copied, if you have enabled versioning on the source bucket.
 */
  public let copySourceVersionId: String?
/**

 */
  public let requestCharged: Requestcharged?
/**
If server-side encryption with a customer-provided encryption key was requested, the response will include this header confirming the encryption algorithm used.
 */
  public let sSECustomerAlgorithm: String?
/**
If server-side encryption with a customer-provided encryption key was requested, the response will include this header to provide round trip message integrity verification of the customer-provided encryption key.
 */
  public let sSECustomerKeyMD5: String?
/**
If present, specifies the ID of the AWS Key Management Service (KMS) master encryption key that was used for the object.
 */
  public let sSEKMSKeyId: String?
/**
The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).
 */
  public let serverSideEncryption: Serversideencryption?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> UploadPartCopyOutput {
    guard case let .xml(node) = body else { fatalError() }
    return UploadPartCopyOutput(
        copyPartResult: try! node.nodes(forXPath: "CopyPartResult").first.map { CopyPartResult.deserialize(response: response, body: .xml($0)) },
      copySourceVersionId: response.allHeaderFields["x-amz-copy-source-version-id"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      requestCharged: response.allHeaderFields["x-amz-request-charged"].flatMap { ($0 is NSNull) ? nil : Requestcharged.deserialize(response: response, body: .json($0)) },
      sSECustomerAlgorithm: response.allHeaderFields["x-amz-server-side-encryption-customer-algorithm"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      sSECustomerKeyMD5: response.allHeaderFields["x-amz-server-side-encryption-customer-key-MD5"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      sSEKMSKeyId: response.allHeaderFields["x-amz-server-side-encryption-aws-kms-key-id"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      serverSideEncryption: response.allHeaderFields["x-amz-server-side-encryption"].flatMap { ($0 is NSNull) ? nil : Serversideencryption.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - copyPartResult: 
      - copySourceVersionId: The version of the source object that was copied, if you have enabled versioning on the source bucket.
      - requestCharged: 
      - sSECustomerAlgorithm: If server-side encryption with a customer-provided encryption key was requested, the response will include this header confirming the encryption algorithm used.
      - sSECustomerKeyMD5: If server-side encryption with a customer-provided encryption key was requested, the response will include this header to provide round trip message integrity verification of the customer-provided encryption key.
      - sSEKMSKeyId: If present, specifies the ID of the AWS Key Management Service (KMS) master encryption key that was used for the object.
      - serverSideEncryption: The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).
 */
  public init(copyPartResult: CopyPartResult?, copySourceVersionId: String?, requestCharged: Requestcharged?, sSECustomerAlgorithm: String?, sSECustomerKeyMD5: String?, sSEKMSKeyId: String?, serverSideEncryption: Serversideencryption?) {
self.copyPartResult = copyPartResult
self.copySourceVersionId = copySourceVersionId
self.requestCharged = requestCharged
self.sSECustomerAlgorithm = sSECustomerAlgorithm
self.sSECustomerKeyMD5 = sSECustomerKeyMD5
self.sSEKMSKeyId = sSEKMSKeyId
self.serverSideEncryption = serverSideEncryption
  }
}

public struct UploadPartCopyRequest: AwswiftSerializable {
/**

 */
  public let bucket: String
/**
The name of the source bucket and key name of the source object, separated by a slash (/). Must be URL-encoded.
 */
  public let copySource: String
/**
Copies the object if its entity tag (ETag) matches the specified tag.
 */
  public let copySourceIfMatch: String?
/**
Copies the object if it has been modified since the specified time.
 */
  public let copySourceIfModifiedSince: Date?
/**
Copies the object if its entity tag (ETag) is different than the specified ETag.
 */
  public let copySourceIfNoneMatch: String?
/**
Copies the object if it hasn't been modified since the specified time.
 */
  public let copySourceIfUnmodifiedSince: Date?
/**
The range of bytes to copy from the source object. The range value must use the form bytes=first-last, where the first and last are the zero-based byte offsets to copy. For example, bytes=0-9 indicates that you want to copy the first ten bytes of the source. You can copy a range only if the source object is greater than 5 GB.
 */
  public let copySourceRange: String?
/**
Specifies the algorithm to use when decrypting the source object (e.g., AES256).
 */
  public let copySourceSSECustomerAlgorithm: String?
/**
Specifies the customer-provided encryption key for Amazon S3 to use to decrypt the source object. The encryption key provided in this header must be one that was used when the source object was created.
 */
  public let copySourceSSECustomerKey: String?
/**
Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure the encryption key was transmitted without error.
 */
  public let copySourceSSECustomerKeyMD5: String?
/**

 */
  public let key: String
/**
Part number of part being copied. This is a positive integer between 1 and 10,000.
 */
  public let partNumber: Int
/**

 */
  public let requestPayer: Requestpayer?
/**
Specifies the algorithm to use to when encrypting the object (e.g., AES256).
 */
  public let sSECustomerAlgorithm: String?
/**
Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data. This value is used to store the object and then it is discarded; Amazon does not store the encryption key. The key must be appropriate for use with the algorithm specified in the x-amz-server-side​-encryption​-customer-algorithm header. This must be the same encryption key specified in the initiate multipart upload request.
 */
  public let sSECustomerKey: String?
/**
Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure the encryption key was transmitted without error.
 */
  public let sSECustomerKeyMD5: String?
/**
Upload ID identifying the multipart upload whose part is being copied.
 */
  public let uploadId: String

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    var querystring: [String: String] = [:]
    var header: [String: String] = [:]
    
  
    uri["Bucket"] = "\(bucket)"
    uri["Key"] = "\(key)"
    querystring["partNumber"] = "\(partNumber)"
    querystring["uploadId"] = "\(uploadId)"
    header["x-amz-copy-source"] = "\(copySource)"
    if copySourceIfMatch != nil { header["x-amz-copy-source-if-match"] = "\(copySourceIfMatch!)" }
    if copySourceIfModifiedSince != nil { header["x-amz-copy-source-if-modified-since"] = "\(copySourceIfModifiedSince!)" }
    if copySourceIfNoneMatch != nil { header["x-amz-copy-source-if-none-match"] = "\(copySourceIfNoneMatch!)" }
    if copySourceIfUnmodifiedSince != nil { header["x-amz-copy-source-if-unmodified-since"] = "\(copySourceIfUnmodifiedSince!)" }
    if copySourceRange != nil { header["x-amz-copy-source-range"] = "\(copySourceRange!)" }
    if copySourceSSECustomerAlgorithm != nil { header["x-amz-copy-source-server-side-encryption-customer-algorithm"] = "\(copySourceSSECustomerAlgorithm!)" }
    if copySourceSSECustomerKey != nil { header["x-amz-copy-source-server-side-encryption-customer-key"] = "\(copySourceSSECustomerKey!)" }
    if copySourceSSECustomerKeyMD5 != nil { header["x-amz-copy-source-server-side-encryption-customer-key-MD5"] = "\(copySourceSSECustomerKeyMD5!)" }
    if requestPayer != nil { header["x-amz-request-payer"] = "\(requestPayer!)" }
    if sSECustomerAlgorithm != nil { header["x-amz-server-side-encryption-customer-algorithm"] = "\(sSECustomerAlgorithm!)" }
    if sSECustomerKey != nil { header["x-amz-server-side-encryption-customer-key"] = "\(sSECustomerKey!)" }
    if sSECustomerKeyMD5 != nil { header["x-amz-server-side-encryption-customer-key-MD5"] = "\(sSECustomerKeyMD5!)" }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - bucket: 
      - copySource: The name of the source bucket and key name of the source object, separated by a slash (/). Must be URL-encoded.
      - copySourceIfMatch: Copies the object if its entity tag (ETag) matches the specified tag.
      - copySourceIfModifiedSince: Copies the object if it has been modified since the specified time.
      - copySourceIfNoneMatch: Copies the object if its entity tag (ETag) is different than the specified ETag.
      - copySourceIfUnmodifiedSince: Copies the object if it hasn't been modified since the specified time.
      - copySourceRange: The range of bytes to copy from the source object. The range value must use the form bytes=first-last, where the first and last are the zero-based byte offsets to copy. For example, bytes=0-9 indicates that you want to copy the first ten bytes of the source. You can copy a range only if the source object is greater than 5 GB.
      - copySourceSSECustomerAlgorithm: Specifies the algorithm to use when decrypting the source object (e.g., AES256).
      - copySourceSSECustomerKey: Specifies the customer-provided encryption key for Amazon S3 to use to decrypt the source object. The encryption key provided in this header must be one that was used when the source object was created.
      - copySourceSSECustomerKeyMD5: Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure the encryption key was transmitted without error.
      - key: 
      - partNumber: Part number of part being copied. This is a positive integer between 1 and 10,000.
      - requestPayer: 
      - sSECustomerAlgorithm: Specifies the algorithm to use to when encrypting the object (e.g., AES256).
      - sSECustomerKey: Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data. This value is used to store the object and then it is discarded; Amazon does not store the encryption key. The key must be appropriate for use with the algorithm specified in the x-amz-server-side​-encryption​-customer-algorithm header. This must be the same encryption key specified in the initiate multipart upload request.
      - sSECustomerKeyMD5: Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure the encryption key was transmitted without error.
      - uploadId: Upload ID identifying the multipart upload whose part is being copied.
 */
  public init(bucket: String, copySource: String, copySourceIfMatch: String?, copySourceIfModifiedSince: Date?, copySourceIfNoneMatch: String?, copySourceIfUnmodifiedSince: Date?, copySourceRange: String?, copySourceSSECustomerAlgorithm: String?, copySourceSSECustomerKey: String?, copySourceSSECustomerKeyMD5: String?, key: String, partNumber: Int, requestPayer: Requestpayer?, sSECustomerAlgorithm: String?, sSECustomerKey: String?, sSECustomerKeyMD5: String?, uploadId: String) {
self.bucket = bucket
self.copySource = copySource
self.copySourceIfMatch = copySourceIfMatch
self.copySourceIfModifiedSince = copySourceIfModifiedSince
self.copySourceIfNoneMatch = copySourceIfNoneMatch
self.copySourceIfUnmodifiedSince = copySourceIfUnmodifiedSince
self.copySourceRange = copySourceRange
self.copySourceSSECustomerAlgorithm = copySourceSSECustomerAlgorithm
self.copySourceSSECustomerKey = copySourceSSECustomerKey
self.copySourceSSECustomerKeyMD5 = copySourceSSECustomerKeyMD5
self.key = key
self.partNumber = partNumber
self.requestPayer = requestPayer
self.sSECustomerAlgorithm = sSECustomerAlgorithm
self.sSECustomerKey = sSECustomerKey
self.sSECustomerKeyMD5 = sSECustomerKeyMD5
self.uploadId = uploadId
  }
}

public struct UploadPartOutput: AwswiftDeserializable {
/**
Entity tag for the uploaded object.
 */
  public let eTag: String?
/**

 */
  public let requestCharged: Requestcharged?
/**
If server-side encryption with a customer-provided encryption key was requested, the response will include this header confirming the encryption algorithm used.
 */
  public let sSECustomerAlgorithm: String?
/**
If server-side encryption with a customer-provided encryption key was requested, the response will include this header to provide round trip message integrity verification of the customer-provided encryption key.
 */
  public let sSECustomerKeyMD5: String?
/**
If present, specifies the ID of the AWS Key Management Service (KMS) master encryption key that was used for the object.
 */
  public let sSEKMSKeyId: String?
/**
The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).
 */
  public let serverSideEncryption: Serversideencryption?


  static func deserializableBody(data: Data) -> DeserializableBody {
    fatalError()
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> UploadPartOutput {
  
    return UploadPartOutput(
        eTag: response.allHeaderFields["ETag"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      requestCharged: response.allHeaderFields["x-amz-request-charged"].flatMap { ($0 is NSNull) ? nil : Requestcharged.deserialize(response: response, body: .json($0)) },
      sSECustomerAlgorithm: response.allHeaderFields["x-amz-server-side-encryption-customer-algorithm"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      sSECustomerKeyMD5: response.allHeaderFields["x-amz-server-side-encryption-customer-key-MD5"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      sSEKMSKeyId: response.allHeaderFields["x-amz-server-side-encryption-aws-kms-key-id"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      serverSideEncryption: response.allHeaderFields["x-amz-server-side-encryption"].flatMap { ($0 is NSNull) ? nil : Serversideencryption.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - eTag: Entity tag for the uploaded object.
      - requestCharged: 
      - sSECustomerAlgorithm: If server-side encryption with a customer-provided encryption key was requested, the response will include this header confirming the encryption algorithm used.
      - sSECustomerKeyMD5: If server-side encryption with a customer-provided encryption key was requested, the response will include this header to provide round trip message integrity verification of the customer-provided encryption key.
      - sSEKMSKeyId: If present, specifies the ID of the AWS Key Management Service (KMS) master encryption key that was used for the object.
      - serverSideEncryption: The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).
 */
  public init(eTag: String?, requestCharged: Requestcharged?, sSECustomerAlgorithm: String?, sSECustomerKeyMD5: String?, sSEKMSKeyId: String?, serverSideEncryption: Serversideencryption?) {
self.eTag = eTag
self.requestCharged = requestCharged
self.sSECustomerAlgorithm = sSECustomerAlgorithm
self.sSECustomerKeyMD5 = sSECustomerKeyMD5
self.sSEKMSKeyId = sSEKMSKeyId
self.serverSideEncryption = serverSideEncryption
  }
}

public struct UploadPartRequest: AwswiftSerializable {
/**
Object data.
 */
  public let s3Body: Data?
/**
Name of the bucket to which the multipart upload was initiated.
 */
  public let bucket: String
/**
Size of the body in bytes. This parameter is useful when the size of the body cannot be determined automatically.
 */
  public let contentLength: Int?
/**
The base64-encoded 128-bit MD5 digest of the part data.
 */
  public let contentMD5: String?
/**
Object key for which the multipart upload was initiated.
 */
  public let key: String
/**
Part number of part being uploaded. This is a positive integer between 1 and 10,000.
 */
  public let partNumber: Int
/**

 */
  public let requestPayer: Requestpayer?
/**
Specifies the algorithm to use to when encrypting the object (e.g., AES256).
 */
  public let sSECustomerAlgorithm: String?
/**
Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data. This value is used to store the object and then it is discarded; Amazon does not store the encryption key. The key must be appropriate for use with the algorithm specified in the x-amz-server-side​-encryption​-customer-algorithm header. This must be the same encryption key specified in the initiate multipart upload request.
 */
  public let sSECustomerKey: String?
/**
Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure the encryption key was transmitted without error.
 */
  public let sSECustomerKeyMD5: String?
/**
Upload ID identifying the multipart upload whose part is being uploaded.
 */
  public let uploadId: String

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    var querystring: [String: String] = [:]
    var header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    uri["Bucket"] = "\(bucket)"
    uri["Key"] = "\(key)"
    querystring["partNumber"] = "\(partNumber)"
    querystring["uploadId"] = "\(uploadId)"
    if contentLength != nil { header["Content-Length"] = "\(contentLength!)" }
    if contentMD5 != nil { header["Content-MD5"] = "\(contentMD5!)" }
    if requestPayer != nil { header["x-amz-request-payer"] = "\(requestPayer!)" }
    if sSECustomerAlgorithm != nil { header["x-amz-server-side-encryption-customer-algorithm"] = "\(sSECustomerAlgorithm!)" }
    if sSECustomerKey != nil { header["x-amz-server-side-encryption-customer-key"] = "\(sSECustomerKey!)" }
    if sSECustomerKeyMD5 != nil { header["x-amz-server-side-encryption-customer-key-MD5"] = "\(sSECustomerKeyMD5!)" }
    if s3Body != nil { body["Body"] = s3Body! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - s3Body: Object data.
      - bucket: Name of the bucket to which the multipart upload was initiated.
      - contentLength: Size of the body in bytes. This parameter is useful when the size of the body cannot be determined automatically.
      - contentMD5: The base64-encoded 128-bit MD5 digest of the part data.
      - key: Object key for which the multipart upload was initiated.
      - partNumber: Part number of part being uploaded. This is a positive integer between 1 and 10,000.
      - requestPayer: 
      - sSECustomerAlgorithm: Specifies the algorithm to use to when encrypting the object (e.g., AES256).
      - sSECustomerKey: Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data. This value is used to store the object and then it is discarded; Amazon does not store the encryption key. The key must be appropriate for use with the algorithm specified in the x-amz-server-side​-encryption​-customer-algorithm header. This must be the same encryption key specified in the initiate multipart upload request.
      - sSECustomerKeyMD5: Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure the encryption key was transmitted without error.
      - uploadId: Upload ID identifying the multipart upload whose part is being uploaded.
 */
  public init(s3Body: Data?, bucket: String, contentLength: Int?, contentMD5: String?, key: String, partNumber: Int, requestPayer: Requestpayer?, sSECustomerAlgorithm: String?, sSECustomerKey: String?, sSECustomerKeyMD5: String?, uploadId: String) {
self.s3Body = s3Body
self.bucket = bucket
self.contentLength = contentLength
self.contentMD5 = contentMD5
self.key = key
self.partNumber = partNumber
self.requestPayer = requestPayer
self.sSECustomerAlgorithm = sSECustomerAlgorithm
self.sSECustomerKey = sSECustomerKey
self.sSECustomerKeyMD5 = sSECustomerKeyMD5
self.uploadId = uploadId
  }
}



public struct VersioningConfiguration: AwswiftSerializable, AwswiftDeserializable {
/**
Specifies whether MFA delete is enabled in the bucket versioning configuration. This element is only returned if the bucket has been configured with MFA delete. If the bucket has never been so configured, this element is not returned.
 */
  public let mFADelete: Mfadelete?
/**
The versioning state of the bucket.
 */
  public let status: Bucketversioningstatus?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if mFADelete != nil { body["MfaDelete"] = mFADelete! }
    if status != nil { body["Status"] = status! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> VersioningConfiguration {
    guard case let .xml(node) = body else { fatalError() }
    return VersioningConfiguration(
        mFADelete: try! node.nodes(forXPath: "MfaDelete").first.map { Mfadelete.deserialize(response: response, body: .xml($0)) },
      status: try! node.nodes(forXPath: "Status").first.map { Bucketversioningstatus.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - mFADelete: Specifies whether MFA delete is enabled in the bucket versioning configuration. This element is only returned if the bucket has been configured with MFA delete. If the bucket has never been so configured, this element is not returned.
      - status: The versioning state of the bucket.
 */
  public init(mFADelete: Mfadelete?, status: Bucketversioningstatus?) {
self.mFADelete = mFADelete
self.status = status
  }
}

public struct WebsiteConfiguration: AwswiftSerializable, AwswiftDeserializable {
/**

 */
  public let errorDocument: ErrorDocument?
/**

 */
  public let indexDocument: IndexDocument?
/**

 */
  public let redirectAllRequestsTo: RedirectAllRequestsTo?
/**

 */
  public let routingRules: [RoutingRule]?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if errorDocument != nil { body["ErrorDocument"] = errorDocument! }
    if indexDocument != nil { body["IndexDocument"] = indexDocument! }
    if redirectAllRequestsTo != nil { body["RedirectAllRequestsTo"] = redirectAllRequestsTo! }
    if routingRules != nil { body["RoutingRules"] = routingRules! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> WebsiteConfiguration {
    guard case let .xml(node) = body else { fatalError() }
    return WebsiteConfiguration(
        errorDocument: try! node.nodes(forXPath: "ErrorDocument").first.map { ErrorDocument.deserialize(response: response, body: .xml($0)) },
      indexDocument: try! node.nodes(forXPath: "IndexDocument").first.map { IndexDocument.deserialize(response: response, body: .xml($0)) },
      redirectAllRequestsTo: try! node.nodes(forXPath: "RedirectAllRequestsTo").first.map { RedirectAllRequestsTo.deserialize(response: response, body: .xml($0)) },
      routingRules: try! node.nodes(forXPath: "RoutingRules").map { RoutingRule.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - errorDocument: 
      - indexDocument: 
      - redirectAllRequestsTo: 
      - routingRules: 
 */
  public init(errorDocument: ErrorDocument?, indexDocument: IndexDocument?, redirectAllRequestsTo: RedirectAllRequestsTo?, routingRules: [RoutingRule]?) {
self.errorDocument = errorDocument
self.indexDocument = indexDocument
self.redirectAllRequestsTo = redirectAllRequestsTo
self.routingRules = routingRules
  }
}


}
