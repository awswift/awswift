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
Return torrent files from a bucket.
 */
func getObjectTorrent(input: GetObjectTorrentRequest) -> ApiCallTask<GetObjectTorrentOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}/{Key+}?torrent", 
      httpMethod: "GET", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}?notification", 
      httpMethod: "PUT", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}?cors", 
      httpMethod: "GET", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}/{Key+}", 
      httpMethod: "DELETE", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}", 
      httpMethod: "DELETE", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}/{Key+}", 
      httpMethod: "PUT", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}/{Key+}", 
      httpMethod: "DELETE", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}/{Key+}?restore", 
      httpMethod: "POST", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}?website", 
      httpMethod: "DELETE", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}/{Key+}?acl", 
      httpMethod: "PUT", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}?tagging", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}?list-type=2", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}?location", 
      httpMethod: "GET", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}?replication", 
      httpMethod: "DELETE", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}?lifecycle", 
      httpMethod: "PUT", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}?notification", 
      httpMethod: "GET", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}?versioning", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}?policy", 
      httpMethod: "PUT", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}?versions", 
      httpMethod: "GET", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}", 
      httpMethod: "PUT", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}?logging", 
      httpMethod: "GET", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}?website", 
      httpMethod: "PUT", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}?accelerate", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}?acl", 
      httpMethod: "GET", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}?replication", 
      httpMethod: "PUT", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/", 
      httpMethod: "GET", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}?delete", 
      httpMethod: "POST", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}?requestPayment", 
      httpMethod: "PUT", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}?notification", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}?lifecycle", 
      httpMethod: "GET", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}?logging", 
      httpMethod: "PUT", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}?tagging", 
      httpMethod: "DELETE", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}?lifecycle", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}?uploads", 
      httpMethod: "GET", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}/{Key+}", 
      httpMethod: "PUT", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}?policy", 
      httpMethod: "DELETE", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}?accelerate", 
      httpMethod: "PUT", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}", 
      httpMethod: "HEAD", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}/{Key+}", 
      httpMethod: "PUT", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}?replication", 
      httpMethod: "GET", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}/{Key+}", 
      httpMethod: "POST", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}?notification", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}?acl", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}/{Key+}?uploads", 
      httpMethod: "POST", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}?cors", 
      httpMethod: "PUT", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}/{Key+}?acl", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}/{Key+}", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}/{Key+}", 
      httpMethod: "GET", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}/{Key+}", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}?lifecycle", 
      httpMethod: "PUT", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}?lifecycle", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}?cors", 
      httpMethod: "DELETE", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}?versioning", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}?requestPayment", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}?website", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}?policy", 
      httpMethod: "GET", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}/{Key+}", 
      httpMethod: "HEAD", 
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
      urlString: "https://s3-\(self.region).amazonaws.com/{Bucket}?tagging", 
      httpMethod: "PUT", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


  }

public struct DeleteBucketWebsiteRequest: RestJsonSerializable {
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


public struct LifecycleExpiration: RestJsonSerializable, RestJsonDeserializable {
/**
Indicates whether Amazon S3 will remove a delete marker with no noncurrent versions. If set to true, the delete marker will be expired; if set to false the policy takes no action. This cannot be specified with Days or Date in a Lifecycle Expiration Policy.
 */
  public let expiredObjectDeleteMarker: Bool?
/**
Indicates at what date the object is to be moved or deleted. Should be in GMT ISO 8601 Format.
 */
  public let date: Date?
/**
Indicates the lifetime, in days, of the objects that are subject to the rule. The value must be a non-zero positive integer.
 */
  public let days: Int?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if expiredObjectDeleteMarker != nil { body["ExpiredObjectDeleteMarker"] = expiredObjectDeleteMarker! }
    if date != nil { body["Date"] = date! }
    if days != nil { body["Days"] = days! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserialize(response: HTTPURLResponse, json: Any) -> LifecycleExpiration {
    let jsonDict = json as! [String: Any]
    return LifecycleExpiration(
        expiredObjectDeleteMarker: jsonDict["ExpiredObjectDeleteMarker"].flatMap { ($0 is NSNull) ? nil : Bool.deserialize(response: response, json: $0) },
      date: jsonDict["Date"].flatMap { ($0 is NSNull) ? nil : Date.deserialize(response: response, json: $0) },
      days: jsonDict["Days"].flatMap { ($0 is NSNull) ? nil : Int.deserialize(response: response, json: $0) }
    )
  }

/**
    - parameters:
      - expiredObjectDeleteMarker: Indicates whether Amazon S3 will remove a delete marker with no noncurrent versions. If set to true, the delete marker will be expired; if set to false the policy takes no action. This cannot be specified with Days or Date in a Lifecycle Expiration Policy.
      - date: Indicates at what date the object is to be moved or deleted. Should be in GMT ISO 8601 Format.
      - days: Indicates the lifetime, in days, of the objects that are subject to the rule. The value must be a non-zero positive integer.
 */
  public init(expiredObjectDeleteMarker: Bool?, date: Date?, days: Int?) {
self.expiredObjectDeleteMarker = expiredObjectDeleteMarker
self.date = date
self.days = days
  }
}


public struct PutBucketCorsRequest: RestJsonSerializable {
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


public struct DeleteBucketCorsRequest: RestJsonSerializable {
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


public struct GetBucketLifecycleConfigurationRequest: RestJsonSerializable {
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

public struct GetObjectAclRequest: RestJsonSerializable {
/**

 */
  public let bucket: String
/**
VersionId used to reference a specific version of the object.
 */
  public let versionId: String?
/**

 */
  public let key: String
/**

 */
  public let requestPayer: Requestpayer?

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
      - versionId: VersionId used to reference a specific version of the object.
      - key: 
      - requestPayer: 
 */
  public init(bucket: String, versionId: String?, key: String, requestPayer: Requestpayer?) {
self.bucket = bucket
self.versionId = versionId
self.key = key
self.requestPayer = requestPayer
  }
}


public struct GetBucketReplicationRequest: RestJsonSerializable {
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


public struct Rule: RestJsonSerializable, RestJsonDeserializable {
/**
Unique identifier for the rule. The value cannot be longer than 255 characters.
 */
  public let iD: String?
/**
If 'Enabled', the rule is currently being applied. If 'Disabled', the rule is not currently being applied.
 */
  public let status: Expirationstatus
/**

 */
  public let abortIncompleteMultipartUpload: AbortIncompleteMultipartUpload?
/**

 */
  public let noncurrentVersionExpiration: NoncurrentVersionExpiration?
/**

 */
  public let transition: Transition?
/**

 */
  public let noncurrentVersionTransition: NoncurrentVersionTransition?
/**

 */
  public let expiration: LifecycleExpiration?
/**
Prefix identifying one or more objects to which the rule applies.
 */
  public let prefix: String

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if iD != nil { body["ID"] = iD! }
    body["Status"] = status
    if abortIncompleteMultipartUpload != nil { body["AbortIncompleteMultipartUpload"] = abortIncompleteMultipartUpload! }
    if noncurrentVersionExpiration != nil { body["NoncurrentVersionExpiration"] = noncurrentVersionExpiration! }
    if transition != nil { body["Transition"] = transition! }
    if noncurrentVersionTransition != nil { body["NoncurrentVersionTransition"] = noncurrentVersionTransition! }
    if expiration != nil { body["Expiration"] = expiration! }
    body["Prefix"] = prefix
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserialize(response: HTTPURLResponse, json: Any) -> Rule {
    let jsonDict = json as! [String: Any]
    return Rule(
        iD: jsonDict["ID"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      status: jsonDict["Status"].flatMap { ($0 is NSNull) ? nil : Expirationstatus.deserialize(response: response, json: $0) }!,
      abortIncompleteMultipartUpload: jsonDict["AbortIncompleteMultipartUpload"].flatMap { ($0 is NSNull) ? nil : AbortIncompleteMultipartUpload.deserialize(response: response, json: $0) },
      noncurrentVersionExpiration: jsonDict["NoncurrentVersionExpiration"].flatMap { ($0 is NSNull) ? nil : NoncurrentVersionExpiration.deserialize(response: response, json: $0) },
      transition: jsonDict["Transition"].flatMap { ($0 is NSNull) ? nil : Transition.deserialize(response: response, json: $0) },
      noncurrentVersionTransition: jsonDict["NoncurrentVersionTransition"].flatMap { ($0 is NSNull) ? nil : NoncurrentVersionTransition.deserialize(response: response, json: $0) },
      expiration: jsonDict["Expiration"].flatMap { ($0 is NSNull) ? nil : LifecycleExpiration.deserialize(response: response, json: $0) },
      prefix: jsonDict["Prefix"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) }!
    )
  }

/**
    - parameters:
      - iD: Unique identifier for the rule. The value cannot be longer than 255 characters.
      - status: If 'Enabled', the rule is currently being applied. If 'Disabled', the rule is not currently being applied.
      - abortIncompleteMultipartUpload: 
      - noncurrentVersionExpiration: 
      - transition: 
      - noncurrentVersionTransition: 
      - expiration: 
      - prefix: Prefix identifying one or more objects to which the rule applies.
 */
  public init(iD: String?, status: Expirationstatus, abortIncompleteMultipartUpload: AbortIncompleteMultipartUpload?, noncurrentVersionExpiration: NoncurrentVersionExpiration?, transition: Transition?, noncurrentVersionTransition: NoncurrentVersionTransition?, expiration: LifecycleExpiration?, prefix: String) {
self.iD = iD
self.status = status
self.abortIncompleteMultipartUpload = abortIncompleteMultipartUpload
self.noncurrentVersionExpiration = noncurrentVersionExpiration
self.transition = transition
self.noncurrentVersionTransition = noncurrentVersionTransition
self.expiration = expiration
self.prefix = prefix
  }
}

public struct AccessControlPolicy: RestJsonSerializable, RestJsonDeserializable {
/**

 */
  public let owner: Owner?
/**
A list of grants.
 */
  public let grants: [Grant]?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if owner != nil { body["Owner"] = owner! }
    if grants != nil { body["AccessControlList"] = grants! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserialize(response: HTTPURLResponse, json: Any) -> AccessControlPolicy {
    let jsonDict = json as! [String: Any]
    return AccessControlPolicy(
        owner: jsonDict["Owner"].flatMap { ($0 is NSNull) ? nil : Owner.deserialize(response: response, json: $0) },
      grants: jsonDict["AccessControlList"].flatMap { ($0 is NSNull) ? nil : [Grant].deserialize(response: response, json: $0) }
    )
  }

/**
    - parameters:
      - owner: 
      - grants: A list of grants.
 */
  public init(owner: Owner?, grants: [Grant]?) {
self.owner = owner
self.grants = grants
  }
}



public struct DeleteBucketLifecycleRequest: RestJsonSerializable {
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

public struct CreateBucketOutput: RestJsonDeserializable {
/**

 */
  public let location: String?


  static func deserialize(response: HTTPURLResponse, json: Any) -> CreateBucketOutput {
  
    return CreateBucketOutput(
        location: response.allHeaderFields["Location"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) }
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


public struct GetBucketPolicyRequest: RestJsonSerializable {
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

public struct CopyObjectResult: RestJsonSerializable, RestJsonDeserializable {
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

  static func deserialize(response: HTTPURLResponse, json: Any) -> CopyObjectResult {
    let jsonDict = json as! [String: Any]
    return CopyObjectResult(
        eTag: jsonDict["ETag"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      lastModified: jsonDict["LastModified"].flatMap { ($0 is NSNull) ? nil : Date.deserialize(response: response, json: $0) }
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

enum Payer: String, RestJsonDeserializable, RestJsonSerializable {
  case `requester` = "Requester"
  case `bucketOwner` = "BucketOwner"

  static func deserialize(response: HTTPURLResponse, json: Any) -> Payer {
    return Payer(rawValue: json as! String)!
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}



public struct PutBucketAccelerateConfigurationRequest: RestJsonSerializable {
/**
Name of the bucket for which the accelerate configuration is set.
 */
  public let bucket: String
/**
Specifies the Accelerate Configuration you want to set for the bucket.
 */
  public let accelerateConfiguration: AccelerateConfiguration

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
      - bucket: Name of the bucket for which the accelerate configuration is set.
      - accelerateConfiguration: Specifies the Accelerate Configuration you want to set for the bucket.
 */
  public init(bucket: String, accelerateConfiguration: AccelerateConfiguration) {
self.bucket = bucket
self.accelerateConfiguration = accelerateConfiguration
  }
}

/**
The specified multipart upload does not exist.
 */
public struct NoSuchUpload: RestJsonSerializable, RestJsonDeserializable {

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }

  static func deserialize(response: HTTPURLResponse, json: Any) -> NoSuchUpload {
  
    return NoSuchUpload(
  
    )
  }

/**
    - parameters:
 */
  public init() {
  }
}

public struct GetBucketLocationOutput: RestJsonDeserializable {
/**

 */
  public let locationConstraint: Bucketlocationconstraint?


  static func deserialize(response: HTTPURLResponse, json: Any) -> GetBucketLocationOutput {
    let jsonDict = json as! [String: Any]
    return GetBucketLocationOutput(
        locationConstraint: jsonDict["LocationConstraint"].flatMap { ($0 is NSNull) ? nil : Bucketlocationconstraint.deserialize(response: response, json: $0) }
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



public struct GetBucketWebsiteOutput: RestJsonDeserializable {
/**

 */
  public let routingRules: [RoutingRule]?
/**

 */
  public let indexDocument: IndexDocument?
/**

 */
  public let errorDocument: ErrorDocument?
/**

 */
  public let redirectAllRequestsTo: RedirectAllRequestsTo?


  static func deserialize(response: HTTPURLResponse, json: Any) -> GetBucketWebsiteOutput {
    let jsonDict = json as! [String: Any]
    return GetBucketWebsiteOutput(
        routingRules: jsonDict["RoutingRules"].flatMap { ($0 is NSNull) ? nil : [RoutingRule].deserialize(response: response, json: $0) },
      indexDocument: jsonDict["IndexDocument"].flatMap { ($0 is NSNull) ? nil : IndexDocument.deserialize(response: response, json: $0) },
      errorDocument: jsonDict["ErrorDocument"].flatMap { ($0 is NSNull) ? nil : ErrorDocument.deserialize(response: response, json: $0) },
      redirectAllRequestsTo: jsonDict["RedirectAllRequestsTo"].flatMap { ($0 is NSNull) ? nil : RedirectAllRequestsTo.deserialize(response: response, json: $0) }
    )
  }

/**
    - parameters:
      - routingRules: 
      - indexDocument: 
      - errorDocument: 
      - redirectAllRequestsTo: 
 */
  public init(routingRules: [RoutingRule]?, indexDocument: IndexDocument?, errorDocument: ErrorDocument?, redirectAllRequestsTo: RedirectAllRequestsTo?) {
self.routingRules = routingRules
self.indexDocument = indexDocument
self.errorDocument = errorDocument
self.redirectAllRequestsTo = redirectAllRequestsTo
  }
}



public struct RedirectAllRequestsTo: RestJsonSerializable, RestJsonDeserializable {
/**
Name of the host where requests will be redirected.
 */
  public let hostName: String
/**
Protocol to use (http, https) when redirecting requests. The default is the protocol that is used in the original request.
 */
  public let protocolProtocol: ProtocolProtocol?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["HostName"] = hostName
    if protocolProtocol != nil { body["Protocol"] = protocolProtocol! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserialize(response: HTTPURLResponse, json: Any) -> RedirectAllRequestsTo {
    let jsonDict = json as! [String: Any]
    return RedirectAllRequestsTo(
        hostName: jsonDict["HostName"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) }!,
      protocolProtocol: jsonDict["Protocol"].flatMap { ($0 is NSNull) ? nil : ProtocolProtocol.deserialize(response: response, json: $0) }
    )
  }

/**
    - parameters:
      - hostName: Name of the host where requests will be redirected.
      - protocolProtocol: Protocol to use (http, https) when redirecting requests. The default is the protocol that is used in the original request.
 */
  public init(hostName: String, protocolProtocol: ProtocolProtocol?) {
self.hostName = hostName
self.protocolProtocol = protocolProtocol
  }
}



public struct CORSConfiguration: RestJsonSerializable, RestJsonDeserializable {
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

  static func deserialize(response: HTTPURLResponse, json: Any) -> CORSConfiguration {
    let jsonDict = json as! [String: Any]
    return CORSConfiguration(
        cORSRules: jsonDict["CORSRule"].flatMap { ($0 is NSNull) ? nil : [CORSRule].deserialize(response: response, json: $0) }!
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

public struct ObjectIdentifier: RestJsonSerializable, RestJsonDeserializable {
/**
VersionId for the specific version of the object to delete.
 */
  public let versionId: String?
/**
Key name of the object to delete.
 */
  public let key: String

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if versionId != nil { body["VersionId"] = versionId! }
    body["Key"] = key
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserialize(response: HTTPURLResponse, json: Any) -> ObjectIdentifier {
    let jsonDict = json as! [String: Any]
    return ObjectIdentifier(
        versionId: jsonDict["VersionId"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      key: jsonDict["Key"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) }!
    )
  }

/**
    - parameters:
      - versionId: VersionId for the specific version of the object to delete.
      - key: Key name of the object to delete.
 */
  public init(versionId: String?, key: String) {
self.versionId = versionId
self.key = key
  }
}


/**
This operation is not allowed against this storage tier
 */
public struct ObjectAlreadyInActiveTierError: RestJsonSerializable, RestJsonDeserializable {

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }

  static func deserialize(response: HTTPURLResponse, json: Any) -> ObjectAlreadyInActiveTierError {
  
    return ObjectAlreadyInActiveTierError(
  
    )
  }

/**
    - parameters:
 */
  public init() {
  }
}

enum Serversideencryption: String, RestJsonDeserializable, RestJsonSerializable {
  case `aES256` = "AES256"
  case `awskms` = "aws:kms"

  static func deserialize(response: HTTPURLResponse, json: Any) -> Serversideencryption {
    return Serversideencryption(rawValue: json as! String)!
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}

public struct LoggingEnabled: RestJsonSerializable, RestJsonDeserializable {
/**

 */
  public let targetGrants: [TargetGrant]?
/**
This element lets you specify a prefix for the keys that the log files will be stored under.
 */
  public let targetPrefix: String?
/**
Specifies the bucket where you want Amazon S3 to store server access logs. You can have your logs delivered to any bucket that you own, including the same bucket that is being logged. You can also configure multiple buckets to deliver their logs to the same target bucket. In this case you should choose a different TargetPrefix for each source bucket so that the delivered log files can be distinguished by key.
 */
  public let targetBucket: String?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if targetGrants != nil { body["TargetGrants"] = targetGrants! }
    if targetPrefix != nil { body["TargetPrefix"] = targetPrefix! }
    if targetBucket != nil { body["TargetBucket"] = targetBucket! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserialize(response: HTTPURLResponse, json: Any) -> LoggingEnabled {
    let jsonDict = json as! [String: Any]
    return LoggingEnabled(
        targetGrants: jsonDict["TargetGrants"].flatMap { ($0 is NSNull) ? nil : [TargetGrant].deserialize(response: response, json: $0) },
      targetPrefix: jsonDict["TargetPrefix"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      targetBucket: jsonDict["TargetBucket"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) }
    )
  }

/**
    - parameters:
      - targetGrants: 
      - targetPrefix: This element lets you specify a prefix for the keys that the log files will be stored under.
      - targetBucket: Specifies the bucket where you want Amazon S3 to store server access logs. You can have your logs delivered to any bucket that you own, including the same bucket that is being logged. You can also configure multiple buckets to deliver their logs to the same target bucket. In this case you should choose a different TargetPrefix for each source bucket so that the delivered log files can be distinguished by key.
 */
  public init(targetGrants: [TargetGrant]?, targetPrefix: String?, targetBucket: String?) {
self.targetGrants = targetGrants
self.targetPrefix = targetPrefix
self.targetBucket = targetBucket
  }
}

public struct UploadPartCopyOutput: RestJsonDeserializable {
/**

 */
  public let copyPartResult: CopyPartResult?
/**
If server-side encryption with a customer-provided encryption key was requested, the response will include this header to provide round trip message integrity verification of the customer-provided encryption key.
 */
  public let sSECustomerKeyMD5: String?
/**
The version of the source object that was copied, if you have enabled versioning on the source bucket.
 */
  public let copySourceVersionId: String?
/**
If present, specifies the ID of the AWS Key Management Service (KMS) master encryption key that was used for the object.
 */
  public let sSEKMSKeyId: String?
/**
If server-side encryption with a customer-provided encryption key was requested, the response will include this header confirming the encryption algorithm used.
 */
  public let sSECustomerAlgorithm: String?
/**
The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).
 */
  public let serverSideEncryption: Serversideencryption?
/**

 */
  public let requestCharged: Requestcharged?


  static func deserialize(response: HTTPURLResponse, json: Any) -> UploadPartCopyOutput {
    let jsonDict = json as! [String: Any]
    return UploadPartCopyOutput(
        copyPartResult: jsonDict["CopyPartResult"].flatMap { ($0 is NSNull) ? nil : CopyPartResult.deserialize(response: response, json: $0) },
      sSECustomerKeyMD5: response.allHeaderFields["x-amz-server-side-encryption-customer-key-MD5"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      copySourceVersionId: response.allHeaderFields["x-amz-copy-source-version-id"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      sSEKMSKeyId: response.allHeaderFields["x-amz-server-side-encryption-aws-kms-key-id"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      sSECustomerAlgorithm: response.allHeaderFields["x-amz-server-side-encryption-customer-algorithm"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      serverSideEncryption: response.allHeaderFields["x-amz-server-side-encryption"].flatMap { ($0 is NSNull) ? nil : Serversideencryption.deserialize(response: response, json: $0) },
      requestCharged: response.allHeaderFields["x-amz-request-charged"].flatMap { ($0 is NSNull) ? nil : Requestcharged.deserialize(response: response, json: $0) }
    )
  }

/**
    - parameters:
      - copyPartResult: 
      - sSECustomerKeyMD5: If server-side encryption with a customer-provided encryption key was requested, the response will include this header to provide round trip message integrity verification of the customer-provided encryption key.
      - copySourceVersionId: The version of the source object that was copied, if you have enabled versioning on the source bucket.
      - sSEKMSKeyId: If present, specifies the ID of the AWS Key Management Service (KMS) master encryption key that was used for the object.
      - sSECustomerAlgorithm: If server-side encryption with a customer-provided encryption key was requested, the response will include this header confirming the encryption algorithm used.
      - serverSideEncryption: The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).
      - requestCharged: 
 */
  public init(copyPartResult: CopyPartResult?, sSECustomerKeyMD5: String?, copySourceVersionId: String?, sSEKMSKeyId: String?, sSECustomerAlgorithm: String?, serverSideEncryption: Serversideencryption?, requestCharged: Requestcharged?) {
self.copyPartResult = copyPartResult
self.sSECustomerKeyMD5 = sSECustomerKeyMD5
self.copySourceVersionId = copySourceVersionId
self.sSEKMSKeyId = sSEKMSKeyId
self.sSECustomerAlgorithm = sSECustomerAlgorithm
self.serverSideEncryption = serverSideEncryption
self.requestCharged = requestCharged
  }
}



public struct Tag: RestJsonSerializable, RestJsonDeserializable {
/**
Value of the tag.
 */
  public let value: String
/**
Name of the tag.
 */
  public let key: String

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["Value"] = value
    body["Key"] = key
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserialize(response: HTTPURLResponse, json: Any) -> Tag {
    let jsonDict = json as! [String: Any]
    return Tag(
        value: jsonDict["Value"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) }!,
      key: jsonDict["Key"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) }!
    )
  }

/**
    - parameters:
      - value: Value of the tag.
      - key: Name of the tag.
 */
  public init(value: String, key: String) {
self.value = value
self.key = key
  }
}

public struct Tagging: RestJsonSerializable, RestJsonDeserializable {
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

  static func deserialize(response: HTTPURLResponse, json: Any) -> Tagging {
    let jsonDict = json as! [String: Any]
    return Tagging(
        tagSet: jsonDict["TagSet"].flatMap { ($0 is NSNull) ? nil : [Tag].deserialize(response: response, json: $0) }!
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


public struct Owner: RestJsonSerializable, RestJsonDeserializable {
/**

 */
  public let iD: String?
/**

 */
  public let displayName: String?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if iD != nil { body["ID"] = iD! }
    if displayName != nil { body["DisplayName"] = displayName! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserialize(response: HTTPURLResponse, json: Any) -> Owner {
    let jsonDict = json as! [String: Any]
    return Owner(
        iD: jsonDict["ID"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      displayName: jsonDict["DisplayName"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) }
    )
  }

/**
    - parameters:
      - iD: 
      - displayName: 
 */
  public init(iD: String?, displayName: String?) {
self.iD = iD
self.displayName = displayName
  }
}

public struct CreateMultipartUploadOutput: RestJsonDeserializable {
/**
Name of the bucket to which the multipart upload was initiated.
 */
  public let bucket: String?
/**
Date when multipart upload will become eligible for abort operation by lifecycle.
 */
  public let abortDate: Date?
/**
Id of the lifecycle rule that makes a multipart upload eligible for abort operation.
 */
  public let abortRuleId: String?
/**
If server-side encryption with a customer-provided encryption key was requested, the response will include this header to provide round trip message integrity verification of the customer-provided encryption key.
 */
  public let sSECustomerKeyMD5: String?
/**
Object key for which the multipart upload was initiated.
 */
  public let key: String?
/**
ID for the initiated multipart upload.
 */
  public let uploadId: String?
/**
If present, specifies the ID of the AWS Key Management Service (KMS) master encryption key that was used for the object.
 */
  public let sSEKMSKeyId: String?
/**
If server-side encryption with a customer-provided encryption key was requested, the response will include this header confirming the encryption algorithm used.
 */
  public let sSECustomerAlgorithm: String?
/**

 */
  public let requestCharged: Requestcharged?
/**
The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).
 */
  public let serverSideEncryption: Serversideencryption?


  static func deserialize(response: HTTPURLResponse, json: Any) -> CreateMultipartUploadOutput {
    let jsonDict = json as! [String: Any]
    return CreateMultipartUploadOutput(
        bucket: jsonDict["Bucket"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      abortDate: response.allHeaderFields["x-amz-abort-date"].flatMap { ($0 is NSNull) ? nil : Date.deserialize(response: response, json: $0) },
      abortRuleId: response.allHeaderFields["x-amz-abort-rule-id"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      sSECustomerKeyMD5: response.allHeaderFields["x-amz-server-side-encryption-customer-key-MD5"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      key: jsonDict["Key"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      uploadId: jsonDict["UploadId"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      sSEKMSKeyId: response.allHeaderFields["x-amz-server-side-encryption-aws-kms-key-id"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      sSECustomerAlgorithm: response.allHeaderFields["x-amz-server-side-encryption-customer-algorithm"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      requestCharged: response.allHeaderFields["x-amz-request-charged"].flatMap { ($0 is NSNull) ? nil : Requestcharged.deserialize(response: response, json: $0) },
      serverSideEncryption: response.allHeaderFields["x-amz-server-side-encryption"].flatMap { ($0 is NSNull) ? nil : Serversideencryption.deserialize(response: response, json: $0) }
    )
  }

/**
    - parameters:
      - bucket: Name of the bucket to which the multipart upload was initiated.
      - abortDate: Date when multipart upload will become eligible for abort operation by lifecycle.
      - abortRuleId: Id of the lifecycle rule that makes a multipart upload eligible for abort operation.
      - sSECustomerKeyMD5: If server-side encryption with a customer-provided encryption key was requested, the response will include this header to provide round trip message integrity verification of the customer-provided encryption key.
      - key: Object key for which the multipart upload was initiated.
      - uploadId: ID for the initiated multipart upload.
      - sSEKMSKeyId: If present, specifies the ID of the AWS Key Management Service (KMS) master encryption key that was used for the object.
      - sSECustomerAlgorithm: If server-side encryption with a customer-provided encryption key was requested, the response will include this header confirming the encryption algorithm used.
      - requestCharged: 
      - serverSideEncryption: The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).
 */
  public init(bucket: String?, abortDate: Date?, abortRuleId: String?, sSECustomerKeyMD5: String?, key: String?, uploadId: String?, sSEKMSKeyId: String?, sSECustomerAlgorithm: String?, requestCharged: Requestcharged?, serverSideEncryption: Serversideencryption?) {
self.bucket = bucket
self.abortDate = abortDate
self.abortRuleId = abortRuleId
self.sSECustomerKeyMD5 = sSECustomerKeyMD5
self.key = key
self.uploadId = uploadId
self.sSEKMSKeyId = sSEKMSKeyId
self.sSECustomerAlgorithm = sSECustomerAlgorithm
self.requestCharged = requestCharged
self.serverSideEncryption = serverSideEncryption
  }
}

public struct Object: RestJsonSerializable, RestJsonDeserializable {
/**

 */
  public let lastModified: Date?
/**
The class of storage used to store the object.
 */
  public let storageClass: Objectstorageclass?
/**

 */
  public let key: String?
/**

 */
  public let eTag: String?
/**

 */
  public let owner: Owner?
/**

 */
  public let size: Int?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if lastModified != nil { body["LastModified"] = lastModified! }
    if storageClass != nil { body["StorageClass"] = storageClass! }
    if key != nil { body["Key"] = key! }
    if eTag != nil { body["ETag"] = eTag! }
    if owner != nil { body["Owner"] = owner! }
    if size != nil { body["Size"] = size! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserialize(response: HTTPURLResponse, json: Any) -> Object {
    let jsonDict = json as! [String: Any]
    return Object(
        lastModified: jsonDict["LastModified"].flatMap { ($0 is NSNull) ? nil : Date.deserialize(response: response, json: $0) },
      storageClass: jsonDict["StorageClass"].flatMap { ($0 is NSNull) ? nil : Objectstorageclass.deserialize(response: response, json: $0) },
      key: jsonDict["Key"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      eTag: jsonDict["ETag"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      owner: jsonDict["Owner"].flatMap { ($0 is NSNull) ? nil : Owner.deserialize(response: response, json: $0) },
      size: jsonDict["Size"].flatMap { ($0 is NSNull) ? nil : Int.deserialize(response: response, json: $0) }
    )
  }

/**
    - parameters:
      - lastModified: 
      - storageClass: The class of storage used to store the object.
      - key: 
      - eTag: 
      - owner: 
      - size: 
 */
  public init(lastModified: Date?, storageClass: Objectstorageclass?, key: String?, eTag: String?, owner: Owner?, size: Int?) {
self.lastModified = lastModified
self.storageClass = storageClass
self.key = key
self.eTag = eTag
self.owner = owner
self.size = size
  }
}



public struct RestoreObjectOutput: RestJsonDeserializable {
/**

 */
  public let requestCharged: Requestcharged?


  static func deserialize(response: HTTPURLResponse, json: Any) -> RestoreObjectOutput {
  
    return RestoreObjectOutput(
        requestCharged: response.allHeaderFields["x-amz-request-charged"].flatMap { ($0 is NSNull) ? nil : Requestcharged.deserialize(response: response, json: $0) }
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


public struct CopyObjectRequest: RestJsonSerializable {
/**

 */
  public let bucket: String
/**
Specifies presentational information for the object.
 */
  public let contentDisposition: String?
/**
Copies the object if it has been modified since the specified time.
 */
  public let copySourceIfModifiedSince: Date?
/**
Copies the object if its entity tag (ETag) is different than the specified ETag.
 */
  public let copySourceIfNoneMatch: String?
/**
Specifies the customer-provided encryption key for Amazon S3 to use to decrypt the source object. The encryption key provided in this header must be one that was used when the source object was created.
 */
  public let copySourceSSECustomerKey: String?
/**
Copies the object if its entity tag (ETag) matches the specified tag.
 */
  public let copySourceIfMatch: String?
/**
Specifies the AWS KMS key ID to use for object encryption. All GET and PUT requests for an object protected by AWS KMS will fail if not made via SSL or using SigV4. Documentation on configuring any of the officially supported AWS SDKs and CLI can be found at http://docs.aws.amazon.com/AmazonS3/latest/dev/UsingAWSSDK.html#specify-signature-version
 */
  public let sSEKMSKeyId: String?
/**
Allows grantee to read the object ACL.
 */
  public let grantReadACP: String?
/**
Specifies the algorithm to use to when encrypting the object (e.g., AES256).
 */
  public let sSECustomerAlgorithm: String?
/**
The language the content is in.
 */
  public let contentLanguage: String?
/**
Specifies what content encodings have been applied to the object and thus what decoding mechanisms must be applied to obtain the media-type referenced by the Content-Type header field.
 */
  public let contentEncoding: String?
/**
Allows grantee to write the ACL for the applicable object.
 */
  public let grantWriteACP: String?
/**

 */
  public let key: String
/**
If the bucket is configured as a website, redirects requests for this object to another object in the same bucket or to an external URL. Amazon S3 stores the value of this header in the object metadata.
 */
  public let websiteRedirectLocation: String?
/**
Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure the encryption key was transmitted without error.
 */
  public let copySourceSSECustomerKeyMD5: String?
/**
Copies the object if it hasn't been modified since the specified time.
 */
  public let copySourceIfUnmodifiedSince: Date?
/**
Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data. This value is used to store the object and then it is discarded; Amazon does not store the encryption key. The key must be appropriate for use with the algorithm specified in the x-amz-server-side​-encryption​-customer-algorithm header.
 */
  public let sSECustomerKey: String?
/**
Specifies caching behavior along the request/reply chain.
 */
  public let cacheControl: String?
/**

 */
  public let requestPayer: Requestpayer?
/**
Gives the grantee READ, READ_ACP, and WRITE_ACP permissions on the object.
 */
  public let grantFullControl: String?
/**
Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure the encryption key was transmitted without error.
 */
  public let sSECustomerKeyMD5: String?
/**
The name of the source bucket and key name of the source object, separated by a slash (/). Must be URL-encoded.
 */
  public let copySource: String
/**
Specifies whether the metadata is copied from the source object or replaced with metadata provided in the request.
 */
  public let metadataDirective: Metadatadirective?
/**
The canned ACL to apply to the object.
 */
  public let aCL: Objectcannedacl?
/**
A map of metadata to store with the object in S3.
 */
  public let metadata: [String: String]?
/**
The date and time at which the object is no longer cacheable.
 */
  public let expires: Date?
/**
A standard MIME type describing the format of the object data.
 */
  public let contentType: String?
/**
The type of storage to use for the object. Defaults to 'STANDARD'.
 */
  public let storageClass: Storageclass?
/**
Allows grantee to read the object data and its metadata.
 */
  public let grantRead: String?
/**
Specifies the algorithm to use when decrypting the source object (e.g., AES256).
 */
  public let copySourceSSECustomerAlgorithm: String?
/**
The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).
 */
  public let serverSideEncryption: Serversideencryption?

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    var header: [String: String] = [:]
    
  
    uri["Bucket"] = "\(bucket)"
    uri["Key"] = "\(key)"
    if contentDisposition != nil { header["Content-Disposition"] = "\(contentDisposition!)" }
    if copySourceIfModifiedSince != nil { header["x-amz-copy-source-if-modified-since"] = "\(copySourceIfModifiedSince!)" }
    if copySourceIfNoneMatch != nil { header["x-amz-copy-source-if-none-match"] = "\(copySourceIfNoneMatch!)" }
    if copySourceSSECustomerKey != nil { header["x-amz-copy-source-server-side-encryption-customer-key"] = "\(copySourceSSECustomerKey!)" }
    if copySourceIfMatch != nil { header["x-amz-copy-source-if-match"] = "\(copySourceIfMatch!)" }
    if sSEKMSKeyId != nil { header["x-amz-server-side-encryption-aws-kms-key-id"] = "\(sSEKMSKeyId!)" }
    if grantReadACP != nil { header["x-amz-grant-read-acp"] = "\(grantReadACP!)" }
    if sSECustomerAlgorithm != nil { header["x-amz-server-side-encryption-customer-algorithm"] = "\(sSECustomerAlgorithm!)" }
    if contentLanguage != nil { header["Content-Language"] = "\(contentLanguage!)" }
    if contentEncoding != nil { header["Content-Encoding"] = "\(contentEncoding!)" }
    if grantWriteACP != nil { header["x-amz-grant-write-acp"] = "\(grantWriteACP!)" }
    if websiteRedirectLocation != nil { header["x-amz-website-redirect-location"] = "\(websiteRedirectLocation!)" }
    if copySourceSSECustomerKeyMD5 != nil { header["x-amz-copy-source-server-side-encryption-customer-key-MD5"] = "\(copySourceSSECustomerKeyMD5!)" }
    if copySourceIfUnmodifiedSince != nil { header["x-amz-copy-source-if-unmodified-since"] = "\(copySourceIfUnmodifiedSince!)" }
    if sSECustomerKey != nil { header["x-amz-server-side-encryption-customer-key"] = "\(sSECustomerKey!)" }
    if cacheControl != nil { header["Cache-Control"] = "\(cacheControl!)" }
    if requestPayer != nil { header["x-amz-request-payer"] = "\(requestPayer!)" }
    if grantFullControl != nil { header["x-amz-grant-full-control"] = "\(grantFullControl!)" }
    if sSECustomerKeyMD5 != nil { header["x-amz-server-side-encryption-customer-key-MD5"] = "\(sSECustomerKeyMD5!)" }
    header["x-amz-copy-source"] = "\(copySource)"
    if metadataDirective != nil { header["x-amz-metadata-directive"] = "\(metadataDirective!)" }
    if aCL != nil { header["x-amz-acl"] = "\(aCL!)" }
    if expires != nil { header["Expires"] = "\(expires!)" }
    if contentType != nil { header["Content-Type"] = "\(contentType!)" }
    if storageClass != nil { header["x-amz-storage-class"] = "\(storageClass!)" }
    if grantRead != nil { header["x-amz-grant-read"] = "\(grantRead!)" }
    if copySourceSSECustomerAlgorithm != nil { header["x-amz-copy-source-server-side-encryption-customer-algorithm"] = "\(copySourceSSECustomerAlgorithm!)" }
    if serverSideEncryption != nil { header["x-amz-server-side-encryption"] = "\(serverSideEncryption!)" }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - bucket: 
      - contentDisposition: Specifies presentational information for the object.
      - copySourceIfModifiedSince: Copies the object if it has been modified since the specified time.
      - copySourceIfNoneMatch: Copies the object if its entity tag (ETag) is different than the specified ETag.
      - copySourceSSECustomerKey: Specifies the customer-provided encryption key for Amazon S3 to use to decrypt the source object. The encryption key provided in this header must be one that was used when the source object was created.
      - copySourceIfMatch: Copies the object if its entity tag (ETag) matches the specified tag.
      - sSEKMSKeyId: Specifies the AWS KMS key ID to use for object encryption. All GET and PUT requests for an object protected by AWS KMS will fail if not made via SSL or using SigV4. Documentation on configuring any of the officially supported AWS SDKs and CLI can be found at http://docs.aws.amazon.com/AmazonS3/latest/dev/UsingAWSSDK.html#specify-signature-version
      - grantReadACP: Allows grantee to read the object ACL.
      - sSECustomerAlgorithm: Specifies the algorithm to use to when encrypting the object (e.g., AES256).
      - contentLanguage: The language the content is in.
      - contentEncoding: Specifies what content encodings have been applied to the object and thus what decoding mechanisms must be applied to obtain the media-type referenced by the Content-Type header field.
      - grantWriteACP: Allows grantee to write the ACL for the applicable object.
      - key: 
      - websiteRedirectLocation: If the bucket is configured as a website, redirects requests for this object to another object in the same bucket or to an external URL. Amazon S3 stores the value of this header in the object metadata.
      - copySourceSSECustomerKeyMD5: Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure the encryption key was transmitted without error.
      - copySourceIfUnmodifiedSince: Copies the object if it hasn't been modified since the specified time.
      - sSECustomerKey: Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data. This value is used to store the object and then it is discarded; Amazon does not store the encryption key. The key must be appropriate for use with the algorithm specified in the x-amz-server-side​-encryption​-customer-algorithm header.
      - cacheControl: Specifies caching behavior along the request/reply chain.
      - requestPayer: 
      - grantFullControl: Gives the grantee READ, READ_ACP, and WRITE_ACP permissions on the object.
      - sSECustomerKeyMD5: Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure the encryption key was transmitted without error.
      - copySource: The name of the source bucket and key name of the source object, separated by a slash (/). Must be URL-encoded.
      - metadataDirective: Specifies whether the metadata is copied from the source object or replaced with metadata provided in the request.
      - aCL: The canned ACL to apply to the object.
      - metadata: A map of metadata to store with the object in S3.
      - expires: The date and time at which the object is no longer cacheable.
      - contentType: A standard MIME type describing the format of the object data.
      - storageClass: The type of storage to use for the object. Defaults to 'STANDARD'.
      - grantRead: Allows grantee to read the object data and its metadata.
      - copySourceSSECustomerAlgorithm: Specifies the algorithm to use when decrypting the source object (e.g., AES256).
      - serverSideEncryption: The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).
 */
  public init(bucket: String, contentDisposition: String?, copySourceIfModifiedSince: Date?, copySourceIfNoneMatch: String?, copySourceSSECustomerKey: String?, copySourceIfMatch: String?, sSEKMSKeyId: String?, grantReadACP: String?, sSECustomerAlgorithm: String?, contentLanguage: String?, contentEncoding: String?, grantWriteACP: String?, key: String, websiteRedirectLocation: String?, copySourceSSECustomerKeyMD5: String?, copySourceIfUnmodifiedSince: Date?, sSECustomerKey: String?, cacheControl: String?, requestPayer: Requestpayer?, grantFullControl: String?, sSECustomerKeyMD5: String?, copySource: String, metadataDirective: Metadatadirective?, aCL: Objectcannedacl?, metadata: [String: String]?, expires: Date?, contentType: String?, storageClass: Storageclass?, grantRead: String?, copySourceSSECustomerAlgorithm: String?, serverSideEncryption: Serversideencryption?) {
self.bucket = bucket
self.contentDisposition = contentDisposition
self.copySourceIfModifiedSince = copySourceIfModifiedSince
self.copySourceIfNoneMatch = copySourceIfNoneMatch
self.copySourceSSECustomerKey = copySourceSSECustomerKey
self.copySourceIfMatch = copySourceIfMatch
self.sSEKMSKeyId = sSEKMSKeyId
self.grantReadACP = grantReadACP
self.sSECustomerAlgorithm = sSECustomerAlgorithm
self.contentLanguage = contentLanguage
self.contentEncoding = contentEncoding
self.grantWriteACP = grantWriteACP
self.key = key
self.websiteRedirectLocation = websiteRedirectLocation
self.copySourceSSECustomerKeyMD5 = copySourceSSECustomerKeyMD5
self.copySourceIfUnmodifiedSince = copySourceIfUnmodifiedSince
self.sSECustomerKey = sSECustomerKey
self.cacheControl = cacheControl
self.requestPayer = requestPayer
self.grantFullControl = grantFullControl
self.sSECustomerKeyMD5 = sSECustomerKeyMD5
self.copySource = copySource
self.metadataDirective = metadataDirective
self.aCL = aCL
self.metadata = metadata
self.expires = expires
self.contentType = contentType
self.storageClass = storageClass
self.grantRead = grantRead
self.copySourceSSECustomerAlgorithm = copySourceSSECustomerAlgorithm
self.serverSideEncryption = serverSideEncryption
  }
}


public struct GetBucketLocationRequest: RestJsonSerializable {
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

public struct Grant: RestJsonSerializable, RestJsonDeserializable {
/**
Specifies the permission given to the grantee.
 */
  public let permission: Permission?
/**

 */
  public let grantee: Grantee?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if permission != nil { body["Permission"] = permission! }
    if grantee != nil { body["Grantee"] = grantee! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserialize(response: HTTPURLResponse, json: Any) -> Grant {
    let jsonDict = json as! [String: Any]
    return Grant(
        permission: jsonDict["Permission"].flatMap { ($0 is NSNull) ? nil : Permission.deserialize(response: response, json: $0) },
      grantee: jsonDict["Grantee"].flatMap { ($0 is NSNull) ? nil : Grantee.deserialize(response: response, json: $0) }
    )
  }

/**
    - parameters:
      - permission: Specifies the permission given to the grantee.
      - grantee: 
 */
  public init(permission: Permission?, grantee: Grantee?) {
self.permission = permission
self.grantee = grantee
  }
}

enum Metadatadirective: String, RestJsonDeserializable, RestJsonSerializable {
  case `cOPY` = "COPY"
  case `rEPLACE` = "REPLACE"

  static func deserialize(response: HTTPURLResponse, json: Any) -> Metadatadirective {
    return Metadatadirective(rawValue: json as! String)!
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}



enum Bucketcannedacl: String, RestJsonDeserializable, RestJsonSerializable {
  case `private` = "private"
  case `publicread` = "public-read"
  case `publicreadwrite` = "public-read-write"
  case `authenticatedread` = "authenticated-read"

  static func deserialize(response: HTTPURLResponse, json: Any) -> Bucketcannedacl {
    return Bucketcannedacl(rawValue: json as! String)!
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}


public struct BucketLifecycleConfiguration: RestJsonSerializable, RestJsonDeserializable {
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

  static func deserialize(response: HTTPURLResponse, json: Any) -> BucketLifecycleConfiguration {
    let jsonDict = json as! [String: Any]
    return BucketLifecycleConfiguration(
        rules: jsonDict["Rule"].flatMap { ($0 is NSNull) ? nil : [LifecycleRule].deserialize(response: response, json: $0) }!
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

public struct ListObjectsRequest: RestJsonSerializable {
/**

 */
  public let bucket: String
/**
Sets the maximum number of keys returned in the response. The response might contain fewer keys but will never contain more.
 */
  public let maxKeys: Int?
/**
Specifies the key to start with when listing objects in a bucket.
 */
  public let marker: String?
/**
Confirms that the requester knows that she or he will be charged for the list objects request. Bucket owners need not specify this parameter in their requests.
 */
  public let requestPayer: Requestpayer?
/**
Limits the response to keys that begin with the specified prefix.
 */
  public let prefix: String?
/**
A delimiter is a character you use to group keys.
 */
  public let delimiter: String?
/**

 */
  public let encodingType: Encodingtype?

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    var querystring: [String: String] = [:]
    var header: [String: String] = [:]
    
  
    uri["Bucket"] = "\(bucket)"
    if maxKeys != nil { querystring["max-keys"] = "\(maxKeys!)" }
    if marker != nil { querystring["marker"] = "\(marker!)" }
    if prefix != nil { querystring["prefix"] = "\(prefix!)" }
    if delimiter != nil { querystring["delimiter"] = "\(delimiter!)" }
    if encodingType != nil { querystring["encoding-type"] = "\(encodingType!)" }
    if requestPayer != nil { header["x-amz-request-payer"] = "\(requestPayer!)" }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - bucket: 
      - maxKeys: Sets the maximum number of keys returned in the response. The response might contain fewer keys but will never contain more.
      - marker: Specifies the key to start with when listing objects in a bucket.
      - requestPayer: Confirms that the requester knows that she or he will be charged for the list objects request. Bucket owners need not specify this parameter in their requests.
      - prefix: Limits the response to keys that begin with the specified prefix.
      - delimiter: A delimiter is a character you use to group keys.
      - encodingType: 
 */
  public init(bucket: String, maxKeys: Int?, marker: String?, requestPayer: Requestpayer?, prefix: String?, delimiter: String?, encodingType: Encodingtype?) {
self.bucket = bucket
self.maxKeys = maxKeys
self.marker = marker
self.requestPayer = requestPayer
self.prefix = prefix
self.delimiter = delimiter
self.encodingType = encodingType
  }
}





public struct LifecycleRule: RestJsonSerializable, RestJsonDeserializable {
/**
Unique identifier for the rule. The value cannot be longer than 255 characters.
 */
  public let iD: String?
/**
If 'Enabled', the rule is currently being applied. If 'Disabled', the rule is not currently being applied.
 */
  public let status: Expirationstatus
/**

 */
  public let noncurrentVersionExpiration: NoncurrentVersionExpiration?
/**

 */
  public let abortIncompleteMultipartUpload: AbortIncompleteMultipartUpload?
/**

 */
  public let expiration: LifecycleExpiration?
/**
Prefix identifying one or more objects to which the rule applies.
 */
  public let prefix: String
/**

 */
  public let transitions: [Transition]?
/**

 */
  public let noncurrentVersionTransitions: [NoncurrentVersionTransition]?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if iD != nil { body["ID"] = iD! }
    body["Status"] = status
    if noncurrentVersionExpiration != nil { body["NoncurrentVersionExpiration"] = noncurrentVersionExpiration! }
    if abortIncompleteMultipartUpload != nil { body["AbortIncompleteMultipartUpload"] = abortIncompleteMultipartUpload! }
    if expiration != nil { body["Expiration"] = expiration! }
    body["Prefix"] = prefix
    if transitions != nil { body["Transition"] = transitions! }
    if noncurrentVersionTransitions != nil { body["NoncurrentVersionTransition"] = noncurrentVersionTransitions! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserialize(response: HTTPURLResponse, json: Any) -> LifecycleRule {
    let jsonDict = json as! [String: Any]
    return LifecycleRule(
        iD: jsonDict["ID"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      status: jsonDict["Status"].flatMap { ($0 is NSNull) ? nil : Expirationstatus.deserialize(response: response, json: $0) }!,
      noncurrentVersionExpiration: jsonDict["NoncurrentVersionExpiration"].flatMap { ($0 is NSNull) ? nil : NoncurrentVersionExpiration.deserialize(response: response, json: $0) },
      abortIncompleteMultipartUpload: jsonDict["AbortIncompleteMultipartUpload"].flatMap { ($0 is NSNull) ? nil : AbortIncompleteMultipartUpload.deserialize(response: response, json: $0) },
      expiration: jsonDict["Expiration"].flatMap { ($0 is NSNull) ? nil : LifecycleExpiration.deserialize(response: response, json: $0) },
      prefix: jsonDict["Prefix"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) }!,
      transitions: jsonDict["Transition"].flatMap { ($0 is NSNull) ? nil : [Transition].deserialize(response: response, json: $0) },
      noncurrentVersionTransitions: jsonDict["NoncurrentVersionTransition"].flatMap { ($0 is NSNull) ? nil : [NoncurrentVersionTransition].deserialize(response: response, json: $0) }
    )
  }

/**
    - parameters:
      - iD: Unique identifier for the rule. The value cannot be longer than 255 characters.
      - status: If 'Enabled', the rule is currently being applied. If 'Disabled', the rule is not currently being applied.
      - noncurrentVersionExpiration: 
      - abortIncompleteMultipartUpload: 
      - expiration: 
      - prefix: Prefix identifying one or more objects to which the rule applies.
      - transitions: 
      - noncurrentVersionTransitions: 
 */
  public init(iD: String?, status: Expirationstatus, noncurrentVersionExpiration: NoncurrentVersionExpiration?, abortIncompleteMultipartUpload: AbortIncompleteMultipartUpload?, expiration: LifecycleExpiration?, prefix: String, transitions: [Transition]?, noncurrentVersionTransitions: [NoncurrentVersionTransition]?) {
self.iD = iD
self.status = status
self.noncurrentVersionExpiration = noncurrentVersionExpiration
self.abortIncompleteMultipartUpload = abortIncompleteMultipartUpload
self.expiration = expiration
self.prefix = prefix
self.transitions = transitions
self.noncurrentVersionTransitions = noncurrentVersionTransitions
  }
}

public struct Bucket: RestJsonSerializable, RestJsonDeserializable {
/**
The name of the bucket.
 */
  public let name: String?
/**
Date the bucket was created.
 */
  public let creationDate: Date?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if name != nil { body["Name"] = name! }
    if creationDate != nil { body["CreationDate"] = creationDate! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserialize(response: HTTPURLResponse, json: Any) -> Bucket {
    let jsonDict = json as! [String: Any]
    return Bucket(
        name: jsonDict["Name"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      creationDate: jsonDict["CreationDate"].flatMap { ($0 is NSNull) ? nil : Date.deserialize(response: response, json: $0) }
    )
  }

/**
    - parameters:
      - name: The name of the bucket.
      - creationDate: Date the bucket was created.
 */
  public init(name: String?, creationDate: Date?) {
self.name = name
self.creationDate = creationDate
  }
}

public struct GetBucketCorsRequest: RestJsonSerializable {
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

public struct Destination: RestJsonSerializable, RestJsonDeserializable {
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

  static func deserialize(response: HTTPURLResponse, json: Any) -> Destination {
    let jsonDict = json as! [String: Any]
    return Destination(
        bucket: jsonDict["Bucket"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) }!,
      storageClass: jsonDict["StorageClass"].flatMap { ($0 is NSNull) ? nil : Storageclass.deserialize(response: response, json: $0) }
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





public struct CloudFunctionConfiguration: RestJsonSerializable, RestJsonDeserializable {
/**

 */
  public let cloudFunction: String?
/**

 */
  public let events: [Event]?
/**

 */
  public let invocationRole: String?
/**

 */
  public let event: Event?
/**

 */
  public let id: String?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if cloudFunction != nil { body["CloudFunction"] = cloudFunction! }
    if events != nil { body["Event"] = events! }
    if invocationRole != nil { body["InvocationRole"] = invocationRole! }
    if event != nil { body["Event"] = event! }
    if id != nil { body["Id"] = id! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserialize(response: HTTPURLResponse, json: Any) -> CloudFunctionConfiguration {
    let jsonDict = json as! [String: Any]
    return CloudFunctionConfiguration(
        cloudFunction: jsonDict["CloudFunction"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      events: jsonDict["Event"].flatMap { ($0 is NSNull) ? nil : [Event].deserialize(response: response, json: $0) },
      invocationRole: jsonDict["InvocationRole"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      event: jsonDict["Event"].flatMap { ($0 is NSNull) ? nil : Event.deserialize(response: response, json: $0) },
      id: jsonDict["Id"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) }
    )
  }

/**
    - parameters:
      - cloudFunction: 
      - events: 
      - invocationRole: 
      - event: 
      - id: 
 */
  public init(cloudFunction: String?, events: [Event]?, invocationRole: String?, event: Event?, id: String?) {
self.cloudFunction = cloudFunction
self.events = events
self.invocationRole = invocationRole
self.event = event
self.id = id
  }
}

public struct HeadObjectRequest: RestJsonSerializable {
/**

 */
  public let bucket: String
/**
Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data. This value is used to store the object and then it is discarded; Amazon does not store the encryption key. The key must be appropriate for use with the algorithm specified in the x-amz-server-side​-encryption​-customer-algorithm header.
 */
  public let sSECustomerKey: String?
/**
Return the object only if it has not been modified since the specified time, otherwise return a 412 (precondition failed).
 */
  public let ifUnmodifiedSince: Date?
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
Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure the encryption key was transmitted without error.
 */
  public let sSECustomerKeyMD5: String?
/**
VersionId used to reference a specific version of the object.
 */
  public let versionId: String?
/**
Specifies the algorithm to use to when encrypting the object (e.g., AES256).
 */
  public let sSECustomerAlgorithm: String?
/**
Return the object only if its entity tag (ETag) is different from the one specified, otherwise return a 304 (not modified).
 */
  public let ifNoneMatch: String?
/**

 */
  public let key: String
/**
Return the object only if it has been modified since the specified time, otherwise return a 304 (not modified).
 */
  public let ifModifiedSince: Date?
/**
Return the object only if its entity tag (ETag) is the same as the one specified, otherwise return a 412 (precondition failed).
 */
  public let ifMatch: String?

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    var querystring: [String: String] = [:]
    var header: [String: String] = [:]
    
  
    uri["Bucket"] = "\(bucket)"
    uri["Key"] = "\(key)"
    if partNumber != nil { querystring["partNumber"] = "\(partNumber!)" }
    if versionId != nil { querystring["versionId"] = "\(versionId!)" }
    if sSECustomerKey != nil { header["x-amz-server-side-encryption-customer-key"] = "\(sSECustomerKey!)" }
    if ifUnmodifiedSince != nil { header["If-Unmodified-Since"] = "\(ifUnmodifiedSince!)" }
    if range != nil { header["Range"] = "\(range!)" }
    if requestPayer != nil { header["x-amz-request-payer"] = "\(requestPayer!)" }
    if sSECustomerKeyMD5 != nil { header["x-amz-server-side-encryption-customer-key-MD5"] = "\(sSECustomerKeyMD5!)" }
    if sSECustomerAlgorithm != nil { header["x-amz-server-side-encryption-customer-algorithm"] = "\(sSECustomerAlgorithm!)" }
    if ifNoneMatch != nil { header["If-None-Match"] = "\(ifNoneMatch!)" }
    if ifModifiedSince != nil { header["If-Modified-Since"] = "\(ifModifiedSince!)" }
    if ifMatch != nil { header["If-Match"] = "\(ifMatch!)" }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - bucket: 
      - sSECustomerKey: Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data. This value is used to store the object and then it is discarded; Amazon does not store the encryption key. The key must be appropriate for use with the algorithm specified in the x-amz-server-side​-encryption​-customer-algorithm header.
      - ifUnmodifiedSince: Return the object only if it has not been modified since the specified time, otherwise return a 412 (precondition failed).
      - partNumber: Part number of the object being read. This is a positive integer between 1 and 10,000. Effectively performs a 'ranged' HEAD request for the part specified. Useful querying about the size of the part and the number of parts in this object.
      - range: Downloads the specified range bytes of an object. For more information about the HTTP Range header, go to http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.35.
      - requestPayer: 
      - sSECustomerKeyMD5: Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure the encryption key was transmitted without error.
      - versionId: VersionId used to reference a specific version of the object.
      - sSECustomerAlgorithm: Specifies the algorithm to use to when encrypting the object (e.g., AES256).
      - ifNoneMatch: Return the object only if its entity tag (ETag) is different from the one specified, otherwise return a 304 (not modified).
      - key: 
      - ifModifiedSince: Return the object only if it has been modified since the specified time, otherwise return a 304 (not modified).
      - ifMatch: Return the object only if its entity tag (ETag) is the same as the one specified, otherwise return a 412 (precondition failed).
 */
  public init(bucket: String, sSECustomerKey: String?, ifUnmodifiedSince: Date?, partNumber: Int?, range: String?, requestPayer: Requestpayer?, sSECustomerKeyMD5: String?, versionId: String?, sSECustomerAlgorithm: String?, ifNoneMatch: String?, key: String, ifModifiedSince: Date?, ifMatch: String?) {
self.bucket = bucket
self.sSECustomerKey = sSECustomerKey
self.ifUnmodifiedSince = ifUnmodifiedSince
self.partNumber = partNumber
self.range = range
self.requestPayer = requestPayer
self.sSECustomerKeyMD5 = sSECustomerKeyMD5
self.versionId = versionId
self.sSECustomerAlgorithm = sSECustomerAlgorithm
self.ifNoneMatch = ifNoneMatch
self.key = key
self.ifModifiedSince = ifModifiedSince
self.ifMatch = ifMatch
  }
}


public struct GetBucketRequestPaymentOutput: RestJsonDeserializable {
/**
Specifies who pays for the download and request fees.
 */
  public let payer: Payer?


  static func deserialize(response: HTTPURLResponse, json: Any) -> GetBucketRequestPaymentOutput {
    let jsonDict = json as! [String: Any]
    return GetBucketRequestPaymentOutput(
        payer: jsonDict["Payer"].flatMap { ($0 is NSNull) ? nil : Payer.deserialize(response: response, json: $0) }
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

public struct AbortMultipartUploadOutput: RestJsonDeserializable {
/**

 */
  public let requestCharged: Requestcharged?


  static func deserialize(response: HTTPURLResponse, json: Any) -> AbortMultipartUploadOutput {
  
    return AbortMultipartUploadOutput(
        requestCharged: response.allHeaderFields["x-amz-request-charged"].flatMap { ($0 is NSNull) ? nil : Requestcharged.deserialize(response: response, json: $0) }
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

public struct PutBucketNotificationRequest: RestJsonSerializable {
/**

 */
  public let contentMD5: String?
/**

 */
  public let bucket: String
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
      - contentMD5: 
      - bucket: 
      - notificationConfiguration: 
 */
  public init(contentMD5: String?, bucket: String, notificationConfiguration: NotificationConfigurationDeprecated) {
self.contentMD5 = contentMD5
self.bucket = bucket
self.notificationConfiguration = notificationConfiguration
  }
}


public struct CompleteMultipartUploadRequest: RestJsonSerializable {
/**

 */
  public let bucket: String
/**

 */
  public let multipartUpload: CompletedMultipartUpload?
/**

 */
  public let key: String
/**

 */
  public let uploadId: String
/**

 */
  public let requestPayer: Requestpayer?

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
      - multipartUpload: 
      - key: 
      - uploadId: 
      - requestPayer: 
 */
  public init(bucket: String, multipartUpload: CompletedMultipartUpload?, key: String, uploadId: String, requestPayer: Requestpayer?) {
self.bucket = bucket
self.multipartUpload = multipartUpload
self.key = key
self.uploadId = uploadId
self.requestPayer = requestPayer
  }
}


public struct CompletedMultipartUpload: RestJsonSerializable, RestJsonDeserializable {
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

  static func deserialize(response: HTTPURLResponse, json: Any) -> CompletedMultipartUpload {
    let jsonDict = json as! [String: Any]
    return CompletedMultipartUpload(
        parts: jsonDict["Part"].flatMap { ($0 is NSNull) ? nil : [CompletedPart].deserialize(response: response, json: $0) }
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






enum Objectcannedacl: String, RestJsonDeserializable, RestJsonSerializable {
  case `private` = "private"
  case `publicread` = "public-read"
  case `publicreadwrite` = "public-read-write"
  case `authenticatedread` = "authenticated-read"
  case `awsexecread` = "aws-exec-read"
  case `bucketownerread` = "bucket-owner-read"
  case `bucketownerfullcontrol` = "bucket-owner-full-control"

  static func deserialize(response: HTTPURLResponse, json: Any) -> Objectcannedacl {
    return Objectcannedacl(rawValue: json as! String)!
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}



enum Mfadeletestatus: String, RestJsonDeserializable, RestJsonSerializable {
  case `enabled` = "Enabled"
  case `disabled` = "Disabled"

  static func deserialize(response: HTTPURLResponse, json: Any) -> Mfadeletestatus {
    return Mfadeletestatus(rawValue: json as! String)!
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}



public struct GetObjectOutput: RestJsonDeserializable {
/**
The count of parts this object has.
 */
  public let partsCount: Int?
/**
Specifies presentational information for the object.
 */
  public let contentDisposition: String?
/**
Version of the object.
 */
  public let versionId: String?
/**

 */
  public let replicationStatus: Replicationstatus?
/**
If present, specifies the ID of the AWS Key Management Service (KMS) master encryption key that was used for the object.
 */
  public let sSEKMSKeyId: String?
/**
The language the content is in.
 */
  public let contentLanguage: String?
/**
If server-side encryption with a customer-provided encryption key was requested, the response will include this header confirming the encryption algorithm used.
 */
  public let sSECustomerAlgorithm: String?
/**
Provides information about object restoration operation and expiration time of the restored object copy.
 */
  public let restore: String?
/**
Specifies what content encodings have been applied to the object and thus what decoding mechanisms must be applied to obtain the media-type referenced by the Content-Type header field.
 */
  public let contentEncoding: String?
/**
Size of the body in bytes.
 */
  public let contentLength: Int?
/**
If the object expiration is configured (see PUT Bucket lifecycle), the response includes this header. It includes the expiry-date and rule-id key value pairs providing object expiration information. The value of the rule-id is URL encoded.
 */
  public let expiration: String?
/**
If the bucket is configured as a website, redirects requests for this object to another object in the same bucket or to an external URL. Amazon S3 stores the value of this header in the object metadata.
 */
  public let websiteRedirectLocation: String?
/**
An ETag is an opaque identifier assigned by a web server to a specific version of a resource found at a URL
 */
  public let eTag: String?
/**
Object data.
 */
  public let bodyBody: Data?
/**
This is set to the number of metadata entries not returned in x-amz-meta headers. This can happen if you create metadata using an API like SOAP that supports more flexible metadata than the REST API. For example, using SOAP, you can create metadata whose values are not legal HTTP headers.
 */
  public let missingMeta: Int?
/**
Specifies caching behavior along the request/reply chain.
 */
  public let cacheControl: String?
/**
If server-side encryption with a customer-provided encryption key was requested, the response will include this header to provide round trip message integrity verification of the customer-provided encryption key.
 */
  public let sSECustomerKeyMD5: String?
/**

 */
  public let acceptRanges: String?
/**
Last modified date of the object
 */
  public let lastModified: Date?
/**
A map of metadata to store with the object in S3.
 */
  public let metadata: [String: String]?
/**
The date and time at which the object is no longer cacheable.
 */
  public let expires: Date?
/**
The portion of the object returned in the response.
 */
  public let contentRange: String?
/**
A standard MIME type describing the format of the object data.
 */
  public let contentType: String?
/**

 */
  public let storageClass: Storageclass?
/**
The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).
 */
  public let serverSideEncryption: Serversideencryption?
/**

 */
  public let requestCharged: Requestcharged?
/**
Specifies whether the object retrieved was (true) or was not (false) a Delete Marker. If false, this response header does not appear in the response.
 */
  public let deleteMarker: Bool?


  static func deserialize(response: HTTPURLResponse, json: Any) -> GetObjectOutput {
    let jsonDict = json as! [String: Any]
    return GetObjectOutput(
        partsCount: response.allHeaderFields["x-amz-mp-parts-count"].flatMap { ($0 is NSNull) ? nil : Int.deserialize(response: response, json: $0) },
      contentDisposition: response.allHeaderFields["Content-Disposition"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      versionId: response.allHeaderFields["x-amz-version-id"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      replicationStatus: response.allHeaderFields["x-amz-replication-status"].flatMap { ($0 is NSNull) ? nil : Replicationstatus.deserialize(response: response, json: $0) },
      sSEKMSKeyId: response.allHeaderFields["x-amz-server-side-encryption-aws-kms-key-id"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      contentLanguage: response.allHeaderFields["Content-Language"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      sSECustomerAlgorithm: response.allHeaderFields["x-amz-server-side-encryption-customer-algorithm"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      restore: response.allHeaderFields["x-amz-restore"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      contentEncoding: response.allHeaderFields["Content-Encoding"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      contentLength: response.allHeaderFields["Content-Length"].flatMap { ($0 is NSNull) ? nil : Int.deserialize(response: response, json: $0) },
      expiration: response.allHeaderFields["x-amz-expiration"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      websiteRedirectLocation: response.allHeaderFields["x-amz-website-redirect-location"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      eTag: response.allHeaderFields["ETag"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      bodyBody: jsonDict["Body"].flatMap { ($0 is NSNull) ? nil : Data.deserialize(response: response, json: $0) },
      missingMeta: response.allHeaderFields["x-amz-missing-meta"].flatMap { ($0 is NSNull) ? nil : Int.deserialize(response: response, json: $0) },
      cacheControl: response.allHeaderFields["Cache-Control"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      sSECustomerKeyMD5: response.allHeaderFields["x-amz-server-side-encryption-customer-key-MD5"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      acceptRanges: response.allHeaderFields["accept-ranges"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      lastModified: response.allHeaderFields["Last-Modified"].flatMap { ($0 is NSNull) ? nil : Date.deserialize(response: response, json: $0) },
      metadata: Dictionary(response.allHeaderFields.map { (key: $0 as! String, value: $1 as! String) }.filter { $0.key.lowercased().hasPrefix("x-amz-meta-") }),
      expires: response.allHeaderFields["Expires"].flatMap { ($0 is NSNull) ? nil : Date.deserialize(response: response, json: $0) },
      contentRange: response.allHeaderFields["Content-Range"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      contentType: response.allHeaderFields["Content-Type"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      storageClass: response.allHeaderFields["x-amz-storage-class"].flatMap { ($0 is NSNull) ? nil : Storageclass.deserialize(response: response, json: $0) },
      serverSideEncryption: response.allHeaderFields["x-amz-server-side-encryption"].flatMap { ($0 is NSNull) ? nil : Serversideencryption.deserialize(response: response, json: $0) },
      requestCharged: response.allHeaderFields["x-amz-request-charged"].flatMap { ($0 is NSNull) ? nil : Requestcharged.deserialize(response: response, json: $0) },
      deleteMarker: response.allHeaderFields["x-amz-delete-marker"].flatMap { ($0 is NSNull) ? nil : Bool.deserialize(response: response, json: $0) }
    )
  }

/**
    - parameters:
      - partsCount: The count of parts this object has.
      - contentDisposition: Specifies presentational information for the object.
      - versionId: Version of the object.
      - replicationStatus: 
      - sSEKMSKeyId: If present, specifies the ID of the AWS Key Management Service (KMS) master encryption key that was used for the object.
      - contentLanguage: The language the content is in.
      - sSECustomerAlgorithm: If server-side encryption with a customer-provided encryption key was requested, the response will include this header confirming the encryption algorithm used.
      - restore: Provides information about object restoration operation and expiration time of the restored object copy.
      - contentEncoding: Specifies what content encodings have been applied to the object and thus what decoding mechanisms must be applied to obtain the media-type referenced by the Content-Type header field.
      - contentLength: Size of the body in bytes.
      - expiration: If the object expiration is configured (see PUT Bucket lifecycle), the response includes this header. It includes the expiry-date and rule-id key value pairs providing object expiration information. The value of the rule-id is URL encoded.
      - websiteRedirectLocation: If the bucket is configured as a website, redirects requests for this object to another object in the same bucket or to an external URL. Amazon S3 stores the value of this header in the object metadata.
      - eTag: An ETag is an opaque identifier assigned by a web server to a specific version of a resource found at a URL
      - bodyBody: Object data.
      - missingMeta: This is set to the number of metadata entries not returned in x-amz-meta headers. This can happen if you create metadata using an API like SOAP that supports more flexible metadata than the REST API. For example, using SOAP, you can create metadata whose values are not legal HTTP headers.
      - cacheControl: Specifies caching behavior along the request/reply chain.
      - sSECustomerKeyMD5: If server-side encryption with a customer-provided encryption key was requested, the response will include this header to provide round trip message integrity verification of the customer-provided encryption key.
      - acceptRanges: 
      - lastModified: Last modified date of the object
      - metadata: A map of metadata to store with the object in S3.
      - expires: The date and time at which the object is no longer cacheable.
      - contentRange: The portion of the object returned in the response.
      - contentType: A standard MIME type describing the format of the object data.
      - storageClass: 
      - serverSideEncryption: The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).
      - requestCharged: 
      - deleteMarker: Specifies whether the object retrieved was (true) or was not (false) a Delete Marker. If false, this response header does not appear in the response.
 */
  public init(partsCount: Int?, contentDisposition: String?, versionId: String?, replicationStatus: Replicationstatus?, sSEKMSKeyId: String?, contentLanguage: String?, sSECustomerAlgorithm: String?, restore: String?, contentEncoding: String?, contentLength: Int?, expiration: String?, websiteRedirectLocation: String?, eTag: String?, bodyBody: Data?, missingMeta: Int?, cacheControl: String?, sSECustomerKeyMD5: String?, acceptRanges: String?, lastModified: Date?, metadata: [String: String]?, expires: Date?, contentRange: String?, contentType: String?, storageClass: Storageclass?, serverSideEncryption: Serversideencryption?, requestCharged: Requestcharged?, deleteMarker: Bool?) {
self.partsCount = partsCount
self.contentDisposition = contentDisposition
self.versionId = versionId
self.replicationStatus = replicationStatus
self.sSEKMSKeyId = sSEKMSKeyId
self.contentLanguage = contentLanguage
self.sSECustomerAlgorithm = sSECustomerAlgorithm
self.restore = restore
self.contentEncoding = contentEncoding
self.contentLength = contentLength
self.expiration = expiration
self.websiteRedirectLocation = websiteRedirectLocation
self.eTag = eTag
self.bodyBody = bodyBody
self.missingMeta = missingMeta
self.cacheControl = cacheControl
self.sSECustomerKeyMD5 = sSECustomerKeyMD5
self.acceptRanges = acceptRanges
self.lastModified = lastModified
self.metadata = metadata
self.expires = expires
self.contentRange = contentRange
self.contentType = contentType
self.storageClass = storageClass
self.serverSideEncryption = serverSideEncryption
self.requestCharged = requestCharged
self.deleteMarker = deleteMarker
  }
}

public struct Part: RestJsonSerializable, RestJsonDeserializable {
/**
Date and time at which the part was uploaded.
 */
  public let lastModified: Date?
/**
Part number identifying the part. This is a positive integer between 1 and 10,000.
 */
  public let partNumber: Int?
/**
Entity tag returned when the part was uploaded.
 */
  public let eTag: String?
/**
Size of the uploaded part data.
 */
  public let size: Int?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if lastModified != nil { body["LastModified"] = lastModified! }
    if partNumber != nil { body["PartNumber"] = partNumber! }
    if eTag != nil { body["ETag"] = eTag! }
    if size != nil { body["Size"] = size! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserialize(response: HTTPURLResponse, json: Any) -> Part {
    let jsonDict = json as! [String: Any]
    return Part(
        lastModified: jsonDict["LastModified"].flatMap { ($0 is NSNull) ? nil : Date.deserialize(response: response, json: $0) },
      partNumber: jsonDict["PartNumber"].flatMap { ($0 is NSNull) ? nil : Int.deserialize(response: response, json: $0) },
      eTag: jsonDict["ETag"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      size: jsonDict["Size"].flatMap { ($0 is NSNull) ? nil : Int.deserialize(response: response, json: $0) }
    )
  }

/**
    - parameters:
      - lastModified: Date and time at which the part was uploaded.
      - partNumber: Part number identifying the part. This is a positive integer between 1 and 10,000.
      - eTag: Entity tag returned when the part was uploaded.
      - size: Size of the uploaded part data.
 */
  public init(lastModified: Date?, partNumber: Int?, eTag: String?, size: Int?) {
self.lastModified = lastModified
self.partNumber = partNumber
self.eTag = eTag
self.size = size
  }
}

/**
Bucket event for which to send notifications.
 */
enum Event: String, RestJsonDeserializable, RestJsonSerializable {
  case `s3ReducedRedundancyLostObject` = "s3:ReducedRedundancyLostObject"
  case `s3ObjectCreated` = "s3:ObjectCreated:*"
  case `s3ObjectCreatedPut` = "s3:ObjectCreated:Put"
  case `s3ObjectCreatedPost` = "s3:ObjectCreated:Post"
  case `s3ObjectCreatedCopy` = "s3:ObjectCreated:Copy"
  case `s3ObjectCreatedCompleteMultipartUpload` = "s3:ObjectCreated:CompleteMultipartUpload"
  case `s3ObjectRemoved` = "s3:ObjectRemoved:*"
  case `s3ObjectRemovedDelete` = "s3:ObjectRemoved:Delete"
  case `s3ObjectRemovedDeleteMarkerCreated` = "s3:ObjectRemoved:DeleteMarkerCreated"

  static func deserialize(response: HTTPURLResponse, json: Any) -> Event {
    return Event(rawValue: json as! String)!
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}




public struct ListBucketsOutput: RestJsonDeserializable {
/**

 */
  public let buckets: [Bucket]?
/**

 */
  public let owner: Owner?


  static func deserialize(response: HTTPURLResponse, json: Any) -> ListBucketsOutput {
    let jsonDict = json as! [String: Any]
    return ListBucketsOutput(
        buckets: jsonDict["Buckets"].flatMap { ($0 is NSNull) ? nil : [Bucket].deserialize(response: response, json: $0) },
      owner: jsonDict["Owner"].flatMap { ($0 is NSNull) ? nil : Owner.deserialize(response: response, json: $0) }
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

public struct GetBucketAccelerateConfigurationOutput: RestJsonDeserializable {
/**
The accelerate configuration of the bucket.
 */
  public let status: Bucketacceleratestatus?


  static func deserialize(response: HTTPURLResponse, json: Any) -> GetBucketAccelerateConfigurationOutput {
    let jsonDict = json as! [String: Any]
    return GetBucketAccelerateConfigurationOutput(
        status: jsonDict["Status"].flatMap { ($0 is NSNull) ? nil : Bucketacceleratestatus.deserialize(response: response, json: $0) }
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


/**
The specified bucket does not exist.
 */
public struct NoSuchBucket: RestJsonSerializable, RestJsonDeserializable {

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }

  static func deserialize(response: HTTPURLResponse, json: Any) -> NoSuchBucket {
  
    return NoSuchBucket(
  
    )
  }

/**
    - parameters:
 */
  public init() {
  }
}


public struct NotificationConfigurationDeprecated: RestJsonSerializable, RestJsonDeserializable {
/**

 */
  public let cloudFunctionConfiguration: CloudFunctionConfiguration?
/**

 */
  public let topicConfiguration: TopicConfigurationDeprecated?
/**

 */
  public let queueConfiguration: QueueConfigurationDeprecated?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if cloudFunctionConfiguration != nil { body["CloudFunctionConfiguration"] = cloudFunctionConfiguration! }
    if topicConfiguration != nil { body["TopicConfiguration"] = topicConfiguration! }
    if queueConfiguration != nil { body["QueueConfiguration"] = queueConfiguration! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserialize(response: HTTPURLResponse, json: Any) -> NotificationConfigurationDeprecated {
    let jsonDict = json as! [String: Any]
    return NotificationConfigurationDeprecated(
        cloudFunctionConfiguration: jsonDict["CloudFunctionConfiguration"].flatMap { ($0 is NSNull) ? nil : CloudFunctionConfiguration.deserialize(response: response, json: $0) },
      topicConfiguration: jsonDict["TopicConfiguration"].flatMap { ($0 is NSNull) ? nil : TopicConfigurationDeprecated.deserialize(response: response, json: $0) },
      queueConfiguration: jsonDict["QueueConfiguration"].flatMap { ($0 is NSNull) ? nil : QueueConfigurationDeprecated.deserialize(response: response, json: $0) }
    )
  }

/**
    - parameters:
      - cloudFunctionConfiguration: 
      - topicConfiguration: 
      - queueConfiguration: 
 */
  public init(cloudFunctionConfiguration: CloudFunctionConfiguration?, topicConfiguration: TopicConfigurationDeprecated?, queueConfiguration: QueueConfigurationDeprecated?) {
self.cloudFunctionConfiguration = cloudFunctionConfiguration
self.topicConfiguration = topicConfiguration
self.queueConfiguration = queueConfiguration
  }
}

public struct CopyPartResult: RestJsonSerializable, RestJsonDeserializable {
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

  static func deserialize(response: HTTPURLResponse, json: Any) -> CopyPartResult {
    let jsonDict = json as! [String: Any]
    return CopyPartResult(
        eTag: jsonDict["ETag"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      lastModified: jsonDict["LastModified"].flatMap { ($0 is NSNull) ? nil : Date.deserialize(response: response, json: $0) }
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

/**
Specifies when noncurrent object versions expire. Upon expiration, Amazon S3 permanently deletes the noncurrent object versions. You set this lifecycle configuration action on a bucket that has versioning enabled (or suspended) to request that Amazon S3 delete noncurrent object versions at a specific period in the object's lifetime.
 */
public struct NoncurrentVersionExpiration: RestJsonSerializable, RestJsonDeserializable {
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

  static func deserialize(response: HTTPURLResponse, json: Any) -> NoncurrentVersionExpiration {
    let jsonDict = json as! [String: Any]
    return NoncurrentVersionExpiration(
        noncurrentDays: jsonDict["NoncurrentDays"].flatMap { ($0 is NSNull) ? nil : Int.deserialize(response: response, json: $0) }
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



public struct Transition: RestJsonSerializable, RestJsonDeserializable {
/**
The class of storage used to store the object.
 */
  public let storageClass: Transitionstorageclass?
/**
Indicates at what date the object is to be moved or deleted. Should be in GMT ISO 8601 Format.
 */
  public let date: Date?
/**
Indicates the lifetime, in days, of the objects that are subject to the rule. The value must be a non-zero positive integer.
 */
  public let days: Int?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if storageClass != nil { body["StorageClass"] = storageClass! }
    if date != nil { body["Date"] = date! }
    if days != nil { body["Days"] = days! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserialize(response: HTTPURLResponse, json: Any) -> Transition {
    let jsonDict = json as! [String: Any]
    return Transition(
        storageClass: jsonDict["StorageClass"].flatMap { ($0 is NSNull) ? nil : Transitionstorageclass.deserialize(response: response, json: $0) },
      date: jsonDict["Date"].flatMap { ($0 is NSNull) ? nil : Date.deserialize(response: response, json: $0) },
      days: jsonDict["Days"].flatMap { ($0 is NSNull) ? nil : Int.deserialize(response: response, json: $0) }
    )
  }

/**
    - parameters:
      - storageClass: The class of storage used to store the object.
      - date: Indicates at what date the object is to be moved or deleted. Should be in GMT ISO 8601 Format.
      - days: Indicates the lifetime, in days, of the objects that are subject to the rule. The value must be a non-zero positive integer.
 */
  public init(storageClass: Transitionstorageclass?, date: Date?, days: Int?) {
self.storageClass = storageClass
self.date = date
self.days = days
  }
}



/**
Container for key value pair that defines the criteria for the filter rule.
 */
public struct FilterRule: RestJsonSerializable, RestJsonDeserializable {
/**

 */
  public let value: String?
/**
Object key name prefix or suffix identifying one or more objects to which the filtering rule applies. Maximum prefix length can be up to 1,024 characters. Overlapping prefixes and suffixes are not supported. For more information, go to <a href="http://docs.aws.amazon.com/AmazonS3/latest/dev/NotificationHowTo.html">Configuring Event Notifications</a> in the Amazon Simple Storage Service Developer Guide.
 */
  public let name: Filterrulename?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if value != nil { body["Value"] = value! }
    if name != nil { body["Name"] = name! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserialize(response: HTTPURLResponse, json: Any) -> FilterRule {
    let jsonDict = json as! [String: Any]
    return FilterRule(
        value: jsonDict["Value"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      name: jsonDict["Name"].flatMap { ($0 is NSNull) ? nil : Filterrulename.deserialize(response: response, json: $0) }
    )
  }

/**
    - parameters:
      - value: 
      - name: Object key name prefix or suffix identifying one or more objects to which the filtering rule applies. Maximum prefix length can be up to 1,024 characters. Overlapping prefixes and suffixes are not supported. For more information, go to <a href="http://docs.aws.amazon.com/AmazonS3/latest/dev/NotificationHowTo.html">Configuring Event Notifications</a> in the Amazon Simple Storage Service Developer Guide.
 */
  public init(value: String?, name: Filterrulename?) {
self.value = value
self.name = name
  }
}

public struct Condition: RestJsonSerializable, RestJsonDeserializable {
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

  static func deserialize(response: HTTPURLResponse, json: Any) -> Condition {
    let jsonDict = json as! [String: Any]
    return Condition(
        httpErrorCodeReturnedEquals: jsonDict["HttpErrorCodeReturnedEquals"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      keyPrefixEquals: jsonDict["KeyPrefixEquals"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) }
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

public struct AccelerateConfiguration: RestJsonSerializable, RestJsonDeserializable {
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

  static func deserialize(response: HTTPURLResponse, json: Any) -> AccelerateConfiguration {
    let jsonDict = json as! [String: Any]
    return AccelerateConfiguration(
        status: jsonDict["Status"].flatMap { ($0 is NSNull) ? nil : Bucketacceleratestatus.deserialize(response: response, json: $0) }
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

public struct PutBucketLoggingRequest: RestJsonSerializable {
/**

 */
  public let contentMD5: String?
/**

 */
  public let bucket: String
/**

 */
  public let bucketLoggingStatus: BucketLoggingStatus

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
      - contentMD5: 
      - bucket: 
      - bucketLoggingStatus: 
 */
  public init(contentMD5: String?, bucket: String, bucketLoggingStatus: BucketLoggingStatus) {
self.contentMD5 = contentMD5
self.bucket = bucket
self.bucketLoggingStatus = bucketLoggingStatus
  }
}

enum TypeType: String, RestJsonDeserializable, RestJsonSerializable {
  case `canonicalUser` = "CanonicalUser"
  case `amazonCustomerByEmail` = "AmazonCustomerByEmail"
  case `group` = "Group"

  static func deserialize(response: HTTPURLResponse, json: Any) -> TypeType {
    return TypeType(rawValue: json as! String)!
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}

public struct GetBucketPolicyOutput: RestJsonDeserializable {
/**
The bucket policy as a JSON document.
 */
  public let policy: String?


  static func deserialize(response: HTTPURLResponse, json: Any) -> GetBucketPolicyOutput {
    let jsonDict = json as! [String: Any]
    return GetBucketPolicyOutput(
        policy: jsonDict["Policy"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) }
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


public struct VersioningConfiguration: RestJsonSerializable, RestJsonDeserializable {
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

  static func deserialize(response: HTTPURLResponse, json: Any) -> VersioningConfiguration {
    let jsonDict = json as! [String: Any]
    return VersioningConfiguration(
        mFADelete: jsonDict["MfaDelete"].flatMap { ($0 is NSNull) ? nil : Mfadelete.deserialize(response: response, json: $0) },
      status: jsonDict["Status"].flatMap { ($0 is NSNull) ? nil : Bucketversioningstatus.deserialize(response: response, json: $0) }
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

public struct PutBucketPolicyRequest: RestJsonSerializable {
/**

 */
  public let contentMD5: String?
/**

 */
  public let bucket: String
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
      - contentMD5: 
      - bucket: 
      - policy: The bucket policy as a JSON document.
 */
  public init(contentMD5: String?, bucket: String, policy: String) {
self.contentMD5 = contentMD5
self.bucket = bucket
self.policy = policy
  }
}



/**
Container for replication rules. You can add as many as 1,000 rules. Total replication configuration size can be up to 2 MB.
 */
public struct ReplicationConfiguration: RestJsonSerializable, RestJsonDeserializable {
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

  static func deserialize(response: HTTPURLResponse, json: Any) -> ReplicationConfiguration {
    let jsonDict = json as! [String: Any]
    return ReplicationConfiguration(
        role: jsonDict["Role"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) }!,
      rules: jsonDict["Rule"].flatMap { ($0 is NSNull) ? nil : [ReplicationRule].deserialize(response: response, json: $0) }!
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

/**
Optional unique identifier for configurations in a notification configuration. If you don't provide one, Amazon S3 will assign an ID.
 */

enum Replicationstatus: String, RestJsonDeserializable, RestJsonSerializable {
  case `cOMPLETE` = "COMPLETE"
  case `pENDING` = "PENDING"
  case `fAILED` = "FAILED"
  case `rEPLICA` = "REPLICA"

  static func deserialize(response: HTTPURLResponse, json: Any) -> Replicationstatus {
    return Replicationstatus(rawValue: json as! String)!
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}




public struct GetObjectRequest: RestJsonSerializable {
/**

 */
  public let bucket: String
/**
Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data. This value is used to store the object and then it is discarded; Amazon does not store the encryption key. The key must be appropriate for use with the algorithm specified in the x-amz-server-side​-encryption​-customer-algorithm header.
 */
  public let sSECustomerKey: String?
/**
Return the object only if it has not been modified since the specified time, otherwise return a 412 (precondition failed).
 */
  public let ifUnmodifiedSince: Date?
/**
Part number of the object being read. This is a positive integer between 1 and 10,000. Effectively performs a 'ranged' GET request for the part specified. Useful for downloading just a part of an object.
 */
  public let partNumber: Int?
/**
Downloads the specified range bytes of an object. For more information about the HTTP Range header, go to http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.35.
 */
  public let range: String?
/**
Sets the Content-Encoding header of the response.
 */
  public let responseContentEncoding: String?
/**

 */
  public let requestPayer: Requestpayer?
/**
Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure the encryption key was transmitted without error.
 */
  public let sSECustomerKeyMD5: String?
/**
Sets the Content-Language header of the response.
 */
  public let responseContentLanguage: String?
/**
Sets the Expires header of the response.
 */
  public let responseExpires: Date?
/**
VersionId used to reference a specific version of the object.
 */
  public let versionId: String?
/**
Specifies the algorithm to use to when encrypting the object (e.g., AES256).
 */
  public let sSECustomerAlgorithm: String?
/**
Return the object only if its entity tag (ETag) is different from the one specified, otherwise return a 304 (not modified).
 */
  public let ifNoneMatch: String?
/**
Sets the Content-Disposition header of the response
 */
  public let responseContentDisposition: String?
/**

 */
  public let key: String
/**
Sets the Cache-Control header of the response.
 */
  public let responseCacheControl: String?
/**
Sets the Content-Type header of the response.
 */
  public let responseContentType: String?
/**
Return the object only if it has been modified since the specified time, otherwise return a 304 (not modified).
 */
  public let ifModifiedSince: Date?
/**
Return the object only if its entity tag (ETag) is the same as the one specified, otherwise return a 412 (precondition failed).
 */
  public let ifMatch: String?

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    var querystring: [String: String] = [:]
    var header: [String: String] = [:]
    
  
    uri["Bucket"] = "\(bucket)"
    uri["Key"] = "\(key)"
    if partNumber != nil { querystring["partNumber"] = "\(partNumber!)" }
    if responseContentEncoding != nil { querystring["response-content-encoding"] = "\(responseContentEncoding!)" }
    if responseContentLanguage != nil { querystring["response-content-language"] = "\(responseContentLanguage!)" }
    if responseExpires != nil { querystring["response-expires"] = "\(responseExpires!)" }
    if versionId != nil { querystring["versionId"] = "\(versionId!)" }
    if responseContentDisposition != nil { querystring["response-content-disposition"] = "\(responseContentDisposition!)" }
    if responseCacheControl != nil { querystring["response-cache-control"] = "\(responseCacheControl!)" }
    if responseContentType != nil { querystring["response-content-type"] = "\(responseContentType!)" }
    if sSECustomerKey != nil { header["x-amz-server-side-encryption-customer-key"] = "\(sSECustomerKey!)" }
    if ifUnmodifiedSince != nil { header["If-Unmodified-Since"] = "\(ifUnmodifiedSince!)" }
    if range != nil { header["Range"] = "\(range!)" }
    if requestPayer != nil { header["x-amz-request-payer"] = "\(requestPayer!)" }
    if sSECustomerKeyMD5 != nil { header["x-amz-server-side-encryption-customer-key-MD5"] = "\(sSECustomerKeyMD5!)" }
    if sSECustomerAlgorithm != nil { header["x-amz-server-side-encryption-customer-algorithm"] = "\(sSECustomerAlgorithm!)" }
    if ifNoneMatch != nil { header["If-None-Match"] = "\(ifNoneMatch!)" }
    if ifModifiedSince != nil { header["If-Modified-Since"] = "\(ifModifiedSince!)" }
    if ifMatch != nil { header["If-Match"] = "\(ifMatch!)" }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - bucket: 
      - sSECustomerKey: Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data. This value is used to store the object and then it is discarded; Amazon does not store the encryption key. The key must be appropriate for use with the algorithm specified in the x-amz-server-side​-encryption​-customer-algorithm header.
      - ifUnmodifiedSince: Return the object only if it has not been modified since the specified time, otherwise return a 412 (precondition failed).
      - partNumber: Part number of the object being read. This is a positive integer between 1 and 10,000. Effectively performs a 'ranged' GET request for the part specified. Useful for downloading just a part of an object.
      - range: Downloads the specified range bytes of an object. For more information about the HTTP Range header, go to http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.35.
      - responseContentEncoding: Sets the Content-Encoding header of the response.
      - requestPayer: 
      - sSECustomerKeyMD5: Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure the encryption key was transmitted without error.
      - responseContentLanguage: Sets the Content-Language header of the response.
      - responseExpires: Sets the Expires header of the response.
      - versionId: VersionId used to reference a specific version of the object.
      - sSECustomerAlgorithm: Specifies the algorithm to use to when encrypting the object (e.g., AES256).
      - ifNoneMatch: Return the object only if its entity tag (ETag) is different from the one specified, otherwise return a 304 (not modified).
      - responseContentDisposition: Sets the Content-Disposition header of the response
      - key: 
      - responseCacheControl: Sets the Cache-Control header of the response.
      - responseContentType: Sets the Content-Type header of the response.
      - ifModifiedSince: Return the object only if it has been modified since the specified time, otherwise return a 304 (not modified).
      - ifMatch: Return the object only if its entity tag (ETag) is the same as the one specified, otherwise return a 412 (precondition failed).
 */
  public init(bucket: String, sSECustomerKey: String?, ifUnmodifiedSince: Date?, partNumber: Int?, range: String?, responseContentEncoding: String?, requestPayer: Requestpayer?, sSECustomerKeyMD5: String?, responseContentLanguage: String?, responseExpires: Date?, versionId: String?, sSECustomerAlgorithm: String?, ifNoneMatch: String?, responseContentDisposition: String?, key: String, responseCacheControl: String?, responseContentType: String?, ifModifiedSince: Date?, ifMatch: String?) {
self.bucket = bucket
self.sSECustomerKey = sSECustomerKey
self.ifUnmodifiedSince = ifUnmodifiedSince
self.partNumber = partNumber
self.range = range
self.responseContentEncoding = responseContentEncoding
self.requestPayer = requestPayer
self.sSECustomerKeyMD5 = sSECustomerKeyMD5
self.responseContentLanguage = responseContentLanguage
self.responseExpires = responseExpires
self.versionId = versionId
self.sSECustomerAlgorithm = sSECustomerAlgorithm
self.ifNoneMatch = ifNoneMatch
self.responseContentDisposition = responseContentDisposition
self.key = key
self.responseCacheControl = responseCacheControl
self.responseContentType = responseContentType
self.ifModifiedSince = ifModifiedSince
self.ifMatch = ifMatch
  }
}


enum Replicationrulestatus: String, RestJsonDeserializable, RestJsonSerializable {
  case `enabled` = "Enabled"
  case `disabled` = "Disabled"

  static func deserialize(response: HTTPURLResponse, json: Any) -> Replicationrulestatus {
    return Replicationrulestatus(rawValue: json as! String)!
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}

public struct ObjectVersion: RestJsonSerializable, RestJsonDeserializable {
/**
Date and time the object was last modified.
 */
  public let lastModified: Date?
/**
Size in bytes of the object.
 */
  public let size: Int?
/**
Version ID of an object.
 */
  public let versionId: String?
/**
The class of storage used to store the object.
 */
  public let storageClass: Objectversionstorageclass?
/**
The object key.
 */
  public let key: String?
/**
Specifies whether the object is (true) or is not (false) the latest version of an object.
 */
  public let isLatest: Bool?
/**

 */
  public let eTag: String?
/**

 */
  public let owner: Owner?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if lastModified != nil { body["LastModified"] = lastModified! }
    if size != nil { body["Size"] = size! }
    if versionId != nil { body["VersionId"] = versionId! }
    if storageClass != nil { body["StorageClass"] = storageClass! }
    if key != nil { body["Key"] = key! }
    if isLatest != nil { body["IsLatest"] = isLatest! }
    if eTag != nil { body["ETag"] = eTag! }
    if owner != nil { body["Owner"] = owner! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserialize(response: HTTPURLResponse, json: Any) -> ObjectVersion {
    let jsonDict = json as! [String: Any]
    return ObjectVersion(
        lastModified: jsonDict["LastModified"].flatMap { ($0 is NSNull) ? nil : Date.deserialize(response: response, json: $0) },
      size: jsonDict["Size"].flatMap { ($0 is NSNull) ? nil : Int.deserialize(response: response, json: $0) },
      versionId: jsonDict["VersionId"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      storageClass: jsonDict["StorageClass"].flatMap { ($0 is NSNull) ? nil : Objectversionstorageclass.deserialize(response: response, json: $0) },
      key: jsonDict["Key"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      isLatest: jsonDict["IsLatest"].flatMap { ($0 is NSNull) ? nil : Bool.deserialize(response: response, json: $0) },
      eTag: jsonDict["ETag"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      owner: jsonDict["Owner"].flatMap { ($0 is NSNull) ? nil : Owner.deserialize(response: response, json: $0) }
    )
  }

/**
    - parameters:
      - lastModified: Date and time the object was last modified.
      - size: Size in bytes of the object.
      - versionId: Version ID of an object.
      - storageClass: The class of storage used to store the object.
      - key: The object key.
      - isLatest: Specifies whether the object is (true) or is not (false) the latest version of an object.
      - eTag: 
      - owner: 
 */
  public init(lastModified: Date?, size: Int?, versionId: String?, storageClass: Objectversionstorageclass?, key: String?, isLatest: Bool?, eTag: String?, owner: Owner?) {
self.lastModified = lastModified
self.size = size
self.versionId = versionId
self.storageClass = storageClass
self.key = key
self.isLatest = isLatest
self.eTag = eTag
self.owner = owner
  }
}

public struct GetBucketReplicationOutput: RestJsonDeserializable {
/**

 */
  public let replicationConfiguration: ReplicationConfiguration?


  static func deserialize(response: HTTPURLResponse, json: Any) -> GetBucketReplicationOutput {
    let jsonDict = json as! [String: Any]
    return GetBucketReplicationOutput(
        replicationConfiguration: jsonDict["ReplicationConfiguration"].flatMap { ($0 is NSNull) ? nil : ReplicationConfiguration.deserialize(response: response, json: $0) }
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

public struct BucketAlreadyOwnedByYou: RestJsonSerializable, RestJsonDeserializable {

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }

  static func deserialize(response: HTTPURLResponse, json: Any) -> BucketAlreadyOwnedByYou {
  
    return BucketAlreadyOwnedByYou(
  
    )
  }

/**
    - parameters:
 */
  public init() {
  }
}


public struct AbortMultipartUploadRequest: RestJsonSerializable {
/**

 */
  public let bucket: String
/**

 */
  public let key: String
/**

 */
  public let uploadId: String
/**

 */
  public let requestPayer: Requestpayer?

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
      - uploadId: 
      - requestPayer: 
 */
  public init(bucket: String, key: String, uploadId: String, requestPayer: Requestpayer?) {
self.bucket = bucket
self.key = key
self.uploadId = uploadId
self.requestPayer = requestPayer
  }
}




public struct ListObjectsOutput: RestJsonDeserializable {
/**

 */
  public let maxKeys: Int?
/**
A flag that indicates whether or not Amazon S3 returned all of the results that satisfied the search criteria.
 */
  public let isTruncated: Bool?
/**

 */
  public let marker: String?
/**

 */
  public let name: String?
/**

 */
  public let prefix: String?
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
When response is truncated (the IsTruncated element value in the response is true), you can use the key name in this field as marker in the subsequent request to get next set of objects. Amazon S3 lists objects in alphabetical order Note: This element is returned only if you have delimiter request parameter specified. If response does not include the NextMaker and it is truncated, you can use the value of the last Key in the response as the marker in the subsequent request to get the next set of object keys.
 */
  public let nextMarker: String?


  static func deserialize(response: HTTPURLResponse, json: Any) -> ListObjectsOutput {
    let jsonDict = json as! [String: Any]
    return ListObjectsOutput(
        maxKeys: jsonDict["MaxKeys"].flatMap { ($0 is NSNull) ? nil : Int.deserialize(response: response, json: $0) },
      isTruncated: jsonDict["IsTruncated"].flatMap { ($0 is NSNull) ? nil : Bool.deserialize(response: response, json: $0) },
      marker: jsonDict["Marker"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      name: jsonDict["Name"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      prefix: jsonDict["Prefix"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      commonPrefixes: jsonDict["CommonPrefixes"].flatMap { ($0 is NSNull) ? nil : [CommonPrefix].deserialize(response: response, json: $0) },
      contents: jsonDict["Contents"].flatMap { ($0 is NSNull) ? nil : [Object].deserialize(response: response, json: $0) },
      delimiter: jsonDict["Delimiter"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      encodingType: jsonDict["EncodingType"].flatMap { ($0 is NSNull) ? nil : Encodingtype.deserialize(response: response, json: $0) },
      nextMarker: jsonDict["NextMarker"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) }
    )
  }

/**
    - parameters:
      - maxKeys: 
      - isTruncated: A flag that indicates whether or not Amazon S3 returned all of the results that satisfied the search criteria.
      - marker: 
      - name: 
      - prefix: 
      - commonPrefixes: 
      - contents: 
      - delimiter: 
      - encodingType: Encoding type used by Amazon S3 to encode object keys in the response.
      - nextMarker: When response is truncated (the IsTruncated element value in the response is true), you can use the key name in this field as marker in the subsequent request to get next set of objects. Amazon S3 lists objects in alphabetical order Note: This element is returned only if you have delimiter request parameter specified. If response does not include the NextMaker and it is truncated, you can use the value of the last Key in the response as the marker in the subsequent request to get the next set of object keys.
 */
  public init(maxKeys: Int?, isTruncated: Bool?, marker: String?, name: String?, prefix: String?, commonPrefixes: [CommonPrefix]?, contents: [Object]?, delimiter: String?, encodingType: Encodingtype?, nextMarker: String?) {
self.maxKeys = maxKeys
self.isTruncated = isTruncated
self.marker = marker
self.name = name
self.prefix = prefix
self.commonPrefixes = commonPrefixes
self.contents = contents
self.delimiter = delimiter
self.encodingType = encodingType
self.nextMarker = nextMarker
  }
}



public struct CompleteMultipartUploadOutput: RestJsonDeserializable {
/**

 */
  public let bucket: String?
/**

 */
  public let location: String?
/**
If the object expiration is configured, this will contain the expiration date (expiry-date) and rule ID (rule-id). The value of rule-id is URL encoded.
 */
  public let expiration: String?
/**
Version of the object.
 */
  public let versionId: String?
/**

 */
  public let key: String?
/**
If present, specifies the ID of the AWS Key Management Service (KMS) master encryption key that was used for the object.
 */
  public let sSEKMSKeyId: String?
/**
Entity tag of the object.
 */
  public let eTag: String?
/**
The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).
 */
  public let serverSideEncryption: Serversideencryption?
/**

 */
  public let requestCharged: Requestcharged?


  static func deserialize(response: HTTPURLResponse, json: Any) -> CompleteMultipartUploadOutput {
    let jsonDict = json as! [String: Any]
    return CompleteMultipartUploadOutput(
        bucket: jsonDict["Bucket"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      location: jsonDict["Location"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      expiration: response.allHeaderFields["x-amz-expiration"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      versionId: response.allHeaderFields["x-amz-version-id"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      key: jsonDict["Key"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      sSEKMSKeyId: response.allHeaderFields["x-amz-server-side-encryption-aws-kms-key-id"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      eTag: jsonDict["ETag"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      serverSideEncryption: response.allHeaderFields["x-amz-server-side-encryption"].flatMap { ($0 is NSNull) ? nil : Serversideencryption.deserialize(response: response, json: $0) },
      requestCharged: response.allHeaderFields["x-amz-request-charged"].flatMap { ($0 is NSNull) ? nil : Requestcharged.deserialize(response: response, json: $0) }
    )
  }

/**
    - parameters:
      - bucket: 
      - location: 
      - expiration: If the object expiration is configured, this will contain the expiration date (expiry-date) and rule ID (rule-id). The value of rule-id is URL encoded.
      - versionId: Version of the object.
      - key: 
      - sSEKMSKeyId: If present, specifies the ID of the AWS Key Management Service (KMS) master encryption key that was used for the object.
      - eTag: Entity tag of the object.
      - serverSideEncryption: The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).
      - requestCharged: 
 */
  public init(bucket: String?, location: String?, expiration: String?, versionId: String?, key: String?, sSEKMSKeyId: String?, eTag: String?, serverSideEncryption: Serversideencryption?, requestCharged: Requestcharged?) {
self.bucket = bucket
self.location = location
self.expiration = expiration
self.versionId = versionId
self.key = key
self.sSEKMSKeyId = sSEKMSKeyId
self.eTag = eTag
self.serverSideEncryption = serverSideEncryption
self.requestCharged = requestCharged
  }
}

/**
The requested bucket name is not available. The bucket namespace is shared by all users of the system. Please select a different name and try again.
 */
public struct BucketAlreadyExists: RestJsonSerializable, RestJsonDeserializable {

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }

  static func deserialize(response: HTTPURLResponse, json: Any) -> BucketAlreadyExists {
  
    return BucketAlreadyExists(
  
    )
  }

/**
    - parameters:
 */
  public init() {
  }
}


public struct GetObjectTorrentOutput: RestJsonDeserializable {
/**

 */
  public let bodyBody: Data?
/**

 */
  public let requestCharged: Requestcharged?


  static func deserialize(response: HTTPURLResponse, json: Any) -> GetObjectTorrentOutput {
    let jsonDict = json as! [String: Any]
    return GetObjectTorrentOutput(
        bodyBody: jsonDict["Body"].flatMap { ($0 is NSNull) ? nil : Data.deserialize(response: response, json: $0) },
      requestCharged: response.allHeaderFields["x-amz-request-charged"].flatMap { ($0 is NSNull) ? nil : Requestcharged.deserialize(response: response, json: $0) }
    )
  }

/**
    - parameters:
      - bodyBody: 
      - requestCharged: 
 */
  public init(bodyBody: Data?, requestCharged: Requestcharged?) {
self.bodyBody = bodyBody
self.requestCharged = requestCharged
  }
}

enum Mfadelete: String, RestJsonDeserializable, RestJsonSerializable {
  case `enabled` = "Enabled"
  case `disabled` = "Disabled"

  static func deserialize(response: HTTPURLResponse, json: Any) -> Mfadelete {
    return Mfadelete(rawValue: json as! String)!
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}

/**
Container for object key name filtering rules. For information about key name filtering, go to <a href="http://docs.aws.amazon.com/AmazonS3/latest/dev/NotificationHowTo.html">Configuring Event Notifications</a> in the Amazon Simple Storage Service Developer Guide.
 */
public struct NotificationConfigurationFilter: RestJsonSerializable, RestJsonDeserializable {
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

  static func deserialize(response: HTTPURLResponse, json: Any) -> NotificationConfigurationFilter {
    let jsonDict = json as! [String: Any]
    return NotificationConfigurationFilter(
        key: jsonDict["S3Key"].flatMap { ($0 is NSNull) ? nil : S3KeyFilter.deserialize(response: response, json: $0) }
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

public struct PutObjectAclRequest: RestJsonSerializable {
/**

 */
  public let bucket: String
/**

 */
  public let contentMD5: String?
/**

 */
  public let accessControlPolicy: AccessControlPolicy?
/**
Allows grantee to write the ACL for the applicable bucket.
 */
  public let grantWriteACP: String?
/**

 */
  public let requestPayer: Requestpayer?
/**
Allows grantee the read, write, read ACP, and write ACP permissions on the bucket.
 */
  public let grantFullControl: String?
/**
VersionId used to reference a specific version of the object.
 */
  public let versionId: String?
/**
Allows grantee to create, overwrite, and delete any object in the bucket.
 */
  public let grantWrite: String?
/**

 */
  public let key: String
/**
Allows grantee to read the bucket ACL.
 */
  public let grantReadACP: String?
/**
Allows grantee to list the objects in the bucket.
 */
  public let grantRead: String?
/**
The canned ACL to apply to the object.
 */
  public let aCL: Objectcannedacl?

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    var querystring: [String: String] = [:]
    var header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    uri["Bucket"] = "\(bucket)"
    uri["Key"] = "\(key)"
    if versionId != nil { querystring["versionId"] = "\(versionId!)" }
    if contentMD5 != nil { header["Content-MD5"] = "\(contentMD5!)" }
    if grantWriteACP != nil { header["x-amz-grant-write-acp"] = "\(grantWriteACP!)" }
    if requestPayer != nil { header["x-amz-request-payer"] = "\(requestPayer!)" }
    if grantFullControl != nil { header["x-amz-grant-full-control"] = "\(grantFullControl!)" }
    if grantWrite != nil { header["x-amz-grant-write"] = "\(grantWrite!)" }
    if grantReadACP != nil { header["x-amz-grant-read-acp"] = "\(grantReadACP!)" }
    if grantRead != nil { header["x-amz-grant-read"] = "\(grantRead!)" }
    if aCL != nil { header["x-amz-acl"] = "\(aCL!)" }
    if accessControlPolicy != nil { body["AccessControlPolicy"] = accessControlPolicy! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - bucket: 
      - contentMD5: 
      - accessControlPolicy: 
      - grantWriteACP: Allows grantee to write the ACL for the applicable bucket.
      - requestPayer: 
      - grantFullControl: Allows grantee the read, write, read ACP, and write ACP permissions on the bucket.
      - versionId: VersionId used to reference a specific version of the object.
      - grantWrite: Allows grantee to create, overwrite, and delete any object in the bucket.
      - key: 
      - grantReadACP: Allows grantee to read the bucket ACL.
      - grantRead: Allows grantee to list the objects in the bucket.
      - aCL: The canned ACL to apply to the object.
 */
  public init(bucket: String, contentMD5: String?, accessControlPolicy: AccessControlPolicy?, grantWriteACP: String?, requestPayer: Requestpayer?, grantFullControl: String?, versionId: String?, grantWrite: String?, key: String, grantReadACP: String?, grantRead: String?, aCL: Objectcannedacl?) {
self.bucket = bucket
self.contentMD5 = contentMD5
self.accessControlPolicy = accessControlPolicy
self.grantWriteACP = grantWriteACP
self.requestPayer = requestPayer
self.grantFullControl = grantFullControl
self.versionId = versionId
self.grantWrite = grantWrite
self.key = key
self.grantReadACP = grantReadACP
self.grantRead = grantRead
self.aCL = aCL
  }
}

/**
Container for the transition rule that describes when noncurrent objects transition to the STANDARD_IA or GLACIER storage class. If your bucket is versioning-enabled (or versioning is suspended), you can set this action to request that Amazon S3 transition noncurrent object versions to the STANDARD_IA or GLACIER storage class at a specific period in the object's lifetime.
 */
public struct NoncurrentVersionTransition: RestJsonSerializable, RestJsonDeserializable {
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

  static func deserialize(response: HTTPURLResponse, json: Any) -> NoncurrentVersionTransition {
    let jsonDict = json as! [String: Any]
    return NoncurrentVersionTransition(
        noncurrentDays: jsonDict["NoncurrentDays"].flatMap { ($0 is NSNull) ? nil : Int.deserialize(response: response, json: $0) },
      storageClass: jsonDict["StorageClass"].flatMap { ($0 is NSNull) ? nil : Transitionstorageclass.deserialize(response: response, json: $0) }
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

public struct Redirect: RestJsonSerializable, RestJsonDeserializable {
/**
The object key prefix to use in the redirect request. For example, to redirect requests for all pages with prefix docs/ (objects in the docs/ folder) to documents/, you can set a condition block with KeyPrefixEquals set to docs/ and in the Redirect set ReplaceKeyPrefixWith to /documents. Not required if one of the siblings is present. Can be present only if ReplaceKeyWith is not provided.
 */
  public let replaceKeyPrefixWith: String?
/**
The HTTP redirect code to use on the response. Not required if one of the siblings is present.
 */
  public let httpRedirectCode: String?
/**
The host name to use in the redirect request.
 */
  public let hostName: String?
/**
Protocol to use (http, https) when redirecting requests. The default is the protocol that is used in the original request.
 */
  public let protocolProtocol: ProtocolProtocol?
/**
The specific object key to use in the redirect request. For example, redirect request to error.html. Not required if one of the sibling is present. Can be present only if ReplaceKeyPrefixWith is not provided.
 */
  public let replaceKeyWith: String?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if replaceKeyPrefixWith != nil { body["ReplaceKeyPrefixWith"] = replaceKeyPrefixWith! }
    if httpRedirectCode != nil { body["HttpRedirectCode"] = httpRedirectCode! }
    if hostName != nil { body["HostName"] = hostName! }
    if protocolProtocol != nil { body["Protocol"] = protocolProtocol! }
    if replaceKeyWith != nil { body["ReplaceKeyWith"] = replaceKeyWith! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserialize(response: HTTPURLResponse, json: Any) -> Redirect {
    let jsonDict = json as! [String: Any]
    return Redirect(
        replaceKeyPrefixWith: jsonDict["ReplaceKeyPrefixWith"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      httpRedirectCode: jsonDict["HttpRedirectCode"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      hostName: jsonDict["HostName"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      protocolProtocol: jsonDict["Protocol"].flatMap { ($0 is NSNull) ? nil : ProtocolProtocol.deserialize(response: response, json: $0) },
      replaceKeyWith: jsonDict["ReplaceKeyWith"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) }
    )
  }

/**
    - parameters:
      - replaceKeyPrefixWith: The object key prefix to use in the redirect request. For example, to redirect requests for all pages with prefix docs/ (objects in the docs/ folder) to documents/, you can set a condition block with KeyPrefixEquals set to docs/ and in the Redirect set ReplaceKeyPrefixWith to /documents. Not required if one of the siblings is present. Can be present only if ReplaceKeyWith is not provided.
      - httpRedirectCode: The HTTP redirect code to use on the response. Not required if one of the siblings is present.
      - hostName: The host name to use in the redirect request.
      - protocolProtocol: Protocol to use (http, https) when redirecting requests. The default is the protocol that is used in the original request.
      - replaceKeyWith: The specific object key to use in the redirect request. For example, redirect request to error.html. Not required if one of the sibling is present. Can be present only if ReplaceKeyPrefixWith is not provided.
 */
  public init(replaceKeyPrefixWith: String?, httpRedirectCode: String?, hostName: String?, protocolProtocol: ProtocolProtocol?, replaceKeyWith: String?) {
self.replaceKeyPrefixWith = replaceKeyPrefixWith
self.httpRedirectCode = httpRedirectCode
self.hostName = hostName
self.protocolProtocol = protocolProtocol
self.replaceKeyWith = replaceKeyWith
  }
}

public struct PutBucketAclRequest: RestJsonSerializable {
/**

 */
  public let bucket: String
/**

 */
  public let contentMD5: String?
/**

 */
  public let accessControlPolicy: AccessControlPolicy?
/**
Allows grantee to write the ACL for the applicable bucket.
 */
  public let grantWriteACP: String?
/**
Allows grantee the read, write, read ACP, and write ACP permissions on the bucket.
 */
  public let grantFullControl: String?
/**
Allows grantee to create, overwrite, and delete any object in the bucket.
 */
  public let grantWrite: String?
/**
Allows grantee to list the objects in the bucket.
 */
  public let grantRead: String?
/**
The canned ACL to apply to the bucket.
 */
  public let aCL: Bucketcannedacl?
/**
Allows grantee to read the bucket ACL.
 */
  public let grantReadACP: String?

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    var header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    uri["Bucket"] = "\(bucket)"
    if contentMD5 != nil { header["Content-MD5"] = "\(contentMD5!)" }
    if grantWriteACP != nil { header["x-amz-grant-write-acp"] = "\(grantWriteACP!)" }
    if grantFullControl != nil { header["x-amz-grant-full-control"] = "\(grantFullControl!)" }
    if grantWrite != nil { header["x-amz-grant-write"] = "\(grantWrite!)" }
    if grantRead != nil { header["x-amz-grant-read"] = "\(grantRead!)" }
    if aCL != nil { header["x-amz-acl"] = "\(aCL!)" }
    if grantReadACP != nil { header["x-amz-grant-read-acp"] = "\(grantReadACP!)" }
    if accessControlPolicy != nil { body["AccessControlPolicy"] = accessControlPolicy! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - bucket: 
      - contentMD5: 
      - accessControlPolicy: 
      - grantWriteACP: Allows grantee to write the ACL for the applicable bucket.
      - grantFullControl: Allows grantee the read, write, read ACP, and write ACP permissions on the bucket.
      - grantWrite: Allows grantee to create, overwrite, and delete any object in the bucket.
      - grantRead: Allows grantee to list the objects in the bucket.
      - aCL: The canned ACL to apply to the bucket.
      - grantReadACP: Allows grantee to read the bucket ACL.
 */
  public init(bucket: String, contentMD5: String?, accessControlPolicy: AccessControlPolicy?, grantWriteACP: String?, grantFullControl: String?, grantWrite: String?, grantRead: String?, aCL: Bucketcannedacl?, grantReadACP: String?) {
self.bucket = bucket
self.contentMD5 = contentMD5
self.accessControlPolicy = accessControlPolicy
self.grantWriteACP = grantWriteACP
self.grantFullControl = grantFullControl
self.grantWrite = grantWrite
self.grantRead = grantRead
self.aCL = aCL
self.grantReadACP = grantReadACP
  }
}

public struct UploadPartCopyRequest: RestJsonSerializable {
/**

 */
  public let bucket: String
/**
Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data. This value is used to store the object and then it is discarded; Amazon does not store the encryption key. The key must be appropriate for use with the algorithm specified in the x-amz-server-side​-encryption​-customer-algorithm header. This must be the same encryption key specified in the initiate multipart upload request.
 */
  public let sSECustomerKey: String?
/**
Part number of part being copied. This is a positive integer between 1 and 10,000.
 */
  public let partNumber: Int
/**
Copies the object if it has been modified since the specified time.
 */
  public let copySourceIfModifiedSince: Date?
/**

 */
  public let requestPayer: Requestpayer?
/**
Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure the encryption key was transmitted without error.
 */
  public let sSECustomerKeyMD5: String?
/**
Specifies the customer-provided encryption key for Amazon S3 to use to decrypt the source object. The encryption key provided in this header must be one that was used when the source object was created.
 */
  public let copySourceSSECustomerKey: String?
/**
The name of the source bucket and key name of the source object, separated by a slash (/). Must be URL-encoded.
 */
  public let copySource: String
/**
Copies the object if its entity tag (ETag) is different than the specified ETag.
 */
  public let copySourceIfNoneMatch: String?
/**
Upload ID identifying the multipart upload whose part is being copied.
 */
  public let uploadId: String
/**
Specifies the algorithm to use to when encrypting the object (e.g., AES256).
 */
  public let sSECustomerAlgorithm: String?
/**
Copies the object if its entity tag (ETag) matches the specified tag.
 */
  public let copySourceIfMatch: String?
/**
The range of bytes to copy from the source object. The range value must use the form bytes=first-last, where the first and last are the zero-based byte offsets to copy. For example, bytes=0-9 indicates that you want to copy the first ten bytes of the source. You can copy a range only if the source object is greater than 5 GB.
 */
  public let copySourceRange: String?
/**

 */
  public let key: String
/**
Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure the encryption key was transmitted without error.
 */
  public let copySourceSSECustomerKeyMD5: String?
/**
Specifies the algorithm to use when decrypting the source object (e.g., AES256).
 */
  public let copySourceSSECustomerAlgorithm: String?
/**
Copies the object if it hasn't been modified since the specified time.
 */
  public let copySourceIfUnmodifiedSince: Date?

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    var querystring: [String: String] = [:]
    var header: [String: String] = [:]
    
  
    uri["Bucket"] = "\(bucket)"
    uri["Key"] = "\(key)"
    querystring["partNumber"] = "\(partNumber)"
    querystring["uploadId"] = "\(uploadId)"
    if sSECustomerKey != nil { header["x-amz-server-side-encryption-customer-key"] = "\(sSECustomerKey!)" }
    if copySourceIfModifiedSince != nil { header["x-amz-copy-source-if-modified-since"] = "\(copySourceIfModifiedSince!)" }
    if requestPayer != nil { header["x-amz-request-payer"] = "\(requestPayer!)" }
    if sSECustomerKeyMD5 != nil { header["x-amz-server-side-encryption-customer-key-MD5"] = "\(sSECustomerKeyMD5!)" }
    if copySourceSSECustomerKey != nil { header["x-amz-copy-source-server-side-encryption-customer-key"] = "\(copySourceSSECustomerKey!)" }
    header["x-amz-copy-source"] = "\(copySource)"
    if copySourceIfNoneMatch != nil { header["x-amz-copy-source-if-none-match"] = "\(copySourceIfNoneMatch!)" }
    if sSECustomerAlgorithm != nil { header["x-amz-server-side-encryption-customer-algorithm"] = "\(sSECustomerAlgorithm!)" }
    if copySourceIfMatch != nil { header["x-amz-copy-source-if-match"] = "\(copySourceIfMatch!)" }
    if copySourceRange != nil { header["x-amz-copy-source-range"] = "\(copySourceRange!)" }
    if copySourceSSECustomerKeyMD5 != nil { header["x-amz-copy-source-server-side-encryption-customer-key-MD5"] = "\(copySourceSSECustomerKeyMD5!)" }
    if copySourceSSECustomerAlgorithm != nil { header["x-amz-copy-source-server-side-encryption-customer-algorithm"] = "\(copySourceSSECustomerAlgorithm!)" }
    if copySourceIfUnmodifiedSince != nil { header["x-amz-copy-source-if-unmodified-since"] = "\(copySourceIfUnmodifiedSince!)" }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - bucket: 
      - sSECustomerKey: Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data. This value is used to store the object and then it is discarded; Amazon does not store the encryption key. The key must be appropriate for use with the algorithm specified in the x-amz-server-side​-encryption​-customer-algorithm header. This must be the same encryption key specified in the initiate multipart upload request.
      - partNumber: Part number of part being copied. This is a positive integer between 1 and 10,000.
      - copySourceIfModifiedSince: Copies the object if it has been modified since the specified time.
      - requestPayer: 
      - sSECustomerKeyMD5: Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure the encryption key was transmitted without error.
      - copySourceSSECustomerKey: Specifies the customer-provided encryption key for Amazon S3 to use to decrypt the source object. The encryption key provided in this header must be one that was used when the source object was created.
      - copySource: The name of the source bucket and key name of the source object, separated by a slash (/). Must be URL-encoded.
      - copySourceIfNoneMatch: Copies the object if its entity tag (ETag) is different than the specified ETag.
      - uploadId: Upload ID identifying the multipart upload whose part is being copied.
      - sSECustomerAlgorithm: Specifies the algorithm to use to when encrypting the object (e.g., AES256).
      - copySourceIfMatch: Copies the object if its entity tag (ETag) matches the specified tag.
      - copySourceRange: The range of bytes to copy from the source object. The range value must use the form bytes=first-last, where the first and last are the zero-based byte offsets to copy. For example, bytes=0-9 indicates that you want to copy the first ten bytes of the source. You can copy a range only if the source object is greater than 5 GB.
      - key: 
      - copySourceSSECustomerKeyMD5: Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure the encryption key was transmitted without error.
      - copySourceSSECustomerAlgorithm: Specifies the algorithm to use when decrypting the source object (e.g., AES256).
      - copySourceIfUnmodifiedSince: Copies the object if it hasn't been modified since the specified time.
 */
  public init(bucket: String, sSECustomerKey: String?, partNumber: Int, copySourceIfModifiedSince: Date?, requestPayer: Requestpayer?, sSECustomerKeyMD5: String?, copySourceSSECustomerKey: String?, copySource: String, copySourceIfNoneMatch: String?, uploadId: String, sSECustomerAlgorithm: String?, copySourceIfMatch: String?, copySourceRange: String?, key: String, copySourceSSECustomerKeyMD5: String?, copySourceSSECustomerAlgorithm: String?, copySourceIfUnmodifiedSince: Date?) {
self.bucket = bucket
self.sSECustomerKey = sSECustomerKey
self.partNumber = partNumber
self.copySourceIfModifiedSince = copySourceIfModifiedSince
self.requestPayer = requestPayer
self.sSECustomerKeyMD5 = sSECustomerKeyMD5
self.copySourceSSECustomerKey = copySourceSSECustomerKey
self.copySource = copySource
self.copySourceIfNoneMatch = copySourceIfNoneMatch
self.uploadId = uploadId
self.sSECustomerAlgorithm = sSECustomerAlgorithm
self.copySourceIfMatch = copySourceIfMatch
self.copySourceRange = copySourceRange
self.key = key
self.copySourceSSECustomerKeyMD5 = copySourceSSECustomerKeyMD5
self.copySourceSSECustomerAlgorithm = copySourceSSECustomerAlgorithm
self.copySourceIfUnmodifiedSince = copySourceIfUnmodifiedSince
  }
}

/**
Container for specifying the configuration when you want Amazon S3 to publish events to an Amazon Simple Notification Service (Amazon SNS) topic.
 */
public struct TopicConfiguration: RestJsonSerializable, RestJsonDeserializable {
/**
Amazon SNS topic ARN to which Amazon S3 will publish a message when it detects events of specified type.
 */
  public let topicArn: String
/**

 */
  public let events: [Event]
/**

 */
  public let filter: NotificationConfigurationFilter?
/**

 */
  public let id: String?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["Topic"] = topicArn
    body["Event"] = events
    if filter != nil { body["Filter"] = filter! }
    if id != nil { body["Id"] = id! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserialize(response: HTTPURLResponse, json: Any) -> TopicConfiguration {
    let jsonDict = json as! [String: Any]
    return TopicConfiguration(
        topicArn: jsonDict["Topic"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) }!,
      events: jsonDict["Event"].flatMap { ($0 is NSNull) ? nil : [Event].deserialize(response: response, json: $0) }!,
      filter: jsonDict["Filter"].flatMap { ($0 is NSNull) ? nil : NotificationConfigurationFilter.deserialize(response: response, json: $0) },
      id: jsonDict["Id"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) }
    )
  }

/**
    - parameters:
      - topicArn: Amazon SNS topic ARN to which Amazon S3 will publish a message when it detects events of specified type.
      - events: 
      - filter: 
      - id: 
 */
  public init(topicArn: String, events: [Event], filter: NotificationConfigurationFilter?, id: String?) {
self.topicArn = topicArn
self.events = events
self.filter = filter
self.id = id
  }
}

public struct RoutingRule: RestJsonSerializable, RestJsonDeserializable {
/**
Container for redirect information. You can redirect requests to another host, to another page, or with another protocol. In the event of an error, you can can specify a different error code to return.
 */
  public let redirect: Redirect
/**
A container for describing a condition that must be met for the specified redirect to apply. For example, 1. If request is for pages in the /docs folder, redirect to the /documents folder. 2. If request results in HTTP error 4xx, redirect request to another host where you might process the error.
 */
  public let condition: Condition?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["Redirect"] = redirect
    if condition != nil { body["Condition"] = condition! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserialize(response: HTTPURLResponse, json: Any) -> RoutingRule {
    let jsonDict = json as! [String: Any]
    return RoutingRule(
        redirect: jsonDict["Redirect"].flatMap { ($0 is NSNull) ? nil : Redirect.deserialize(response: response, json: $0) }!,
      condition: jsonDict["Condition"].flatMap { ($0 is NSNull) ? nil : Condition.deserialize(response: response, json: $0) }
    )
  }

/**
    - parameters:
      - redirect: Container for redirect information. You can redirect requests to another host, to another page, or with another protocol. In the event of an error, you can can specify a different error code to return.
      - condition: A container for describing a condition that must be met for the specified redirect to apply. For example, 1. If request is for pages in the /docs folder, redirect to the /documents folder. 2. If request results in HTTP error 4xx, redirect request to another host where you might process the error.
 */
  public init(redirect: Redirect, condition: Condition?) {
self.redirect = redirect
self.condition = condition
  }
}


/**
Requests Amazon S3 to encode the object keys in the response and specifies the encoding method to use. An object key may contain any Unicode character; however, XML 1.0 parser cannot parse some characters, such as characters with an ASCII value from 0 to 10. For characters that are not supported in XML 1.0, you can add this parameter to request that Amazon S3 encode the keys in the response.
 */
enum Encodingtype: String, RestJsonDeserializable, RestJsonSerializable {
  case `url` = "url"

  static func deserialize(response: HTTPURLResponse, json: Any) -> Encodingtype {
    return Encodingtype(rawValue: json as! String)!
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}




public struct IndexDocument: RestJsonSerializable, RestJsonDeserializable {
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

  static func deserialize(response: HTTPURLResponse, json: Any) -> IndexDocument {
    let jsonDict = json as! [String: Any]
    return IndexDocument(
        suffix: jsonDict["Suffix"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) }!
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

public struct HeadObjectOutput: RestJsonDeserializable {
/**
The count of parts this object has.
 */
  public let partsCount: Int?
/**
Specifies presentational information for the object.
 */
  public let contentDisposition: String?
/**
Version of the object.
 */
  public let versionId: String?
/**

 */
  public let replicationStatus: Replicationstatus?
/**
If present, specifies the ID of the AWS Key Management Service (KMS) master encryption key that was used for the object.
 */
  public let sSEKMSKeyId: String?
/**
The language the content is in.
 */
  public let contentLanguage: String?
/**
If server-side encryption with a customer-provided encryption key was requested, the response will include this header confirming the encryption algorithm used.
 */
  public let sSECustomerAlgorithm: String?
/**
Provides information about object restoration operation and expiration time of the restored object copy.
 */
  public let restore: String?
/**
Specifies what content encodings have been applied to the object and thus what decoding mechanisms must be applied to obtain the media-type referenced by the Content-Type header field.
 */
  public let contentEncoding: String?
/**
Size of the body in bytes.
 */
  public let contentLength: Int?
/**
If the object expiration is configured (see PUT Bucket lifecycle), the response includes this header. It includes the expiry-date and rule-id key value pairs providing object expiration information. The value of the rule-id is URL encoded.
 */
  public let expiration: String?
/**
If the bucket is configured as a website, redirects requests for this object to another object in the same bucket or to an external URL. Amazon S3 stores the value of this header in the object metadata.
 */
  public let websiteRedirectLocation: String?
/**
An ETag is an opaque identifier assigned by a web server to a specific version of a resource found at a URL
 */
  public let eTag: String?
/**
This is set to the number of metadata entries not returned in x-amz-meta headers. This can happen if you create metadata using an API like SOAP that supports more flexible metadata than the REST API. For example, using SOAP, you can create metadata whose values are not legal HTTP headers.
 */
  public let missingMeta: Int?
/**
Specifies caching behavior along the request/reply chain.
 */
  public let cacheControl: String?
/**
If server-side encryption with a customer-provided encryption key was requested, the response will include this header to provide round trip message integrity verification of the customer-provided encryption key.
 */
  public let sSECustomerKeyMD5: String?
/**

 */
  public let acceptRanges: String?
/**
Last modified date of the object
 */
  public let lastModified: Date?
/**
A map of metadata to store with the object in S3.
 */
  public let metadata: [String: String]?
/**
The date and time at which the object is no longer cacheable.
 */
  public let expires: Date?
/**
A standard MIME type describing the format of the object data.
 */
  public let contentType: String?
/**

 */
  public let storageClass: Storageclass?
/**
The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).
 */
  public let serverSideEncryption: Serversideencryption?
/**

 */
  public let requestCharged: Requestcharged?
/**
Specifies whether the object retrieved was (true) or was not (false) a Delete Marker. If false, this response header does not appear in the response.
 */
  public let deleteMarker: Bool?


  static func deserialize(response: HTTPURLResponse, json: Any) -> HeadObjectOutput {
  
    return HeadObjectOutput(
        partsCount: response.allHeaderFields["x-amz-mp-parts-count"].flatMap { ($0 is NSNull) ? nil : Int.deserialize(response: response, json: $0) },
      contentDisposition: response.allHeaderFields["Content-Disposition"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      versionId: response.allHeaderFields["x-amz-version-id"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      replicationStatus: response.allHeaderFields["x-amz-replication-status"].flatMap { ($0 is NSNull) ? nil : Replicationstatus.deserialize(response: response, json: $0) },
      sSEKMSKeyId: response.allHeaderFields["x-amz-server-side-encryption-aws-kms-key-id"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      contentLanguage: response.allHeaderFields["Content-Language"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      sSECustomerAlgorithm: response.allHeaderFields["x-amz-server-side-encryption-customer-algorithm"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      restore: response.allHeaderFields["x-amz-restore"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      contentEncoding: response.allHeaderFields["Content-Encoding"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      contentLength: response.allHeaderFields["Content-Length"].flatMap { ($0 is NSNull) ? nil : Int.deserialize(response: response, json: $0) },
      expiration: response.allHeaderFields["x-amz-expiration"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      websiteRedirectLocation: response.allHeaderFields["x-amz-website-redirect-location"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      eTag: response.allHeaderFields["ETag"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      missingMeta: response.allHeaderFields["x-amz-missing-meta"].flatMap { ($0 is NSNull) ? nil : Int.deserialize(response: response, json: $0) },
      cacheControl: response.allHeaderFields["Cache-Control"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      sSECustomerKeyMD5: response.allHeaderFields["x-amz-server-side-encryption-customer-key-MD5"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      acceptRanges: response.allHeaderFields["accept-ranges"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      lastModified: response.allHeaderFields["Last-Modified"].flatMap { ($0 is NSNull) ? nil : Date.deserialize(response: response, json: $0) },
      metadata: Dictionary(response.allHeaderFields.map { (key: $0 as! String, value: $1 as! String) }.filter { $0.key.lowercased().hasPrefix("x-amz-meta-") }),
      expires: response.allHeaderFields["Expires"].flatMap { ($0 is NSNull) ? nil : Date.deserialize(response: response, json: $0) },
      contentType: response.allHeaderFields["Content-Type"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      storageClass: response.allHeaderFields["x-amz-storage-class"].flatMap { ($0 is NSNull) ? nil : Storageclass.deserialize(response: response, json: $0) },
      serverSideEncryption: response.allHeaderFields["x-amz-server-side-encryption"].flatMap { ($0 is NSNull) ? nil : Serversideencryption.deserialize(response: response, json: $0) },
      requestCharged: response.allHeaderFields["x-amz-request-charged"].flatMap { ($0 is NSNull) ? nil : Requestcharged.deserialize(response: response, json: $0) },
      deleteMarker: response.allHeaderFields["x-amz-delete-marker"].flatMap { ($0 is NSNull) ? nil : Bool.deserialize(response: response, json: $0) }
    )
  }

/**
    - parameters:
      - partsCount: The count of parts this object has.
      - contentDisposition: Specifies presentational information for the object.
      - versionId: Version of the object.
      - replicationStatus: 
      - sSEKMSKeyId: If present, specifies the ID of the AWS Key Management Service (KMS) master encryption key that was used for the object.
      - contentLanguage: The language the content is in.
      - sSECustomerAlgorithm: If server-side encryption with a customer-provided encryption key was requested, the response will include this header confirming the encryption algorithm used.
      - restore: Provides information about object restoration operation and expiration time of the restored object copy.
      - contentEncoding: Specifies what content encodings have been applied to the object and thus what decoding mechanisms must be applied to obtain the media-type referenced by the Content-Type header field.
      - contentLength: Size of the body in bytes.
      - expiration: If the object expiration is configured (see PUT Bucket lifecycle), the response includes this header. It includes the expiry-date and rule-id key value pairs providing object expiration information. The value of the rule-id is URL encoded.
      - websiteRedirectLocation: If the bucket is configured as a website, redirects requests for this object to another object in the same bucket or to an external URL. Amazon S3 stores the value of this header in the object metadata.
      - eTag: An ETag is an opaque identifier assigned by a web server to a specific version of a resource found at a URL
      - missingMeta: This is set to the number of metadata entries not returned in x-amz-meta headers. This can happen if you create metadata using an API like SOAP that supports more flexible metadata than the REST API. For example, using SOAP, you can create metadata whose values are not legal HTTP headers.
      - cacheControl: Specifies caching behavior along the request/reply chain.
      - sSECustomerKeyMD5: If server-side encryption with a customer-provided encryption key was requested, the response will include this header to provide round trip message integrity verification of the customer-provided encryption key.
      - acceptRanges: 
      - lastModified: Last modified date of the object
      - metadata: A map of metadata to store with the object in S3.
      - expires: The date and time at which the object is no longer cacheable.
      - contentType: A standard MIME type describing the format of the object data.
      - storageClass: 
      - serverSideEncryption: The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).
      - requestCharged: 
      - deleteMarker: Specifies whether the object retrieved was (true) or was not (false) a Delete Marker. If false, this response header does not appear in the response.
 */
  public init(partsCount: Int?, contentDisposition: String?, versionId: String?, replicationStatus: Replicationstatus?, sSEKMSKeyId: String?, contentLanguage: String?, sSECustomerAlgorithm: String?, restore: String?, contentEncoding: String?, contentLength: Int?, expiration: String?, websiteRedirectLocation: String?, eTag: String?, missingMeta: Int?, cacheControl: String?, sSECustomerKeyMD5: String?, acceptRanges: String?, lastModified: Date?, metadata: [String: String]?, expires: Date?, contentType: String?, storageClass: Storageclass?, serverSideEncryption: Serversideencryption?, requestCharged: Requestcharged?, deleteMarker: Bool?) {
self.partsCount = partsCount
self.contentDisposition = contentDisposition
self.versionId = versionId
self.replicationStatus = replicationStatus
self.sSEKMSKeyId = sSEKMSKeyId
self.contentLanguage = contentLanguage
self.sSECustomerAlgorithm = sSECustomerAlgorithm
self.restore = restore
self.contentEncoding = contentEncoding
self.contentLength = contentLength
self.expiration = expiration
self.websiteRedirectLocation = websiteRedirectLocation
self.eTag = eTag
self.missingMeta = missingMeta
self.cacheControl = cacheControl
self.sSECustomerKeyMD5 = sSECustomerKeyMD5
self.acceptRanges = acceptRanges
self.lastModified = lastModified
self.metadata = metadata
self.expires = expires
self.contentType = contentType
self.storageClass = storageClass
self.serverSideEncryption = serverSideEncryption
self.requestCharged = requestCharged
self.deleteMarker = deleteMarker
  }
}


public struct GetBucketTaggingRequest: RestJsonSerializable {
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


enum Bucketversioningstatus: String, RestJsonDeserializable, RestJsonSerializable {
  case `enabled` = "Enabled"
  case `suspended` = "Suspended"

  static func deserialize(response: HTTPURLResponse, json: Any) -> Bucketversioningstatus {
    return Bucketversioningstatus(rawValue: json as! String)!
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}


public struct CompletedPart: RestJsonSerializable, RestJsonDeserializable {
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

  static func deserialize(response: HTTPURLResponse, json: Any) -> CompletedPart {
    let jsonDict = json as! [String: Any]
    return CompletedPart(
        eTag: jsonDict["ETag"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      partNumber: jsonDict["PartNumber"].flatMap { ($0 is NSNull) ? nil : Int.deserialize(response: response, json: $0) }
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

/**
A list of containers for key value pair that defines the criteria for the filter rule.
 */

public struct MultipartUpload: RestJsonSerializable, RestJsonDeserializable {
/**
The class of storage used to store the object.
 */
  public let storageClass: Storageclass?
/**
Key of the object for which the multipart upload was initiated.
 */
  public let key: String?
/**
Upload ID that identifies the multipart upload.
 */
  public let uploadId: String?
/**

 */
  public let owner: Owner?
/**
Date and time at which the multipart upload was initiated.
 */
  public let initiated: Date?
/**
Identifies who initiated the multipart upload.
 */
  public let initiator: Initiator?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if storageClass != nil { body["StorageClass"] = storageClass! }
    if key != nil { body["Key"] = key! }
    if uploadId != nil { body["UploadId"] = uploadId! }
    if owner != nil { body["Owner"] = owner! }
    if initiated != nil { body["Initiated"] = initiated! }
    if initiator != nil { body["Initiator"] = initiator! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserialize(response: HTTPURLResponse, json: Any) -> MultipartUpload {
    let jsonDict = json as! [String: Any]
    return MultipartUpload(
        storageClass: jsonDict["StorageClass"].flatMap { ($0 is NSNull) ? nil : Storageclass.deserialize(response: response, json: $0) },
      key: jsonDict["Key"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      uploadId: jsonDict["UploadId"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      owner: jsonDict["Owner"].flatMap { ($0 is NSNull) ? nil : Owner.deserialize(response: response, json: $0) },
      initiated: jsonDict["Initiated"].flatMap { ($0 is NSNull) ? nil : Date.deserialize(response: response, json: $0) },
      initiator: jsonDict["Initiator"].flatMap { ($0 is NSNull) ? nil : Initiator.deserialize(response: response, json: $0) }
    )
  }

/**
    - parameters:
      - storageClass: The class of storage used to store the object.
      - key: Key of the object for which the multipart upload was initiated.
      - uploadId: Upload ID that identifies the multipart upload.
      - owner: 
      - initiated: Date and time at which the multipart upload was initiated.
      - initiator: Identifies who initiated the multipart upload.
 */
  public init(storageClass: Storageclass?, key: String?, uploadId: String?, owner: Owner?, initiated: Date?, initiator: Initiator?) {
self.storageClass = storageClass
self.key = key
self.uploadId = uploadId
self.owner = owner
self.initiated = initiated
self.initiator = initiator
  }
}


public struct ListObjectsV2Output: RestJsonDeserializable {
/**
Sets the maximum number of keys returned in the response. The response might contain fewer keys but will never contain more.
 */
  public let maxKeys: Int?
/**
StartAfter is where you want Amazon S3 to start listing from. Amazon S3 starts listing after this specified key. StartAfter can be any key in the bucket
 */
  public let startAfter: String?
/**
A flag that indicates whether or not Amazon S3 returned all of the results that satisfied the search criteria.
 */
  public let isTruncated: Bool?
/**
ContinuationToken indicates Amazon S3 that the list is being continued on this bucket with a token. ContinuationToken is obfuscated and is not a real key
 */
  public let continuationToken: String?
/**
Name of the bucket to list.
 */
  public let name: String?
/**
Limits the response to keys that begin with the specified prefix.
 */
  public let prefix: String?
/**
NextContinuationToken is sent when isTruncated is true which means there are more keys in the bucket that can be listed. The next list requests to Amazon S3 can be continued with this NextContinuationToken. NextContinuationToken is obfuscated and is not a real key
 */
  public let nextContinuationToken: String?
/**
CommonPrefixes contains all (if there are any) keys between Prefix and the next occurrence of the string specified by delimiter
 */
  public let commonPrefixes: [CommonPrefix]?
/**
Metadata about each object returned.
 */
  public let contents: [Object]?
/**
A delimiter is a character you use to group keys.
 */
  public let delimiter: String?
/**
Encoding type used by Amazon S3 to encode object keys in the response.
 */
  public let encodingType: Encodingtype?
/**
KeyCount is the number of keys returned with this request. KeyCount will always be less than equals to MaxKeys field. Say you ask for 50 keys, your result will include less than equals 50 keys
 */
  public let keyCount: Int?


  static func deserialize(response: HTTPURLResponse, json: Any) -> ListObjectsV2Output {
    let jsonDict = json as! [String: Any]
    return ListObjectsV2Output(
        maxKeys: jsonDict["MaxKeys"].flatMap { ($0 is NSNull) ? nil : Int.deserialize(response: response, json: $0) },
      startAfter: jsonDict["StartAfter"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      isTruncated: jsonDict["IsTruncated"].flatMap { ($0 is NSNull) ? nil : Bool.deserialize(response: response, json: $0) },
      continuationToken: jsonDict["ContinuationToken"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      name: jsonDict["Name"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      prefix: jsonDict["Prefix"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      nextContinuationToken: jsonDict["NextContinuationToken"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      commonPrefixes: jsonDict["CommonPrefixes"].flatMap { ($0 is NSNull) ? nil : [CommonPrefix].deserialize(response: response, json: $0) },
      contents: jsonDict["Contents"].flatMap { ($0 is NSNull) ? nil : [Object].deserialize(response: response, json: $0) },
      delimiter: jsonDict["Delimiter"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      encodingType: jsonDict["EncodingType"].flatMap { ($0 is NSNull) ? nil : Encodingtype.deserialize(response: response, json: $0) },
      keyCount: jsonDict["KeyCount"].flatMap { ($0 is NSNull) ? nil : Int.deserialize(response: response, json: $0) }
    )
  }

/**
    - parameters:
      - maxKeys: Sets the maximum number of keys returned in the response. The response might contain fewer keys but will never contain more.
      - startAfter: StartAfter is where you want Amazon S3 to start listing from. Amazon S3 starts listing after this specified key. StartAfter can be any key in the bucket
      - isTruncated: A flag that indicates whether or not Amazon S3 returned all of the results that satisfied the search criteria.
      - continuationToken: ContinuationToken indicates Amazon S3 that the list is being continued on this bucket with a token. ContinuationToken is obfuscated and is not a real key
      - name: Name of the bucket to list.
      - prefix: Limits the response to keys that begin with the specified prefix.
      - nextContinuationToken: NextContinuationToken is sent when isTruncated is true which means there are more keys in the bucket that can be listed. The next list requests to Amazon S3 can be continued with this NextContinuationToken. NextContinuationToken is obfuscated and is not a real key
      - commonPrefixes: CommonPrefixes contains all (if there are any) keys between Prefix and the next occurrence of the string specified by delimiter
      - contents: Metadata about each object returned.
      - delimiter: A delimiter is a character you use to group keys.
      - encodingType: Encoding type used by Amazon S3 to encode object keys in the response.
      - keyCount: KeyCount is the number of keys returned with this request. KeyCount will always be less than equals to MaxKeys field. Say you ask for 50 keys, your result will include less than equals 50 keys
 */
  public init(maxKeys: Int?, startAfter: String?, isTruncated: Bool?, continuationToken: String?, name: String?, prefix: String?, nextContinuationToken: String?, commonPrefixes: [CommonPrefix]?, contents: [Object]?, delimiter: String?, encodingType: Encodingtype?, keyCount: Int?) {
self.maxKeys = maxKeys
self.startAfter = startAfter
self.isTruncated = isTruncated
self.continuationToken = continuationToken
self.name = name
self.prefix = prefix
self.nextContinuationToken = nextContinuationToken
self.commonPrefixes = commonPrefixes
self.contents = contents
self.delimiter = delimiter
self.encodingType = encodingType
self.keyCount = keyCount
  }
}


enum Objectstorageclass: String, RestJsonDeserializable, RestJsonSerializable {
  case `sTANDARD` = "STANDARD"
  case `rEDUCED_REDUNDANCY` = "REDUCED_REDUNDANCY"
  case `gLACIER` = "GLACIER"

  static func deserialize(response: HTTPURLResponse, json: Any) -> Objectstorageclass {
    return Objectstorageclass(rawValue: json as! String)!
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}

public struct TargetGrant: RestJsonSerializable, RestJsonDeserializable {
/**
Logging permissions assigned to the Grantee for the bucket.
 */
  public let permission: Bucketlogspermission?
/**

 */
  public let grantee: Grantee?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if permission != nil { body["Permission"] = permission! }
    if grantee != nil { body["Grantee"] = grantee! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserialize(response: HTTPURLResponse, json: Any) -> TargetGrant {
    let jsonDict = json as! [String: Any]
    return TargetGrant(
        permission: jsonDict["Permission"].flatMap { ($0 is NSNull) ? nil : Bucketlogspermission.deserialize(response: response, json: $0) },
      grantee: jsonDict["Grantee"].flatMap { ($0 is NSNull) ? nil : Grantee.deserialize(response: response, json: $0) }
    )
  }

/**
    - parameters:
      - permission: Logging permissions assigned to the Grantee for the bucket.
      - grantee: 
 */
  public init(permission: Bucketlogspermission?, grantee: Grantee?) {
self.permission = permission
self.grantee = grantee
  }
}



public struct GetBucketLifecycleRequest: RestJsonSerializable {
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




public struct RequestPaymentConfiguration: RestJsonSerializable, RestJsonDeserializable {
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

  static func deserialize(response: HTTPURLResponse, json: Any) -> RequestPaymentConfiguration {
    let jsonDict = json as! [String: Any]
    return RequestPaymentConfiguration(
        payer: jsonDict["Payer"].flatMap { ($0 is NSNull) ? nil : Payer.deserialize(response: response, json: $0) }!
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

public struct PutBucketLifecycleRequest: RestJsonSerializable {
/**

 */
  public let contentMD5: String?
/**

 */
  public let bucket: String
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
      - contentMD5: 
      - bucket: 
      - lifecycleConfiguration: 
 */
  public init(contentMD5: String?, bucket: String, lifecycleConfiguration: LifecycleConfiguration?) {
self.contentMD5 = contentMD5
self.bucket = bucket
self.lifecycleConfiguration = lifecycleConfiguration
  }
}

public struct GetBucketLifecycleConfigurationOutput: RestJsonDeserializable {
/**

 */
  public let rules: [LifecycleRule]?


  static func deserialize(response: HTTPURLResponse, json: Any) -> GetBucketLifecycleConfigurationOutput {
    let jsonDict = json as! [String: Any]
    return GetBucketLifecycleConfigurationOutput(
        rules: jsonDict["Rule"].flatMap { ($0 is NSNull) ? nil : [LifecycleRule].deserialize(response: response, json: $0) }
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

public struct BucketLoggingStatus: RestJsonSerializable, RestJsonDeserializable {
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

  static func deserialize(response: HTTPURLResponse, json: Any) -> BucketLoggingStatus {
    let jsonDict = json as! [String: Any]
    return BucketLoggingStatus(
        loggingEnabled: jsonDict["LoggingEnabled"].flatMap { ($0 is NSNull) ? nil : LoggingEnabled.deserialize(response: response, json: $0) }
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

public struct WebsiteConfiguration: RestJsonSerializable, RestJsonDeserializable {
/**

 */
  public let routingRules: [RoutingRule]?
/**

 */
  public let indexDocument: IndexDocument?
/**

 */
  public let errorDocument: ErrorDocument?
/**

 */
  public let redirectAllRequestsTo: RedirectAllRequestsTo?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if routingRules != nil { body["RoutingRules"] = routingRules! }
    if indexDocument != nil { body["IndexDocument"] = indexDocument! }
    if errorDocument != nil { body["ErrorDocument"] = errorDocument! }
    if redirectAllRequestsTo != nil { body["RedirectAllRequestsTo"] = redirectAllRequestsTo! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserialize(response: HTTPURLResponse, json: Any) -> WebsiteConfiguration {
    let jsonDict = json as! [String: Any]
    return WebsiteConfiguration(
        routingRules: jsonDict["RoutingRules"].flatMap { ($0 is NSNull) ? nil : [RoutingRule].deserialize(response: response, json: $0) },
      indexDocument: jsonDict["IndexDocument"].flatMap { ($0 is NSNull) ? nil : IndexDocument.deserialize(response: response, json: $0) },
      errorDocument: jsonDict["ErrorDocument"].flatMap { ($0 is NSNull) ? nil : ErrorDocument.deserialize(response: response, json: $0) },
      redirectAllRequestsTo: jsonDict["RedirectAllRequestsTo"].flatMap { ($0 is NSNull) ? nil : RedirectAllRequestsTo.deserialize(response: response, json: $0) }
    )
  }

/**
    - parameters:
      - routingRules: 
      - indexDocument: 
      - errorDocument: 
      - redirectAllRequestsTo: 
 */
  public init(routingRules: [RoutingRule]?, indexDocument: IndexDocument?, errorDocument: ErrorDocument?, redirectAllRequestsTo: RedirectAllRequestsTo?) {
self.routingRules = routingRules
self.indexDocument = indexDocument
self.errorDocument = errorDocument
self.redirectAllRequestsTo = redirectAllRequestsTo
  }
}

public struct DeleteObjectOutput: RestJsonDeserializable {
/**
Returns the version ID of the delete marker created as a result of the DELETE operation.
 */
  public let versionId: String?
/**

 */
  public let requestCharged: Requestcharged?
/**
Specifies whether the versioned object that was permanently deleted was (true) or was not (false) a delete marker.
 */
  public let deleteMarker: Bool?


  static func deserialize(response: HTTPURLResponse, json: Any) -> DeleteObjectOutput {
  
    return DeleteObjectOutput(
        versionId: response.allHeaderFields["x-amz-version-id"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      requestCharged: response.allHeaderFields["x-amz-request-charged"].flatMap { ($0 is NSNull) ? nil : Requestcharged.deserialize(response: response, json: $0) },
      deleteMarker: response.allHeaderFields["x-amz-delete-marker"].flatMap { ($0 is NSNull) ? nil : Bool.deserialize(response: response, json: $0) }
    )
  }

/**
    - parameters:
      - versionId: Returns the version ID of the delete marker created as a result of the DELETE operation.
      - requestCharged: 
      - deleteMarker: Specifies whether the versioned object that was permanently deleted was (true) or was not (false) a delete marker.
 */
  public init(versionId: String?, requestCharged: Requestcharged?, deleteMarker: Bool?) {
self.versionId = versionId
self.requestCharged = requestCharged
self.deleteMarker = deleteMarker
  }
}

/**
Container for specifying the notification configuration of the bucket. If this element is empty, notifications are turned off on the bucket.
 */
public struct NotificationConfiguration: RestJsonSerializable, RestJsonDeserializable {
/**

 */
  public let topicConfigurations: [TopicConfiguration]?
/**

 */
  public let queueConfigurations: [QueueConfiguration]?
/**

 */
  public let lambdaFunctionConfigurations: [LambdaFunctionConfiguration]?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if topicConfigurations != nil { body["TopicConfiguration"] = topicConfigurations! }
    if queueConfigurations != nil { body["QueueConfiguration"] = queueConfigurations! }
    if lambdaFunctionConfigurations != nil { body["CloudFunctionConfiguration"] = lambdaFunctionConfigurations! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserialize(response: HTTPURLResponse, json: Any) -> NotificationConfiguration {
    let jsonDict = json as! [String: Any]
    return NotificationConfiguration(
        topicConfigurations: jsonDict["TopicConfiguration"].flatMap { ($0 is NSNull) ? nil : [TopicConfiguration].deserialize(response: response, json: $0) },
      queueConfigurations: jsonDict["QueueConfiguration"].flatMap { ($0 is NSNull) ? nil : [QueueConfiguration].deserialize(response: response, json: $0) },
      lambdaFunctionConfigurations: jsonDict["CloudFunctionConfiguration"].flatMap { ($0 is NSNull) ? nil : [LambdaFunctionConfiguration].deserialize(response: response, json: $0) }
    )
  }

/**
    - parameters:
      - topicConfigurations: 
      - queueConfigurations: 
      - lambdaFunctionConfigurations: 
 */
  public init(topicConfigurations: [TopicConfiguration]?, queueConfigurations: [QueueConfiguration]?, lambdaFunctionConfigurations: [LambdaFunctionConfiguration]?) {
self.topicConfigurations = topicConfigurations
self.queueConfigurations = queueConfigurations
self.lambdaFunctionConfigurations = lambdaFunctionConfigurations
  }
}




public struct GetBucketAclRequest: RestJsonSerializable {
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





/**
Container for specifying an configuration when you want Amazon S3 to publish events to an Amazon Simple Queue Service (Amazon SQS) queue.
 */
public struct QueueConfiguration: RestJsonSerializable, RestJsonDeserializable {
/**

 */
  public let events: [Event]
/**
Amazon SQS queue ARN to which Amazon S3 will publish a message when it detects events of specified type.
 */
  public let queueArn: String
/**

 */
  public let filter: NotificationConfigurationFilter?
/**

 */
  public let id: String?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["Event"] = events
    body["Queue"] = queueArn
    if filter != nil { body["Filter"] = filter! }
    if id != nil { body["Id"] = id! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserialize(response: HTTPURLResponse, json: Any) -> QueueConfiguration {
    let jsonDict = json as! [String: Any]
    return QueueConfiguration(
        events: jsonDict["Event"].flatMap { ($0 is NSNull) ? nil : [Event].deserialize(response: response, json: $0) }!,
      queueArn: jsonDict["Queue"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) }!,
      filter: jsonDict["Filter"].flatMap { ($0 is NSNull) ? nil : NotificationConfigurationFilter.deserialize(response: response, json: $0) },
      id: jsonDict["Id"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) }
    )
  }

/**
    - parameters:
      - events: 
      - queueArn: Amazon SQS queue ARN to which Amazon S3 will publish a message when it detects events of specified type.
      - filter: 
      - id: 
 */
  public init(events: [Event], queueArn: String, filter: NotificationConfigurationFilter?, id: String?) {
self.events = events
self.queueArn = queueArn
self.filter = filter
self.id = id
  }
}


public struct PutBucketLifecycleConfigurationRequest: RestJsonSerializable {
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

/**
The source object of the COPY operation is not in the active tier and is only stored in Amazon Glacier.
 */
public struct ObjectNotInActiveTierError: RestJsonSerializable, RestJsonDeserializable {

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }

  static func deserialize(response: HTTPURLResponse, json: Any) -> ObjectNotInActiveTierError {
  
    return ObjectNotInActiveTierError(
  
    )
  }

/**
    - parameters:
 */
  public init() {
  }
}


public struct GetBucketTaggingOutput: RestJsonDeserializable {
/**

 */
  public let tagSet: [Tag]


  static func deserialize(response: HTTPURLResponse, json: Any) -> GetBucketTaggingOutput {
    let jsonDict = json as! [String: Any]
    return GetBucketTaggingOutput(
        tagSet: jsonDict["TagSet"].flatMap { ($0 is NSNull) ? nil : [Tag].deserialize(response: response, json: $0) }!
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


public struct ListObjectVersionsOutput: RestJsonDeserializable {
/**

 */
  public let maxKeys: Int?
/**
A flag that indicates whether or not Amazon S3 returned all of the results that satisfied the search criteria. If your results were truncated, you can make a follow-up paginated request using the NextKeyMarker and NextVersionIdMarker response parameters as a starting place in another request to return the rest of the results.
 */
  public let isTruncated: Bool?
/**

 */
  public let versions: [ObjectVersion]?
/**
Use this value for the next version id marker parameter in a subsequent request.
 */
  public let nextVersionIdMarker: String?
/**

 */
  public let commonPrefixes: [CommonPrefix]?
/**

 */
  public let delimiter: String?
/**
Marks the last Key returned in a truncated response.
 */
  public let keyMarker: String?
/**
Encoding type used by Amazon S3 to encode object keys in the response.
 */
  public let encodingType: Encodingtype?
/**

 */
  public let name: String?
/**

 */
  public let prefix: String?
/**

 */
  public let deleteMarkers: [DeleteMarkerEntry]?
/**
Use this value for the key marker request parameter in a subsequent request.
 */
  public let nextKeyMarker: String?
/**

 */
  public let versionIdMarker: String?


  static func deserialize(response: HTTPURLResponse, json: Any) -> ListObjectVersionsOutput {
    let jsonDict = json as! [String: Any]
    return ListObjectVersionsOutput(
        maxKeys: jsonDict["MaxKeys"].flatMap { ($0 is NSNull) ? nil : Int.deserialize(response: response, json: $0) },
      isTruncated: jsonDict["IsTruncated"].flatMap { ($0 is NSNull) ? nil : Bool.deserialize(response: response, json: $0) },
      versions: jsonDict["Version"].flatMap { ($0 is NSNull) ? nil : [ObjectVersion].deserialize(response: response, json: $0) },
      nextVersionIdMarker: jsonDict["NextVersionIdMarker"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      commonPrefixes: jsonDict["CommonPrefixes"].flatMap { ($0 is NSNull) ? nil : [CommonPrefix].deserialize(response: response, json: $0) },
      delimiter: jsonDict["Delimiter"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      keyMarker: jsonDict["KeyMarker"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      encodingType: jsonDict["EncodingType"].flatMap { ($0 is NSNull) ? nil : Encodingtype.deserialize(response: response, json: $0) },
      name: jsonDict["Name"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      prefix: jsonDict["Prefix"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      deleteMarkers: jsonDict["DeleteMarker"].flatMap { ($0 is NSNull) ? nil : [DeleteMarkerEntry].deserialize(response: response, json: $0) },
      nextKeyMarker: jsonDict["NextKeyMarker"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      versionIdMarker: jsonDict["VersionIdMarker"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) }
    )
  }

/**
    - parameters:
      - maxKeys: 
      - isTruncated: A flag that indicates whether or not Amazon S3 returned all of the results that satisfied the search criteria. If your results were truncated, you can make a follow-up paginated request using the NextKeyMarker and NextVersionIdMarker response parameters as a starting place in another request to return the rest of the results.
      - versions: 
      - nextVersionIdMarker: Use this value for the next version id marker parameter in a subsequent request.
      - commonPrefixes: 
      - delimiter: 
      - keyMarker: Marks the last Key returned in a truncated response.
      - encodingType: Encoding type used by Amazon S3 to encode object keys in the response.
      - name: 
      - prefix: 
      - deleteMarkers: 
      - nextKeyMarker: Use this value for the key marker request parameter in a subsequent request.
      - versionIdMarker: 
 */
  public init(maxKeys: Int?, isTruncated: Bool?, versions: [ObjectVersion]?, nextVersionIdMarker: String?, commonPrefixes: [CommonPrefix]?, delimiter: String?, keyMarker: String?, encodingType: Encodingtype?, name: String?, prefix: String?, deleteMarkers: [DeleteMarkerEntry]?, nextKeyMarker: String?, versionIdMarker: String?) {
self.maxKeys = maxKeys
self.isTruncated = isTruncated
self.versions = versions
self.nextVersionIdMarker = nextVersionIdMarker
self.commonPrefixes = commonPrefixes
self.delimiter = delimiter
self.keyMarker = keyMarker
self.encodingType = encodingType
self.name = name
self.prefix = prefix
self.deleteMarkers = deleteMarkers
self.nextKeyMarker = nextKeyMarker
self.versionIdMarker = versionIdMarker
  }
}

public struct GetBucketVersioningOutput: RestJsonDeserializable {
/**
Specifies whether MFA delete is enabled in the bucket versioning configuration. This element is only returned if the bucket has been configured with MFA delete. If the bucket has never been so configured, this element is not returned.
 */
  public let mFADelete: Mfadeletestatus?
/**
The versioning state of the bucket.
 */
  public let status: Bucketversioningstatus?


  static func deserialize(response: HTTPURLResponse, json: Any) -> GetBucketVersioningOutput {
    let jsonDict = json as! [String: Any]
    return GetBucketVersioningOutput(
        mFADelete: jsonDict["MfaDelete"].flatMap { ($0 is NSNull) ? nil : Mfadeletestatus.deserialize(response: response, json: $0) },
      status: jsonDict["Status"].flatMap { ($0 is NSNull) ? nil : Bucketversioningstatus.deserialize(response: response, json: $0) }
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

public struct ErrorDocument: RestJsonSerializable, RestJsonDeserializable {
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

  static func deserialize(response: HTTPURLResponse, json: Any) -> ErrorDocument {
    let jsonDict = json as! [String: Any]
    return ErrorDocument(
        key: jsonDict["Key"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) }!
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

public struct DeleteObjectsRequest: RestJsonSerializable {
/**

 */
  public let bucket: String
/**
The concatenation of the authentication device's serial number, a space, and the value that is displayed on your authentication device.
 */
  public let mFA: String?
/**

 */
  public let requestPayer: Requestpayer?
/**

 */
  public let delete: Delete

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
      - mFA: The concatenation of the authentication device's serial number, a space, and the value that is displayed on your authentication device.
      - requestPayer: 
      - delete: 
 */
  public init(bucket: String, mFA: String?, requestPayer: Requestpayer?, delete: Delete) {
self.bucket = bucket
self.mFA = mFA
self.requestPayer = requestPayer
self.delete = delete
  }
}

public struct PutBucketVersioningRequest: RestJsonSerializable {
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

public struct PutBucketTaggingRequest: RestJsonSerializable {
/**

 */
  public let contentMD5: String?
/**

 */
  public let bucket: String
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
      - contentMD5: 
      - bucket: 
      - tagging: 
 */
  public init(contentMD5: String?, bucket: String, tagging: Tagging) {
self.contentMD5 = contentMD5
self.bucket = bucket
self.tagging = tagging
  }
}

public struct GetObjectAclOutput: RestJsonDeserializable {
/**

 */
  public let owner: Owner?
/**
A list of grants.
 */
  public let grants: [Grant]?
/**

 */
  public let requestCharged: Requestcharged?


  static func deserialize(response: HTTPURLResponse, json: Any) -> GetObjectAclOutput {
    let jsonDict = json as! [String: Any]
    return GetObjectAclOutput(
        owner: jsonDict["Owner"].flatMap { ($0 is NSNull) ? nil : Owner.deserialize(response: response, json: $0) },
      grants: jsonDict["AccessControlList"].flatMap { ($0 is NSNull) ? nil : [Grant].deserialize(response: response, json: $0) },
      requestCharged: response.allHeaderFields["x-amz-request-charged"].flatMap { ($0 is NSNull) ? nil : Requestcharged.deserialize(response: response, json: $0) }
    )
  }

/**
    - parameters:
      - owner: 
      - grants: A list of grants.
      - requestCharged: 
 */
  public init(owner: Owner?, grants: [Grant]?, requestCharged: Requestcharged?) {
self.owner = owner
self.grants = grants
self.requestCharged = requestCharged
  }
}

public struct ListObjectVersionsRequest: RestJsonSerializable {
/**

 */
  public let bucket: String
/**
Sets the maximum number of keys returned in the response. The response might contain fewer keys but will never contain more.
 */
  public let maxKeys: Int?
/**
Limits the response to keys that begin with the specified prefix.
 */
  public let prefix: String?
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
Specifies the object version you want to start listing from.
 */
  public let versionIdMarker: String?

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    var querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
    uri["Bucket"] = "\(bucket)"
    if maxKeys != nil { querystring["max-keys"] = "\(maxKeys!)" }
    if prefix != nil { querystring["prefix"] = "\(prefix!)" }
    if delimiter != nil { querystring["delimiter"] = "\(delimiter!)" }
    if encodingType != nil { querystring["encoding-type"] = "\(encodingType!)" }
    if keyMarker != nil { querystring["key-marker"] = "\(keyMarker!)" }
    if versionIdMarker != nil { querystring["version-id-marker"] = "\(versionIdMarker!)" }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - bucket: 
      - maxKeys: Sets the maximum number of keys returned in the response. The response might contain fewer keys but will never contain more.
      - prefix: Limits the response to keys that begin with the specified prefix.
      - delimiter: A delimiter is a character you use to group keys.
      - encodingType: 
      - keyMarker: Specifies the key to start with when listing objects in a bucket.
      - versionIdMarker: Specifies the object version you want to start listing from.
 */
  public init(bucket: String, maxKeys: Int?, prefix: String?, delimiter: String?, encodingType: Encodingtype?, keyMarker: String?, versionIdMarker: String?) {
self.bucket = bucket
self.maxKeys = maxKeys
self.prefix = prefix
self.delimiter = delimiter
self.encodingType = encodingType
self.keyMarker = keyMarker
self.versionIdMarker = versionIdMarker
  }
}

public struct Delete: RestJsonSerializable, RestJsonDeserializable {
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

  static func deserialize(response: HTTPURLResponse, json: Any) -> Delete {
    let jsonDict = json as! [String: Any]
    return Delete(
        objects: jsonDict["Object"].flatMap { ($0 is NSNull) ? nil : [ObjectIdentifier].deserialize(response: response, json: $0) }!,
      quiet: jsonDict["Quiet"].flatMap { ($0 is NSNull) ? nil : Bool.deserialize(response: response, json: $0) }
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




public struct GetBucketLifecycleOutput: RestJsonDeserializable {
/**

 */
  public let rules: [Rule]?


  static func deserialize(response: HTTPURLResponse, json: Any) -> GetBucketLifecycleOutput {
    let jsonDict = json as! [String: Any]
    return GetBucketLifecycleOutput(
        rules: jsonDict["Rule"].flatMap { ($0 is NSNull) ? nil : [Rule].deserialize(response: response, json: $0) }
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


enum Bucketlogspermission: String, RestJsonDeserializable, RestJsonSerializable {
  case `fULL_CONTROL` = "FULL_CONTROL"
  case `rEAD` = "READ"
  case `wRITE` = "WRITE"

  static func deserialize(response: HTTPURLResponse, json: Any) -> Bucketlogspermission {
    return Bucketlogspermission(rawValue: json as! String)!
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}

/**
The specified key does not exist.
 */
public struct NoSuchKey: RestJsonSerializable, RestJsonDeserializable {

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }

  static func deserialize(response: HTTPURLResponse, json: Any) -> NoSuchKey {
  
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
If present, indicates that the requester was successfully charged for the request.
 */
enum Requestcharged: String, RestJsonDeserializable, RestJsonSerializable {
  case `requester` = "requester"

  static func deserialize(response: HTTPURLResponse, json: Any) -> Requestcharged {
    return Requestcharged(rawValue: json as! String)!
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}


public struct DeleteMarkerEntry: RestJsonSerializable, RestJsonDeserializable {
/**
Specifies whether the object is (true) or is not (false) the latest version of an object.
 */
  public let isLatest: Bool?
/**
Date and time the object was last modified.
 */
  public let lastModified: Date?
/**
The object key.
 */
  public let key: String?
/**
Version ID of an object.
 */
  public let versionId: String?
/**

 */
  public let owner: Owner?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if isLatest != nil { body["IsLatest"] = isLatest! }
    if lastModified != nil { body["LastModified"] = lastModified! }
    if key != nil { body["Key"] = key! }
    if versionId != nil { body["VersionId"] = versionId! }
    if owner != nil { body["Owner"] = owner! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserialize(response: HTTPURLResponse, json: Any) -> DeleteMarkerEntry {
    let jsonDict = json as! [String: Any]
    return DeleteMarkerEntry(
        isLatest: jsonDict["IsLatest"].flatMap { ($0 is NSNull) ? nil : Bool.deserialize(response: response, json: $0) },
      lastModified: jsonDict["LastModified"].flatMap { ($0 is NSNull) ? nil : Date.deserialize(response: response, json: $0) },
      key: jsonDict["Key"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      versionId: jsonDict["VersionId"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      owner: jsonDict["Owner"].flatMap { ($0 is NSNull) ? nil : Owner.deserialize(response: response, json: $0) }
    )
  }

/**
    - parameters:
      - isLatest: Specifies whether the object is (true) or is not (false) the latest version of an object.
      - lastModified: Date and time the object was last modified.
      - key: The object key.
      - versionId: Version ID of an object.
      - owner: 
 */
  public init(isLatest: Bool?, lastModified: Date?, key: String?, versionId: String?, owner: Owner?) {
self.isLatest = isLatest
self.lastModified = lastModified
self.key = key
self.versionId = versionId
self.owner = owner
  }
}



public struct ListMultipartUploadsRequest: RestJsonSerializable {
/**

 */
  public let bucket: String
/**
Together with key-marker, specifies the multipart upload after which listing should begin. If key-marker is not specified, the upload-id-marker parameter is ignored.
 */
  public let uploadIdMarker: String?
/**
Lists in-progress uploads only for those keys that begin with the specified prefix.
 */
  public let prefix: String?
/**
Sets the maximum number of multipart uploads, from 1 to 1,000, to return in the response body. 1,000 is the maximum number of uploads that can be returned in a response.
 */
  public let maxUploads: Int?
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

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    var querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
    uri["Bucket"] = "\(bucket)"
    if uploadIdMarker != nil { querystring["upload-id-marker"] = "\(uploadIdMarker!)" }
    if prefix != nil { querystring["prefix"] = "\(prefix!)" }
    if maxUploads != nil { querystring["max-uploads"] = "\(maxUploads!)" }
    if delimiter != nil { querystring["delimiter"] = "\(delimiter!)" }
    if encodingType != nil { querystring["encoding-type"] = "\(encodingType!)" }
    if keyMarker != nil { querystring["key-marker"] = "\(keyMarker!)" }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - bucket: 
      - uploadIdMarker: Together with key-marker, specifies the multipart upload after which listing should begin. If key-marker is not specified, the upload-id-marker parameter is ignored.
      - prefix: Lists in-progress uploads only for those keys that begin with the specified prefix.
      - maxUploads: Sets the maximum number of multipart uploads, from 1 to 1,000, to return in the response body. 1,000 is the maximum number of uploads that can be returned in a response.
      - delimiter: Character you use to group keys.
      - encodingType: 
      - keyMarker: Together with upload-id-marker, this parameter specifies the multipart upload after which listing should begin.
 */
  public init(bucket: String, uploadIdMarker: String?, prefix: String?, maxUploads: Int?, delimiter: String?, encodingType: Encodingtype?, keyMarker: String?) {
self.bucket = bucket
self.uploadIdMarker = uploadIdMarker
self.prefix = prefix
self.maxUploads = maxUploads
self.delimiter = delimiter
self.encodingType = encodingType
self.keyMarker = keyMarker
  }
}


public struct DeleteObjectsOutput: RestJsonDeserializable {
/**

 */
  public let errors: [ErrorError]?
/**

 */
  public let deleted: [DeletedObject]?
/**

 */
  public let requestCharged: Requestcharged?


  static func deserialize(response: HTTPURLResponse, json: Any) -> DeleteObjectsOutput {
    let jsonDict = json as! [String: Any]
    return DeleteObjectsOutput(
        errors: jsonDict["Error"].flatMap { ($0 is NSNull) ? nil : [ErrorError].deserialize(response: response, json: $0) },
      deleted: jsonDict["Deleted"].flatMap { ($0 is NSNull) ? nil : [DeletedObject].deserialize(response: response, json: $0) },
      requestCharged: response.allHeaderFields["x-amz-request-charged"].flatMap { ($0 is NSNull) ? nil : Requestcharged.deserialize(response: response, json: $0) }
    )
  }

/**
    - parameters:
      - errors: 
      - deleted: 
      - requestCharged: 
 */
  public init(errors: [ErrorError]?, deleted: [DeletedObject]?, requestCharged: Requestcharged?) {
self.errors = errors
self.deleted = deleted
self.requestCharged = requestCharged
  }
}



public struct DeleteBucketTaggingRequest: RestJsonSerializable {
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










public struct ReplicationRule: RestJsonSerializable, RestJsonDeserializable {
/**
Unique identifier for the rule. The value cannot be longer than 255 characters.
 */
  public let iD: String?
/**
The rule is ignored if status is not Enabled.
 */
  public let status: Replicationrulestatus
/**

 */
  public let destination: Destination
/**
Object keyname prefix identifying one or more objects to which the rule applies. Maximum prefix length can be up to 1,024 characters. Overlapping prefixes are not supported.
 */
  public let prefix: String

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if iD != nil { body["ID"] = iD! }
    body["Status"] = status
    body["Destination"] = destination
    body["Prefix"] = prefix
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserialize(response: HTTPURLResponse, json: Any) -> ReplicationRule {
    let jsonDict = json as! [String: Any]
    return ReplicationRule(
        iD: jsonDict["ID"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      status: jsonDict["Status"].flatMap { ($0 is NSNull) ? nil : Replicationrulestatus.deserialize(response: response, json: $0) }!,
      destination: jsonDict["Destination"].flatMap { ($0 is NSNull) ? nil : Destination.deserialize(response: response, json: $0) }!,
      prefix: jsonDict["Prefix"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) }!
    )
  }

/**
    - parameters:
      - iD: Unique identifier for the rule. The value cannot be longer than 255 characters.
      - status: The rule is ignored if status is not Enabled.
      - destination: 
      - prefix: Object keyname prefix identifying one or more objects to which the rule applies. Maximum prefix length can be up to 1,024 characters. Overlapping prefixes are not supported.
 */
  public init(iD: String?, status: Replicationrulestatus, destination: Destination, prefix: String) {
self.iD = iD
self.status = status
self.destination = destination
self.prefix = prefix
  }
}

public struct DeleteBucketReplicationRequest: RestJsonSerializable {
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


/**
Container for specifying the AWS Lambda notification configuration.
 */
public struct LambdaFunctionConfiguration: RestJsonSerializable, RestJsonDeserializable {
/**

 */
  public let id: String?
/**

 */
  public let events: [Event]
/**

 */
  public let filter: NotificationConfigurationFilter?
/**
Lambda cloud function ARN that Amazon S3 can invoke when it detects events of the specified type.
 */
  public let lambdaFunctionArn: String

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if id != nil { body["Id"] = id! }
    body["Event"] = events
    if filter != nil { body["Filter"] = filter! }
    body["CloudFunction"] = lambdaFunctionArn
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserialize(response: HTTPURLResponse, json: Any) -> LambdaFunctionConfiguration {
    let jsonDict = json as! [String: Any]
    return LambdaFunctionConfiguration(
        id: jsonDict["Id"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      events: jsonDict["Event"].flatMap { ($0 is NSNull) ? nil : [Event].deserialize(response: response, json: $0) }!,
      filter: jsonDict["Filter"].flatMap { ($0 is NSNull) ? nil : NotificationConfigurationFilter.deserialize(response: response, json: $0) },
      lambdaFunctionArn: jsonDict["CloudFunction"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) }!
    )
  }

/**
    - parameters:
      - id: 
      - events: 
      - filter: 
      - lambdaFunctionArn: Lambda cloud function ARN that Amazon S3 can invoke when it detects events of the specified type.
 */
  public init(id: String?, events: [Event], filter: NotificationConfigurationFilter?, lambdaFunctionArn: String) {
self.id = id
self.events = events
self.filter = filter
self.lambdaFunctionArn = lambdaFunctionArn
  }
}

public struct GetBucketLoggingOutput: RestJsonDeserializable {
/**

 */
  public let loggingEnabled: LoggingEnabled?


  static func deserialize(response: HTTPURLResponse, json: Any) -> GetBucketLoggingOutput {
    let jsonDict = json as! [String: Any]
    return GetBucketLoggingOutput(
        loggingEnabled: jsonDict["LoggingEnabled"].flatMap { ($0 is NSNull) ? nil : LoggingEnabled.deserialize(response: response, json: $0) }
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

public struct UploadPartOutput: RestJsonDeserializable {
/**

 */
  public let requestCharged: Requestcharged?
/**
If present, specifies the ID of the AWS Key Management Service (KMS) master encryption key that was used for the object.
 */
  public let sSEKMSKeyId: String?
/**
Entity tag for the uploaded object.
 */
  public let eTag: String?
/**
If server-side encryption with a customer-provided encryption key was requested, the response will include this header confirming the encryption algorithm used.
 */
  public let sSECustomerAlgorithm: String?
/**
The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).
 */
  public let serverSideEncryption: Serversideencryption?
/**
If server-side encryption with a customer-provided encryption key was requested, the response will include this header to provide round trip message integrity verification of the customer-provided encryption key.
 */
  public let sSECustomerKeyMD5: String?


  static func deserialize(response: HTTPURLResponse, json: Any) -> UploadPartOutput {
  
    return UploadPartOutput(
        requestCharged: response.allHeaderFields["x-amz-request-charged"].flatMap { ($0 is NSNull) ? nil : Requestcharged.deserialize(response: response, json: $0) },
      sSEKMSKeyId: response.allHeaderFields["x-amz-server-side-encryption-aws-kms-key-id"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      eTag: response.allHeaderFields["ETag"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      sSECustomerAlgorithm: response.allHeaderFields["x-amz-server-side-encryption-customer-algorithm"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      serverSideEncryption: response.allHeaderFields["x-amz-server-side-encryption"].flatMap { ($0 is NSNull) ? nil : Serversideencryption.deserialize(response: response, json: $0) },
      sSECustomerKeyMD5: response.allHeaderFields["x-amz-server-side-encryption-customer-key-MD5"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) }
    )
  }

/**
    - parameters:
      - requestCharged: 
      - sSEKMSKeyId: If present, specifies the ID of the AWS Key Management Service (KMS) master encryption key that was used for the object.
      - eTag: Entity tag for the uploaded object.
      - sSECustomerAlgorithm: If server-side encryption with a customer-provided encryption key was requested, the response will include this header confirming the encryption algorithm used.
      - serverSideEncryption: The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).
      - sSECustomerKeyMD5: If server-side encryption with a customer-provided encryption key was requested, the response will include this header to provide round trip message integrity verification of the customer-provided encryption key.
 */
  public init(requestCharged: Requestcharged?, sSEKMSKeyId: String?, eTag: String?, sSECustomerAlgorithm: String?, serverSideEncryption: Serversideencryption?, sSECustomerKeyMD5: String?) {
self.requestCharged = requestCharged
self.sSEKMSKeyId = sSEKMSKeyId
self.eTag = eTag
self.sSECustomerAlgorithm = sSECustomerAlgorithm
self.serverSideEncryption = serverSideEncryption
self.sSECustomerKeyMD5 = sSECustomerKeyMD5
  }
}


enum Storageclass: String, RestJsonDeserializable, RestJsonSerializable {
  case `sTANDARD` = "STANDARD"
  case `rEDUCED_REDUNDANCY` = "REDUCED_REDUNDANCY"
  case `sTANDARD_IA` = "STANDARD_IA"

  static func deserialize(response: HTTPURLResponse, json: Any) -> Storageclass {
    return Storageclass(rawValue: json as! String)!
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}

public struct GetBucketCorsOutput: RestJsonDeserializable {
/**

 */
  public let cORSRules: [CORSRule]?


  static func deserialize(response: HTTPURLResponse, json: Any) -> GetBucketCorsOutput {
    let jsonDict = json as! [String: Any]
    return GetBucketCorsOutput(
        cORSRules: jsonDict["CORSRule"].flatMap { ($0 is NSNull) ? nil : [CORSRule].deserialize(response: response, json: $0) }
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

public struct ErrorError: RestJsonSerializable, RestJsonDeserializable {
/**

 */
  public let versionId: String?
/**

 */
  public let key: String?
/**

 */
  public let code: String?
/**

 */
  public let message: String?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if versionId != nil { body["VersionId"] = versionId! }
    if key != nil { body["Key"] = key! }
    if code != nil { body["Code"] = code! }
    if message != nil { body["Message"] = message! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserialize(response: HTTPURLResponse, json: Any) -> ErrorError {
    let jsonDict = json as! [String: Any]
    return ErrorError(
        versionId: jsonDict["VersionId"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      key: jsonDict["Key"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      code: jsonDict["Code"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      message: jsonDict["Message"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) }
    )
  }

/**
    - parameters:
      - versionId: 
      - key: 
      - code: 
      - message: 
 */
  public init(versionId: String?, key: String?, code: String?, message: String?) {
self.versionId = versionId
self.key = key
self.code = code
self.message = message
  }
}




public struct CreateBucketConfiguration: RestJsonSerializable, RestJsonDeserializable {
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

  static func deserialize(response: HTTPURLResponse, json: Any) -> CreateBucketConfiguration {
    let jsonDict = json as! [String: Any]
    return CreateBucketConfiguration(
        locationConstraint: jsonDict["LocationConstraint"].flatMap { ($0 is NSNull) ? nil : Bucketlocationconstraint.deserialize(response: response, json: $0) }
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

public struct GetBucketWebsiteRequest: RestJsonSerializable {
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


public struct UploadPartRequest: RestJsonSerializable {
/**
Name of the bucket to which the multipart upload was initiated.
 */
  public let bucket: String
/**
Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data. This value is used to store the object and then it is discarded; Amazon does not store the encryption key. The key must be appropriate for use with the algorithm specified in the x-amz-server-side​-encryption​-customer-algorithm header. This must be the same encryption key specified in the initiate multipart upload request.
 */
  public let sSECustomerKey: String?
/**
The base64-encoded 128-bit MD5 digest of the part data.
 */
  public let contentMD5: String?
/**
Part number of part being uploaded. This is a positive integer between 1 and 10,000.
 */
  public let partNumber: Int
/**
Size of the body in bytes. This parameter is useful when the size of the body cannot be determined automatically.
 */
  public let contentLength: Int?
/**

 */
  public let requestPayer: Requestpayer?
/**
Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure the encryption key was transmitted without error.
 */
  public let sSECustomerKeyMD5: String?
/**
Object key for which the multipart upload was initiated.
 */
  public let key: String
/**
Upload ID identifying the multipart upload whose part is being uploaded.
 */
  public let uploadId: String
/**
Object data.
 */
  public let bodyBody: Data?
/**
Specifies the algorithm to use to when encrypting the object (e.g., AES256).
 */
  public let sSECustomerAlgorithm: String?

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    var querystring: [String: String] = [:]
    var header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    uri["Bucket"] = "\(bucket)"
    uri["Key"] = "\(key)"
    querystring["partNumber"] = "\(partNumber)"
    querystring["uploadId"] = "\(uploadId)"
    if sSECustomerKey != nil { header["x-amz-server-side-encryption-customer-key"] = "\(sSECustomerKey!)" }
    if contentMD5 != nil { header["Content-MD5"] = "\(contentMD5!)" }
    if contentLength != nil { header["Content-Length"] = "\(contentLength!)" }
    if requestPayer != nil { header["x-amz-request-payer"] = "\(requestPayer!)" }
    if sSECustomerKeyMD5 != nil { header["x-amz-server-side-encryption-customer-key-MD5"] = "\(sSECustomerKeyMD5!)" }
    if sSECustomerAlgorithm != nil { header["x-amz-server-side-encryption-customer-algorithm"] = "\(sSECustomerAlgorithm!)" }
    if bodyBody != nil { body["Body"] = bodyBody! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - bucket: Name of the bucket to which the multipart upload was initiated.
      - sSECustomerKey: Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data. This value is used to store the object and then it is discarded; Amazon does not store the encryption key. The key must be appropriate for use with the algorithm specified in the x-amz-server-side​-encryption​-customer-algorithm header. This must be the same encryption key specified in the initiate multipart upload request.
      - contentMD5: The base64-encoded 128-bit MD5 digest of the part data.
      - partNumber: Part number of part being uploaded. This is a positive integer between 1 and 10,000.
      - contentLength: Size of the body in bytes. This parameter is useful when the size of the body cannot be determined automatically.
      - requestPayer: 
      - sSECustomerKeyMD5: Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure the encryption key was transmitted without error.
      - key: Object key for which the multipart upload was initiated.
      - uploadId: Upload ID identifying the multipart upload whose part is being uploaded.
      - bodyBody: Object data.
      - sSECustomerAlgorithm: Specifies the algorithm to use to when encrypting the object (e.g., AES256).
 */
  public init(bucket: String, sSECustomerKey: String?, contentMD5: String?, partNumber: Int, contentLength: Int?, requestPayer: Requestpayer?, sSECustomerKeyMD5: String?, key: String, uploadId: String, bodyBody: Data?, sSECustomerAlgorithm: String?) {
self.bucket = bucket
self.sSECustomerKey = sSECustomerKey
self.contentMD5 = contentMD5
self.partNumber = partNumber
self.contentLength = contentLength
self.requestPayer = requestPayer
self.sSECustomerKeyMD5 = sSECustomerKeyMD5
self.key = key
self.uploadId = uploadId
self.bodyBody = bodyBody
self.sSECustomerAlgorithm = sSECustomerAlgorithm
  }
}

public struct PutObjectRequest: RestJsonSerializable {
/**
Name of the bucket to which the PUT operation was initiated.
 */
  public let bucket: String
/**
Specifies presentational information for the object.
 */
  public let contentDisposition: String?
/**
Specifies the AWS KMS key ID to use for object encryption. All GET and PUT requests for an object protected by AWS KMS will fail if not made via SSL or using SigV4. Documentation on configuring any of the officially supported AWS SDKs and CLI can be found at http://docs.aws.amazon.com/AmazonS3/latest/dev/UsingAWSSDK.html#specify-signature-version
 */
  public let sSEKMSKeyId: String?
/**
Allows grantee to read the object ACL.
 */
  public let grantReadACP: String?
/**
Specifies the algorithm to use to when encrypting the object (e.g., AES256).
 */
  public let sSECustomerAlgorithm: String?
/**
The language the content is in.
 */
  public let contentLanguage: String?
/**
Specifies what content encodings have been applied to the object and thus what decoding mechanisms must be applied to obtain the media-type referenced by the Content-Type header field.
 */
  public let contentEncoding: String?
/**
Size of the body in bytes. This parameter is useful when the size of the body cannot be determined automatically.
 */
  public let contentLength: Int?
/**
Allows grantee to write the ACL for the applicable object.
 */
  public let grantWriteACP: String?
/**
Object key for which the PUT operation was initiated.
 */
  public let key: String
/**
If the bucket is configured as a website, redirects requests for this object to another object in the same bucket or to an external URL. Amazon S3 stores the value of this header in the object metadata.
 */
  public let websiteRedirectLocation: String?
/**
Object data.
 */
  public let bodyBody: Data?
/**
Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data. This value is used to store the object and then it is discarded; Amazon does not store the encryption key. The key must be appropriate for use with the algorithm specified in the x-amz-server-side​-encryption​-customer-algorithm header.
 */
  public let sSECustomerKey: String?
/**
The base64-encoded 128-bit MD5 digest of the part data.
 */
  public let contentMD5: String?
/**
Specifies caching behavior along the request/reply chain.
 */
  public let cacheControl: String?
/**

 */
  public let requestPayer: Requestpayer?
/**
Gives the grantee READ, READ_ACP, and WRITE_ACP permissions on the object.
 */
  public let grantFullControl: String?
/**
Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure the encryption key was transmitted without error.
 */
  public let sSECustomerKeyMD5: String?
/**
The canned ACL to apply to the object.
 */
  public let aCL: Objectcannedacl?
/**
A map of metadata to store with the object in S3.
 */
  public let metadata: [String: String]?
/**
The date and time at which the object is no longer cacheable.
 */
  public let expires: Date?
/**
A standard MIME type describing the format of the object data.
 */
  public let contentType: String?
/**
The type of storage to use for the object. Defaults to 'STANDARD'.
 */
  public let storageClass: Storageclass?
/**
Allows grantee to read the object data and its metadata.
 */
  public let grantRead: String?
/**
The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).
 */
  public let serverSideEncryption: Serversideencryption?

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    var header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    uri["Bucket"] = "\(bucket)"
    uri["Key"] = "\(key)"
    if contentDisposition != nil { header["Content-Disposition"] = "\(contentDisposition!)" }
    if sSEKMSKeyId != nil { header["x-amz-server-side-encryption-aws-kms-key-id"] = "\(sSEKMSKeyId!)" }
    if grantReadACP != nil { header["x-amz-grant-read-acp"] = "\(grantReadACP!)" }
    if sSECustomerAlgorithm != nil { header["x-amz-server-side-encryption-customer-algorithm"] = "\(sSECustomerAlgorithm!)" }
    if contentLanguage != nil { header["Content-Language"] = "\(contentLanguage!)" }
    if contentEncoding != nil { header["Content-Encoding"] = "\(contentEncoding!)" }
    if contentLength != nil { header["Content-Length"] = "\(contentLength!)" }
    if grantWriteACP != nil { header["x-amz-grant-write-acp"] = "\(grantWriteACP!)" }
    if websiteRedirectLocation != nil { header["x-amz-website-redirect-location"] = "\(websiteRedirectLocation!)" }
    if sSECustomerKey != nil { header["x-amz-server-side-encryption-customer-key"] = "\(sSECustomerKey!)" }
    if contentMD5 != nil { header["Content-MD5"] = "\(contentMD5!)" }
    if cacheControl != nil { header["Cache-Control"] = "\(cacheControl!)" }
    if requestPayer != nil { header["x-amz-request-payer"] = "\(requestPayer!)" }
    if grantFullControl != nil { header["x-amz-grant-full-control"] = "\(grantFullControl!)" }
    if sSECustomerKeyMD5 != nil { header["x-amz-server-side-encryption-customer-key-MD5"] = "\(sSECustomerKeyMD5!)" }
    if aCL != nil { header["x-amz-acl"] = "\(aCL!)" }
    if expires != nil { header["Expires"] = "\(expires!)" }
    if contentType != nil { header["Content-Type"] = "\(contentType!)" }
    if storageClass != nil { header["x-amz-storage-class"] = "\(storageClass!)" }
    if grantRead != nil { header["x-amz-grant-read"] = "\(grantRead!)" }
    if serverSideEncryption != nil { header["x-amz-server-side-encryption"] = "\(serverSideEncryption!)" }
    if bodyBody != nil { body["Body"] = bodyBody! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - bucket: Name of the bucket to which the PUT operation was initiated.
      - contentDisposition: Specifies presentational information for the object.
      - sSEKMSKeyId: Specifies the AWS KMS key ID to use for object encryption. All GET and PUT requests for an object protected by AWS KMS will fail if not made via SSL or using SigV4. Documentation on configuring any of the officially supported AWS SDKs and CLI can be found at http://docs.aws.amazon.com/AmazonS3/latest/dev/UsingAWSSDK.html#specify-signature-version
      - grantReadACP: Allows grantee to read the object ACL.
      - sSECustomerAlgorithm: Specifies the algorithm to use to when encrypting the object (e.g., AES256).
      - contentLanguage: The language the content is in.
      - contentEncoding: Specifies what content encodings have been applied to the object and thus what decoding mechanisms must be applied to obtain the media-type referenced by the Content-Type header field.
      - contentLength: Size of the body in bytes. This parameter is useful when the size of the body cannot be determined automatically.
      - grantWriteACP: Allows grantee to write the ACL for the applicable object.
      - key: Object key for which the PUT operation was initiated.
      - websiteRedirectLocation: If the bucket is configured as a website, redirects requests for this object to another object in the same bucket or to an external URL. Amazon S3 stores the value of this header in the object metadata.
      - bodyBody: Object data.
      - sSECustomerKey: Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data. This value is used to store the object and then it is discarded; Amazon does not store the encryption key. The key must be appropriate for use with the algorithm specified in the x-amz-server-side​-encryption​-customer-algorithm header.
      - contentMD5: The base64-encoded 128-bit MD5 digest of the part data.
      - cacheControl: Specifies caching behavior along the request/reply chain.
      - requestPayer: 
      - grantFullControl: Gives the grantee READ, READ_ACP, and WRITE_ACP permissions on the object.
      - sSECustomerKeyMD5: Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure the encryption key was transmitted without error.
      - aCL: The canned ACL to apply to the object.
      - metadata: A map of metadata to store with the object in S3.
      - expires: The date and time at which the object is no longer cacheable.
      - contentType: A standard MIME type describing the format of the object data.
      - storageClass: The type of storage to use for the object. Defaults to 'STANDARD'.
      - grantRead: Allows grantee to read the object data and its metadata.
      - serverSideEncryption: The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).
 */
  public init(bucket: String, contentDisposition: String?, sSEKMSKeyId: String?, grantReadACP: String?, sSECustomerAlgorithm: String?, contentLanguage: String?, contentEncoding: String?, contentLength: Int?, grantWriteACP: String?, key: String, websiteRedirectLocation: String?, bodyBody: Data?, sSECustomerKey: String?, contentMD5: String?, cacheControl: String?, requestPayer: Requestpayer?, grantFullControl: String?, sSECustomerKeyMD5: String?, aCL: Objectcannedacl?, metadata: [String: String]?, expires: Date?, contentType: String?, storageClass: Storageclass?, grantRead: String?, serverSideEncryption: Serversideencryption?) {
self.bucket = bucket
self.contentDisposition = contentDisposition
self.sSEKMSKeyId = sSEKMSKeyId
self.grantReadACP = grantReadACP
self.sSECustomerAlgorithm = sSECustomerAlgorithm
self.contentLanguage = contentLanguage
self.contentEncoding = contentEncoding
self.contentLength = contentLength
self.grantWriteACP = grantWriteACP
self.key = key
self.websiteRedirectLocation = websiteRedirectLocation
self.bodyBody = bodyBody
self.sSECustomerKey = sSECustomerKey
self.contentMD5 = contentMD5
self.cacheControl = cacheControl
self.requestPayer = requestPayer
self.grantFullControl = grantFullControl
self.sSECustomerKeyMD5 = sSECustomerKeyMD5
self.aCL = aCL
self.metadata = metadata
self.expires = expires
self.contentType = contentType
self.storageClass = storageClass
self.grantRead = grantRead
self.serverSideEncryption = serverSideEncryption
  }
}

public struct DeletedObject: RestJsonSerializable, RestJsonDeserializable {
/**

 */
  public let deleteMarkerVersionId: String?
/**

 */
  public let versionId: String?
/**

 */
  public let key: String?
/**

 */
  public let deleteMarker: Bool?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if deleteMarkerVersionId != nil { body["DeleteMarkerVersionId"] = deleteMarkerVersionId! }
    if versionId != nil { body["VersionId"] = versionId! }
    if key != nil { body["Key"] = key! }
    if deleteMarker != nil { body["DeleteMarker"] = deleteMarker! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserialize(response: HTTPURLResponse, json: Any) -> DeletedObject {
    let jsonDict = json as! [String: Any]
    return DeletedObject(
        deleteMarkerVersionId: jsonDict["DeleteMarkerVersionId"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      versionId: jsonDict["VersionId"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      key: jsonDict["Key"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      deleteMarker: jsonDict["DeleteMarker"].flatMap { ($0 is NSNull) ? nil : Bool.deserialize(response: response, json: $0) }
    )
  }

/**
    - parameters:
      - deleteMarkerVersionId: 
      - versionId: 
      - key: 
      - deleteMarker: 
 */
  public init(deleteMarkerVersionId: String?, versionId: String?, key: String?, deleteMarker: Bool?) {
self.deleteMarkerVersionId = deleteMarkerVersionId
self.versionId = versionId
self.key = key
self.deleteMarker = deleteMarker
  }
}



public struct ListMultipartUploadsOutput: RestJsonDeserializable {
/**
Name of the bucket to which the multipart upload was initiated.
 */
  public let bucket: String?
/**
Indicates whether the returned list of multipart uploads is truncated. A value of true indicates that the list was truncated. The list can be truncated if the number of multipart uploads exceeds the limit allowed or specified by max uploads.
 */
  public let isTruncated: Bool?
/**
When a list is truncated, this element specifies the value that should be used for the key-marker request parameter in a subsequent request.
 */
  public let nextKeyMarker: String?
/**
Upload ID after which listing began.
 */
  public let uploadIdMarker: String?
/**
When a prefix is provided in the request, this field contains the specified prefix. The result contains only keys starting with the specified prefix.
 */
  public let prefix: String?
/**

 */
  public let commonPrefixes: [CommonPrefix]?
/**
Maximum number of multipart uploads that could have been included in the response.
 */
  public let maxUploads: Int?
/**

 */
  public let uploads: [MultipartUpload]?
/**

 */
  public let delimiter: String?
/**
Encoding type used by Amazon S3 to encode object keys in the response.
 */
  public let encodingType: Encodingtype?
/**
When a list is truncated, this element specifies the value that should be used for the upload-id-marker request parameter in a subsequent request.
 */
  public let nextUploadIdMarker: String?
/**
The key at or after which the listing began.
 */
  public let keyMarker: String?


  static func deserialize(response: HTTPURLResponse, json: Any) -> ListMultipartUploadsOutput {
    let jsonDict = json as! [String: Any]
    return ListMultipartUploadsOutput(
        bucket: jsonDict["Bucket"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      isTruncated: jsonDict["IsTruncated"].flatMap { ($0 is NSNull) ? nil : Bool.deserialize(response: response, json: $0) },
      nextKeyMarker: jsonDict["NextKeyMarker"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      uploadIdMarker: jsonDict["UploadIdMarker"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      prefix: jsonDict["Prefix"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      commonPrefixes: jsonDict["CommonPrefixes"].flatMap { ($0 is NSNull) ? nil : [CommonPrefix].deserialize(response: response, json: $0) },
      maxUploads: jsonDict["MaxUploads"].flatMap { ($0 is NSNull) ? nil : Int.deserialize(response: response, json: $0) },
      uploads: jsonDict["Upload"].flatMap { ($0 is NSNull) ? nil : [MultipartUpload].deserialize(response: response, json: $0) },
      delimiter: jsonDict["Delimiter"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      encodingType: jsonDict["EncodingType"].flatMap { ($0 is NSNull) ? nil : Encodingtype.deserialize(response: response, json: $0) },
      nextUploadIdMarker: jsonDict["NextUploadIdMarker"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      keyMarker: jsonDict["KeyMarker"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) }
    )
  }

/**
    - parameters:
      - bucket: Name of the bucket to which the multipart upload was initiated.
      - isTruncated: Indicates whether the returned list of multipart uploads is truncated. A value of true indicates that the list was truncated. The list can be truncated if the number of multipart uploads exceeds the limit allowed or specified by max uploads.
      - nextKeyMarker: When a list is truncated, this element specifies the value that should be used for the key-marker request parameter in a subsequent request.
      - uploadIdMarker: Upload ID after which listing began.
      - prefix: When a prefix is provided in the request, this field contains the specified prefix. The result contains only keys starting with the specified prefix.
      - commonPrefixes: 
      - maxUploads: Maximum number of multipart uploads that could have been included in the response.
      - uploads: 
      - delimiter: 
      - encodingType: Encoding type used by Amazon S3 to encode object keys in the response.
      - nextUploadIdMarker: When a list is truncated, this element specifies the value that should be used for the upload-id-marker request parameter in a subsequent request.
      - keyMarker: The key at or after which the listing began.
 */
  public init(bucket: String?, isTruncated: Bool?, nextKeyMarker: String?, uploadIdMarker: String?, prefix: String?, commonPrefixes: [CommonPrefix]?, maxUploads: Int?, uploads: [MultipartUpload]?, delimiter: String?, encodingType: Encodingtype?, nextUploadIdMarker: String?, keyMarker: String?) {
self.bucket = bucket
self.isTruncated = isTruncated
self.nextKeyMarker = nextKeyMarker
self.uploadIdMarker = uploadIdMarker
self.prefix = prefix
self.commonPrefixes = commonPrefixes
self.maxUploads = maxUploads
self.uploads = uploads
self.delimiter = delimiter
self.encodingType = encodingType
self.nextUploadIdMarker = nextUploadIdMarker
self.keyMarker = keyMarker
  }
}

public struct GetBucketAclOutput: RestJsonDeserializable {
/**

 */
  public let owner: Owner?
/**
A list of grants.
 */
  public let grants: [Grant]?


  static func deserialize(response: HTTPURLResponse, json: Any) -> GetBucketAclOutput {
    let jsonDict = json as! [String: Any]
    return GetBucketAclOutput(
        owner: jsonDict["Owner"].flatMap { ($0 is NSNull) ? nil : Owner.deserialize(response: response, json: $0) },
      grants: jsonDict["AccessControlList"].flatMap { ($0 is NSNull) ? nil : [Grant].deserialize(response: response, json: $0) }
    )
  }

/**
    - parameters:
      - owner: 
      - grants: A list of grants.
 */
  public init(owner: Owner?, grants: [Grant]?) {
self.owner = owner
self.grants = grants
  }
}


public struct GetBucketRequestPaymentRequest: RestJsonSerializable {
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



public struct DeleteBucketPolicyRequest: RestJsonSerializable {
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


public struct HeadBucketRequest: RestJsonSerializable {
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

/**
Container for object key name prefix and suffix filtering rules.
 */
public struct S3KeyFilter: RestJsonSerializable, RestJsonDeserializable {
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

  static func deserialize(response: HTTPURLResponse, json: Any) -> S3KeyFilter {
    let jsonDict = json as! [String: Any]
    return S3KeyFilter(
        filterRules: jsonDict["FilterRule"].flatMap { ($0 is NSNull) ? nil : [FilterRule].deserialize(response: response, json: $0) }
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

public struct ListObjectsV2Request: RestJsonSerializable {
/**
Name of the bucket to list.
 */
  public let bucket: String
/**
Sets the maximum number of keys returned in the response. The response might contain fewer keys but will never contain more.
 */
  public let maxKeys: Int?
/**
StartAfter is where you want Amazon S3 to start listing from. Amazon S3 starts listing after this specified key. StartAfter can be any key in the bucket
 */
  public let startAfter: String?
/**
ContinuationToken indicates Amazon S3 that the list is being continued on this bucket with a token. ContinuationToken is obfuscated and is not a real key
 */
  public let continuationToken: String?
/**
Confirms that the requester knows that she or he will be charged for the list objects request in V2 style. Bucket owners need not specify this parameter in their requests.
 */
  public let requestPayer: Requestpayer?
/**
Limits the response to keys that begin with the specified prefix.
 */
  public let prefix: String?
/**
The owner field is not present in listV2 by default, if you want to return owner field with each key in the result then set the fetch owner field to true
 */
  public let fetchOwner: Bool?
/**
A delimiter is a character you use to group keys.
 */
  public let delimiter: String?
/**
Encoding type used by Amazon S3 to encode object keys in the response.
 */
  public let encodingType: Encodingtype?

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    var querystring: [String: String] = [:]
    var header: [String: String] = [:]
    
  
    uri["Bucket"] = "\(bucket)"
    if maxKeys != nil { querystring["max-keys"] = "\(maxKeys!)" }
    if startAfter != nil { querystring["start-after"] = "\(startAfter!)" }
    if continuationToken != nil { querystring["continuation-token"] = "\(continuationToken!)" }
    if prefix != nil { querystring["prefix"] = "\(prefix!)" }
    if fetchOwner != nil { querystring["fetch-owner"] = "\(fetchOwner!)" }
    if delimiter != nil { querystring["delimiter"] = "\(delimiter!)" }
    if encodingType != nil { querystring["encoding-type"] = "\(encodingType!)" }
    if requestPayer != nil { header["x-amz-request-payer"] = "\(requestPayer!)" }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - bucket: Name of the bucket to list.
      - maxKeys: Sets the maximum number of keys returned in the response. The response might contain fewer keys but will never contain more.
      - startAfter: StartAfter is where you want Amazon S3 to start listing from. Amazon S3 starts listing after this specified key. StartAfter can be any key in the bucket
      - continuationToken: ContinuationToken indicates Amazon S3 that the list is being continued on this bucket with a token. ContinuationToken is obfuscated and is not a real key
      - requestPayer: Confirms that the requester knows that she or he will be charged for the list objects request in V2 style. Bucket owners need not specify this parameter in their requests.
      - prefix: Limits the response to keys that begin with the specified prefix.
      - fetchOwner: The owner field is not present in listV2 by default, if you want to return owner field with each key in the result then set the fetch owner field to true
      - delimiter: A delimiter is a character you use to group keys.
      - encodingType: Encoding type used by Amazon S3 to encode object keys in the response.
 */
  public init(bucket: String, maxKeys: Int?, startAfter: String?, continuationToken: String?, requestPayer: Requestpayer?, prefix: String?, fetchOwner: Bool?, delimiter: String?, encodingType: Encodingtype?) {
self.bucket = bucket
self.maxKeys = maxKeys
self.startAfter = startAfter
self.continuationToken = continuationToken
self.requestPayer = requestPayer
self.prefix = prefix
self.fetchOwner = fetchOwner
self.delimiter = delimiter
self.encodingType = encodingType
  }
}

enum Transitionstorageclass: String, RestJsonDeserializable, RestJsonSerializable {
  case `gLACIER` = "GLACIER"
  case `sTANDARD_IA` = "STANDARD_IA"

  static func deserialize(response: HTTPURLResponse, json: Any) -> Transitionstorageclass {
    return Transitionstorageclass(rawValue: json as! String)!
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}



public struct PutBucketWebsiteRequest: RestJsonSerializable {
/**

 */
  public let contentMD5: String?
/**

 */
  public let bucket: String
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
      - contentMD5: 
      - bucket: 
      - websiteConfiguration: 
 */
  public init(contentMD5: String?, bucket: String, websiteConfiguration: WebsiteConfiguration) {
self.contentMD5 = contentMD5
self.bucket = bucket
self.websiteConfiguration = websiteConfiguration
  }
}


public struct PutBucketNotificationConfigurationRequest: RestJsonSerializable {
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


public struct CreateBucketRequest: RestJsonSerializable {
/**

 */
  public let bucket: String
/**

 */
  public let createBucketConfiguration: CreateBucketConfiguration?
/**
Allows grantee to write the ACL for the applicable bucket.
 */
  public let grantWriteACP: String?
/**
Allows grantee the read, write, read ACP, and write ACP permissions on the bucket.
 */
  public let grantFullControl: String?
/**
Allows grantee to create, overwrite, and delete any object in the bucket.
 */
  public let grantWrite: String?
/**
Allows grantee to list the objects in the bucket.
 */
  public let grantRead: String?
/**
The canned ACL to apply to the bucket.
 */
  public let aCL: Bucketcannedacl?
/**
Allows grantee to read the bucket ACL.
 */
  public let grantReadACP: String?

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    var header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    uri["Bucket"] = "\(bucket)"
    if grantWriteACP != nil { header["x-amz-grant-write-acp"] = "\(grantWriteACP!)" }
    if grantFullControl != nil { header["x-amz-grant-full-control"] = "\(grantFullControl!)" }
    if grantWrite != nil { header["x-amz-grant-write"] = "\(grantWrite!)" }
    if grantRead != nil { header["x-amz-grant-read"] = "\(grantRead!)" }
    if aCL != nil { header["x-amz-acl"] = "\(aCL!)" }
    if grantReadACP != nil { header["x-amz-grant-read-acp"] = "\(grantReadACP!)" }
    if createBucketConfiguration != nil { body["CreateBucketConfiguration"] = createBucketConfiguration! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - bucket: 
      - createBucketConfiguration: 
      - grantWriteACP: Allows grantee to write the ACL for the applicable bucket.
      - grantFullControl: Allows grantee the read, write, read ACP, and write ACP permissions on the bucket.
      - grantWrite: Allows grantee to create, overwrite, and delete any object in the bucket.
      - grantRead: Allows grantee to list the objects in the bucket.
      - aCL: The canned ACL to apply to the bucket.
      - grantReadACP: Allows grantee to read the bucket ACL.
 */
  public init(bucket: String, createBucketConfiguration: CreateBucketConfiguration?, grantWriteACP: String?, grantFullControl: String?, grantWrite: String?, grantRead: String?, aCL: Bucketcannedacl?, grantReadACP: String?) {
self.bucket = bucket
self.createBucketConfiguration = createBucketConfiguration
self.grantWriteACP = grantWriteACP
self.grantFullControl = grantFullControl
self.grantWrite = grantWrite
self.grantRead = grantRead
self.aCL = aCL
self.grantReadACP = grantReadACP
  }
}

/**
Specifies the days since the initiation of an Incomplete Multipart Upload that Lifecycle will wait before permanently removing all parts of the upload.
 */
public struct AbortIncompleteMultipartUpload: RestJsonSerializable, RestJsonDeserializable {
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

  static func deserialize(response: HTTPURLResponse, json: Any) -> AbortIncompleteMultipartUpload {
    let jsonDict = json as! [String: Any]
    return AbortIncompleteMultipartUpload(
        daysAfterInitiation: jsonDict["DaysAfterInitiation"].flatMap { ($0 is NSNull) ? nil : Int.deserialize(response: response, json: $0) }
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

enum Bucketlocationconstraint: String, RestJsonDeserializable, RestJsonSerializable {
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

  static func deserialize(response: HTTPURLResponse, json: Any) -> Bucketlocationconstraint {
    return Bucketlocationconstraint(rawValue: json as! String)!
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}

public struct Initiator: RestJsonSerializable, RestJsonDeserializable {
/**
If the principal is an AWS account, it provides the Canonical User ID. If the principal is an IAM User, it provides a user ARN value.
 */
  public let iD: String?
/**
Name of the Principal.
 */
  public let displayName: String?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if iD != nil { body["ID"] = iD! }
    if displayName != nil { body["DisplayName"] = displayName! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserialize(response: HTTPURLResponse, json: Any) -> Initiator {
    let jsonDict = json as! [String: Any]
    return Initiator(
        iD: jsonDict["ID"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      displayName: jsonDict["DisplayName"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) }
    )
  }

/**
    - parameters:
      - iD: If the principal is an AWS account, it provides the Canonical User ID. If the principal is an IAM User, it provides a user ARN value.
      - displayName: Name of the Principal.
 */
  public init(iD: String?, displayName: String?) {
self.iD = iD
self.displayName = displayName
  }
}

public struct RestoreRequest: RestJsonSerializable {
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


public struct PutBucketReplicationRequest: RestJsonSerializable {
/**

 */
  public let contentMD5: String?
/**

 */
  public let bucket: String
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
      - contentMD5: 
      - bucket: 
      - replicationConfiguration: 
 */
  public init(contentMD5: String?, bucket: String, replicationConfiguration: ReplicationConfiguration) {
self.contentMD5 = contentMD5
self.bucket = bucket
self.replicationConfiguration = replicationConfiguration
  }
}

public struct LifecycleConfiguration: RestJsonSerializable, RestJsonDeserializable {
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

  static func deserialize(response: HTTPURLResponse, json: Any) -> LifecycleConfiguration {
    let jsonDict = json as! [String: Any]
    return LifecycleConfiguration(
        rules: jsonDict["Rule"].flatMap { ($0 is NSNull) ? nil : [Rule].deserialize(response: response, json: $0) }!
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



public struct CORSRule: RestJsonSerializable, RestJsonDeserializable {
/**
One or more headers in the response that you want customers to be able to access from their applications (for example, from a JavaScript XMLHttpRequest object).
 */
  public let exposeHeaders: [String]?
/**
Identifies HTTP methods that the domain/origin specified in the rule is allowed to execute.
 */
  public let allowedMethods: [String]
/**
One or more origins you want customers to be able to access the bucket from.
 */
  public let allowedOrigins: [String]
/**
The time in seconds that your browser is to cache the preflight response for the specified resource.
 */
  public let maxAgeSeconds: Int?
/**
Specifies which headers are allowed in a pre-flight OPTIONS request.
 */
  public let allowedHeaders: [String]?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if exposeHeaders != nil { body["ExposeHeader"] = exposeHeaders! }
    body["AllowedMethod"] = allowedMethods
    body["AllowedOrigin"] = allowedOrigins
    if maxAgeSeconds != nil { body["MaxAgeSeconds"] = maxAgeSeconds! }
    if allowedHeaders != nil { body["AllowedHeader"] = allowedHeaders! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserialize(response: HTTPURLResponse, json: Any) -> CORSRule {
    let jsonDict = json as! [String: Any]
    return CORSRule(
        exposeHeaders: jsonDict["ExposeHeader"].flatMap { ($0 is NSNull) ? nil : [String].deserialize(response: response, json: $0) },
      allowedMethods: jsonDict["AllowedMethod"].flatMap { ($0 is NSNull) ? nil : [String].deserialize(response: response, json: $0) }!,
      allowedOrigins: jsonDict["AllowedOrigin"].flatMap { ($0 is NSNull) ? nil : [String].deserialize(response: response, json: $0) }!,
      maxAgeSeconds: jsonDict["MaxAgeSeconds"].flatMap { ($0 is NSNull) ? nil : Int.deserialize(response: response, json: $0) },
      allowedHeaders: jsonDict["AllowedHeader"].flatMap { ($0 is NSNull) ? nil : [String].deserialize(response: response, json: $0) }
    )
  }

/**
    - parameters:
      - exposeHeaders: One or more headers in the response that you want customers to be able to access from their applications (for example, from a JavaScript XMLHttpRequest object).
      - allowedMethods: Identifies HTTP methods that the domain/origin specified in the rule is allowed to execute.
      - allowedOrigins: One or more origins you want customers to be able to access the bucket from.
      - maxAgeSeconds: The time in seconds that your browser is to cache the preflight response for the specified resource.
      - allowedHeaders: Specifies which headers are allowed in a pre-flight OPTIONS request.
 */
  public init(exposeHeaders: [String]?, allowedMethods: [String], allowedOrigins: [String], maxAgeSeconds: Int?, allowedHeaders: [String]?) {
self.exposeHeaders = exposeHeaders
self.allowedMethods = allowedMethods
self.allowedOrigins = allowedOrigins
self.maxAgeSeconds = maxAgeSeconds
self.allowedHeaders = allowedHeaders
  }
}


public struct CreateMultipartUploadRequest: RestJsonSerializable {
/**
Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data. This value is used to store the object and then it is discarded; Amazon does not store the encryption key. The key must be appropriate for use with the algorithm specified in the x-amz-server-side​-encryption​-customer-algorithm header.
 */
  public let sSECustomerKey: String?
/**
Specifies caching behavior along the request/reply chain.
 */
  public let cacheControl: String?
/**

 */
  public let bucket: String
/**
Specifies presentational information for the object.
 */
  public let contentDisposition: String?
/**

 */
  public let requestPayer: Requestpayer?
/**
Gives the grantee READ, READ_ACP, and WRITE_ACP permissions on the object.
 */
  public let grantFullControl: String?
/**
Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure the encryption key was transmitted without error.
 */
  public let sSECustomerKeyMD5: String?
/**
Specifies the AWS KMS key ID to use for object encryption. All GET and PUT requests for an object protected by AWS KMS will fail if not made via SSL or using SigV4. Documentation on configuring any of the officially supported AWS SDKs and CLI can be found at http://docs.aws.amazon.com/AmazonS3/latest/dev/UsingAWSSDK.html#specify-signature-version
 */
  public let sSEKMSKeyId: String?
/**
Allows grantee to read the object ACL.
 */
  public let grantReadACP: String?
/**
The canned ACL to apply to the object.
 */
  public let aCL: Objectcannedacl?
/**
Specifies the algorithm to use to when encrypting the object (e.g., AES256).
 */
  public let sSECustomerAlgorithm: String?
/**
The language the content is in.
 */
  public let contentLanguage: String?
/**
A map of metadata to store with the object in S3.
 */
  public let metadata: [String: String]?
/**
Specifies what content encodings have been applied to the object and thus what decoding mechanisms must be applied to obtain the media-type referenced by the Content-Type header field.
 */
  public let contentEncoding: String?
/**
The date and time at which the object is no longer cacheable.
 */
  public let expires: Date?
/**
Allows grantee to write the ACL for the applicable object.
 */
  public let grantWriteACP: String?
/**
A standard MIME type describing the format of the object data.
 */
  public let contentType: String?
/**
The type of storage to use for the object. Defaults to 'STANDARD'.
 */
  public let storageClass: Storageclass?
/**

 */
  public let key: String
/**
If the bucket is configured as a website, redirects requests for this object to another object in the same bucket or to an external URL. Amazon S3 stores the value of this header in the object metadata.
 */
  public let websiteRedirectLocation: String?
/**
Allows grantee to read the object data and its metadata.
 */
  public let grantRead: String?
/**
The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).
 */
  public let serverSideEncryption: Serversideencryption?

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    var header: [String: String] = [:]
    
  
    uri["Bucket"] = "\(bucket)"
    uri["Key"] = "\(key)"
    if sSECustomerKey != nil { header["x-amz-server-side-encryption-customer-key"] = "\(sSECustomerKey!)" }
    if cacheControl != nil { header["Cache-Control"] = "\(cacheControl!)" }
    if contentDisposition != nil { header["Content-Disposition"] = "\(contentDisposition!)" }
    if requestPayer != nil { header["x-amz-request-payer"] = "\(requestPayer!)" }
    if grantFullControl != nil { header["x-amz-grant-full-control"] = "\(grantFullControl!)" }
    if sSECustomerKeyMD5 != nil { header["x-amz-server-side-encryption-customer-key-MD5"] = "\(sSECustomerKeyMD5!)" }
    if sSEKMSKeyId != nil { header["x-amz-server-side-encryption-aws-kms-key-id"] = "\(sSEKMSKeyId!)" }
    if grantReadACP != nil { header["x-amz-grant-read-acp"] = "\(grantReadACP!)" }
    if aCL != nil { header["x-amz-acl"] = "\(aCL!)" }
    if sSECustomerAlgorithm != nil { header["x-amz-server-side-encryption-customer-algorithm"] = "\(sSECustomerAlgorithm!)" }
    if contentLanguage != nil { header["Content-Language"] = "\(contentLanguage!)" }
    if contentEncoding != nil { header["Content-Encoding"] = "\(contentEncoding!)" }
    if expires != nil { header["Expires"] = "\(expires!)" }
    if grantWriteACP != nil { header["x-amz-grant-write-acp"] = "\(grantWriteACP!)" }
    if contentType != nil { header["Content-Type"] = "\(contentType!)" }
    if storageClass != nil { header["x-amz-storage-class"] = "\(storageClass!)" }
    if websiteRedirectLocation != nil { header["x-amz-website-redirect-location"] = "\(websiteRedirectLocation!)" }
    if grantRead != nil { header["x-amz-grant-read"] = "\(grantRead!)" }
    if serverSideEncryption != nil { header["x-amz-server-side-encryption"] = "\(serverSideEncryption!)" }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - sSECustomerKey: Specifies the customer-provided encryption key for Amazon S3 to use in encrypting data. This value is used to store the object and then it is discarded; Amazon does not store the encryption key. The key must be appropriate for use with the algorithm specified in the x-amz-server-side​-encryption​-customer-algorithm header.
      - cacheControl: Specifies caching behavior along the request/reply chain.
      - bucket: 
      - contentDisposition: Specifies presentational information for the object.
      - requestPayer: 
      - grantFullControl: Gives the grantee READ, READ_ACP, and WRITE_ACP permissions on the object.
      - sSECustomerKeyMD5: Specifies the 128-bit MD5 digest of the encryption key according to RFC 1321. Amazon S3 uses this header for a message integrity check to ensure the encryption key was transmitted without error.
      - sSEKMSKeyId: Specifies the AWS KMS key ID to use for object encryption. All GET and PUT requests for an object protected by AWS KMS will fail if not made via SSL or using SigV4. Documentation on configuring any of the officially supported AWS SDKs and CLI can be found at http://docs.aws.amazon.com/AmazonS3/latest/dev/UsingAWSSDK.html#specify-signature-version
      - grantReadACP: Allows grantee to read the object ACL.
      - aCL: The canned ACL to apply to the object.
      - sSECustomerAlgorithm: Specifies the algorithm to use to when encrypting the object (e.g., AES256).
      - contentLanguage: The language the content is in.
      - metadata: A map of metadata to store with the object in S3.
      - contentEncoding: Specifies what content encodings have been applied to the object and thus what decoding mechanisms must be applied to obtain the media-type referenced by the Content-Type header field.
      - expires: The date and time at which the object is no longer cacheable.
      - grantWriteACP: Allows grantee to write the ACL for the applicable object.
      - contentType: A standard MIME type describing the format of the object data.
      - storageClass: The type of storage to use for the object. Defaults to 'STANDARD'.
      - key: 
      - websiteRedirectLocation: If the bucket is configured as a website, redirects requests for this object to another object in the same bucket or to an external URL. Amazon S3 stores the value of this header in the object metadata.
      - grantRead: Allows grantee to read the object data and its metadata.
      - serverSideEncryption: The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).
 */
  public init(sSECustomerKey: String?, cacheControl: String?, bucket: String, contentDisposition: String?, requestPayer: Requestpayer?, grantFullControl: String?, sSECustomerKeyMD5: String?, sSEKMSKeyId: String?, grantReadACP: String?, aCL: Objectcannedacl?, sSECustomerAlgorithm: String?, contentLanguage: String?, metadata: [String: String]?, contentEncoding: String?, expires: Date?, grantWriteACP: String?, contentType: String?, storageClass: Storageclass?, key: String, websiteRedirectLocation: String?, grantRead: String?, serverSideEncryption: Serversideencryption?) {
self.sSECustomerKey = sSECustomerKey
self.cacheControl = cacheControl
self.bucket = bucket
self.contentDisposition = contentDisposition
self.requestPayer = requestPayer
self.grantFullControl = grantFullControl
self.sSECustomerKeyMD5 = sSECustomerKeyMD5
self.sSEKMSKeyId = sSEKMSKeyId
self.grantReadACP = grantReadACP
self.aCL = aCL
self.sSECustomerAlgorithm = sSECustomerAlgorithm
self.contentLanguage = contentLanguage
self.metadata = metadata
self.contentEncoding = contentEncoding
self.expires = expires
self.grantWriteACP = grantWriteACP
self.contentType = contentType
self.storageClass = storageClass
self.key = key
self.websiteRedirectLocation = websiteRedirectLocation
self.grantRead = grantRead
self.serverSideEncryption = serverSideEncryption
  }
}

public struct GetBucketAccelerateConfigurationRequest: RestJsonSerializable {
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

public struct ListPartsRequest: RestJsonSerializable {
/**

 */
  public let bucket: String
/**
Specifies the part after which listing should begin. Only parts with higher part numbers will be listed.
 */
  public let partNumberMarker: Int?
/**

 */
  public let key: String
/**
Upload ID identifying the multipart upload whose parts are being listed.
 */
  public let uploadId: String
/**
Sets the maximum number of parts to return.
 */
  public let maxParts: Int?
/**

 */
  public let requestPayer: Requestpayer?

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    var querystring: [String: String] = [:]
    var header: [String: String] = [:]
    
  
    uri["Bucket"] = "\(bucket)"
    uri["Key"] = "\(key)"
    if partNumberMarker != nil { querystring["part-number-marker"] = "\(partNumberMarker!)" }
    querystring["uploadId"] = "\(uploadId)"
    if maxParts != nil { querystring["max-parts"] = "\(maxParts!)" }
    if requestPayer != nil { header["x-amz-request-payer"] = "\(requestPayer!)" }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - bucket: 
      - partNumberMarker: Specifies the part after which listing should begin. Only parts with higher part numbers will be listed.
      - key: 
      - uploadId: Upload ID identifying the multipart upload whose parts are being listed.
      - maxParts: Sets the maximum number of parts to return.
      - requestPayer: 
 */
  public init(bucket: String, partNumberMarker: Int?, key: String, uploadId: String, maxParts: Int?, requestPayer: Requestpayer?) {
self.bucket = bucket
self.partNumberMarker = partNumberMarker
self.key = key
self.uploadId = uploadId
self.maxParts = maxParts
self.requestPayer = requestPayer
  }
}



public struct PutObjectAclOutput: RestJsonDeserializable {
/**

 */
  public let requestCharged: Requestcharged?


  static func deserialize(response: HTTPURLResponse, json: Any) -> PutObjectAclOutput {
  
    return PutObjectAclOutput(
        requestCharged: response.allHeaderFields["x-amz-request-charged"].flatMap { ($0 is NSNull) ? nil : Requestcharged.deserialize(response: response, json: $0) }
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

public struct DeleteObjectRequest: RestJsonSerializable {
/**
VersionId used to reference a specific version of the object.
 */
  public let versionId: String?
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
      - versionId: VersionId used to reference a specific version of the object.
      - bucket: 
      - key: 
      - mFA: The concatenation of the authentication device's serial number, a space, and the value that is displayed on your authentication device.
      - requestPayer: 
 */
  public init(versionId: String?, bucket: String, key: String, mFA: String?, requestPayer: Requestpayer?) {
self.versionId = versionId
self.bucket = bucket
self.key = key
self.mFA = mFA
self.requestPayer = requestPayer
  }
}






public struct ListPartsOutput: RestJsonDeserializable {
/**
Part number after which listing begins.
 */
  public let partNumberMarker: Int?
/**
Name of the bucket to which the multipart upload was initiated.
 */
  public let bucket: String?
/**
Indicates whether the returned list of parts is truncated.
 */
  public let isTruncated: Bool?
/**
Date when multipart upload will become eligible for abort operation by lifecycle.
 */
  public let abortDate: Date?
/**
Upload ID identifying the multipart upload whose parts are being listed.
 */
  public let uploadId: String?
/**

 */
  public let owner: Owner?
/**

 */
  public let parts: [Part]?
/**
Identifies who initiated the multipart upload.
 */
  public let initiator: Initiator?
/**
Id of the lifecycle rule that makes a multipart upload eligible for abort operation.
 */
  public let abortRuleId: String?
/**
The class of storage used to store the object.
 */
  public let storageClass: Storageclass?
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
  public let requestCharged: Requestcharged?


  static func deserialize(response: HTTPURLResponse, json: Any) -> ListPartsOutput {
    let jsonDict = json as! [String: Any]
    return ListPartsOutput(
        partNumberMarker: jsonDict["PartNumberMarker"].flatMap { ($0 is NSNull) ? nil : Int.deserialize(response: response, json: $0) },
      bucket: jsonDict["Bucket"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      isTruncated: jsonDict["IsTruncated"].flatMap { ($0 is NSNull) ? nil : Bool.deserialize(response: response, json: $0) },
      abortDate: response.allHeaderFields["x-amz-abort-date"].flatMap { ($0 is NSNull) ? nil : Date.deserialize(response: response, json: $0) },
      uploadId: jsonDict["UploadId"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      owner: jsonDict["Owner"].flatMap { ($0 is NSNull) ? nil : Owner.deserialize(response: response, json: $0) },
      parts: jsonDict["Part"].flatMap { ($0 is NSNull) ? nil : [Part].deserialize(response: response, json: $0) },
      initiator: jsonDict["Initiator"].flatMap { ($0 is NSNull) ? nil : Initiator.deserialize(response: response, json: $0) },
      abortRuleId: response.allHeaderFields["x-amz-abort-rule-id"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      storageClass: jsonDict["StorageClass"].flatMap { ($0 is NSNull) ? nil : Storageclass.deserialize(response: response, json: $0) },
      key: jsonDict["Key"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      maxParts: jsonDict["MaxParts"].flatMap { ($0 is NSNull) ? nil : Int.deserialize(response: response, json: $0) },
      nextPartNumberMarker: jsonDict["NextPartNumberMarker"].flatMap { ($0 is NSNull) ? nil : Int.deserialize(response: response, json: $0) },
      requestCharged: response.allHeaderFields["x-amz-request-charged"].flatMap { ($0 is NSNull) ? nil : Requestcharged.deserialize(response: response, json: $0) }
    )
  }

/**
    - parameters:
      - partNumberMarker: Part number after which listing begins.
      - bucket: Name of the bucket to which the multipart upload was initiated.
      - isTruncated: Indicates whether the returned list of parts is truncated.
      - abortDate: Date when multipart upload will become eligible for abort operation by lifecycle.
      - uploadId: Upload ID identifying the multipart upload whose parts are being listed.
      - owner: 
      - parts: 
      - initiator: Identifies who initiated the multipart upload.
      - abortRuleId: Id of the lifecycle rule that makes a multipart upload eligible for abort operation.
      - storageClass: The class of storage used to store the object.
      - key: Object key for which the multipart upload was initiated.
      - maxParts: Maximum number of parts that were allowed in the response.
      - nextPartNumberMarker: When a list is truncated, this element specifies the last part in the list, as well as the value to use for the part-number-marker request parameter in a subsequent request.
      - requestCharged: 
 */
  public init(partNumberMarker: Int?, bucket: String?, isTruncated: Bool?, abortDate: Date?, uploadId: String?, owner: Owner?, parts: [Part]?, initiator: Initiator?, abortRuleId: String?, storageClass: Storageclass?, key: String?, maxParts: Int?, nextPartNumberMarker: Int?, requestCharged: Requestcharged?) {
self.partNumberMarker = partNumberMarker
self.bucket = bucket
self.isTruncated = isTruncated
self.abortDate = abortDate
self.uploadId = uploadId
self.owner = owner
self.parts = parts
self.initiator = initiator
self.abortRuleId = abortRuleId
self.storageClass = storageClass
self.key = key
self.maxParts = maxParts
self.nextPartNumberMarker = nextPartNumberMarker
self.requestCharged = requestCharged
  }
}

enum Bucketacceleratestatus: String, RestJsonDeserializable, RestJsonSerializable {
  case `enabled` = "Enabled"
  case `suspended` = "Suspended"

  static func deserialize(response: HTTPURLResponse, json: Any) -> Bucketacceleratestatus {
    return Bucketacceleratestatus(rawValue: json as! String)!
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}

public struct DeleteBucketRequest: RestJsonSerializable {
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



enum Objectversionstorageclass: String, RestJsonDeserializable, RestJsonSerializable {
  case `sTANDARD` = "STANDARD"

  static func deserialize(response: HTTPURLResponse, json: Any) -> Objectversionstorageclass {
    return Objectversionstorageclass(rawValue: json as! String)!
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}

public struct RestoreObjectRequest: RestJsonSerializable {
/**

 */
  public let bucket: String
/**

 */
  public let restoreRequest: RestoreRequest?
/**

 */
  public let key: String
/**

 */
  public let versionId: String?
/**

 */
  public let requestPayer: Requestpayer?

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
      - restoreRequest: 
      - key: 
      - versionId: 
      - requestPayer: 
 */
  public init(bucket: String, restoreRequest: RestoreRequest?, key: String, versionId: String?, requestPayer: Requestpayer?) {
self.bucket = bucket
self.restoreRequest = restoreRequest
self.key = key
self.versionId = versionId
self.requestPayer = requestPayer
  }
}

enum Filterrulename: String, RestJsonDeserializable, RestJsonSerializable {
  case `prefix` = "prefix"
  case `suffix` = "suffix"

  static func deserialize(response: HTTPURLResponse, json: Any) -> Filterrulename {
    return Filterrulename(rawValue: json as! String)!
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}

public struct TopicConfigurationDeprecated: RestJsonSerializable, RestJsonDeserializable {
/**
Amazon SNS topic to which Amazon S3 will publish a message to report the specified events for the bucket.
 */
  public let topic: String?
/**

 */
  public let events: [Event]?
/**
Bucket event for which to send notifications.
 */
  public let event: Event?
/**

 */
  public let id: String?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if topic != nil { body["Topic"] = topic! }
    if events != nil { body["Event"] = events! }
    if event != nil { body["Event"] = event! }
    if id != nil { body["Id"] = id! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserialize(response: HTTPURLResponse, json: Any) -> TopicConfigurationDeprecated {
    let jsonDict = json as! [String: Any]
    return TopicConfigurationDeprecated(
        topic: jsonDict["Topic"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      events: jsonDict["Event"].flatMap { ($0 is NSNull) ? nil : [Event].deserialize(response: response, json: $0) },
      event: jsonDict["Event"].flatMap { ($0 is NSNull) ? nil : Event.deserialize(response: response, json: $0) },
      id: jsonDict["Id"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) }
    )
  }

/**
    - parameters:
      - topic: Amazon SNS topic to which Amazon S3 will publish a message to report the specified events for the bucket.
      - events: 
      - event: Bucket event for which to send notifications.
      - id: 
 */
  public init(topic: String?, events: [Event]?, event: Event?, id: String?) {
self.topic = topic
self.events = events
self.event = event
self.id = id
  }
}


public struct Grantee: RestJsonSerializable, RestJsonDeserializable {
/**
The canonical user ID of the grantee.
 */
  public let iD: String?
/**
Email address of the grantee.
 */
  public let emailAddress: String?
/**
Type of grantee
 */
  public let typeType: TypeType
/**
Screen name of the grantee.
 */
  public let displayName: String?
/**
URI of the grantee group.
 */
  public let uRI: String?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if iD != nil { body["ID"] = iD! }
    if emailAddress != nil { body["EmailAddress"] = emailAddress! }
    body["xsi:type"] = typeType
    if displayName != nil { body["DisplayName"] = displayName! }
    if uRI != nil { body["URI"] = uRI! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserialize(response: HTTPURLResponse, json: Any) -> Grantee {
    let jsonDict = json as! [String: Any]
    return Grantee(
        iD: jsonDict["ID"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      emailAddress: jsonDict["EmailAddress"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      typeType: jsonDict["xsi:type"].flatMap { ($0 is NSNull) ? nil : TypeType.deserialize(response: response, json: $0) }!,
      displayName: jsonDict["DisplayName"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      uRI: jsonDict["URI"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) }
    )
  }

/**
    - parameters:
      - iD: The canonical user ID of the grantee.
      - emailAddress: Email address of the grantee.
      - typeType: Type of grantee
      - displayName: Screen name of the grantee.
      - uRI: URI of the grantee group.
 */
  public init(iD: String?, emailAddress: String?, typeType: TypeType, displayName: String?, uRI: String?) {
self.iD = iD
self.emailAddress = emailAddress
self.typeType = typeType
self.displayName = displayName
self.uRI = uRI
  }
}

public struct QueueConfigurationDeprecated: RestJsonSerializable, RestJsonDeserializable {
/**

 */
  public let id: String?
/**

 */
  public let events: [Event]?
/**

 */
  public let event: Event?
/**

 */
  public let queue: String?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if id != nil { body["Id"] = id! }
    if events != nil { body["Event"] = events! }
    if event != nil { body["Event"] = event! }
    if queue != nil { body["Queue"] = queue! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserialize(response: HTTPURLResponse, json: Any) -> QueueConfigurationDeprecated {
    let jsonDict = json as! [String: Any]
    return QueueConfigurationDeprecated(
        id: jsonDict["Id"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      events: jsonDict["Event"].flatMap { ($0 is NSNull) ? nil : [Event].deserialize(response: response, json: $0) },
      event: jsonDict["Event"].flatMap { ($0 is NSNull) ? nil : Event.deserialize(response: response, json: $0) },
      queue: jsonDict["Queue"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) }
    )
  }

/**
    - parameters:
      - id: 
      - events: 
      - event: 
      - queue: 
 */
  public init(id: String?, events: [Event]?, event: Event?, queue: String?) {
self.id = id
self.events = events
self.event = event
self.queue = queue
  }
}

/**
Confirms that the requester knows that she or he will be charged for the request. Bucket owners need not specify this parameter in their requests. Documentation on downloading objects from requester pays buckets can be found at http://docs.aws.amazon.com/AmazonS3/latest/dev/ObjectsinRequesterPaysBuckets.html
 */
enum Requestpayer: String, RestJsonDeserializable, RestJsonSerializable {
  case `requester` = "requester"

  static func deserialize(response: HTTPURLResponse, json: Any) -> Requestpayer {
    return Requestpayer(rawValue: json as! String)!
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}


public struct GetBucketNotificationConfigurationRequest: RestJsonSerializable {
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



public struct CommonPrefix: RestJsonSerializable, RestJsonDeserializable {
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

  static func deserialize(response: HTTPURLResponse, json: Any) -> CommonPrefix {
    let jsonDict = json as! [String: Any]
    return CommonPrefix(
        prefix: jsonDict["Prefix"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) }
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

public struct GetBucketVersioningRequest: RestJsonSerializable {
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

enum Permission: String, RestJsonDeserializable, RestJsonSerializable {
  case `fULL_CONTROL` = "FULL_CONTROL"
  case `wRITE` = "WRITE"
  case `wRITE_ACP` = "WRITE_ACP"
  case `rEAD` = "READ"
  case `rEAD_ACP` = "READ_ACP"

  static func deserialize(response: HTTPURLResponse, json: Any) -> Permission {
    return Permission(rawValue: json as! String)!
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}

enum Expirationstatus: String, RestJsonDeserializable, RestJsonSerializable {
  case `enabled` = "Enabled"
  case `disabled` = "Disabled"

  static func deserialize(response: HTTPURLResponse, json: Any) -> Expirationstatus {
    return Expirationstatus(rawValue: json as! String)!
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}

public struct GetBucketLoggingRequest: RestJsonSerializable {
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

enum ProtocolProtocol: String, RestJsonDeserializable, RestJsonSerializable {
  case `http` = "http"
  case `https` = "https"

  static func deserialize(response: HTTPURLResponse, json: Any) -> ProtocolProtocol {
    return ProtocolProtocol(rawValue: json as! String)!
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}

public struct GetObjectTorrentRequest: RestJsonSerializable {
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



public struct PutBucketRequestPaymentRequest: RestJsonSerializable {
/**

 */
  public let contentMD5: String?
/**

 */
  public let bucket: String
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
      - contentMD5: 
      - bucket: 
      - requestPaymentConfiguration: 
 */
  public init(contentMD5: String?, bucket: String, requestPaymentConfiguration: RequestPaymentConfiguration) {
self.contentMD5 = contentMD5
self.bucket = bucket
self.requestPaymentConfiguration = requestPaymentConfiguration
  }
}

public struct PutObjectOutput: RestJsonDeserializable {
/**
If the object expiration is configured, this will contain the expiration date (expiry-date) and rule ID (rule-id). The value of rule-id is URL encoded.
 */
  public let expiration: String?
/**
Version of the object.
 */
  public let versionId: String?
/**
If server-side encryption with a customer-provided encryption key was requested, the response will include this header to provide round trip message integrity verification of the customer-provided encryption key.
 */
  public let sSECustomerKeyMD5: String?
/**
If present, specifies the ID of the AWS Key Management Service (KMS) master encryption key that was used for the object.
 */
  public let sSEKMSKeyId: String?
/**
Entity tag for the uploaded object.
 */
  public let eTag: String?
/**
If server-side encryption with a customer-provided encryption key was requested, the response will include this header confirming the encryption algorithm used.
 */
  public let sSECustomerAlgorithm: String?
/**

 */
  public let requestCharged: Requestcharged?
/**
The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).
 */
  public let serverSideEncryption: Serversideencryption?


  static func deserialize(response: HTTPURLResponse, json: Any) -> PutObjectOutput {
  
    return PutObjectOutput(
        expiration: response.allHeaderFields["x-amz-expiration"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      versionId: response.allHeaderFields["x-amz-version-id"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      sSECustomerKeyMD5: response.allHeaderFields["x-amz-server-side-encryption-customer-key-MD5"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      sSEKMSKeyId: response.allHeaderFields["x-amz-server-side-encryption-aws-kms-key-id"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      eTag: response.allHeaderFields["ETag"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      sSECustomerAlgorithm: response.allHeaderFields["x-amz-server-side-encryption-customer-algorithm"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      requestCharged: response.allHeaderFields["x-amz-request-charged"].flatMap { ($0 is NSNull) ? nil : Requestcharged.deserialize(response: response, json: $0) },
      serverSideEncryption: response.allHeaderFields["x-amz-server-side-encryption"].flatMap { ($0 is NSNull) ? nil : Serversideencryption.deserialize(response: response, json: $0) }
    )
  }

/**
    - parameters:
      - expiration: If the object expiration is configured, this will contain the expiration date (expiry-date) and rule ID (rule-id). The value of rule-id is URL encoded.
      - versionId: Version of the object.
      - sSECustomerKeyMD5: If server-side encryption with a customer-provided encryption key was requested, the response will include this header to provide round trip message integrity verification of the customer-provided encryption key.
      - sSEKMSKeyId: If present, specifies the ID of the AWS Key Management Service (KMS) master encryption key that was used for the object.
      - eTag: Entity tag for the uploaded object.
      - sSECustomerAlgorithm: If server-side encryption with a customer-provided encryption key was requested, the response will include this header confirming the encryption algorithm used.
      - requestCharged: 
      - serverSideEncryption: The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).
 */
  public init(expiration: String?, versionId: String?, sSECustomerKeyMD5: String?, sSEKMSKeyId: String?, eTag: String?, sSECustomerAlgorithm: String?, requestCharged: Requestcharged?, serverSideEncryption: Serversideencryption?) {
self.expiration = expiration
self.versionId = versionId
self.sSECustomerKeyMD5 = sSECustomerKeyMD5
self.sSEKMSKeyId = sSEKMSKeyId
self.eTag = eTag
self.sSECustomerAlgorithm = sSECustomerAlgorithm
self.requestCharged = requestCharged
self.serverSideEncryption = serverSideEncryption
  }
}

public struct CopyObjectOutput: RestJsonDeserializable {
/**

 */
  public let copyObjectResult: CopyObjectResult?
/**
If the object expiration is configured, the response includes this header.
 */
  public let expiration: String?
/**
Version ID of the newly created copy.
 */
  public let versionId: String?
/**

 */
  public let copySourceVersionId: String?
/**
If present, specifies the ID of the AWS Key Management Service (KMS) master encryption key that was used for the object.
 */
  public let sSEKMSKeyId: String?
/**
If server-side encryption with a customer-provided encryption key was requested, the response will include this header to provide round trip message integrity verification of the customer-provided encryption key.
 */
  public let sSECustomerKeyMD5: String?
/**
If server-side encryption with a customer-provided encryption key was requested, the response will include this header confirming the encryption algorithm used.
 */
  public let sSECustomerAlgorithm: String?
/**
The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).
 */
  public let serverSideEncryption: Serversideencryption?
/**

 */
  public let requestCharged: Requestcharged?


  static func deserialize(response: HTTPURLResponse, json: Any) -> CopyObjectOutput {
    let jsonDict = json as! [String: Any]
    return CopyObjectOutput(
        copyObjectResult: jsonDict["CopyObjectResult"].flatMap { ($0 is NSNull) ? nil : CopyObjectResult.deserialize(response: response, json: $0) },
      expiration: response.allHeaderFields["x-amz-expiration"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      versionId: response.allHeaderFields["x-amz-version-id"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      copySourceVersionId: response.allHeaderFields["x-amz-copy-source-version-id"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      sSEKMSKeyId: response.allHeaderFields["x-amz-server-side-encryption-aws-kms-key-id"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      sSECustomerKeyMD5: response.allHeaderFields["x-amz-server-side-encryption-customer-key-MD5"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      sSECustomerAlgorithm: response.allHeaderFields["x-amz-server-side-encryption-customer-algorithm"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, json: $0) },
      serverSideEncryption: response.allHeaderFields["x-amz-server-side-encryption"].flatMap { ($0 is NSNull) ? nil : Serversideencryption.deserialize(response: response, json: $0) },
      requestCharged: response.allHeaderFields["x-amz-request-charged"].flatMap { ($0 is NSNull) ? nil : Requestcharged.deserialize(response: response, json: $0) }
    )
  }

/**
    - parameters:
      - copyObjectResult: 
      - expiration: If the object expiration is configured, the response includes this header.
      - versionId: Version ID of the newly created copy.
      - copySourceVersionId: 
      - sSEKMSKeyId: If present, specifies the ID of the AWS Key Management Service (KMS) master encryption key that was used for the object.
      - sSECustomerKeyMD5: If server-side encryption with a customer-provided encryption key was requested, the response will include this header to provide round trip message integrity verification of the customer-provided encryption key.
      - sSECustomerAlgorithm: If server-side encryption with a customer-provided encryption key was requested, the response will include this header confirming the encryption algorithm used.
      - serverSideEncryption: The Server-side encryption algorithm used when storing this object in S3 (e.g., AES256, aws:kms).
      - requestCharged: 
 */
  public init(copyObjectResult: CopyObjectResult?, expiration: String?, versionId: String?, copySourceVersionId: String?, sSEKMSKeyId: String?, sSECustomerKeyMD5: String?, sSECustomerAlgorithm: String?, serverSideEncryption: Serversideencryption?, requestCharged: Requestcharged?) {
self.copyObjectResult = copyObjectResult
self.expiration = expiration
self.versionId = versionId
self.copySourceVersionId = copySourceVersionId
self.sSEKMSKeyId = sSEKMSKeyId
self.sSECustomerKeyMD5 = sSECustomerKeyMD5
self.sSECustomerAlgorithm = sSECustomerAlgorithm
self.serverSideEncryption = serverSideEncryption
self.requestCharged = requestCharged
  }
}

}
