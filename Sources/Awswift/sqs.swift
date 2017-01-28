import Foundation
import Signer
struct Sqs {
  struct Client {
    let region: String
    let credentialsProvider: AwsCredentialsProvider
    let session: URLSession
    let queue: DispatchQueue

    init(region: String) {
      self.region = region
      self.credentialsProvider = DefaultChainProvider()
      self.session = URLSession(configuration: URLSessionConfiguration.default)
      self.queue = DispatchQueue(label: "awswift.Sqs.Client.queue")
    }

    func scope() -> AwsCredentialsScope {
      return AwsCredentialsScope(url: URL(string: "https://")!)!
    }

/**
<p>Adds a permission to a queue for a specific <a href="http://docs.aws.amazon.com/general/latest/gr/glos-chap.html#P">principal</a>. This allows for sharing access to the queue.</p> <p>When you create a queue, you have full control access rights for the queue. Only you (as owner of the queue) can grant or deny permissions to the queue. For more information about these permissions, see <a href="http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/acp-overview.html">Shared Queues</a> in the <i>Amazon SQS Developer Guide</i>.</p> <note> <p><code>AddPermission</code> writes an Amazon SQS-generated policy. If you want to write your own policy, use <a>SetQueueAttributes</a> to upload your policy. For more information about writing your own policy, see <a href="http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/AccessPolicyLanguage.html">Using The Access Policy Language</a> in the <i>Amazon SQS Developer Guide</i>.</p> </note> <note><p>Some API actions take lists of parameters. These lists are specified using the <code>param.n</code> notation. Values of <code>n</code> are integers starting from 1. For example, a parameter list with two elements looks like this:</p> </note> <p><code><![CDATA[&amp;Attribute.1=this]]></code></p> <p><code><![CDATA[&amp;Attribute.2=that]]></code></p>
 */
func addPermission(input: AddPermissionRequest) -> ApiCallTask<AwsApiVoidOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://sqs.\(self.region).amazonaws.com/", 
      httpMethod: "POST", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p>Changes the visibility timeout of a specified message in a queue to a new value. The maximum allowed timeout value you can set the value to is 12 hours. This means you can't extend the timeout of a message in an existing queue to more than a total visibility timeout of 12 hours. (For more information visibility timeout, see <a href="http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/AboutVT.html">Visibility Timeout</a> in the <i>Amazon SQS Developer Guide</i>.)</p> <p>For example, let's say you have a message and its default message visibility timeout is 5 minutes. After 3 minutes, you call <code>ChangeMessageVisiblity</code> with a timeout of 10 minutes. At that time, the timeout for the message would be extended by 10 minutes beyond the time of the ChangeMessageVisibility call. This results in a total visibility timeout of 13 minutes. You can continue to call ChangeMessageVisibility to extend the visibility timeout to a maximum of 12 hours. If you try to extend beyond 12 hours, the request will be rejected.</p> <note><p>There is a 120,000 limit for the number of inflight messages per queue. Messages are inflight after they have been received from the queue by a consuming component, but have not yet been deleted from the queue. If you reach the 120,000 limit, you will receive an OverLimit error message from Amazon SQS. To help avoid reaching the limit, you should delete the messages from the queue after they have been processed. You can also increase the number of queues you use to process the messages. </p></note> <important><p>If you attempt to set the <code>VisibilityTimeout</code> to an amount more than the maximum time left, Amazon SQS returns an error. It will not automatically recalculate and increase the timeout to the maximum time remaining.</p></important> <important><p>Unlike with a queue, when you change the visibility timeout for a specific message, that timeout value is applied immediately but is not saved in memory for that message. If you don't delete a message after it is received, the visibility timeout for the message the next time it is received reverts to the original timeout value, not the value you set with the <code>ChangeMessageVisibility</code> action.</p></important>
 */
func changeMessageVisibility(input: ChangeMessageVisibilityRequest) -> ApiCallTask<AwsApiVoidOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://sqs.\(self.region).amazonaws.com/", 
      httpMethod: "POST", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p>Changes the visibility timeout of multiple messages. This is a batch version of <a>ChangeMessageVisibility</a>. The result of the action on each message is reported individually in the response. You can send up to 10 <a>ChangeMessageVisibility</a> requests with each <code>ChangeMessageVisibilityBatch</code> action.</p> <important><p>Because the batch request can result in a combination of successful and unsuccessful actions, you should check for batch errors even when the call returns an HTTP status code of 200.</p></important> <note><p>Some API actions take lists of parameters. These lists are specified using the <code>param.n</code> notation. Values of <code>n</code> are integers starting from 1. For example, a parameter list with two elements looks like this:</p> </note> <p><code><![CDATA[&amp;Attribute.1=this]]></code></p> <p><code><![CDATA[&amp;Attribute.2=that]]></code></p>
 */
func changeMessageVisibilityBatch(input: ChangeMessageVisibilityBatchRequest) -> ApiCallTask<ChangeMessageVisibilityBatchResult> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://sqs.\(self.region).amazonaws.com/", 
      httpMethod: "POST", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p>Creates a new queue, or returns the URL of an existing one. When you request <code>CreateQueue</code>, you provide a name for the queue. To successfully create a new queue, you must provide a name that is unique within the scope of your own queues.</p> <note> <p>If you delete a queue, you must wait at least 60 seconds before creating a queue with the same name.</p> </note> <p>You may pass one or more attributes in the request. If you do not provide a value for any attribute, the queue will have the default value for that attribute.</p> <note><p>Use <a>GetQueueUrl</a> to get a queue's URL. <a>GetQueueUrl</a> requires only the <code>QueueName</code> parameter.</p></note> <p>If you provide the name of an existing queue, along with the exact names and values of all the queue's attributes, <code>CreateQueue</code> returns the queue URL for the existing queue. If the queue name, attribute names, or attribute values do not match an existing queue, <code>CreateQueue</code> returns an error.</p> <note><p>Some API actions take lists of parameters. These lists are specified using the <code>param.n</code> notation. Values of <code>n</code> are integers starting from 1. For example, a parameter list with two elements looks like this:</p> </note> <p><code><![CDATA[&amp;Attribute.1=this]]></code></p> <p><code><![CDATA[&amp;Attribute.2=that]]></code></p>
 */
func createQueue(input: CreateQueueRequest) -> ApiCallTask<CreateQueueResult> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://sqs.\(self.region).amazonaws.com/", 
      httpMethod: "POST", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p> Deletes the specified message from the specified queue. You specify the message by using the message's <code>receipt handle</code> and not the <code>message ID</code> you received when you sent the message. Even if the message is locked by another reader due to the visibility timeout setting, it is still deleted from the queue. If you leave a message in the queue for longer than the queue's configured retention period, Amazon SQS automatically deletes it. </p> <note> <p> The receipt handle is associated with a specific instance of receiving the message. If you receive a message more than once, the receipt handle you get each time you receive the message is different. When you request <code>DeleteMessage</code>, if you don't provide the most recently received receipt handle for the message, the request will still succeed, but the message might not be deleted. </p> </note> <important> <p> It is possible you will receive a message even after you have deleted it. This might happen on rare occasions if one of the servers storing a copy of the message is unavailable when you request to delete the message. The copy remains on the server and might be returned to you again on a subsequent receive request. You should create your system to be idempotent so that receiving a particular message more than once is not a problem. </p> </important>
 */
func deleteMessage(input: DeleteMessageRequest) -> ApiCallTask<AwsApiVoidOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://sqs.\(self.region).amazonaws.com/", 
      httpMethod: "POST", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p>Deletes up to ten messages from the specified queue. This is a batch version of <a>DeleteMessage</a>. The result of the delete action on each message is reported individually in the response.</p> <important> <p> Because the batch request can result in a combination of successful and unsuccessful actions, you should check for batch errors even when the call returns an HTTP status code of 200. </p> </important> <note><p>Some API actions take lists of parameters. These lists are specified using the <code>param.n</code> notation. Values of <code>n</code> are integers starting from 1. For example, a parameter list with two elements looks like this:</p> </note> <p><code><![CDATA[&amp;Attribute.1=this]]></code></p> <p><code><![CDATA[&amp;Attribute.2=that]]></code></p>
 */
func deleteMessageBatch(input: DeleteMessageBatchRequest) -> ApiCallTask<DeleteMessageBatchResult> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://sqs.\(self.region).amazonaws.com/", 
      httpMethod: "POST", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p> Deletes the queue specified by the <b>queue URL</b>, regardless of whether the queue is empty. If the specified queue does not exist, Amazon SQS returns a successful response. </p> <important> <p> Use <code>DeleteQueue</code> with care; once you delete your queue, any messages in the queue are no longer available. </p> </important> <p> When you delete a queue, the deletion process takes up to 60 seconds. Requests you send involving that queue during the 60 seconds might succeed. For example, a <a>SendMessage</a> request might succeed, but after the 60 seconds, the queue and that message you sent no longer exist. Also, when you delete a queue, you must wait at least 60 seconds before creating a queue with the same name. </p> <p> We reserve the right to delete queues that have had no activity for more than 30 days. For more information, see <a href="http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/SQSConcepts.html">How Amazon SQS Queues Work</a> in the <i>Amazon SQS Developer Guide</i>. </p>
 */
func deleteQueue(input: DeleteQueueRequest) -> ApiCallTask<AwsApiVoidOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://sqs.\(self.region).amazonaws.com/", 
      httpMethod: "POST", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p>Gets attributes for the specified queue.</p> <note><p>Some API actions take lists of parameters. These lists are specified using the <code>param.n</code> notation. Values of <code>n</code> are integers starting from 1. For example, a parameter list with two elements looks like this:</p> </note> <p><code><![CDATA[&amp;Attribute.1=this]]></code></p> <p><code><![CDATA[&amp;Attribute.2=that]]></code></p>
 */
func getQueueAttributes(input: GetQueueAttributesRequest) -> ApiCallTask<GetQueueAttributesResult> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://sqs.\(self.region).amazonaws.com/", 
      httpMethod: "POST", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p> Returns the URL of an existing queue. This action provides a simple way to retrieve the URL of an Amazon SQS queue. </p> <p> To access a queue that belongs to another AWS account, use the <code>QueueOwnerAWSAccountId</code> parameter to specify the account ID of the queue's owner. The queue's owner must grant you permission to access the queue. For more information about shared queue access, see <a>AddPermission</a> or go to <a href="http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/acp-overview.html">Shared Queues</a> in the <i>Amazon SQS Developer Guide</i>. </p>
 */
func getQueueUrl(input: GetQueueUrlRequest) -> ApiCallTask<GetQueueUrlResult> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://sqs.\(self.region).amazonaws.com/", 
      httpMethod: "POST", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p>Returns a list of your queues that have the RedrivePolicy queue attribute configured with a dead letter queue.</p> <p>For more information about using dead letter queues, see <a href="http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/SQSDeadLetterQueue.html">Using Amazon SQS Dead Letter Queues</a>.</p>
 */
func listDeadLetterSourceQueues(input: ListDeadLetterSourceQueuesRequest) -> ApiCallTask<ListDeadLetterSourceQueuesResult> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://sqs.\(self.region).amazonaws.com/", 
      httpMethod: "POST", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p>Returns a list of your queues. The maximum number of queues that can be returned is 1000. If you specify a value for the optional <code>QueueNamePrefix</code> parameter, only queues with a name beginning with the specified value are returned.</p>
 */
func listQueues(input: ListQueuesRequest) -> ApiCallTask<ListQueuesResult> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://sqs.\(self.region).amazonaws.com/", 
      httpMethod: "POST", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p>Deletes the messages in a queue specified by the <b>queue URL</b>.</p> <important><p>When you use the <code>PurgeQueue</code> API, the deleted messages in the queue cannot be retrieved.</p></important> <p>When you purge a queue, the message deletion process takes up to 60 seconds. All messages sent to the queue before calling <code>PurgeQueue</code> will be deleted; messages sent to the queue while it is being purged may be deleted. While the queue is being purged, messages sent to the queue before <code>PurgeQueue</code> was called may be received, but will be deleted within the next minute.</p>
 */
func purgeQueue(input: PurgeQueueRequest) -> ApiCallTask<AwsApiVoidOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://sqs.\(self.region).amazonaws.com/", 
      httpMethod: "POST", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p> Retrieves one or more messages, with a maximum limit of 10 messages, from the specified queue. Long poll support is enabled by using the <code>WaitTimeSeconds</code> parameter. For more information, see <a href="http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-long-polling.html">Amazon SQS Long Poll</a> in the <i>Amazon SQS Developer Guide</i>. </p> <p> Short poll is the default behavior where a weighted random set of machines is sampled on a <code>ReceiveMessage</code> call. This means only the messages on the sampled machines are returned. If the number of messages in the queue is small (less than 1000), it is likely you will get fewer messages than you requested per <code>ReceiveMessage</code> call. If the number of messages in the queue is extremely small, you might not receive any messages in a particular <code>ReceiveMessage</code> response; in which case you should repeat the request. </p> <p> For each message returned, the response includes the following: </p> <ul> <li> <p> Message body </p> </li> <li> <p> MD5 digest of the message body. For information about MD5, go to <a href="http://www.faqs.org/rfcs/rfc1321.html">http://www.faqs.org/rfcs/rfc1321.html</a>. </p> </li> <li> <p> Message ID you received when you sent the message to the queue. </p> </li> <li> <p> Receipt handle. </p> </li> <li> <p> Message attributes. </p> </li> <li> <p> MD5 digest of the message attributes. </p> </li> </ul> <p> The receipt handle is the identifier you must provide when deleting the message. For more information, see <a href="http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/ImportantIdentifiers.html">Queue and Message Identifiers</a> in the <i>Amazon SQS Developer Guide</i>. </p> <p> You can provide the <code>VisibilityTimeout</code> parameter in your request, which will be applied to the messages that Amazon SQS returns in the response. If you do not include the parameter, the overall visibility timeout for the queue is used for the returned messages. For more information, see <a href="http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/AboutVT.html">Visibility Timeout</a> in the <i>Amazon SQS Developer Guide</i>. </p> <note> <p> Going forward, new attributes might be added. If you are writing code that calls this action, we recommend that you structure your code so that it can handle new attributes gracefully. </p> </note>
 */
func receiveMessage(input: ReceiveMessageRequest) -> ApiCallTask<ReceiveMessageResult> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://sqs.\(self.region).amazonaws.com/", 
      httpMethod: "POST", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p>Revokes any permissions in the queue policy that matches the specified <code>Label</code> parameter. Only the owner of the queue can remove permissions.</p>
 */
func removePermission(input: RemovePermissionRequest) -> ApiCallTask<AwsApiVoidOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://sqs.\(self.region).amazonaws.com/", 
      httpMethod: "POST", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p> Delivers a message to the specified queue. With Amazon SQS, you now have the ability to send large payload messages that are up to 256KB (262,144 bytes) in size. To send large payloads, you must use an AWS SDK that supports SigV4 signing. To verify whether SigV4 is supported for an AWS SDK, check the SDK release notes. </p> <important> <p> The following list shows the characters (in Unicode) allowed in your message, according to the W3C XML specification. For more information, go to <a href="http://www.w3.org/TR/REC-xml/#charsets">http://www.w3.org/TR/REC-xml/#charsets</a> If you send any characters not included in the list, your request will be rejected. </p> <p> #x9 | #xA | #xD | [#x20 to #xD7FF] | [#xE000 to #xFFFD] | [#x10000 to #x10FFFF] </p> </important>
 */
func sendMessage(input: SendMessageRequest) -> ApiCallTask<SendMessageResult> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://sqs.\(self.region).amazonaws.com/", 
      httpMethod: "POST", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p>Delivers up to ten messages to the specified queue. This is a batch version of <a>SendMessage</a>. The result of the send action on each message is reported individually in the response. The maximum allowed individual message size is 256 KB (262,144 bytes).</p> <p>The maximum total payload size (i.e., the sum of all a batch's individual message lengths) is also 256 KB (262,144 bytes).</p> <p>If the <code>DelaySeconds</code> parameter is not specified for an entry, the default for the queue is used.</p> <important><p>The following list shows the characters (in Unicode) that are allowed in your message, according to the W3C XML specification. For more information, go to <a href="http://www.faqs.org/rfcs/rfc1321.html">http://www.faqs.org/rfcs/rfc1321.html</a>. If you send any characters that are not included in the list, your request will be rejected.</p> <p>#x9 | #xA | #xD | [#x20 to #xD7FF] | [#xE000 to #xFFFD] | [#x10000 to #x10FFFF]</p> </important> <important> <p>Because the batch request can result in a combination of successful and unsuccessful actions, you should check for batch errors even when the call returns an HTTP status code of 200.</p> </important> <note><p>Some API actions take lists of parameters. These lists are specified using the <code>param.n</code> notation. Values of <code>n</code> are integers starting from 1. For example, a parameter list with two elements looks like this: </p> </note> <p><code><![CDATA[&amp;Attribute.1=this]]></code></p> <p><code><![CDATA[&amp;Attribute.2=that]]></code></p>
 */
func sendMessageBatch(input: SendMessageBatchRequest) -> ApiCallTask<SendMessageBatchResult> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://sqs.\(self.region).amazonaws.com/", 
      httpMethod: "POST", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p>Sets the value of one or more queue attributes. When you change a queue's attributes, the change can take up to 60 seconds for most of the attributes to propagate throughout the SQS system. Changes made to the <code>MessageRetentionPeriod</code> attribute can take up to 15 minutes.</p> <note><p>Going forward, new attributes might be added. If you are writing code that calls this action, we recommend that you structure your code so that it can handle new attributes gracefully.</p></note>
 */
func setQueueAttributes(input: SetQueueAttributesRequest) -> ApiCallTask<AwsApiVoidOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://sqs.\(self.region).amazonaws.com/", 
      httpMethod: "POST", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


  }


/**
<p/>
 */
public struct AddPermissionRequest: AwswiftSerializable {
/**
<p>The AWS account number of the <a href="http://docs.aws.amazon.com/general/latest/gr/glos-chap.html#P">principal</a> who will be given permission. The principal must have an AWS account, but does not need to be signed up for Amazon SQS. For information about locating the AWS account identification, see <a href="http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/AWSCredentials.html">Your AWS Identifiers</a> in the <i>Amazon SQS Developer Guide</i>.</p>
 */
  public let aWSAccountIds: [String]
/**
<p>The action the client wants to allow for the specified principal. The following are valid values: <code>* | SendMessage | ReceiveMessage | DeleteMessage | ChangeMessageVisibility | GetQueueAttributes | GetQueueUrl</code>. For more information about these actions, see <a href="http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/acp-overview.html#PermissionTypes">Understanding Permissions</a> in the <i>Amazon SQS Developer Guide</i>.</p> <p>Specifying <code>SendMessage</code>, <code>DeleteMessage</code>, or <code>ChangeMessageVisibility</code> for the <code>ActionName.n</code> also grants permissions for the corresponding batch versions of those actions: <code>SendMessageBatch</code>, <code>DeleteMessageBatch</code>, and <code>ChangeMessageVisibilityBatch</code>.</p>
 */
  public let actions: [String]
/**
<p>The unique identification of the permission you're setting (e.g., <code>AliceSendMessage</code>). Constraints: Maximum 80 characters; alphanumeric characters, hyphens (-), and underscores (_) are allowed.</p>
 */
  public let label: String
/**
<p>The URL of the Amazon SQS queue to take action on.</p> <p>Queue URLs are case-sensitive.</p>
 */
  public let queueUrl: String

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["AWSAccountIds"] = aWSAccountIds
    body["Actions"] = actions
    body["Label"] = label
    body["QueueUrl"] = queueUrl
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - aWSAccountIds: <p>The AWS account number of the <a href="http://docs.aws.amazon.com/general/latest/gr/glos-chap.html#P">principal</a> who will be given permission. The principal must have an AWS account, but does not need to be signed up for Amazon SQS. For information about locating the AWS account identification, see <a href="http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/AWSCredentials.html">Your AWS Identifiers</a> in the <i>Amazon SQS Developer Guide</i>.</p>
      - actions: <p>The action the client wants to allow for the specified principal. The following are valid values: <code>* | SendMessage | ReceiveMessage | DeleteMessage | ChangeMessageVisibility | GetQueueAttributes | GetQueueUrl</code>. For more information about these actions, see <a href="http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/acp-overview.html#PermissionTypes">Understanding Permissions</a> in the <i>Amazon SQS Developer Guide</i>.</p> <p>Specifying <code>SendMessage</code>, <code>DeleteMessage</code>, or <code>ChangeMessageVisibility</code> for the <code>ActionName.n</code> also grants permissions for the corresponding batch versions of those actions: <code>SendMessageBatch</code>, <code>DeleteMessageBatch</code>, and <code>ChangeMessageVisibilityBatch</code>.</p>
      - label: <p>The unique identification of the permission you're setting (e.g., <code>AliceSendMessage</code>). Constraints: Maximum 80 characters; alphanumeric characters, hyphens (-), and underscores (_) are allowed.</p>
      - queueUrl: <p>The URL of the Amazon SQS queue to take action on.</p> <p>Queue URLs are case-sensitive.</p>
 */
  public init(aWSAccountIds: [String], actions: [String], label: String, queueUrl: String) {
self.aWSAccountIds = aWSAccountIds
self.actions = actions
self.label = label
self.queueUrl = queueUrl
  }
}



/**
<p>Two or more batch entries have the same <code>Id</code> in the request.</p>
 */
public struct BatchEntryIdsNotDistinct: AwswiftSerializable, AwswiftDeserializable {

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    fatalError()
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> BatchEntryIdsNotDistinct {
  
    return BatchEntryIdsNotDistinct(
  
    )
  }

/**
    - parameters:
 */
  public init() {
  }
}

/**
<p>The length of all the messages put together is more than the limit.</p>
 */
public struct BatchRequestTooLong: AwswiftSerializable, AwswiftDeserializable {

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    fatalError()
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> BatchRequestTooLong {
  
    return BatchRequestTooLong(
  
    )
  }

/**
    - parameters:
 */
  public init() {
  }
}

/**
<p>This is used in the responses of batch API to give a detailed description of the result of an action on each entry in the request.</p>
 */
public struct BatchResultErrorEntry: AwswiftSerializable, AwswiftDeserializable {
/**
<p>An error code representing why the action failed on this entry.</p>
 */
  public let code: String
/**
<p>The id of an entry in a batch request.</p>
 */
  public let id: String
/**
<p>A message explaining why the action failed on this entry.</p>
 */
  public let message: String?
/**
<p>Whether the error happened due to the sender's fault.</p>
 */
  public let senderFault: Bool

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["Code"] = code
    body["Id"] = id
    if message != nil { body["Message"] = message! }
    body["SenderFault"] = senderFault
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> BatchResultErrorEntry {
    guard case let .xml(node) = body else { fatalError() }
    return BatchResultErrorEntry(
        code: try! node.nodes(forXPath: "Code").first.map { String.deserialize(response: response, body: .xml($0)) }!,
      id: try! node.nodes(forXPath: "Id").first.map { String.deserialize(response: response, body: .xml($0)) }!,
      message: try! node.nodes(forXPath: "Message").first.map { String.deserialize(response: response, body: .xml($0)) },
      senderFault: try! node.nodes(forXPath: "SenderFault").first.map { Bool.deserialize(response: response, body: .xml($0)) }!
    )
  }

/**
    - parameters:
      - code: <p>An error code representing why the action failed on this entry.</p>
      - id: <p>The id of an entry in a batch request.</p>
      - message: <p>A message explaining why the action failed on this entry.</p>
      - senderFault: <p>Whether the error happened due to the sender's fault.</p>
 */
  public init(code: String, id: String, message: String?, senderFault: Bool) {
self.code = code
self.id = id
self.message = message
self.senderFault = senderFault
  }
}





/**
<p/>
 */
public struct ChangeMessageVisibilityBatchRequest: AwswiftSerializable {
/**
<p>A list of receipt handles of the messages for which the visibility timeout must be changed.</p>
 */
  public let entries: [ChangeMessageVisibilityBatchRequestEntry]
/**
<p>The URL of the Amazon SQS queue to take action on.</p> <p>Queue URLs are case-sensitive.</p>
 */
  public let queueUrl: String

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["Entries"] = entries
    body["QueueUrl"] = queueUrl
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - entries: <p>A list of receipt handles of the messages for which the visibility timeout must be changed.</p>
      - queueUrl: <p>The URL of the Amazon SQS queue to take action on.</p> <p>Queue URLs are case-sensitive.</p>
 */
  public init(entries: [ChangeMessageVisibilityBatchRequestEntry], queueUrl: String) {
self.entries = entries
self.queueUrl = queueUrl
  }
}

/**
<p>Encloses a receipt handle and an entry id for each message in <a>ChangeMessageVisibilityBatch</a>. </p> <important> <p>All of the following parameters are list parameters that must be prefixed with <code>ChangeMessageVisibilityBatchRequestEntry.n</code>, where <code>n</code> is an integer value starting with 1. For example, a parameter list for this action might look like this:</p> </important> <p><code><![CDATA[&amp;ChangeMessageVisibilityBatchRequestEntry.1.Id=change_visibility_msg_2]]></code></p> <p><code><![CDATA[&amp;ChangeMessageVisibilityBatchRequestEntry.1.ReceiptHandle=<replaceable>Your_Receipt_Handle</replaceable>]]></code></p> <p><code><![CDATA[&amp;ChangeMessageVisibilityBatchRequestEntry.1.VisibilityTimeout=45]]></code></p>
 */
public struct ChangeMessageVisibilityBatchRequestEntry: AwswiftSerializable, AwswiftDeserializable {
/**
<p>An identifier for this particular receipt handle. This is used to communicate the result. Note that the <code>Id</code>s of a batch request need to be unique within the request.</p>
 */
  public let id: String
/**
<p>A receipt handle.</p>
 */
  public let receiptHandle: String
/**
<p>The new value (in seconds) for the message's visibility timeout.</p>
 */
  public let visibilityTimeout: Int?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["Id"] = id
    body["ReceiptHandle"] = receiptHandle
    if visibilityTimeout != nil { body["VisibilityTimeout"] = visibilityTimeout! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> ChangeMessageVisibilityBatchRequestEntry {
    guard case let .xml(node) = body else { fatalError() }
    return ChangeMessageVisibilityBatchRequestEntry(
        id: try! node.nodes(forXPath: "Id").first.map { String.deserialize(response: response, body: .xml($0)) }!,
      receiptHandle: try! node.nodes(forXPath: "ReceiptHandle").first.map { String.deserialize(response: response, body: .xml($0)) }!,
      visibilityTimeout: try! node.nodes(forXPath: "VisibilityTimeout").first.map { Int.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - id: <p>An identifier for this particular receipt handle. This is used to communicate the result. Note that the <code>Id</code>s of a batch request need to be unique within the request.</p>
      - receiptHandle: <p>A receipt handle.</p>
      - visibilityTimeout: <p>The new value (in seconds) for the message's visibility timeout.</p>
 */
  public init(id: String, receiptHandle: String, visibilityTimeout: Int?) {
self.id = id
self.receiptHandle = receiptHandle
self.visibilityTimeout = visibilityTimeout
  }
}


/**
<p> For each message in the batch, the response contains a <a>ChangeMessageVisibilityBatchResultEntry</a> tag if the message succeeds or a <a>BatchResultErrorEntry</a> tag if the message fails. </p>
 */
public struct ChangeMessageVisibilityBatchResult: AwswiftSerializable, AwswiftDeserializable {
/**
<p>A list of <a>BatchResultErrorEntry</a> items.</p>
 */
  public let failed: [BatchResultErrorEntry]
/**
<p>A list of <a>ChangeMessageVisibilityBatchResultEntry</a> items.</p>
 */
  public let successful: [ChangeMessageVisibilityBatchResultEntry]

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["Failed"] = failed
    body["Successful"] = successful
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> ChangeMessageVisibilityBatchResult {
    guard case let .xml(node) = body else { fatalError() }
    return ChangeMessageVisibilityBatchResult(
        failed: try! node.nodes(forXPath: "Failed").map { BatchResultErrorEntry.deserialize(response: response, body: .xml($0)) },
      successful: try! node.nodes(forXPath: "Successful").map { ChangeMessageVisibilityBatchResultEntry.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - failed: <p>A list of <a>BatchResultErrorEntry</a> items.</p>
      - successful: <p>A list of <a>ChangeMessageVisibilityBatchResultEntry</a> items.</p>
 */
  public init(failed: [BatchResultErrorEntry], successful: [ChangeMessageVisibilityBatchResultEntry]) {
self.failed = failed
self.successful = successful
  }
}

/**
<p>Encloses the id of an entry in <a>ChangeMessageVisibilityBatch</a>.</p>
 */
public struct ChangeMessageVisibilityBatchResultEntry: AwswiftSerializable, AwswiftDeserializable {
/**
<p>Represents a message whose visibility timeout has been changed successfully.</p>
 */
  public let id: String

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["Id"] = id
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> ChangeMessageVisibilityBatchResultEntry {
    guard case let .xml(node) = body else { fatalError() }
    return ChangeMessageVisibilityBatchResultEntry(
        id: try! node.nodes(forXPath: "Id").first.map { String.deserialize(response: response, body: .xml($0)) }!
    )
  }

/**
    - parameters:
      - id: <p>Represents a message whose visibility timeout has been changed successfully.</p>
 */
  public init(id: String) {
self.id = id
  }
}


public struct ChangeMessageVisibilityRequest: AwswiftSerializable {
/**
<p>The URL of the Amazon SQS queue to take action on.</p> <p>Queue URLs are case-sensitive.</p>
 */
  public let queueUrl: String
/**
<p>The receipt handle associated with the message whose visibility timeout should be changed. This parameter is returned by the <a>ReceiveMessage</a> action.</p>
 */
  public let receiptHandle: String
/**
<p>The new value (in seconds - from 0 to 43200 - maximum 12 hours) for the message's visibility timeout.</p>
 */
  public let visibilityTimeout: Int

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["QueueUrl"] = queueUrl
    body["ReceiptHandle"] = receiptHandle
    body["VisibilityTimeout"] = visibilityTimeout
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - queueUrl: <p>The URL of the Amazon SQS queue to take action on.</p> <p>Queue URLs are case-sensitive.</p>
      - receiptHandle: <p>The receipt handle associated with the message whose visibility timeout should be changed. This parameter is returned by the <a>ReceiveMessage</a> action.</p>
      - visibilityTimeout: <p>The new value (in seconds - from 0 to 43200 - maximum 12 hours) for the message's visibility timeout.</p>
 */
  public init(queueUrl: String, receiptHandle: String, visibilityTimeout: Int) {
self.queueUrl = queueUrl
self.receiptHandle = receiptHandle
self.visibilityTimeout = visibilityTimeout
  }
}

/**
<p/>
 */
public struct CreateQueueRequest: AwswiftSerializable {
/**
<p>A map of attributes with their corresponding values.</p> <p>The following lists the names, descriptions, and values of the special request parameters the <code>CreateQueue</code> action uses:</p> <ul> <li><p><code>DelaySeconds</code> - The time in seconds that the delivery of all messages in the queue will be delayed. An integer from 0 to 900 (15 minutes). The default for this attribute is 0 (zero).</p></li> <li><p><code>MaximumMessageSize</code> - The limit of how many bytes a message can contain before Amazon SQS rejects it. An integer from 1024 bytes (1 KiB) up to 262144 bytes (256 KiB). The default for this attribute is 262144 (256 KiB).</p></li> <li><p><code>MessageRetentionPeriod</code> - The number of seconds Amazon SQS retains a message. Integer representing seconds, from 60 (1 minute) to 1209600 (14 days). The default for this attribute is 345600 (4 days).</p></li> <li><p><code>Policy</code> - The queue's policy. A valid AWS policy. For more information about policy structure, see <a href="http://docs.aws.amazon.com/IAM/latest/UserGuide/PoliciesOverview.html">Overview of AWS IAM Policies</a> in the <i>Amazon IAM User Guide</i>.</p></li> <li><p><code>ReceiveMessageWaitTimeSeconds</code> - The time for which a <a>ReceiveMessage</a> call will wait for a message to arrive. An integer from 0 to 20 (seconds). The default for this attribute is 0.</p></li> <li><p><code>RedrivePolicy</code> - The parameters for dead letter queue functionality of the source queue. For more information about RedrivePolicy and dead letter queues, see <a href="http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/SQSDeadLetterQueue.html">Using Amazon SQS Dead Letter Queues</a> in the <i>Amazon SQS Developer Guide</i>.</p></li> <li><p><code>VisibilityTimeout</code> - The visibility timeout for the queue. An integer from 0 to 43200 (12 hours). The default for this attribute is 30. For more information about visibility timeout, see <a href="http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/AboutVT.html">Visibility Timeout</a> in the <i>Amazon SQS Developer Guide</i>.</p></li> </ul> <p>Any other valid special request parameters that are specified (such as <code>ApproximateNumberOfMessages</code>, <code>ApproximateNumberOfMessagesDelayed</code>, <code>ApproximateNumberOfMessagesNotVisible</code>, <code>CreatedTimestamp</code>, <code>LastModifiedTimestamp</code>, and <code>QueueArn</code>) will be ignored.</p>
 */
  public let attributes: [Queueattributename: String]?
/**
<p>The name for the queue to be created.</p> <p>Queue names are case-sensitive.</p>
 */
  public let queueName: String

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if attributes != nil { body["Attribute"] = attributes! }
    body["QueueName"] = queueName
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - attributes: <p>A map of attributes with their corresponding values.</p> <p>The following lists the names, descriptions, and values of the special request parameters the <code>CreateQueue</code> action uses:</p> <ul> <li><p><code>DelaySeconds</code> - The time in seconds that the delivery of all messages in the queue will be delayed. An integer from 0 to 900 (15 minutes). The default for this attribute is 0 (zero).</p></li> <li><p><code>MaximumMessageSize</code> - The limit of how many bytes a message can contain before Amazon SQS rejects it. An integer from 1024 bytes (1 KiB) up to 262144 bytes (256 KiB). The default for this attribute is 262144 (256 KiB).</p></li> <li><p><code>MessageRetentionPeriod</code> - The number of seconds Amazon SQS retains a message. Integer representing seconds, from 60 (1 minute) to 1209600 (14 days). The default for this attribute is 345600 (4 days).</p></li> <li><p><code>Policy</code> - The queue's policy. A valid AWS policy. For more information about policy structure, see <a href="http://docs.aws.amazon.com/IAM/latest/UserGuide/PoliciesOverview.html">Overview of AWS IAM Policies</a> in the <i>Amazon IAM User Guide</i>.</p></li> <li><p><code>ReceiveMessageWaitTimeSeconds</code> - The time for which a <a>ReceiveMessage</a> call will wait for a message to arrive. An integer from 0 to 20 (seconds). The default for this attribute is 0.</p></li> <li><p><code>RedrivePolicy</code> - The parameters for dead letter queue functionality of the source queue. For more information about RedrivePolicy and dead letter queues, see <a href="http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/SQSDeadLetterQueue.html">Using Amazon SQS Dead Letter Queues</a> in the <i>Amazon SQS Developer Guide</i>.</p></li> <li><p><code>VisibilityTimeout</code> - The visibility timeout for the queue. An integer from 0 to 43200 (12 hours). The default for this attribute is 30. For more information about visibility timeout, see <a href="http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/AboutVT.html">Visibility Timeout</a> in the <i>Amazon SQS Developer Guide</i>.</p></li> </ul> <p>Any other valid special request parameters that are specified (such as <code>ApproximateNumberOfMessages</code>, <code>ApproximateNumberOfMessagesDelayed</code>, <code>ApproximateNumberOfMessagesNotVisible</code>, <code>CreatedTimestamp</code>, <code>LastModifiedTimestamp</code>, and <code>QueueArn</code>) will be ignored.</p>
      - queueName: <p>The name for the queue to be created.</p> <p>Queue names are case-sensitive.</p>
 */
  public init(attributes: [Queueattributename: String]?, queueName: String) {
self.attributes = attributes
self.queueName = queueName
  }
}

/**
<p>Returns the QueueUrl element of the created queue.</p>
 */
public struct CreateQueueResult: AwswiftSerializable, AwswiftDeserializable {
/**
<p>The URL for the created Amazon SQS queue.</p>
 */
  public let queueUrl: String?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if queueUrl != nil { body["QueueUrl"] = queueUrl! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> CreateQueueResult {
    guard case let .xml(node) = body else { fatalError() }
    return CreateQueueResult(
        queueUrl: try! node.nodes(forXPath: "QueueUrl").first.map { String.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - queueUrl: <p>The URL for the created Amazon SQS queue.</p>
 */
  public init(queueUrl: String?) {
self.queueUrl = queueUrl
  }
}

/**
<p/>
 */
public struct DeleteMessageBatchRequest: AwswiftSerializable {
/**
<p>A list of receipt handles for the messages to be deleted.</p>
 */
  public let entries: [DeleteMessageBatchRequestEntry]
/**
<p>The URL of the Amazon SQS queue to take action on.</p> <p>Queue URLs are case-sensitive.</p>
 */
  public let queueUrl: String

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["Entries"] = entries
    body["QueueUrl"] = queueUrl
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - entries: <p>A list of receipt handles for the messages to be deleted.</p>
      - queueUrl: <p>The URL of the Amazon SQS queue to take action on.</p> <p>Queue URLs are case-sensitive.</p>
 */
  public init(entries: [DeleteMessageBatchRequestEntry], queueUrl: String) {
self.entries = entries
self.queueUrl = queueUrl
  }
}

/**
<p>Encloses a receipt handle and an identifier for it.</p>
 */
public struct DeleteMessageBatchRequestEntry: AwswiftSerializable, AwswiftDeserializable {
/**
<p>An identifier for this particular receipt handle. This is used to communicate the result. Note that the <code>Id</code>s of a batch request need to be unique within the request.</p>
 */
  public let id: String
/**
<p>A receipt handle.</p>
 */
  public let receiptHandle: String

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["Id"] = id
    body["ReceiptHandle"] = receiptHandle
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> DeleteMessageBatchRequestEntry {
    guard case let .xml(node) = body else { fatalError() }
    return DeleteMessageBatchRequestEntry(
        id: try! node.nodes(forXPath: "Id").first.map { String.deserialize(response: response, body: .xml($0)) }!,
      receiptHandle: try! node.nodes(forXPath: "ReceiptHandle").first.map { String.deserialize(response: response, body: .xml($0)) }!
    )
  }

/**
    - parameters:
      - id: <p>An identifier for this particular receipt handle. This is used to communicate the result. Note that the <code>Id</code>s of a batch request need to be unique within the request.</p>
      - receiptHandle: <p>A receipt handle.</p>
 */
  public init(id: String, receiptHandle: String) {
self.id = id
self.receiptHandle = receiptHandle
  }
}


/**
<p> For each message in the batch, the response contains a <a>DeleteMessageBatchResultEntry</a> tag if the message is deleted or a <a>BatchResultErrorEntry</a> tag if the message cannot be deleted. </p>
 */
public struct DeleteMessageBatchResult: AwswiftSerializable, AwswiftDeserializable {
/**
<p>A list of <a>BatchResultErrorEntry</a> items.</p>
 */
  public let failed: [BatchResultErrorEntry]
/**
<p>A list of <a>DeleteMessageBatchResultEntry</a> items.</p>
 */
  public let successful: [DeleteMessageBatchResultEntry]

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["Failed"] = failed
    body["Successful"] = successful
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> DeleteMessageBatchResult {
    guard case let .xml(node) = body else { fatalError() }
    return DeleteMessageBatchResult(
        failed: try! node.nodes(forXPath: "Failed").map { BatchResultErrorEntry.deserialize(response: response, body: .xml($0)) },
      successful: try! node.nodes(forXPath: "Successful").map { DeleteMessageBatchResultEntry.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - failed: <p>A list of <a>BatchResultErrorEntry</a> items.</p>
      - successful: <p>A list of <a>DeleteMessageBatchResultEntry</a> items.</p>
 */
  public init(failed: [BatchResultErrorEntry], successful: [DeleteMessageBatchResultEntry]) {
self.failed = failed
self.successful = successful
  }
}

/**
<p>Encloses the id an entry in <a>DeleteMessageBatch</a>.</p>
 */
public struct DeleteMessageBatchResultEntry: AwswiftSerializable, AwswiftDeserializable {
/**
<p>Represents a successfully deleted message.</p>
 */
  public let id: String

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["Id"] = id
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> DeleteMessageBatchResultEntry {
    guard case let .xml(node) = body else { fatalError() }
    return DeleteMessageBatchResultEntry(
        id: try! node.nodes(forXPath: "Id").first.map { String.deserialize(response: response, body: .xml($0)) }!
    )
  }

/**
    - parameters:
      - id: <p>Represents a successfully deleted message.</p>
 */
  public init(id: String) {
self.id = id
  }
}


/**
<p/>
 */
public struct DeleteMessageRequest: AwswiftSerializable {
/**
<p>The URL of the Amazon SQS queue to take action on.</p> <p>Queue URLs are case-sensitive.</p>
 */
  public let queueUrl: String
/**
<p>The receipt handle associated with the message to delete.</p>
 */
  public let receiptHandle: String

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["QueueUrl"] = queueUrl
    body["ReceiptHandle"] = receiptHandle
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - queueUrl: <p>The URL of the Amazon SQS queue to take action on.</p> <p>Queue URLs are case-sensitive.</p>
      - receiptHandle: <p>The receipt handle associated with the message to delete.</p>
 */
  public init(queueUrl: String, receiptHandle: String) {
self.queueUrl = queueUrl
self.receiptHandle = receiptHandle
  }
}

/**
<p/>
 */
public struct DeleteQueueRequest: AwswiftSerializable {
/**
<p>The URL of the Amazon SQS queue to take action on.</p> <p>Queue URLs are case-sensitive.</p>
 */
  public let queueUrl: String

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["QueueUrl"] = queueUrl
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - queueUrl: <p>The URL of the Amazon SQS queue to take action on.</p> <p>Queue URLs are case-sensitive.</p>
 */
  public init(queueUrl: String) {
self.queueUrl = queueUrl
  }
}

/**
<p>Batch request does not contain an entry.</p>
 */
public struct EmptyBatchRequest: AwswiftSerializable {

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
 */
  public init() {
  }
}

/**
<p/>
 */
public struct GetQueueAttributesRequest: AwswiftSerializable {
/**
<p>A list of attributes to retrieve information for. The following attributes are supported:</p> <ul> <li><p><code>All</code> - returns all values.</p></li> <li><p><code>ApproximateNumberOfMessages</code> - returns the approximate number of visible messages in a queue. For more information, see <a href="http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/ApproximateNumber.html">Resources Required to Process Messages</a> in the <i>Amazon SQS Developer Guide</i>.</p></li> <li><p><code>ApproximateNumberOfMessagesNotVisible</code> - returns the approximate number of messages that are not timed-out and not deleted. For more information, see <a href="http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/ApproximateNumber.html">Resources Required to Process Messages</a> in the <i>Amazon SQS Developer Guide</i>.</p></li> <li><p><code>VisibilityTimeout</code> - returns the visibility timeout for the queue. For more information about visibility timeout, see <a href="http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/AboutVT.html">Visibility Timeout</a> in the <i>Amazon SQS Developer Guide</i>.</p></li> <li><p><code>CreatedTimestamp</code> - returns the time when the queue was created (epoch time in seconds).</p></li> <li><p><code>LastModifiedTimestamp</code> - returns the time when the queue was last changed (epoch time in seconds).</p></li> <li><p><code>Policy</code> - returns the queue's policy.</p></li> <li><p><code>MaximumMessageSize</code> - returns the limit of how many bytes a message can contain before Amazon SQS rejects it.</p></li> <li><p><code>MessageRetentionPeriod</code> - returns the number of seconds Amazon SQS retains a message.</p></li> <li><p><code>QueueArn</code> - returns the queue's Amazon resource name (ARN).</p></li> <li><p><code>ApproximateNumberOfMessagesDelayed</code> - returns the approximate number of messages that are pending to be added to the queue.</p></li> <li><p><code>DelaySeconds</code> - returns the default delay on the queue in seconds.</p></li> <li><p><code>ReceiveMessageWaitTimeSeconds</code> - returns the time for which a ReceiveMessage call will wait for a message to arrive.</p></li> <li><p><code>RedrivePolicy</code> - returns the parameters for dead letter queue functionality of the source queue. For more information about RedrivePolicy and dead letter queues, see <a href="http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/SQSDeadLetterQueue.html">Using Amazon SQS Dead Letter Queues</a> in the <i>Amazon SQS Developer Guide</i>.</p></li> </ul> <note><p>Going forward, new attributes might be added. If you are writing code that calls this action, we recommend that you structure your code so that it can handle new attributes gracefully.</p></note>
 */
  public let attributeNames: [Queueattributename]?
/**
<p>The URL of the Amazon SQS queue to take action on.</p> <p>Queue URLs are case-sensitive.</p>
 */
  public let queueUrl: String

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if attributeNames != nil { body["AttributeNames"] = attributeNames! }
    body["QueueUrl"] = queueUrl
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - attributeNames: <p>A list of attributes to retrieve information for. The following attributes are supported:</p> <ul> <li><p><code>All</code> - returns all values.</p></li> <li><p><code>ApproximateNumberOfMessages</code> - returns the approximate number of visible messages in a queue. For more information, see <a href="http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/ApproximateNumber.html">Resources Required to Process Messages</a> in the <i>Amazon SQS Developer Guide</i>.</p></li> <li><p><code>ApproximateNumberOfMessagesNotVisible</code> - returns the approximate number of messages that are not timed-out and not deleted. For more information, see <a href="http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/ApproximateNumber.html">Resources Required to Process Messages</a> in the <i>Amazon SQS Developer Guide</i>.</p></li> <li><p><code>VisibilityTimeout</code> - returns the visibility timeout for the queue. For more information about visibility timeout, see <a href="http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/AboutVT.html">Visibility Timeout</a> in the <i>Amazon SQS Developer Guide</i>.</p></li> <li><p><code>CreatedTimestamp</code> - returns the time when the queue was created (epoch time in seconds).</p></li> <li><p><code>LastModifiedTimestamp</code> - returns the time when the queue was last changed (epoch time in seconds).</p></li> <li><p><code>Policy</code> - returns the queue's policy.</p></li> <li><p><code>MaximumMessageSize</code> - returns the limit of how many bytes a message can contain before Amazon SQS rejects it.</p></li> <li><p><code>MessageRetentionPeriod</code> - returns the number of seconds Amazon SQS retains a message.</p></li> <li><p><code>QueueArn</code> - returns the queue's Amazon resource name (ARN).</p></li> <li><p><code>ApproximateNumberOfMessagesDelayed</code> - returns the approximate number of messages that are pending to be added to the queue.</p></li> <li><p><code>DelaySeconds</code> - returns the default delay on the queue in seconds.</p></li> <li><p><code>ReceiveMessageWaitTimeSeconds</code> - returns the time for which a ReceiveMessage call will wait for a message to arrive.</p></li> <li><p><code>RedrivePolicy</code> - returns the parameters for dead letter queue functionality of the source queue. For more information about RedrivePolicy and dead letter queues, see <a href="http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/SQSDeadLetterQueue.html">Using Amazon SQS Dead Letter Queues</a> in the <i>Amazon SQS Developer Guide</i>.</p></li> </ul> <note><p>Going forward, new attributes might be added. If you are writing code that calls this action, we recommend that you structure your code so that it can handle new attributes gracefully.</p></note>
      - queueUrl: <p>The URL of the Amazon SQS queue to take action on.</p> <p>Queue URLs are case-sensitive.</p>
 */
  public init(attributeNames: [Queueattributename]?, queueUrl: String) {
self.attributeNames = attributeNames
self.queueUrl = queueUrl
  }
}

/**
<p>A list of returned queue attributes.</p>
 */
public struct GetQueueAttributesResult: AwswiftSerializable, AwswiftDeserializable {
/**
<p>A map of attributes to the respective values.</p>
 */
  public let attributes: [Queueattributename: String]?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if attributes != nil { body["Attribute"] = attributes! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> GetQueueAttributesResult {
    guard case let .xml(node) = body else { fatalError() }
    return GetQueueAttributesResult(
        attributes: try! node.nodes(forXPath: "Attribute").first.map { [Queueattributename: String].deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - attributes: <p>A map of attributes to the respective values.</p>
 */
  public init(attributes: [Queueattributename: String]?) {
self.attributes = attributes
  }
}

/**
<p/>
 */
public struct GetQueueUrlRequest: AwswiftSerializable {
/**
<p>The name of the queue whose URL must be fetched. Maximum 80 characters; alphanumeric characters, hyphens (-), and underscores (_) are allowed.</p> <p>Queue names are case-sensitive.</p>
 */
  public let queueName: String
/**
<p>The AWS account ID of the account that created the queue.</p>
 */
  public let queueOwnerAWSAccountId: String?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["QueueName"] = queueName
    if queueOwnerAWSAccountId != nil { body["QueueOwnerAWSAccountId"] = queueOwnerAWSAccountId! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - queueName: <p>The name of the queue whose URL must be fetched. Maximum 80 characters; alphanumeric characters, hyphens (-), and underscores (_) are allowed.</p> <p>Queue names are case-sensitive.</p>
      - queueOwnerAWSAccountId: <p>The AWS account ID of the account that created the queue.</p>
 */
  public init(queueName: String, queueOwnerAWSAccountId: String?) {
self.queueName = queueName
self.queueOwnerAWSAccountId = queueOwnerAWSAccountId
  }
}

/**
<p>For more information, see <a href="http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/UnderstandingResponses.html">Responses</a> in the <i>Amazon SQS Developer Guide</i>.</p>
 */
public struct GetQueueUrlResult: AwswiftSerializable, AwswiftDeserializable {
/**
<p>The URL for the queue.</p>
 */
  public let queueUrl: String?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if queueUrl != nil { body["QueueUrl"] = queueUrl! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> GetQueueUrlResult {
    guard case let .xml(node) = body else { fatalError() }
    return GetQueueUrlResult(
        queueUrl: try! node.nodes(forXPath: "QueueUrl").first.map { String.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - queueUrl: <p>The URL for the queue.</p>
 */
  public init(queueUrl: String?) {
self.queueUrl = queueUrl
  }
}


/**
<p>The attribute referred to does not exist.</p>
 */
public struct InvalidAttributeName: AwswiftSerializable, AwswiftDeserializable {

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    fatalError()
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> InvalidAttributeName {
  
    return InvalidAttributeName(
  
    )
  }

/**
    - parameters:
 */
  public init() {
  }
}

/**
<p>The <code>Id</code> of a batch entry in a batch request does not abide by the specification.</p>
 */
public struct InvalidBatchEntryId: AwswiftSerializable, AwswiftDeserializable {

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    fatalError()
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> InvalidBatchEntryId {
  
    return InvalidBatchEntryId(
  
    )
  }

/**
    - parameters:
 */
  public init() {
  }
}

/**
<p>The receipt handle is not valid for the current version.</p>
 */
public struct InvalidIdFormat: AwswiftSerializable, AwswiftDeserializable {

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    fatalError()
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> InvalidIdFormat {
  
    return InvalidIdFormat(
  
    )
  }

/**
    - parameters:
 */
  public init() {
  }
}

/**
<p>The message contains characters outside the allowed set.</p>
 */
public struct InvalidMessageContents: AwswiftSerializable, AwswiftDeserializable {

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    fatalError()
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> InvalidMessageContents {
  
    return InvalidMessageContents(
  
    )
  }

/**
    - parameters:
 */
  public init() {
  }
}

/**
<p/>
 */
public struct ListDeadLetterSourceQueuesRequest: AwswiftSerializable {
/**
<p>The queue URL of a dead letter queue.</p> <p>Queue URLs are case-sensitive.</p>
 */
  public let queueUrl: String

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["QueueUrl"] = queueUrl
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - queueUrl: <p>The queue URL of a dead letter queue.</p> <p>Queue URLs are case-sensitive.</p>
 */
  public init(queueUrl: String) {
self.queueUrl = queueUrl
  }
}

/**
<p>A list of your dead letter source queues.</p>
 */
public struct ListDeadLetterSourceQueuesResult: AwswiftSerializable, AwswiftDeserializable {
/**
<p>A list of source queue URLs that have the RedrivePolicy queue attribute configured with a dead letter queue.</p>
 */
  public let queueUrls: [String]

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["queueUrls"] = queueUrls
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> ListDeadLetterSourceQueuesResult {
    guard case let .xml(node) = body else { fatalError() }
    return ListDeadLetterSourceQueuesResult(
        queueUrls: try! node.nodes(forXPath: "queueUrls").map { String.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - queueUrls: <p>A list of source queue URLs that have the RedrivePolicy queue attribute configured with a dead letter queue.</p>
 */
  public init(queueUrls: [String]) {
self.queueUrls = queueUrls
  }
}

/**
<p/>
 */
public struct ListQueuesRequest: AwswiftSerializable {
/**
<p>A string to use for filtering the list results. Only those queues whose name begins with the specified string are returned.</p> <p>Queue names are case-sensitive.</p>
 */
  public let queueNamePrefix: String?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if queueNamePrefix != nil { body["QueueNamePrefix"] = queueNamePrefix! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - queueNamePrefix: <p>A string to use for filtering the list results. Only those queues whose name begins with the specified string are returned.</p> <p>Queue names are case-sensitive.</p>
 */
  public init(queueNamePrefix: String?) {
self.queueNamePrefix = queueNamePrefix
  }
}

/**
<p>A list of your queues.</p>
 */
public struct ListQueuesResult: AwswiftSerializable, AwswiftDeserializable {
/**
<p>A list of queue URLs, up to 1000 entries.</p>
 */
  public let queueUrls: [String]?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if queueUrls != nil { body["QueueUrls"] = queueUrls! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> ListQueuesResult {
    guard case let .xml(node) = body else { fatalError() }
    return ListQueuesResult(
        queueUrls: try! node.nodes(forXPath: "QueueUrls").map { String.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - queueUrls: <p>A list of queue URLs, up to 1000 entries.</p>
 */
  public init(queueUrls: [String]?) {
self.queueUrls = queueUrls
  }
}

/**
<p>An Amazon SQS message.</p>
 */
public struct Message: AwswiftSerializable, AwswiftDeserializable {
/**
<p><code>SenderId</code>, <code>SentTimestamp</code>, <code>ApproximateReceiveCount</code>, and/or <code>ApproximateFirstReceiveTimestamp</code>. <code>SentTimestamp</code> and <code>ApproximateFirstReceiveTimestamp</code> are each returned as an integer representing the <a href="http://en.wikipedia.org/wiki/Unix_time">epoch time</a> in milliseconds.</p>
 */
  public let attributes: [Queueattributename: String]?
/**
<p>The message's contents (not URL-encoded).</p>
 */
  public let sqsBody: String?
/**
<p>An MD5 digest of the non-URL-encoded message body string.</p>
 */
  public let mD5OfBody: String?
/**
<p>An MD5 digest of the non-URL-encoded message attribute string. This can be used to verify that Amazon SQS received the message correctly. Amazon SQS first URL decodes the message before creating the MD5 digest. For information about MD5, go to <a href="http://www.faqs.org/rfcs/rfc1321.html">http://www.faqs.org/rfcs/rfc1321.html</a>.</p>
 */
  public let mD5OfMessageAttributes: String?
/**
<p>Each message attribute consists of a Name, Type, and Value. For more information, see <a href="http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/SQSMessageAttributes.html#SQSMessageAttributesNTV">Message Attribute Items</a>.</p>
 */
  public let messageAttributes: [String: MessageAttributeValue]?
/**
<p>A unique identifier for the message. Message IDs are considered unique across all AWS accounts for an extended period of time.</p>
 */
  public let messageId: String?
/**
<p>An identifier associated with the act of receiving the message. A new receipt handle is returned every time you receive a message. When deleting a message, you provide the last received receipt handle to delete the message.</p>
 */
  public let receiptHandle: String?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if attributes != nil { body["Attribute"] = attributes! }
    if sqsBody != nil { body["Body"] = sqsBody! }
    if mD5OfBody != nil { body["MD5OfBody"] = mD5OfBody! }
    if mD5OfMessageAttributes != nil { body["MD5OfMessageAttributes"] = mD5OfMessageAttributes! }
    if messageAttributes != nil { body["MessageAttribute"] = messageAttributes! }
    if messageId != nil { body["MessageId"] = messageId! }
    if receiptHandle != nil { body["ReceiptHandle"] = receiptHandle! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Message {
    guard case let .xml(node) = body else { fatalError() }
    return Message(
        attributes: try! node.nodes(forXPath: "Attribute").first.map { [Queueattributename: String].deserialize(response: response, body: .xml($0)) },
      sqsBody: try! node.nodes(forXPath: "Body").first.map { String.deserialize(response: response, body: .xml($0)) },
      mD5OfBody: try! node.nodes(forXPath: "MD5OfBody").first.map { String.deserialize(response: response, body: .xml($0)) },
      mD5OfMessageAttributes: try! node.nodes(forXPath: "MD5OfMessageAttributes").first.map { String.deserialize(response: response, body: .xml($0)) },
      messageAttributes: try! node.nodes(forXPath: "MessageAttribute").first.map { [String: MessageAttributeValue].deserialize(response: response, body: .xml($0)) },
      messageId: try! node.nodes(forXPath: "MessageId").first.map { String.deserialize(response: response, body: .xml($0)) },
      receiptHandle: try! node.nodes(forXPath: "ReceiptHandle").first.map { String.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - attributes: <p><code>SenderId</code>, <code>SentTimestamp</code>, <code>ApproximateReceiveCount</code>, and/or <code>ApproximateFirstReceiveTimestamp</code>. <code>SentTimestamp</code> and <code>ApproximateFirstReceiveTimestamp</code> are each returned as an integer representing the <a href="http://en.wikipedia.org/wiki/Unix_time">epoch time</a> in milliseconds.</p>
      - sqsBody: <p>The message's contents (not URL-encoded).</p>
      - mD5OfBody: <p>An MD5 digest of the non-URL-encoded message body string.</p>
      - mD5OfMessageAttributes: <p>An MD5 digest of the non-URL-encoded message attribute string. This can be used to verify that Amazon SQS received the message correctly. Amazon SQS first URL decodes the message before creating the MD5 digest. For information about MD5, go to <a href="http://www.faqs.org/rfcs/rfc1321.html">http://www.faqs.org/rfcs/rfc1321.html</a>.</p>
      - messageAttributes: <p>Each message attribute consists of a Name, Type, and Value. For more information, see <a href="http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/SQSMessageAttributes.html#SQSMessageAttributesNTV">Message Attribute Items</a>.</p>
      - messageId: <p>A unique identifier for the message. Message IDs are considered unique across all AWS accounts for an extended period of time.</p>
      - receiptHandle: <p>An identifier associated with the act of receiving the message. A new receipt handle is returned every time you receive a message. When deleting a message, you provide the last received receipt handle to delete the message.</p>
 */
  public init(attributes: [Queueattributename: String]?, sqsBody: String?, mD5OfBody: String?, mD5OfMessageAttributes: String?, messageAttributes: [String: MessageAttributeValue]?, messageId: String?, receiptHandle: String?) {
self.attributes = attributes
self.sqsBody = sqsBody
self.mD5OfBody = mD5OfBody
self.mD5OfMessageAttributes = mD5OfMessageAttributes
self.messageAttributes = messageAttributes
self.messageId = messageId
self.receiptHandle = receiptHandle
  }
}




/**
<p>The user-specified message attribute value. For string data types, the value attribute has the same restrictions on the content as the message body. For more information, see <a href="http://docs.aws.amazon.com/AWSSimpleQueueService/latest/APIReference/API_SendMessage.html">SendMessage</a>.</p> <p>Name, type, and value must not be empty or null. In addition, the message body should not be empty or null. All parts of the message attribute, including name, type, and value, are included in the message size restriction, which is currently 256 KB (262,144 bytes).</p>
 */
public struct MessageAttributeValue: AwswiftSerializable, AwswiftDeserializable {
/**
<p>Not implemented. Reserved for future use.</p>
 */
  public let binaryListValues: [Data]?
/**
<p>Binary type attributes can store any binary data, for example, compressed data, encrypted data, or images.</p>
 */
  public let binaryValue: Data?
/**
<p>Amazon SQS supports the following logical data types: String, Number, and Binary. For the Number data type, you must use StringValue.</p> <p>You can also append custom labels. For more information, see <a href="http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/SQSMessageAttributes.html#SQSMessageAttributes.DataTypes">Message Attribute Data Types</a>.</p>
 */
  public let dataType: String
/**
<p>Not implemented. Reserved for future use.</p>
 */
  public let stringListValues: [String]?
/**
<p>Strings are Unicode with UTF8 binary encoding. For a list of code values, see <a href="http://en.wikipedia.org/wiki/ASCII#ASCII_printable_characters">http://en.wikipedia.org/wiki/ASCII#ASCII_printable_characters</a>.</p>
 */
  public let stringValue: String?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if binaryListValues != nil { body["BinaryListValue"] = binaryListValues! }
    if binaryValue != nil { body["BinaryValue"] = binaryValue! }
    body["DataType"] = dataType
    if stringListValues != nil { body["StringListValue"] = stringListValues! }
    if stringValue != nil { body["StringValue"] = stringValue! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> MessageAttributeValue {
    guard case let .xml(node) = body else { fatalError() }
    return MessageAttributeValue(
        binaryListValues: try! node.nodes(forXPath: "BinaryListValue").map { Data.deserialize(response: response, body: .xml($0)) },
      binaryValue: try! node.nodes(forXPath: "BinaryValue").first.map { Data.deserialize(response: response, body: .xml($0)) },
      dataType: try! node.nodes(forXPath: "DataType").first.map { String.deserialize(response: response, body: .xml($0)) }!,
      stringListValues: try! node.nodes(forXPath: "StringListValue").map { String.deserialize(response: response, body: .xml($0)) },
      stringValue: try! node.nodes(forXPath: "StringValue").first.map { String.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - binaryListValues: <p>Not implemented. Reserved for future use.</p>
      - binaryValue: <p>Binary type attributes can store any binary data, for example, compressed data, encrypted data, or images.</p>
      - dataType: <p>Amazon SQS supports the following logical data types: String, Number, and Binary. For the Number data type, you must use StringValue.</p> <p>You can also append custom labels. For more information, see <a href="http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/SQSMessageAttributes.html#SQSMessageAttributes.DataTypes">Message Attribute Data Types</a>.</p>
      - stringListValues: <p>Not implemented. Reserved for future use.</p>
      - stringValue: <p>Strings are Unicode with UTF8 binary encoding. For a list of code values, see <a href="http://en.wikipedia.org/wiki/ASCII#ASCII_printable_characters">http://en.wikipedia.org/wiki/ASCII#ASCII_printable_characters</a>.</p>
 */
  public init(binaryListValues: [Data]?, binaryValue: Data?, dataType: String, stringListValues: [String]?, stringValue: String?) {
self.binaryListValues = binaryListValues
self.binaryValue = binaryValue
self.dataType = dataType
self.stringListValues = stringListValues
self.stringValue = stringValue
  }
}


/**
<p>The message referred to is not in flight.</p>
 */
public struct MessageNotInflight: AwswiftSerializable, AwswiftDeserializable {

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    fatalError()
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> MessageNotInflight {
  
    return MessageNotInflight(
  
    )
  }

/**
    - parameters:
 */
  public init() {
  }
}

/**
<p>The action that you requested would violate a limit. For example, ReceiveMessage returns this error if the maximum number of messages inflight has already been reached. <a>AddPermission</a> returns this error if the maximum number of permissions for the queue has already been reached. </p>
 */
public struct OverLimit: AwswiftSerializable, AwswiftDeserializable {

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    fatalError()
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> OverLimit {
  
    return OverLimit(
  
    )
  }

/**
    - parameters:
 */
  public init() {
  }
}

/**
<p>Indicates that the specified queue previously received a <code>PurgeQueue</code> request within the last 60 seconds, the time it can take to delete the messages in the queue.</p>
 */
public struct PurgeQueueInProgress: AwswiftSerializable, AwswiftDeserializable {

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    fatalError()
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> PurgeQueueInProgress {
  
    return PurgeQueueInProgress(
  
    )
  }

/**
    - parameters:
 */
  public init() {
  }
}

/**
<p/>
 */
public struct PurgeQueueRequest: AwswiftSerializable {
/**
<p>The queue URL of the queue to delete the messages from when using the <code>PurgeQueue</code> API.</p> <p>Queue URLs are case-sensitive.</p>
 */
  public let queueUrl: String

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["QueueUrl"] = queueUrl
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - queueUrl: <p>The queue URL of the queue to delete the messages from when using the <code>PurgeQueue</code> API.</p> <p>Queue URLs are case-sensitive.</p>
 */
  public init(queueUrl: String) {
self.queueUrl = queueUrl
  }
}

enum Queueattributename: String, AwswiftDeserializable, AwswiftSerializable {
  case `policy` = "Policy"
  case `visibilityTimeout` = "VisibilityTimeout"
  case `maximumMessageSize` = "MaximumMessageSize"
  case `messageRetentionPeriod` = "MessageRetentionPeriod"
  case `approximateNumberOfMessages` = "ApproximateNumberOfMessages"
  case `approximateNumberOfMessagesNotVisible` = "ApproximateNumberOfMessagesNotVisible"
  case `createdTimestamp` = "CreatedTimestamp"
  case `lastModifiedTimestamp` = "LastModifiedTimestamp"
  case `queueArn` = "QueueArn"
  case `approximateNumberOfMessagesDelayed` = "ApproximateNumberOfMessagesDelayed"
  case `delaySeconds` = "DelaySeconds"
  case `receiveMessageWaitTimeSeconds` = "ReceiveMessageWaitTimeSeconds"
  case `redrivePolicy` = "RedrivePolicy"

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Queueattributename {
    switch body { 
    case .json(let json): return Queueattributename(rawValue: json as! String)!
    case .xml(let node): return Queueattributename(rawValue: node.stringValue!)!
    }
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}

/**
<p>You must wait 60 seconds after deleting a queue before you can create another with the same name.</p>
 */
public struct QueueDeletedRecently: AwswiftSerializable, AwswiftDeserializable {

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    fatalError()
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> QueueDeletedRecently {
  
    return QueueDeletedRecently(
  
    )
  }

/**
    - parameters:
 */
  public init() {
  }
}

/**
<p>The queue referred to does not exist.</p>
 */
public struct QueueDoesNotExist: AwswiftSerializable, AwswiftDeserializable {

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    fatalError()
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> QueueDoesNotExist {
  
    return QueueDoesNotExist(
  
    )
  }

/**
    - parameters:
 */
  public init() {
  }
}

/**
<p>A queue already exists with this name. Amazon SQS returns this error only if the request includes attributes whose values differ from those of the existing queue.</p>
 */
public struct QueueNameExists: AwswiftSerializable, AwswiftDeserializable {

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    fatalError()
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> QueueNameExists {
  
    return QueueNameExists(
  
    )
  }

/**
    - parameters:
 */
  public init() {
  }
}


/**
<p>The receipt handle provided is not valid.</p>
 */
public struct ReceiptHandleIsInvalid: AwswiftSerializable, AwswiftDeserializable {

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    fatalError()
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> ReceiptHandleIsInvalid {
  
    return ReceiptHandleIsInvalid(
  
    )
  }

/**
    - parameters:
 */
  public init() {
  }
}

/**
<p/>
 */
public struct ReceiveMessageRequest: AwswiftSerializable {
/**
<p>A list of attributes that need to be returned along with each message. These attributes include:</p> <ul> <li><p><code>All</code> - returns all values.</p></li> <li><p><code>ApproximateFirstReceiveTimestamp</code> - returns the time when the message was first received from the queue (epoch time in milliseconds).</p></li> <li><p><code>ApproximateReceiveCount</code> - returns the number of times a message has been received from the queue but not deleted.</p></li> <li><p><code>SenderId</code> - returns the AWS account number (or the IP address, if anonymous access is allowed) of the sender.</p></li> <li><p><code>SentTimestamp</code> - returns the time when the message was sent to the queue (epoch time in milliseconds).</p></li> </ul> <p>Any other valid special request parameters that are specified (such as <code>ApproximateNumberOfMessages</code>, <code>ApproximateNumberOfMessagesDelayed</code>, <code>ApproximateNumberOfMessagesNotVisible</code>, <code>CreatedTimestamp</code>, <code>DelaySeconds</code>, <code>LastModifiedTimestamp</code>, <code>MaximumMessageSize</code>, <code>MessageRetentionPeriod</code>, <code>Policy</code>, <code>QueueArn</code>, <code>ReceiveMessageWaitTimeSeconds</code>, <code>RedrivePolicy</code>, and <code>VisibilityTimeout</code>) will be ignored.</p>
 */
  public let attributeNames: [Queueattributename]?
/**
<p>The maximum number of messages to return. Amazon SQS never returns more messages than this value but may return fewer. Values can be from 1 to 10. Default is 1.</p> <p>All of the messages are not necessarily returned.</p>
 */
  public let maxNumberOfMessages: Int?
/**
<p>The name of the message attribute, where <i>N</i> is the index. The message attribute name can contain the following characters: A-Z, a-z, 0-9, underscore (_), hyphen (-), and period (.). The name must not start or end with a period, and it should not have successive periods. The name is case sensitive and must be unique among all attribute names for the message. The name can be up to 256 characters long. The name cannot start with "AWS." or "Amazon." (or any variations in casing), because these prefixes are reserved for use by Amazon Web Services.</p> <p>When using <code>ReceiveMessage</code>, you can send a list of attribute names to receive, or you can return all of the attributes by specifying "All" or ".*" in your request. You can also use "bar.*" to return all message attributes starting with the "bar" prefix.</p>
 */
  public let messageAttributeNames: [String]?
/**
<p>The URL of the Amazon SQS queue to take action on.</p> <p>Queue URLs are case-sensitive.</p>
 */
  public let queueUrl: String
/**
<p>The duration (in seconds) that the received messages are hidden from subsequent retrieve requests after being retrieved by a <code>ReceiveMessage</code> request.</p>
 */
  public let visibilityTimeout: Int?
/**
<p>The duration (in seconds) for which the call will wait for a message to arrive in the queue before returning. If a message is available, the call will return sooner than WaitTimeSeconds.</p>
 */
  public let waitTimeSeconds: Int?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if attributeNames != nil { body["AttributeNames"] = attributeNames! }
    if maxNumberOfMessages != nil { body["MaxNumberOfMessages"] = maxNumberOfMessages! }
    if messageAttributeNames != nil { body["MessageAttributeNames"] = messageAttributeNames! }
    body["QueueUrl"] = queueUrl
    if visibilityTimeout != nil { body["VisibilityTimeout"] = visibilityTimeout! }
    if waitTimeSeconds != nil { body["WaitTimeSeconds"] = waitTimeSeconds! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - attributeNames: <p>A list of attributes that need to be returned along with each message. These attributes include:</p> <ul> <li><p><code>All</code> - returns all values.</p></li> <li><p><code>ApproximateFirstReceiveTimestamp</code> - returns the time when the message was first received from the queue (epoch time in milliseconds).</p></li> <li><p><code>ApproximateReceiveCount</code> - returns the number of times a message has been received from the queue but not deleted.</p></li> <li><p><code>SenderId</code> - returns the AWS account number (or the IP address, if anonymous access is allowed) of the sender.</p></li> <li><p><code>SentTimestamp</code> - returns the time when the message was sent to the queue (epoch time in milliseconds).</p></li> </ul> <p>Any other valid special request parameters that are specified (such as <code>ApproximateNumberOfMessages</code>, <code>ApproximateNumberOfMessagesDelayed</code>, <code>ApproximateNumberOfMessagesNotVisible</code>, <code>CreatedTimestamp</code>, <code>DelaySeconds</code>, <code>LastModifiedTimestamp</code>, <code>MaximumMessageSize</code>, <code>MessageRetentionPeriod</code>, <code>Policy</code>, <code>QueueArn</code>, <code>ReceiveMessageWaitTimeSeconds</code>, <code>RedrivePolicy</code>, and <code>VisibilityTimeout</code>) will be ignored.</p>
      - maxNumberOfMessages: <p>The maximum number of messages to return. Amazon SQS never returns more messages than this value but may return fewer. Values can be from 1 to 10. Default is 1.</p> <p>All of the messages are not necessarily returned.</p>
      - messageAttributeNames: <p>The name of the message attribute, where <i>N</i> is the index. The message attribute name can contain the following characters: A-Z, a-z, 0-9, underscore (_), hyphen (-), and period (.). The name must not start or end with a period, and it should not have successive periods. The name is case sensitive and must be unique among all attribute names for the message. The name can be up to 256 characters long. The name cannot start with "AWS." or "Amazon." (or any variations in casing), because these prefixes are reserved for use by Amazon Web Services.</p> <p>When using <code>ReceiveMessage</code>, you can send a list of attribute names to receive, or you can return all of the attributes by specifying "All" or ".*" in your request. You can also use "bar.*" to return all message attributes starting with the "bar" prefix.</p>
      - queueUrl: <p>The URL of the Amazon SQS queue to take action on.</p> <p>Queue URLs are case-sensitive.</p>
      - visibilityTimeout: <p>The duration (in seconds) that the received messages are hidden from subsequent retrieve requests after being retrieved by a <code>ReceiveMessage</code> request.</p>
      - waitTimeSeconds: <p>The duration (in seconds) for which the call will wait for a message to arrive in the queue before returning. If a message is available, the call will return sooner than WaitTimeSeconds.</p>
 */
  public init(attributeNames: [Queueattributename]?, maxNumberOfMessages: Int?, messageAttributeNames: [String]?, queueUrl: String, visibilityTimeout: Int?, waitTimeSeconds: Int?) {
self.attributeNames = attributeNames
self.maxNumberOfMessages = maxNumberOfMessages
self.messageAttributeNames = messageAttributeNames
self.queueUrl = queueUrl
self.visibilityTimeout = visibilityTimeout
self.waitTimeSeconds = waitTimeSeconds
  }
}

/**
<p>A list of received messages.</p>
 */
public struct ReceiveMessageResult: AwswiftSerializable, AwswiftDeserializable {
/**
<p>A list of messages.</p>
 */
  public let messages: [Message]?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if messages != nil { body["Messages"] = messages! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> ReceiveMessageResult {
    guard case let .xml(node) = body else { fatalError() }
    return ReceiveMessageResult(
        messages: try! node.nodes(forXPath: "Messages").map { Message.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - messages: <p>A list of messages.</p>
 */
  public init(messages: [Message]?) {
self.messages = messages
  }
}

/**
<p/>
 */
public struct RemovePermissionRequest: AwswiftSerializable {
/**
<p>The identification of the permission to remove. This is the label added with the <a>AddPermission</a> action.</p>
 */
  public let label: String
/**
<p>The URL of the Amazon SQS queue to take action on.</p> <p>Queue URLs are case-sensitive.</p>
 */
  public let queueUrl: String

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["Label"] = label
    body["QueueUrl"] = queueUrl
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - label: <p>The identification of the permission to remove. This is the label added with the <a>AddPermission</a> action.</p>
      - queueUrl: <p>The URL of the Amazon SQS queue to take action on.</p> <p>Queue URLs are case-sensitive.</p>
 */
  public init(label: String, queueUrl: String) {
self.label = label
self.queueUrl = queueUrl
  }
}

/**
<p/>
 */
public struct SendMessageBatchRequest: AwswiftSerializable {
/**
<p>A list of <a>SendMessageBatchRequestEntry</a> items.</p>
 */
  public let entries: [SendMessageBatchRequestEntry]
/**
<p>The URL of the Amazon SQS queue to take action on.</p> <p>Queue URLs are case-sensitive.</p>
 */
  public let queueUrl: String

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["Entries"] = entries
    body["QueueUrl"] = queueUrl
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - entries: <p>A list of <a>SendMessageBatchRequestEntry</a> items.</p>
      - queueUrl: <p>The URL of the Amazon SQS queue to take action on.</p> <p>Queue URLs are case-sensitive.</p>
 */
  public init(entries: [SendMessageBatchRequestEntry], queueUrl: String) {
self.entries = entries
self.queueUrl = queueUrl
  }
}

/**
<p>Contains the details of a single Amazon SQS message along with a <code>Id</code>. </p>
 */
public struct SendMessageBatchRequestEntry: AwswiftSerializable, AwswiftDeserializable {
/**
<p>The number of seconds for which the message has to be delayed.</p>
 */
  public let delaySeconds: Int?
/**
<p>An identifier for the message in this batch. This is used to communicate the result. Note that the <code>Id</code>s of a batch request need to be unique within the request.</p>
 */
  public let id: String
/**
<p>Each message attribute consists of a Name, Type, and Value. For more information, see <a href="http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/SQSMessageAttributes.html#SQSMessageAttributesNTV">Message Attribute Items</a>.</p>
 */
  public let messageAttributes: [String: MessageAttributeValue]?
/**
<p>Body of the message.</p>
 */
  public let messageBody: String

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if delaySeconds != nil { body["DelaySeconds"] = delaySeconds! }
    body["Id"] = id
    if messageAttributes != nil { body["MessageAttribute"] = messageAttributes! }
    body["MessageBody"] = messageBody
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> SendMessageBatchRequestEntry {
    guard case let .xml(node) = body else { fatalError() }
    return SendMessageBatchRequestEntry(
        delaySeconds: try! node.nodes(forXPath: "DelaySeconds").first.map { Int.deserialize(response: response, body: .xml($0)) },
      id: try! node.nodes(forXPath: "Id").first.map { String.deserialize(response: response, body: .xml($0)) }!,
      messageAttributes: try! node.nodes(forXPath: "MessageAttribute").first.map { [String: MessageAttributeValue].deserialize(response: response, body: .xml($0)) },
      messageBody: try! node.nodes(forXPath: "MessageBody").first.map { String.deserialize(response: response, body: .xml($0)) }!
    )
  }

/**
    - parameters:
      - delaySeconds: <p>The number of seconds for which the message has to be delayed.</p>
      - id: <p>An identifier for the message in this batch. This is used to communicate the result. Note that the <code>Id</code>s of a batch request need to be unique within the request.</p>
      - messageAttributes: <p>Each message attribute consists of a Name, Type, and Value. For more information, see <a href="http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/SQSMessageAttributes.html#SQSMessageAttributesNTV">Message Attribute Items</a>.</p>
      - messageBody: <p>Body of the message.</p>
 */
  public init(delaySeconds: Int?, id: String, messageAttributes: [String: MessageAttributeValue]?, messageBody: String) {
self.delaySeconds = delaySeconds
self.id = id
self.messageAttributes = messageAttributes
self.messageBody = messageBody
  }
}


/**
<p>For each message in the batch, the response contains a <a>SendMessageBatchResultEntry</a> tag if the message succeeds or a <a>BatchResultErrorEntry</a> tag if the message fails.</p>
 */
public struct SendMessageBatchResult: AwswiftSerializable, AwswiftDeserializable {
/**
<p>A list of <a>BatchResultErrorEntry</a> items with the error detail about each message that could not be enqueued.</p>
 */
  public let failed: [BatchResultErrorEntry]
/**
<p>A list of <a>SendMessageBatchResultEntry</a> items.</p>
 */
  public let successful: [SendMessageBatchResultEntry]

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["Failed"] = failed
    body["Successful"] = successful
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> SendMessageBatchResult {
    guard case let .xml(node) = body else { fatalError() }
    return SendMessageBatchResult(
        failed: try! node.nodes(forXPath: "Failed").map { BatchResultErrorEntry.deserialize(response: response, body: .xml($0)) },
      successful: try! node.nodes(forXPath: "Successful").map { SendMessageBatchResultEntry.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - failed: <p>A list of <a>BatchResultErrorEntry</a> items with the error detail about each message that could not be enqueued.</p>
      - successful: <p>A list of <a>SendMessageBatchResultEntry</a> items.</p>
 */
  public init(failed: [BatchResultErrorEntry], successful: [SendMessageBatchResultEntry]) {
self.failed = failed
self.successful = successful
  }
}

/**
<p>Encloses a message ID for successfully enqueued message of a <a>SendMessageBatch</a>.</p>
 */
public struct SendMessageBatchResultEntry: AwswiftSerializable, AwswiftDeserializable {
/**
<p>An identifier for the message in this batch.</p>
 */
  public let id: String
/**
<p>An MD5 digest of the non-URL-encoded message attribute string. This can be used to verify that Amazon SQS received the message batch correctly. Amazon SQS first URL decodes the message before creating the MD5 digest. For information about MD5, go to <a href="http://www.faqs.org/rfcs/rfc1321.html">http://www.faqs.org/rfcs/rfc1321.html</a>.</p>
 */
  public let mD5OfMessageAttributes: String?
/**
<p>An MD5 digest of the non-URL-encoded message body string. This can be used to verify that Amazon SQS received the message correctly. Amazon SQS first URL decodes the message before creating the MD5 digest. For information about MD5, go to <a href="http://www.faqs.org/rfcs/rfc1321.html">http://www.faqs.org/rfcs/rfc1321.html</a>.</p>
 */
  public let mD5OfMessageBody: String
/**
<p>An identifier for the message.</p>
 */
  public let messageId: String

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["Id"] = id
    if mD5OfMessageAttributes != nil { body["MD5OfMessageAttributes"] = mD5OfMessageAttributes! }
    body["MD5OfMessageBody"] = mD5OfMessageBody
    body["MessageId"] = messageId
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> SendMessageBatchResultEntry {
    guard case let .xml(node) = body else { fatalError() }
    return SendMessageBatchResultEntry(
        id: try! node.nodes(forXPath: "Id").first.map { String.deserialize(response: response, body: .xml($0)) }!,
      mD5OfMessageAttributes: try! node.nodes(forXPath: "MD5OfMessageAttributes").first.map { String.deserialize(response: response, body: .xml($0)) },
      mD5OfMessageBody: try! node.nodes(forXPath: "MD5OfMessageBody").first.map { String.deserialize(response: response, body: .xml($0)) }!,
      messageId: try! node.nodes(forXPath: "MessageId").first.map { String.deserialize(response: response, body: .xml($0)) }!
    )
  }

/**
    - parameters:
      - id: <p>An identifier for the message in this batch.</p>
      - mD5OfMessageAttributes: <p>An MD5 digest of the non-URL-encoded message attribute string. This can be used to verify that Amazon SQS received the message batch correctly. Amazon SQS first URL decodes the message before creating the MD5 digest. For information about MD5, go to <a href="http://www.faqs.org/rfcs/rfc1321.html">http://www.faqs.org/rfcs/rfc1321.html</a>.</p>
      - mD5OfMessageBody: <p>An MD5 digest of the non-URL-encoded message body string. This can be used to verify that Amazon SQS received the message correctly. Amazon SQS first URL decodes the message before creating the MD5 digest. For information about MD5, go to <a href="http://www.faqs.org/rfcs/rfc1321.html">http://www.faqs.org/rfcs/rfc1321.html</a>.</p>
      - messageId: <p>An identifier for the message.</p>
 */
  public init(id: String, mD5OfMessageAttributes: String?, mD5OfMessageBody: String, messageId: String) {
self.id = id
self.mD5OfMessageAttributes = mD5OfMessageAttributes
self.mD5OfMessageBody = mD5OfMessageBody
self.messageId = messageId
  }
}


/**
<p/>
 */
public struct SendMessageRequest: AwswiftSerializable {
/**
<p> The number of seconds (0 to 900 - 15 minutes) to delay a specific message. Messages with a positive <code>DelaySeconds</code> value become available for processing after the delay time is finished. If you don't specify a value, the default value for the queue applies. </p>
 */
  public let delaySeconds: Int?
/**
<p>Each message attribute consists of a Name, Type, and Value. For more information, see <a href="http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/SQSMessageAttributes.html#SQSMessageAttributesNTV">Message Attribute Items</a>.</p>
 */
  public let messageAttributes: [String: MessageAttributeValue]?
/**
<p>The message to send. String maximum 256 KB in size. For a list of allowed characters, see the preceding important note.</p>
 */
  public let messageBody: String
/**
<p>The URL of the Amazon SQS queue to take action on.</p> <p>Queue URLs are case-sensitive.</p>
 */
  public let queueUrl: String

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if delaySeconds != nil { body["DelaySeconds"] = delaySeconds! }
    if messageAttributes != nil { body["MessageAttribute"] = messageAttributes! }
    body["MessageBody"] = messageBody
    body["QueueUrl"] = queueUrl
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - delaySeconds: <p> The number of seconds (0 to 900 - 15 minutes) to delay a specific message. Messages with a positive <code>DelaySeconds</code> value become available for processing after the delay time is finished. If you don't specify a value, the default value for the queue applies. </p>
      - messageAttributes: <p>Each message attribute consists of a Name, Type, and Value. For more information, see <a href="http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/SQSMessageAttributes.html#SQSMessageAttributesNTV">Message Attribute Items</a>.</p>
      - messageBody: <p>The message to send. String maximum 256 KB in size. For a list of allowed characters, see the preceding important note.</p>
      - queueUrl: <p>The URL of the Amazon SQS queue to take action on.</p> <p>Queue URLs are case-sensitive.</p>
 */
  public init(delaySeconds: Int?, messageAttributes: [String: MessageAttributeValue]?, messageBody: String, queueUrl: String) {
self.delaySeconds = delaySeconds
self.messageAttributes = messageAttributes
self.messageBody = messageBody
self.queueUrl = queueUrl
  }
}

/**
<p>The MD5OfMessageBody and MessageId elements.</p>
 */
public struct SendMessageResult: AwswiftSerializable, AwswiftDeserializable {
/**
<p>An MD5 digest of the non-URL-encoded message attribute string. This can be used to verify that Amazon SQS received the message correctly. Amazon SQS first URL decodes the message before creating the MD5 digest. For information about MD5, go to <a href="http://www.faqs.org/rfcs/rfc1321.html">http://www.faqs.org/rfcs/rfc1321.html</a>.</p>
 */
  public let mD5OfMessageAttributes: String?
/**
<p>An MD5 digest of the non-URL-encoded message body string. This can be used to verify that Amazon SQS received the message correctly. Amazon SQS first URL decodes the message before creating the MD5 digest. For information about MD5, go to <a href="http://www.faqs.org/rfcs/rfc1321.html">http://www.faqs.org/rfcs/rfc1321.html</a>.</p>
 */
  public let mD5OfMessageBody: String?
/**
<p> An element containing the message ID of the message sent to the queue. For more information, see <a href="http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/ImportantIdentifiers.html">Queue and Message Identifiers</a> in the <i>Amazon SQS Developer Guide</i>. </p>
 */
  public let messageId: String?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if mD5OfMessageAttributes != nil { body["MD5OfMessageAttributes"] = mD5OfMessageAttributes! }
    if mD5OfMessageBody != nil { body["MD5OfMessageBody"] = mD5OfMessageBody! }
    if messageId != nil { body["MessageId"] = messageId! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let node = try! XMLDocument(data: data, options: 0).child(at: 0)!
  return .xml(node)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> SendMessageResult {
    guard case let .xml(node) = body else { fatalError() }
    return SendMessageResult(
        mD5OfMessageAttributes: try! node.nodes(forXPath: "MD5OfMessageAttributes").first.map { String.deserialize(response: response, body: .xml($0)) },
      mD5OfMessageBody: try! node.nodes(forXPath: "MD5OfMessageBody").first.map { String.deserialize(response: response, body: .xml($0)) },
      messageId: try! node.nodes(forXPath: "MessageId").first.map { String.deserialize(response: response, body: .xml($0)) }
    )
  }

/**
    - parameters:
      - mD5OfMessageAttributes: <p>An MD5 digest of the non-URL-encoded message attribute string. This can be used to verify that Amazon SQS received the message correctly. Amazon SQS first URL decodes the message before creating the MD5 digest. For information about MD5, go to <a href="http://www.faqs.org/rfcs/rfc1321.html">http://www.faqs.org/rfcs/rfc1321.html</a>.</p>
      - mD5OfMessageBody: <p>An MD5 digest of the non-URL-encoded message body string. This can be used to verify that Amazon SQS received the message correctly. Amazon SQS first URL decodes the message before creating the MD5 digest. For information about MD5, go to <a href="http://www.faqs.org/rfcs/rfc1321.html">http://www.faqs.org/rfcs/rfc1321.html</a>.</p>
      - messageId: <p> An element containing the message ID of the message sent to the queue. For more information, see <a href="http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/ImportantIdentifiers.html">Queue and Message Identifiers</a> in the <i>Amazon SQS Developer Guide</i>. </p>
 */
  public init(mD5OfMessageAttributes: String?, mD5OfMessageBody: String?, messageId: String?) {
self.mD5OfMessageAttributes = mD5OfMessageAttributes
self.mD5OfMessageBody = mD5OfMessageBody
self.messageId = messageId
  }
}

/**
<p/>
 */
public struct SetQueueAttributesRequest: AwswiftSerializable {
/**
<p>A map of attributes to set.</p> <p>The following lists the names, descriptions, and values of the special request parameters the <code>SetQueueAttributes</code> action uses:</p> <ul> <li><p><code>DelaySeconds</code> - The time in seconds that the delivery of all messages in the queue will be delayed. An integer from 0 to 900 (15 minutes). The default for this attribute is 0 (zero).</p></li> <li><p><code>MaximumMessageSize</code> - The limit of how many bytes a message can contain before Amazon SQS rejects it. An integer from 1024 bytes (1 KiB) up to 262144 bytes (256 KiB). The default for this attribute is 262144 (256 KiB).</p></li> <li><p><code>MessageRetentionPeriod</code> - The number of seconds Amazon SQS retains a message. Integer representing seconds, from 60 (1 minute) to 1209600 (14 days). The default for this attribute is 345600 (4 days).</p></li> <li><p><code>Policy</code> - The queue's policy. A valid AWS policy. For more information about policy structure, see <a href="http://docs.aws.amazon.com/IAM/latest/UserGuide/PoliciesOverview.html">Overview of AWS IAM Policies</a> in the <i>Amazon IAM User Guide</i>.</p></li> <li><p><code>ReceiveMessageWaitTimeSeconds</code> - The time for which a ReceiveMessage call will wait for a message to arrive. An integer from 0 to 20 (seconds). The default for this attribute is 0.</p></li> <li><p><code>VisibilityTimeout</code> - The visibility timeout for the queue. An integer from 0 to 43200 (12 hours). The default for this attribute is 30. For more information about visibility timeout, see Visibility Timeout in the <i>Amazon SQS Developer Guide</i>.</p></li> <li><p><code>RedrivePolicy</code> - The parameters for dead letter queue functionality of the source queue. For more information about RedrivePolicy and dead letter queues, see Using Amazon SQS Dead Letter Queues in the <i>Amazon SQS Developer Guide</i>.</p></li> </ul> <p>Any other valid special request parameters that are specified (such as <code>ApproximateNumberOfMessages</code>, <code>ApproximateNumberOfMessagesDelayed</code>, <code>ApproximateNumberOfMessagesNotVisible</code>, <code>CreatedTimestamp</code>, <code>LastModifiedTimestamp</code>, and <code>QueueArn</code>) will be ignored.</p>
 */
  public let attributes: [Queueattributename: String]
/**
<p>The URL of the Amazon SQS queue to take action on.</p> <p>Queue URLs are case-sensitive.</p>
 */
  public let queueUrl: String

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["Attribute"] = attributes
    body["QueueUrl"] = queueUrl
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - attributes: <p>A map of attributes to set.</p> <p>The following lists the names, descriptions, and values of the special request parameters the <code>SetQueueAttributes</code> action uses:</p> <ul> <li><p><code>DelaySeconds</code> - The time in seconds that the delivery of all messages in the queue will be delayed. An integer from 0 to 900 (15 minutes). The default for this attribute is 0 (zero).</p></li> <li><p><code>MaximumMessageSize</code> - The limit of how many bytes a message can contain before Amazon SQS rejects it. An integer from 1024 bytes (1 KiB) up to 262144 bytes (256 KiB). The default for this attribute is 262144 (256 KiB).</p></li> <li><p><code>MessageRetentionPeriod</code> - The number of seconds Amazon SQS retains a message. Integer representing seconds, from 60 (1 minute) to 1209600 (14 days). The default for this attribute is 345600 (4 days).</p></li> <li><p><code>Policy</code> - The queue's policy. A valid AWS policy. For more information about policy structure, see <a href="http://docs.aws.amazon.com/IAM/latest/UserGuide/PoliciesOverview.html">Overview of AWS IAM Policies</a> in the <i>Amazon IAM User Guide</i>.</p></li> <li><p><code>ReceiveMessageWaitTimeSeconds</code> - The time for which a ReceiveMessage call will wait for a message to arrive. An integer from 0 to 20 (seconds). The default for this attribute is 0.</p></li> <li><p><code>VisibilityTimeout</code> - The visibility timeout for the queue. An integer from 0 to 43200 (12 hours). The default for this attribute is 30. For more information about visibility timeout, see Visibility Timeout in the <i>Amazon SQS Developer Guide</i>.</p></li> <li><p><code>RedrivePolicy</code> - The parameters for dead letter queue functionality of the source queue. For more information about RedrivePolicy and dead letter queues, see Using Amazon SQS Dead Letter Queues in the <i>Amazon SQS Developer Guide</i>.</p></li> </ul> <p>Any other valid special request parameters that are specified (such as <code>ApproximateNumberOfMessages</code>, <code>ApproximateNumberOfMessagesDelayed</code>, <code>ApproximateNumberOfMessagesNotVisible</code>, <code>CreatedTimestamp</code>, <code>LastModifiedTimestamp</code>, and <code>QueueArn</code>) will be ignored.</p>
      - queueUrl: <p>The URL of the Amazon SQS queue to take action on.</p> <p>Queue URLs are case-sensitive.</p>
 */
  public init(attributes: [Queueattributename: String], queueUrl: String) {
self.attributes = attributes
self.queueUrl = queueUrl
  }
}



/**
<p>Batch request contains more number of entries than permissible.</p>
 */
public struct TooManyEntriesInBatchRequest: AwswiftSerializable {

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
 */
  public init() {
  }
}

/**
<p>Error code 400. Unsupported operation.</p>
 */
public struct UnsupportedOperation: AwswiftSerializable, AwswiftDeserializable {

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    fatalError()
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> UnsupportedOperation {
  
    return UnsupportedOperation(
  
    )
  }

/**
    - parameters:
 */
  public init() {
  }
}

}
