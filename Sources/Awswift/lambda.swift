import Foundation
import Signer
struct Lambda {
  struct Client {
    let region: String
    let credentialsProvider: AwsCredentialsProvider
    let session: URLSession
    let queue: DispatchQueue

    init(region: String) {
      self.region = region
      self.credentialsProvider = DefaultChainProvider()
      self.session = URLSession(configuration: URLSessionConfiguration.default)
      self.queue = DispatchQueue(label: "awswift.Lambda.Client.queue")
    }

    func scope() -> AwsCredentialsScope {
      return AwsCredentialsScope(url: URL(string: "https://")!)!
    }

/**
<p>Adds a permission to the resource policy associated with the specified AWS Lambda function. You use resource policies to grant permissions to event sources that use <i>push</i> model. In a <i>push</i> model, event sources (such as Amazon S3 and custom applications) invoke your Lambda function. Each permission you add to the resource policy allows an event source, permission to invoke the Lambda function. </p> <p>For information about the push model, see <a href="http://docs.aws.amazon.com/lambda/latest/dg/lambda-introduction.html">AWS Lambda: How it Works</a>. </p> <p>If you are using versioning, the permissions you add are specific to the Lambda function version or alias you specify in the <code>AddPermission</code> request via the <code>Qualifier</code> parameter. For more information about versioning, see <a href="http://docs.aws.amazon.com/lambda/latest/dg/versioning-aliases.html">AWS Lambda Function Versioning and Aliases</a>. </p> <p>This operation requires permission for the <code>lambda:AddPermission</code> action.</p>
 */
func addPermission(input: AddPermissionRequest) -> ApiCallTask<AddPermissionResponse> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://lambda.\(self.region).amazonaws.com/2015-03-31/functions/{FunctionName}/policy", 
      httpMethod: "POST", 
      expectedStatus: 201, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p>Creates an alias that points to the specified Lambda function version. For more information, see <a href="http://docs.aws.amazon.com/lambda/latest/dg/aliases-intro.html">Introduction to AWS Lambda Aliases</a>.</p> <p>Alias names are unique for a given function. This requires permission for the lambda:CreateAlias action.</p>
 */
func createAlias(input: CreateAliasRequest) -> ApiCallTask<AliasConfiguration> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://lambda.\(self.region).amazonaws.com/2015-03-31/functions/{FunctionName}/aliases", 
      httpMethod: "POST", 
      expectedStatus: 201, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p>Identifies a stream as an event source for a Lambda function. It can be either an Amazon Kinesis stream or an Amazon DynamoDB stream. AWS Lambda invokes the specified function when records are posted to the stream.</p> <p>This association between a stream source and a Lambda function is called the event source mapping.</p> <important><p>This event source mapping is relevant only in the AWS Lambda pull model, where AWS Lambda invokes the function. For more information, go to <a href="http://docs.aws.amazon.com/lambda/latest/dg/lambda-introduction.html">AWS Lambda: How it Works</a> in the <i>AWS Lambda Developer Guide</i>.</p> </important> <p>You provide mapping information (for example, which stream to read from and which Lambda function to invoke) in the request body.</p> <p>Each event source, such as an Amazon Kinesis or a DynamoDB stream, can be associated with multiple AWS Lambda function. A given Lambda function can be associated with multiple AWS event sources.</p> <p>If you are using versioning, you can specify a specific function version or an alias via the function name parameter. For more information about versioning, see <a href="http://docs.aws.amazon.com/lambda/latest/dg/versioning-aliases.html">AWS Lambda Function Versioning and Aliases</a>. </p> <p>This operation requires permission for the <code>lambda:CreateEventSourceMapping</code> action.</p>
 */
func createEventSourceMapping(input: CreateEventSourceMappingRequest) -> ApiCallTask<EventSourceMappingConfiguration> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://lambda.\(self.region).amazonaws.com/2015-03-31/event-source-mappings/", 
      httpMethod: "POST", 
      expectedStatus: 202, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p>Creates a new Lambda function. The function metadata is created from the request parameters, and the code for the function is provided by a .zip file in the request body. If the function name already exists, the operation will fail. Note that the function name is case-sensitive.</p> <p> If you are using versioning, you can also publish a version of the Lambda function you are creating using the <code>Publish</code> parameter. For more information about versioning, see <a href="http://docs.aws.amazon.com/lambda/latest/dg/versioning-aliases.html">AWS Lambda Function Versioning and Aliases</a>. </p> <p>This operation requires permission for the <code>lambda:CreateFunction</code> action.</p>
 */
func createFunction(input: CreateFunctionRequest) -> ApiCallTask<FunctionConfiguration> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://lambda.\(self.region).amazonaws.com/2015-03-31/functions", 
      httpMethod: "POST", 
      expectedStatus: 201, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p>Deletes the specified Lambda function alias. For more information, see <a href="http://docs.aws.amazon.com/lambda/latest/dg/aliases-intro.html">Introduction to AWS Lambda Aliases</a>.</p> <p>This requires permission for the lambda:DeleteAlias action.</p>
 */
func deleteAlias(input: DeleteAliasRequest) -> ApiCallTask<AwsApiVoidOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://lambda.\(self.region).amazonaws.com/2015-03-31/functions/{FunctionName}/aliases/{Name}", 
      httpMethod: "DELETE", 
      expectedStatus: 204, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p>Removes an event source mapping. This means AWS Lambda will no longer invoke the function for events in the associated source.</p> <p>This operation requires permission for the <code>lambda:DeleteEventSourceMapping</code> action.</p>
 */
func deleteEventSourceMapping(input: DeleteEventSourceMappingRequest) -> ApiCallTask<EventSourceMappingConfiguration> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://lambda.\(self.region).amazonaws.com/2015-03-31/event-source-mappings/{UUID}", 
      httpMethod: "DELETE", 
      expectedStatus: 202, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p>Deletes the specified Lambda function code and configuration.</p> <p>If you are using the versioning feature and you don't specify a function version in your <code>DeleteFunction</code> request, AWS Lambda will delete the function, including all its versions, and any aliases pointing to the function versions. To delete a specific function version, you must provide the function version via the <code>Qualifier</code> parameter. For information about function versioning, see <a href="http://docs.aws.amazon.com/lambda/latest/dg/versioning-aliases.html">AWS Lambda Function Versioning and Aliases</a>. </p> <p>When you delete a function the associated resource policy is also deleted. You will need to delete the event source mappings explicitly.</p> <p>This operation requires permission for the <code>lambda:DeleteFunction</code> action.</p>
 */
func deleteFunction(input: DeleteFunctionRequest) -> ApiCallTask<AwsApiVoidOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://lambda.\(self.region).amazonaws.com/2015-03-31/functions/{FunctionName}", 
      httpMethod: "DELETE", 
      expectedStatus: 204, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p>Returns the specified alias information such as the alias ARN, description, and function version it is pointing to. For more information, see <a href="http://docs.aws.amazon.com/lambda/latest/dg/aliases-intro.html">Introduction to AWS Lambda Aliases</a>.</p> <p>This requires permission for the <code>lambda:GetAlias</code> action.</p>
 */
func getAlias(input: GetAliasRequest) -> ApiCallTask<AliasConfiguration> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://lambda.\(self.region).amazonaws.com/2015-03-31/functions/{FunctionName}/aliases/{Name}", 
      httpMethod: "GET", 
      expectedStatus: 200, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p>Returns configuration information for the specified event source mapping (see <a>CreateEventSourceMapping</a>).</p> <p>This operation requires permission for the <code>lambda:GetEventSourceMapping</code> action.</p>
 */
func getEventSourceMapping(input: GetEventSourceMappingRequest) -> ApiCallTask<EventSourceMappingConfiguration> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://lambda.\(self.region).amazonaws.com/2015-03-31/event-source-mappings/{UUID}", 
      httpMethod: "GET", 
      expectedStatus: 200, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p>Returns the configuration information of the Lambda function and a presigned URL link to the .zip file you uploaded with <a>CreateFunction</a> so you can download the .zip file. Note that the URL is valid for up to 10 minutes. The configuration information is the same information you provided as parameters when uploading the function.</p> <p>Using the optional <code>Qualifier</code> parameter, you can specify a specific function version for which you want this information. If you don't specify this parameter, the API uses unqualified function ARN which return information about the <code>$LATEST</code> version of the Lambda function. For more information, see <a href="http://docs.aws.amazon.com/lambda/latest/dg/versioning-aliases.html">AWS Lambda Function Versioning and Aliases</a>.</p> <p>This operation requires permission for the <code>lambda:GetFunction</code> action.</p>
 */
func getFunction(input: GetFunctionRequest) -> ApiCallTask<GetFunctionResponse> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://lambda.\(self.region).amazonaws.com/2015-03-31/functions/{FunctionName}", 
      httpMethod: "GET", 
      expectedStatus: 200, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p>Returns the configuration information of the Lambda function. This the same information you provided as parameters when uploading the function by using <a>CreateFunction</a>.</p> <p>If you are using the versioning feature, you can retrieve this information for a specific function version by using the optional <code>Qualifier</code> parameter and specifying the function version or alias that points to it. If you don't provide it, the API returns information about the $LATEST version of the function. For more information about versioning, see <a href="http://docs.aws.amazon.com/lambda/latest/dg/versioning-aliases.html">AWS Lambda Function Versioning and Aliases</a>.</p> <p>This operation requires permission for the <code>lambda:GetFunctionConfiguration</code> operation.</p>
 */
func getFunctionConfiguration(input: GetFunctionConfigurationRequest) -> ApiCallTask<FunctionConfiguration> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://lambda.\(self.region).amazonaws.com/2015-03-31/functions/{FunctionName}/configuration", 
      httpMethod: "GET", 
      expectedStatus: 200, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p>Returns the resource policy associated with the specified Lambda function.</p> <p> If you are using the versioning feature, you can get the resource policy associated with the specific Lambda function version or alias by specifying the version or alias name using the <code>Qualifier</code> parameter. For more information about versioning, see <a href="http://docs.aws.amazon.com/lambda/latest/dg/versioning-aliases.html">AWS Lambda Function Versioning and Aliases</a>. </p> <p>For information about adding permissions, see <a>AddPermission</a>.</p> <p>You need permission for the <code>lambda:GetPolicy action.</code> </p>
 */
func getPolicy(input: GetPolicyRequest) -> ApiCallTask<GetPolicyResponse> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://lambda.\(self.region).amazonaws.com/2015-03-31/functions/{FunctionName}/policy", 
      httpMethod: "GET", 
      expectedStatus: 200, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p>Invokes a specific Lambda function.</p> <p>If you are using the versioning feature, you can invoke the specific function version by providing function version or alias name that is pointing to the function version using the <code>Qualifier</code> parameter in the request. If you don't provide the <code>Qualifier</code> parameter, the <code>$LATEST</code> version of the Lambda function is invoked. Invocations occur at least once in response to an event and functions must be idempotent to handle this. For information about the versioning feature, see <a href="http://docs.aws.amazon.com/lambda/latest/dg/versioning-aliases.html">AWS Lambda Function Versioning and Aliases</a>. </p> <p>This operation requires permission for the <code>lambda:InvokeFunction</code> action.</p>
 */
func invoke(input: InvocationRequest) -> ApiCallTask<InvocationResponse> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://lambda.\(self.region).amazonaws.com/2015-03-31/functions/{FunctionName}/invocations", 
      httpMethod: "POST", 
      expectedStatus: nil, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<important><p>This API is deprecated. We recommend you use <code>Invoke</code> API (see <a>Invoke</a>).</p> </important> <p>Submits an invocation request to AWS Lambda. Upon receiving the request, Lambda executes the specified function asynchronously. To see the logs generated by the Lambda function execution, see the CloudWatch Logs console.</p> <p>This operation requires permission for the <code>lambda:InvokeFunction</code> action.</p>
 */
func invokeAsync(input: InvokeAsyncRequest) -> ApiCallTask<InvokeAsyncResponse> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://lambda.\(self.region).amazonaws.com/2014-11-13/functions/{FunctionName}/invoke-async/", 
      httpMethod: "POST", 
      expectedStatus: 202, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p>Returns list of aliases created for a Lambda function. For each alias, the response includes information such as the alias ARN, description, alias name, and the function version to which it points. For more information, see <a href="http://docs.aws.amazon.com/lambda/latest/dg/aliases-intro.html">Introduction to AWS Lambda Aliases</a>.</p> <p>This requires permission for the lambda:ListAliases action.</p>
 */
func listAliases(input: ListAliasesRequest) -> ApiCallTask<ListAliasesResponse> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://lambda.\(self.region).amazonaws.com/2015-03-31/functions/{FunctionName}/aliases", 
      httpMethod: "GET", 
      expectedStatus: 200, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p>Returns a list of event source mappings you created using the <code>CreateEventSourceMapping</code> (see <a>CreateEventSourceMapping</a>). </p> <p>For each mapping, the API returns configuration information. You can optionally specify filters to retrieve specific event source mappings.</p> <p>If you are using the versioning feature, you can get list of event source mappings for a specific Lambda function version or an alias as described in the <code>FunctionName</code> parameter. For information about the versioning feature, see <a href="http://docs.aws.amazon.com/lambda/latest/dg/versioning-aliases.html">AWS Lambda Function Versioning and Aliases</a>. </p> <p>This operation requires permission for the <code>lambda:ListEventSourceMappings</code> action.</p>
 */
func listEventSourceMappings(input: ListEventSourceMappingsRequest) -> ApiCallTask<ListEventSourceMappingsResponse> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://lambda.\(self.region).amazonaws.com/2015-03-31/event-source-mappings/", 
      httpMethod: "GET", 
      expectedStatus: 200, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p>Returns a list of your Lambda functions. For each function, the response includes the function configuration information. You must use <a>GetFunction</a> to retrieve the code for your function.</p> <p>This operation requires permission for the <code>lambda:ListFunctions</code> action.</p> <p>If you are using versioning feature, the response returns list of $LATEST versions of your functions. For information about the versioning feature, see <a href="http://docs.aws.amazon.com/lambda/latest/dg/versioning-aliases.html">AWS Lambda Function Versioning and Aliases</a>. </p>
 */
func listFunctions(input: ListFunctionsRequest) -> ApiCallTask<ListFunctionsResponse> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://lambda.\(self.region).amazonaws.com/2015-03-31/functions/", 
      httpMethod: "GET", 
      expectedStatus: 200, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p>List all versions of a function. For information about the versioning feature, see <a href="http://docs.aws.amazon.com/lambda/latest/dg/versioning-aliases.html">AWS Lambda Function Versioning and Aliases</a>. </p>
 */
func listVersionsByFunction(input: ListVersionsByFunctionRequest) -> ApiCallTask<ListVersionsByFunctionResponse> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://lambda.\(self.region).amazonaws.com/2015-03-31/functions/{FunctionName}/versions", 
      httpMethod: "GET", 
      expectedStatus: 200, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p>Publishes a version of your function from the current snapshot of $LATEST. That is, AWS Lambda takes a snapshot of the function code and configuration information from $LATEST and publishes a new version. The code and configuration cannot be modified after publication. For information about the versioning feature, see <a href="http://docs.aws.amazon.com/lambda/latest/dg/versioning-aliases.html">AWS Lambda Function Versioning and Aliases</a>. </p>
 */
func publishVersion(input: PublishVersionRequest) -> ApiCallTask<FunctionConfiguration> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://lambda.\(self.region).amazonaws.com/2015-03-31/functions/{FunctionName}/versions", 
      httpMethod: "POST", 
      expectedStatus: 201, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p>You can remove individual permissions from an resource policy associated with a Lambda function by providing a statement ID that you provided when you added the permission.</p> <p>If you are using versioning, the permissions you remove are specific to the Lambda function version or alias you specify in the <code>AddPermission</code> request via the <code>Qualifier</code> parameter. For more information about versioning, see <a href="http://docs.aws.amazon.com/lambda/latest/dg/versioning-aliases.html">AWS Lambda Function Versioning and Aliases</a>. </p> <p>Note that removal of a permission will cause an active event source to lose permission to the function.</p> <p>You need permission for the <code>lambda:RemovePermission</code> action.</p>
 */
func removePermission(input: RemovePermissionRequest) -> ApiCallTask<AwsApiVoidOutput> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://lambda.\(self.region).amazonaws.com/2015-03-31/functions/{FunctionName}/policy/{StatementId}", 
      httpMethod: "DELETE", 
      expectedStatus: 204, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p>Using this API you can update the function version to which the alias points and the alias description. For more information, see <a href="http://docs.aws.amazon.com/lambda/latest/dg/aliases-intro.html">Introduction to AWS Lambda Aliases</a>.</p> <p>This requires permission for the lambda:UpdateAlias action.</p>
 */
func updateAlias(input: UpdateAliasRequest) -> ApiCallTask<AliasConfiguration> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://lambda.\(self.region).amazonaws.com/2015-03-31/functions/{FunctionName}/aliases/{Name}", 
      httpMethod: "PUT", 
      expectedStatus: 200, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p>You can update an event source mapping. This is useful if you want to change the parameters of the existing mapping without losing your position in the stream. You can change which function will receive the stream records, but to change the stream itself, you must create a new mapping.</p> <p>If you are using the versioning feature, you can update the event source mapping to map to a specific Lambda function version or alias as described in the <code>FunctionName</code> parameter. For information about the versioning feature, see <a href="http://docs.aws.amazon.com/lambda/latest/dg/versioning-aliases.html">AWS Lambda Function Versioning and Aliases</a>. </p> <p>If you disable the event source mapping, AWS Lambda stops polling. If you enable again, it will resume polling from the time it had stopped polling, so you don't lose processing of any records. However, if you delete event source mapping and create it again, it will reset.</p> <p>This operation requires permission for the <code>lambda:UpdateEventSourceMapping</code> action.</p>
 */
func updateEventSourceMapping(input: UpdateEventSourceMappingRequest) -> ApiCallTask<EventSourceMappingConfiguration> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://lambda.\(self.region).amazonaws.com/2015-03-31/event-source-mappings/{UUID}", 
      httpMethod: "PUT", 
      expectedStatus: 202, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p>Updates the code for the specified Lambda function. This operation must only be used on an existing Lambda function and cannot be used to update the function configuration.</p> <p>If you are using the versioning feature, note this API will always update the $LATEST version of your Lambda function. For information about the versioning feature, see <a href="http://docs.aws.amazon.com/lambda/latest/dg/versioning-aliases.html">AWS Lambda Function Versioning and Aliases</a>. </p> <p>This operation requires permission for the <code>lambda:UpdateFunctionCode</code> action.</p>
 */
func updateFunctionCode(input: UpdateFunctionCodeRequest) -> ApiCallTask<FunctionConfiguration> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://lambda.\(self.region).amazonaws.com/2015-03-31/functions/{FunctionName}/code", 
      httpMethod: "PUT", 
      expectedStatus: 200, 
      input: input, 
      completionHandler: cb
    )
    task.resume()
  }
}


/**
<p>Updates the configuration parameters for the specified Lambda function by using the values provided in the request. You provide only the parameters you want to change. This operation must only be used on an existing Lambda function and cannot be used to update the function's code.</p> <p>If you are using the versioning feature, note this API will always update the $LATEST version of your Lambda function. For information about the versioning feature, see <a href="http://docs.aws.amazon.com/lambda/latest/dg/versioning-aliases.html">AWS Lambda Function Versioning and Aliases</a>. </p> <p>This operation requires permission for the <code>lambda:UpdateFunctionConfiguration</code> action.</p>
 */
func updateFunctionConfiguration(input: UpdateFunctionConfigurationRequest) -> ApiCallTask<FunctionConfiguration> {
  return ApiCallTask { cb in
    let task = awsApiCallTask(
      session: self.session,
      credentials: self.credentialsProvider.provideAwsCredentials()!,
      scope: self.scope(),
      queue: self.queue,
      urlString: "https://lambda.\(self.region).amazonaws.com/2015-03-31/functions/{FunctionName}/configuration", 
      httpMethod: "PUT", 
      expectedStatus: 200, 
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
<p>The AWS Lambda action you want to allow in this statement. Each Lambda action is a string starting with <code>lambda:</code> followed by the API name . For example, <code>lambda:CreateFunction</code>. You can use wildcard (<code>lambda:*</code>) to grant permission for all AWS Lambda actions. </p>
 */
  public let action: String
/**
<p>A unique token that must be supplied by the principal invoking the function. This is currently only used for Alexa Smart Home functions.</p>
 */
  public let eventSourceToken: String?
/**
<p>Name of the Lambda function whose resource policy you are updating by adding a new permission.</p> <p> You can specify a function name (for example, <code>Thumbnail</code>) or you can specify Amazon Resource Name (ARN) of the function (for example, <code>arn:aws:lambda:us-west-2:account-id:function:ThumbNail</code>). AWS Lambda also allows you to specify partial ARN (for example, <code>account-id:Thumbnail</code>). Note that the length constraint applies only to the ARN. If you specify only the function name, it is limited to 64 character in length. </p>
 */
  public let functionName: String
/**
<p>The principal who is getting this permission. It can be Amazon S3 service Principal (<code>s3.amazonaws.com</code>) if you want Amazon S3 to invoke the function, an AWS account ID if you are granting cross-account permission, or any valid AWS service principal such as <code>sns.amazonaws.com</code>. For example, you might want to allow a custom application in another AWS account to push events to AWS Lambda by invoking your function. </p>
 */
  public let principal: String
/**
<p>You can use this optional query parameter to describe a qualified ARN using a function version or an alias name. The permission will then apply to the specific qualified ARN. For example, if you specify function version 2 as the qualifier, then permission applies only when request is made using qualified function ARN:</p> <p> <code>arn:aws:lambda:aws-region:acct-id:function:function-name:2</code> </p> <p>If you specify an alias name, for example <code>PROD</code>, then the permission is valid only for requests made using the alias ARN:</p> <p> <code>arn:aws:lambda:aws-region:acct-id:function:function-name:PROD</code> </p> <p>If the qualifier is not specified, the permission is valid only when requests is made using unqualified function ARN.</p> <p> <code>arn:aws:lambda:aws-region:acct-id:function:function-name</code> </p>
 */
  public let qualifier: String?
/**
<p>This parameter is used for S3 and SES only. The AWS account ID (without a hyphen) of the source owner. For example, if the <code>SourceArn</code> identifies a bucket, then this is the bucket owner's account ID. You can use this additional condition to ensure the bucket you specify is owned by a specific account (it is possible the bucket owner deleted the bucket and some other AWS account created the bucket). You can also use this condition to specify all sources (that is, you don't specify the <code>SourceArn</code>) owned by a specific account. </p>
 */
  public let sourceAccount: String?
/**
<p>This is optional; however, when granting Amazon S3 permission to invoke your function, you should specify this field with the Amazon Resource Name (ARN) as its value. This ensures that only events generated from the specified source can invoke the function.</p> <important><p>If you add a permission for the Amazon S3 principal without providing the source ARN, any AWS account that creates a mapping to your function ARN can send events to invoke your Lambda function from Amazon S3.</p> </important>
 */
  public let sourceArn: String?
/**
<p>A unique statement identifier.</p>
 */
  public let statementId: String

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    var querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    uri["FunctionName"] = "\(functionName)"
    if qualifier != nil { querystring["Qualifier"] = "\(qualifier!)" }
    body["Action"] = action
    if eventSourceToken != nil { body["EventSourceToken"] = eventSourceToken! }
    body["Principal"] = principal
    if sourceAccount != nil { body["SourceAccount"] = sourceAccount! }
    if sourceArn != nil { body["SourceArn"] = sourceArn! }
    body["StatementId"] = statementId
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - action: <p>The AWS Lambda action you want to allow in this statement. Each Lambda action is a string starting with <code>lambda:</code> followed by the API name . For example, <code>lambda:CreateFunction</code>. You can use wildcard (<code>lambda:*</code>) to grant permission for all AWS Lambda actions. </p>
      - eventSourceToken: <p>A unique token that must be supplied by the principal invoking the function. This is currently only used for Alexa Smart Home functions.</p>
      - functionName: <p>Name of the Lambda function whose resource policy you are updating by adding a new permission.</p> <p> You can specify a function name (for example, <code>Thumbnail</code>) or you can specify Amazon Resource Name (ARN) of the function (for example, <code>arn:aws:lambda:us-west-2:account-id:function:ThumbNail</code>). AWS Lambda also allows you to specify partial ARN (for example, <code>account-id:Thumbnail</code>). Note that the length constraint applies only to the ARN. If you specify only the function name, it is limited to 64 character in length. </p>
      - principal: <p>The principal who is getting this permission. It can be Amazon S3 service Principal (<code>s3.amazonaws.com</code>) if you want Amazon S3 to invoke the function, an AWS account ID if you are granting cross-account permission, or any valid AWS service principal such as <code>sns.amazonaws.com</code>. For example, you might want to allow a custom application in another AWS account to push events to AWS Lambda by invoking your function. </p>
      - qualifier: <p>You can use this optional query parameter to describe a qualified ARN using a function version or an alias name. The permission will then apply to the specific qualified ARN. For example, if you specify function version 2 as the qualifier, then permission applies only when request is made using qualified function ARN:</p> <p> <code>arn:aws:lambda:aws-region:acct-id:function:function-name:2</code> </p> <p>If you specify an alias name, for example <code>PROD</code>, then the permission is valid only for requests made using the alias ARN:</p> <p> <code>arn:aws:lambda:aws-region:acct-id:function:function-name:PROD</code> </p> <p>If the qualifier is not specified, the permission is valid only when requests is made using unqualified function ARN.</p> <p> <code>arn:aws:lambda:aws-region:acct-id:function:function-name</code> </p>
      - sourceAccount: <p>This parameter is used for S3 and SES only. The AWS account ID (without a hyphen) of the source owner. For example, if the <code>SourceArn</code> identifies a bucket, then this is the bucket owner's account ID. You can use this additional condition to ensure the bucket you specify is owned by a specific account (it is possible the bucket owner deleted the bucket and some other AWS account created the bucket). You can also use this condition to specify all sources (that is, you don't specify the <code>SourceArn</code>) owned by a specific account. </p>
      - sourceArn: <p>This is optional; however, when granting Amazon S3 permission to invoke your function, you should specify this field with the Amazon Resource Name (ARN) as its value. This ensures that only events generated from the specified source can invoke the function.</p> <important><p>If you add a permission for the Amazon S3 principal without providing the source ARN, any AWS account that creates a mapping to your function ARN can send events to invoke your Lambda function from Amazon S3.</p> </important>
      - statementId: <p>A unique statement identifier.</p>
 */
  public init(action: String, eventSourceToken: String?, functionName: String, principal: String, qualifier: String?, sourceAccount: String?, sourceArn: String?, statementId: String) {
self.action = action
self.eventSourceToken = eventSourceToken
self.functionName = functionName
self.principal = principal
self.qualifier = qualifier
self.sourceAccount = sourceAccount
self.sourceArn = sourceArn
self.statementId = statementId
  }
}

/**
<p/>
 */
public struct AddPermissionResponse: AwswiftDeserializable {
/**
<p>The permission statement you specified in the request. The response returns the same as a string using a backslash ("\") as an escape character in the JSON.</p>
 */
  public let statement: String?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let json = try! JSONSerialization.jsonObject(with: data, options: [])
  return .json(json)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> AddPermissionResponse {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return AddPermissionResponse(
        statement: jsonDict["Statement"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - statement: <p>The permission statement you specified in the request. The response returns the same as a string using a backslash ("\") as an escape character in the JSON.</p>
 */
  public init(statement: String?) {
self.statement = statement
  }
}


/**
<p>Provides configuration information about a Lambda function version alias.</p>
 */
public struct AliasConfiguration: AwswiftSerializable, AwswiftDeserializable {
/**
<p>Lambda function ARN that is qualified using the alias name as the suffix. For example, if you create an alias called <code>BETA</code> that points to a helloworld function version, the ARN is <code>arn:aws:lambda:aws-regions:acct-id:function:helloworld:BETA</code>.</p>
 */
  public let aliasArn: String?
/**
<p>Alias description.</p>
 */
  public let description: String?
/**
<p>Function version to which the alias points.</p>
 */
  public let functionVersion: String?
/**
<p>Alias name.</p>
 */
  public let name: String?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if aliasArn != nil { body["AliasArn"] = aliasArn! }
    if description != nil { body["Description"] = description! }
    if functionVersion != nil { body["FunctionVersion"] = functionVersion! }
    if name != nil { body["Name"] = name! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let json = try! JSONSerialization.jsonObject(with: data, options: [])
  return .json(json)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> AliasConfiguration {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return AliasConfiguration(
        aliasArn: jsonDict["AliasArn"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      description: jsonDict["Description"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      functionVersion: jsonDict["FunctionVersion"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      name: jsonDict["Name"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - aliasArn: <p>Lambda function ARN that is qualified using the alias name as the suffix. For example, if you create an alias called <code>BETA</code> that points to a helloworld function version, the ARN is <code>arn:aws:lambda:aws-regions:acct-id:function:helloworld:BETA</code>.</p>
      - description: <p>Alias description.</p>
      - functionVersion: <p>Function version to which the alias points.</p>
      - name: <p>Alias name.</p>
 */
  public init(aliasArn: String?, description: String?, functionVersion: String?, name: String?) {
self.aliasArn = aliasArn
self.description = description
self.functionVersion = functionVersion
self.name = name
  }
}







/**
<p>You have exceeded your maximum total code size per account. <a href="http://docs.aws.amazon.com/lambda/latest/dg/limits.html">Limits</a> </p>
 */
public struct CodeStorageExceededException: Error, AwswiftDeserializable {
/**
<p/>
 */
  public let lambdaType: String?
/**

 */
  public let message: String?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let json = try! JSONSerialization.jsonObject(with: data, options: [])
  return .json(json)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> CodeStorageExceededException {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return CodeStorageExceededException(
        lambdaType: jsonDict["Type"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      message: jsonDict["message"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - lambdaType: <p/>
      - message: 
 */
  public init(lambdaType: String?, message: String?) {
self.lambdaType = lambdaType
self.message = message
  }
}

public struct CreateAliasRequest: AwswiftSerializable {
/**
<p>Description of the alias.</p>
 */
  public let description: String?
/**
<p>Name of the Lambda function for which you want to create an alias.</p>
 */
  public let functionName: String
/**
<p>Lambda function version for which you are creating the alias.</p>
 */
  public let functionVersion: String
/**
<p>Name for the alias you are creating.</p>
 */
  public let name: String

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    uri["FunctionName"] = "\(functionName)"
    if description != nil { body["Description"] = description! }
    body["FunctionVersion"] = functionVersion
    body["Name"] = name
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - description: <p>Description of the alias.</p>
      - functionName: <p>Name of the Lambda function for which you want to create an alias.</p>
      - functionVersion: <p>Lambda function version for which you are creating the alias.</p>
      - name: <p>Name for the alias you are creating.</p>
 */
  public init(description: String?, functionName: String, functionVersion: String, name: String) {
self.description = description
self.functionName = functionName
self.functionVersion = functionVersion
self.name = name
  }
}

/**
<p/>
 */
public struct CreateEventSourceMappingRequest: AwswiftSerializable {
/**
<p>The largest number of records that AWS Lambda will retrieve from your event source at the time of invoking your function. Your function receives an event with all the retrieved records. The default is 100 records.</p>
 */
  public let batchSize: Int?
/**
<p>Indicates whether AWS Lambda should begin polling the event source. By default, <code>Enabled</code> is true. </p>
 */
  public let enabled: Bool?
/**
<p>The Amazon Resource Name (ARN) of the Amazon Kinesis or the Amazon DynamoDB stream that is the event source. Any record added to this stream could cause AWS Lambda to invoke your Lambda function, it depends on the <code>BatchSize</code>. AWS Lambda POSTs the Amazon Kinesis event, containing records, to your Lambda function as JSON.</p>
 */
  public let eventSourceArn: String
/**
<p>The Lambda function to invoke when AWS Lambda detects an event on the stream.</p> <p> You can specify the function name (for example, <code>Thumbnail</code>) or you can specify Amazon Resource Name (ARN) of the function (for example, <code>arn:aws:lambda:us-west-2:account-id:function:ThumbNail</code>). </p> <p> If you are using versioning, you can also provide a qualified function ARN (ARN that is qualified with function version or alias name as suffix). For more information about versioning, see <a href="http://docs.aws.amazon.com/lambda/latest/dg/versioning-aliases.html">AWS Lambda Function Versioning and Aliases</a> </p> <p>AWS Lambda also allows you to specify only the function name with the account ID qualifier (for example, <code>account-id:Thumbnail</code>). </p> <p>Note that the length constraint applies only to the ARN. If you specify only the function name, it is limited to 64 character in length.</p>
 */
  public let functionName: String
/**
<p>The position in the stream where AWS Lambda should start reading. For more information, go to <a href="http://docs.aws.amazon.com/kinesis/latest/APIReference/API_GetShardIterator.html#Kinesis-GetShardIterator-request-ShardIteratorType">ShardIteratorType</a> in the <i>Amazon Kinesis API Reference</i>. </p>
 */
  public let startingPosition: Eventsourceposition

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if batchSize != nil { body["BatchSize"] = batchSize! }
    if enabled != nil { body["Enabled"] = enabled! }
    body["EventSourceArn"] = eventSourceArn
    body["FunctionName"] = functionName
    body["StartingPosition"] = startingPosition
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - batchSize: <p>The largest number of records that AWS Lambda will retrieve from your event source at the time of invoking your function. Your function receives an event with all the retrieved records. The default is 100 records.</p>
      - enabled: <p>Indicates whether AWS Lambda should begin polling the event source. By default, <code>Enabled</code> is true. </p>
      - eventSourceArn: <p>The Amazon Resource Name (ARN) of the Amazon Kinesis or the Amazon DynamoDB stream that is the event source. Any record added to this stream could cause AWS Lambda to invoke your Lambda function, it depends on the <code>BatchSize</code>. AWS Lambda POSTs the Amazon Kinesis event, containing records, to your Lambda function as JSON.</p>
      - functionName: <p>The Lambda function to invoke when AWS Lambda detects an event on the stream.</p> <p> You can specify the function name (for example, <code>Thumbnail</code>) or you can specify Amazon Resource Name (ARN) of the function (for example, <code>arn:aws:lambda:us-west-2:account-id:function:ThumbNail</code>). </p> <p> If you are using versioning, you can also provide a qualified function ARN (ARN that is qualified with function version or alias name as suffix). For more information about versioning, see <a href="http://docs.aws.amazon.com/lambda/latest/dg/versioning-aliases.html">AWS Lambda Function Versioning and Aliases</a> </p> <p>AWS Lambda also allows you to specify only the function name with the account ID qualifier (for example, <code>account-id:Thumbnail</code>). </p> <p>Note that the length constraint applies only to the ARN. If you specify only the function name, it is limited to 64 character in length.</p>
      - startingPosition: <p>The position in the stream where AWS Lambda should start reading. For more information, go to <a href="http://docs.aws.amazon.com/kinesis/latest/APIReference/API_GetShardIterator.html#Kinesis-GetShardIterator-request-ShardIteratorType">ShardIteratorType</a> in the <i>Amazon Kinesis API Reference</i>. </p>
 */
  public init(batchSize: Int?, enabled: Bool?, eventSourceArn: String, functionName: String, startingPosition: Eventsourceposition) {
self.batchSize = batchSize
self.enabled = enabled
self.eventSourceArn = eventSourceArn
self.functionName = functionName
self.startingPosition = startingPosition
  }
}

/**
<p/>
 */
public struct CreateFunctionRequest: AwswiftSerializable {
/**
<p>The code for the Lambda function.</p>
 */
  public let code: FunctionCode
/**
<p>A short, user-defined function description. Lambda does not use this value. Assign a meaningful description as you see fit.</p>
 */
  public let description: String?
/**
<p>The name you want to assign to the function you are uploading. The function names appear in the console and are returned in the <a>ListFunctions</a> API. Function names are used to specify functions to other AWS Lambda APIs, such as <a>Invoke</a>. </p>
 */
  public let functionName: String
/**
<p>The function within your code that Lambda calls to begin execution. For Node.js, it is the <i>module-name</i>.<i>export</i> value in your function. For Java, it can be <code>package.class-name::handler</code> or <code>package.class-name</code>. For more information, see <a href="http://docs.aws.amazon.com/lambda/latest/dg/java-programming-model-handler-types.html">Lambda Function Handler (Java)</a>. </p>
 */
  public let handler: String
/**
<p>The amount of memory, in MB, your Lambda function is given. Lambda uses this memory size to infer the amount of CPU and memory allocated to your function. Your function use-case determines your CPU and memory requirements. For example, a database operation might need less memory compared to an image processing function. The default value is 128 MB. The value must be a multiple of 64 MB.</p>
 */
  public let memorySize: Int?
/**
<p>This boolean parameter can be used to request AWS Lambda to create the Lambda function and publish a version as an atomic operation.</p>
 */
  public let publish: Bool?
/**
<p>The Amazon Resource Name (ARN) of the IAM role that Lambda assumes when it executes your function to access any other Amazon Web Services (AWS) resources. For more information, see <a href="http://docs.aws.amazon.com/lambda/latest/dg/lambda-introduction.html">AWS Lambda: How it Works</a>. </p>
 */
  public let role: String
/**
<p>The runtime environment for the Lambda function you are uploading.</p> <p>To use the Node.js runtime v4.3, set the value to "nodejs4.3". To use earlier runtime (v0.10.42), set the value to "nodejs".</p>
 */
  public let runtime: Runtime
/**
<p>The function execution time at which Lambda should terminate the function. Because the execution time has cost implications, we recommend you set this value based on your expected execution time. The default is 3 seconds.</p>
 */
  public let timeout: Int?
/**
<p>If your Lambda function accesses resources in a VPC, you provide this parameter identifying the list of security group IDs and subnet IDs. These must belong to the same VPC. You must provide at least one security group and one subnet ID.</p>
 */
  public let vpcConfig: VpcConfig?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    body["Code"] = code
    if description != nil { body["Description"] = description! }
    body["FunctionName"] = functionName
    body["Handler"] = handler
    if memorySize != nil { body["MemorySize"] = memorySize! }
    if publish != nil { body["Publish"] = publish! }
    body["Role"] = role
    body["Runtime"] = runtime
    if timeout != nil { body["Timeout"] = timeout! }
    if vpcConfig != nil { body["VpcConfig"] = vpcConfig! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - code: <p>The code for the Lambda function.</p>
      - description: <p>A short, user-defined function description. Lambda does not use this value. Assign a meaningful description as you see fit.</p>
      - functionName: <p>The name you want to assign to the function you are uploading. The function names appear in the console and are returned in the <a>ListFunctions</a> API. Function names are used to specify functions to other AWS Lambda APIs, such as <a>Invoke</a>. </p>
      - handler: <p>The function within your code that Lambda calls to begin execution. For Node.js, it is the <i>module-name</i>.<i>export</i> value in your function. For Java, it can be <code>package.class-name::handler</code> or <code>package.class-name</code>. For more information, see <a href="http://docs.aws.amazon.com/lambda/latest/dg/java-programming-model-handler-types.html">Lambda Function Handler (Java)</a>. </p>
      - memorySize: <p>The amount of memory, in MB, your Lambda function is given. Lambda uses this memory size to infer the amount of CPU and memory allocated to your function. Your function use-case determines your CPU and memory requirements. For example, a database operation might need less memory compared to an image processing function. The default value is 128 MB. The value must be a multiple of 64 MB.</p>
      - publish: <p>This boolean parameter can be used to request AWS Lambda to create the Lambda function and publish a version as an atomic operation.</p>
      - role: <p>The Amazon Resource Name (ARN) of the IAM role that Lambda assumes when it executes your function to access any other Amazon Web Services (AWS) resources. For more information, see <a href="http://docs.aws.amazon.com/lambda/latest/dg/lambda-introduction.html">AWS Lambda: How it Works</a>. </p>
      - runtime: <p>The runtime environment for the Lambda function you are uploading.</p> <p>To use the Node.js runtime v4.3, set the value to "nodejs4.3". To use earlier runtime (v0.10.42), set the value to "nodejs".</p>
      - timeout: <p>The function execution time at which Lambda should terminate the function. Because the execution time has cost implications, we recommend you set this value based on your expected execution time. The default is 3 seconds.</p>
      - vpcConfig: <p>If your Lambda function accesses resources in a VPC, you provide this parameter identifying the list of security group IDs and subnet IDs. These must belong to the same VPC. You must provide at least one security group and one subnet ID.</p>
 */
  public init(code: FunctionCode, description: String?, functionName: String, handler: String, memorySize: Int?, publish: Bool?, role: String, runtime: Runtime, timeout: Int?, vpcConfig: VpcConfig?) {
self.code = code
self.description = description
self.functionName = functionName
self.handler = handler
self.memorySize = memorySize
self.publish = publish
self.role = role
self.runtime = runtime
self.timeout = timeout
self.vpcConfig = vpcConfig
  }
}


public struct DeleteAliasRequest: AwswiftSerializable {
/**
<p>The Lambda function name for which the alias is created. Deleting an alias does not delete the function version to which it is pointing.</p>
 */
  public let functionName: String
/**
<p>Name of the alias to delete.</p>
 */
  public let name: String

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
    uri["FunctionName"] = "\(functionName)"
    uri["Name"] = "\(name)"
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - functionName: <p>The Lambda function name for which the alias is created. Deleting an alias does not delete the function version to which it is pointing.</p>
      - name: <p>Name of the alias to delete.</p>
 */
  public init(functionName: String, name: String) {
self.functionName = functionName
self.name = name
  }
}

/**
<p/>
 */
public struct DeleteEventSourceMappingRequest: AwswiftSerializable {
/**
<p>The event source mapping ID.</p>
 */
  public let uUID: String

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
    uri["UUID"] = "\(uUID)"
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - uUID: <p>The event source mapping ID.</p>
 */
  public init(uUID: String) {
self.uUID = uUID
  }
}

public struct DeleteFunctionRequest: AwswiftSerializable {
/**
<p>The Lambda function to delete.</p> <p> You can specify the function name (for example, <code>Thumbnail</code>) or you can specify Amazon Resource Name (ARN) of the function (for example, <code>arn:aws:lambda:us-west-2:account-id:function:ThumbNail</code>). If you are using versioning, you can also provide a qualified function ARN (ARN that is qualified with function version or alias name as suffix). AWS Lambda also allows you to specify only the function name with the account ID qualifier (for example, <code>account-id:Thumbnail</code>). Note that the length constraint applies only to the ARN. If you specify only the function name, it is limited to 64 character in length. </p>
 */
  public let functionName: String
/**
<p>Using this optional parameter you can specify a function version (but not the <code>$LATEST</code> version) to direct AWS Lambda to delete a specific function version. If the function version has one or more aliases pointing to it, you will get an error because you cannot have aliases pointing to it. You can delete any function version but not the <code>$LATEST</code>, that is, you cannot specify <code>$LATEST</code> as the value of this parameter. The <code>$LATEST</code> version can be deleted only when you want to delete all the function versions and aliases.</p> <p>You can only specify a function version, not an alias name, using this parameter. You cannot delete a function version using its alias.</p> <p>If you don't specify this parameter, AWS Lambda will delete the function, including all of its versions and aliases.</p>
 */
  public let qualifier: String?

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    var querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
    uri["FunctionName"] = "\(functionName)"
    if qualifier != nil { querystring["Qualifier"] = "\(qualifier!)" }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - functionName: <p>The Lambda function to delete.</p> <p> You can specify the function name (for example, <code>Thumbnail</code>) or you can specify Amazon Resource Name (ARN) of the function (for example, <code>arn:aws:lambda:us-west-2:account-id:function:ThumbNail</code>). If you are using versioning, you can also provide a qualified function ARN (ARN that is qualified with function version or alias name as suffix). AWS Lambda also allows you to specify only the function name with the account ID qualifier (for example, <code>account-id:Thumbnail</code>). Note that the length constraint applies only to the ARN. If you specify only the function name, it is limited to 64 character in length. </p>
      - qualifier: <p>Using this optional parameter you can specify a function version (but not the <code>$LATEST</code> version) to direct AWS Lambda to delete a specific function version. If the function version has one or more aliases pointing to it, you will get an error because you cannot have aliases pointing to it. You can delete any function version but not the <code>$LATEST</code>, that is, you cannot specify <code>$LATEST</code> as the value of this parameter. The <code>$LATEST</code> version can be deleted only when you want to delete all the function versions and aliases.</p> <p>You can only specify a function version, not an alias name, using this parameter. You cannot delete a function version using its alias.</p> <p>If you don't specify this parameter, AWS Lambda will delete the function, including all of its versions and aliases.</p>
 */
  public init(functionName: String, qualifier: String?) {
self.functionName = functionName
self.qualifier = qualifier
  }
}


/**
<p/>
 */
public struct EC2AccessDeniedException: Error, AwswiftDeserializable {
/**

 */
  public let message: String?
/**

 */
  public let lambdaType: String?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let json = try! JSONSerialization.jsonObject(with: data, options: [])
  return .json(json)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> EC2AccessDeniedException {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return EC2AccessDeniedException(
        message: jsonDict["Message"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      lambdaType: jsonDict["Type"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - message: 
      - lambdaType: 
 */
  public init(message: String?, lambdaType: String?) {
self.message = message
self.lambdaType = lambdaType
  }
}

/**
<p>AWS Lambda was throttled by Amazon EC2 during Lambda function initialization using the execution role provided for the Lambda function.</p>
 */
public struct EC2ThrottledException: Error, AwswiftDeserializable {
/**

 */
  public let message: String?
/**

 */
  public let lambdaType: String?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let json = try! JSONSerialization.jsonObject(with: data, options: [])
  return .json(json)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> EC2ThrottledException {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return EC2ThrottledException(
        message: jsonDict["Message"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      lambdaType: jsonDict["Type"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - message: 
      - lambdaType: 
 */
  public init(message: String?, lambdaType: String?) {
self.message = message
self.lambdaType = lambdaType
  }
}

/**
<p>AWS Lambda received an unexpected EC2 client exception while setting up for the Lambda function.</p>
 */
public struct EC2UnexpectedException: Error, AwswiftDeserializable {
/**

 */
  public let eC2ErrorCode: String?
/**

 */
  public let message: String?
/**

 */
  public let lambdaType: String?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let json = try! JSONSerialization.jsonObject(with: data, options: [])
  return .json(json)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> EC2UnexpectedException {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return EC2UnexpectedException(
        eC2ErrorCode: jsonDict["EC2ErrorCode"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      message: jsonDict["Message"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      lambdaType: jsonDict["Type"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - eC2ErrorCode: 
      - message: 
      - lambdaType: 
 */
  public init(eC2ErrorCode: String?, message: String?, lambdaType: String?) {
self.eC2ErrorCode = eC2ErrorCode
self.message = message
self.lambdaType = lambdaType
  }
}

/**
<p>AWS Lambda was not able to create an Elastic Network Interface (ENI) in the VPC, specified as part of Lambda function configuration, because the limit for network interfaces has been reached.</p>
 */
public struct ENILimitReachedException: Error, AwswiftDeserializable {
/**

 */
  public let message: String?
/**

 */
  public let lambdaType: String?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let json = try! JSONSerialization.jsonObject(with: data, options: [])
  return .json(json)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> ENILimitReachedException {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return ENILimitReachedException(
        message: jsonDict["Message"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      lambdaType: jsonDict["Type"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - message: 
      - lambdaType: 
 */
  public init(message: String?, lambdaType: String?) {
self.message = message
self.lambdaType = lambdaType
  }
}


/**
<p>Describes mapping between an Amazon Kinesis stream and a Lambda function.</p>
 */
public struct EventSourceMappingConfiguration: AwswiftSerializable, AwswiftDeserializable {
/**
<p>The largest number of records that AWS Lambda will retrieve from your event source at the time of invoking your function. Your function receives an event with all the retrieved records.</p>
 */
  public let batchSize: Int?
/**
<p>The Amazon Resource Name (ARN) of the Amazon Kinesis stream that is the source of events.</p>
 */
  public let eventSourceArn: String?
/**
<p>The Lambda function to invoke when AWS Lambda detects an event on the stream.</p>
 */
  public let functionArn: String?
/**
<p>The UTC time string indicating the last time the event mapping was updated.</p>
 */
  public let lastModified: Date?
/**
<p>The result of the last AWS Lambda invocation of your Lambda function.</p>
 */
  public let lastProcessingResult: String?
/**
<p>The state of the event source mapping. It can be <code>Creating</code>, <code>Enabled</code>, <code>Disabled</code>, <code>Enabling</code>, <code>Disabling</code>, <code>Updating</code>, or <code>Deleting</code>.</p>
 */
  public let state: String?
/**
<p>The reason the event source mapping is in its current state. It is either user-requested or an AWS Lambda-initiated state transition.</p>
 */
  public let stateTransitionReason: String?
/**
<p>The AWS Lambda assigned opaque identifier for the mapping.</p>
 */
  public let uUID: String?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if batchSize != nil { body["BatchSize"] = batchSize! }
    if eventSourceArn != nil { body["EventSourceArn"] = eventSourceArn! }
    if functionArn != nil { body["FunctionArn"] = functionArn! }
    if lastModified != nil { body["LastModified"] = lastModified! }
    if lastProcessingResult != nil { body["LastProcessingResult"] = lastProcessingResult! }
    if state != nil { body["State"] = state! }
    if stateTransitionReason != nil { body["StateTransitionReason"] = stateTransitionReason! }
    if uUID != nil { body["UUID"] = uUID! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let json = try! JSONSerialization.jsonObject(with: data, options: [])
  return .json(json)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> EventSourceMappingConfiguration {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return EventSourceMappingConfiguration(
        batchSize: jsonDict["BatchSize"].flatMap { ($0 is NSNull) ? nil : Int.deserialize(response: response, body: .json($0)) },
      eventSourceArn: jsonDict["EventSourceArn"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      functionArn: jsonDict["FunctionArn"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      lastModified: jsonDict["LastModified"].flatMap { ($0 is NSNull) ? nil : Date.deserialize(response: response, body: .json($0)) },
      lastProcessingResult: jsonDict["LastProcessingResult"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      state: jsonDict["State"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      stateTransitionReason: jsonDict["StateTransitionReason"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      uUID: jsonDict["UUID"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - batchSize: <p>The largest number of records that AWS Lambda will retrieve from your event source at the time of invoking your function. Your function receives an event with all the retrieved records.</p>
      - eventSourceArn: <p>The Amazon Resource Name (ARN) of the Amazon Kinesis stream that is the source of events.</p>
      - functionArn: <p>The Lambda function to invoke when AWS Lambda detects an event on the stream.</p>
      - lastModified: <p>The UTC time string indicating the last time the event mapping was updated.</p>
      - lastProcessingResult: <p>The result of the last AWS Lambda invocation of your Lambda function.</p>
      - state: <p>The state of the event source mapping. It can be <code>Creating</code>, <code>Enabled</code>, <code>Disabled</code>, <code>Enabling</code>, <code>Disabling</code>, <code>Updating</code>, or <code>Deleting</code>.</p>
      - stateTransitionReason: <p>The reason the event source mapping is in its current state. It is either user-requested or an AWS Lambda-initiated state transition.</p>
      - uUID: <p>The AWS Lambda assigned opaque identifier for the mapping.</p>
 */
  public init(batchSize: Int?, eventSourceArn: String?, functionArn: String?, lastModified: Date?, lastProcessingResult: String?, state: String?, stateTransitionReason: String?, uUID: String?) {
self.batchSize = batchSize
self.eventSourceArn = eventSourceArn
self.functionArn = functionArn
self.lastModified = lastModified
self.lastProcessingResult = lastProcessingResult
self.state = state
self.stateTransitionReason = stateTransitionReason
self.uUID = uUID
  }
}


enum Eventsourceposition: String, AwswiftDeserializable, AwswiftSerializable {
  case `tRIM_HORIZON` = "TRIM_HORIZON"
  case `lATEST` = "LATEST"

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Eventsourceposition {
    switch body { 
    case .json(let json): return Eventsourceposition(rawValue: json as! String)!
    case .xml(let node): return Eventsourceposition(rawValue: node.stringValue!)!
    }
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}



/**
<p>The code for the Lambda function.</p>
 */
public struct FunctionCode: AwswiftSerializable, AwswiftDeserializable {
/**
<p>Amazon S3 bucket name where the .zip file containing your deployment package is stored. This bucket must reside in the same AWS region where you are creating the Lambda function.</p>
 */
  public let s3Bucket: String?
/**
<p>The Amazon S3 object (the deployment package) key name you want to upload.</p>
 */
  public let s3Key: String?
/**
<p>The Amazon S3 object (the deployment package) version you want to upload.</p>
 */
  public let s3ObjectVersion: String?
/**
<p>The contents of your zip file containing your deployment package. If you are using the web API directly, the contents of the zip file must be base64-encoded. If you are using the AWS SDKs or the AWS CLI, the SDKs or CLI will do the encoding for you. For more information about creating a .zip file, go to <a href="http://docs.aws.amazon.com/lambda/latest/dg/intro-permission-model.html#lambda-intro-execution-role.html">Execution Permissions</a> in the <i>AWS Lambda Developer Guide</i>. </p>
 */
  public let zipFile: Data?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if s3Bucket != nil { body["S3Bucket"] = s3Bucket! }
    if s3Key != nil { body["S3Key"] = s3Key! }
    if s3ObjectVersion != nil { body["S3ObjectVersion"] = s3ObjectVersion! }
    if zipFile != nil { body["ZipFile"] = zipFile! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let json = try! JSONSerialization.jsonObject(with: data, options: [])
  return .json(json)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> FunctionCode {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return FunctionCode(
        s3Bucket: jsonDict["S3Bucket"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      s3Key: jsonDict["S3Key"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      s3ObjectVersion: jsonDict["S3ObjectVersion"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      zipFile: jsonDict["ZipFile"].flatMap { ($0 is NSNull) ? nil : Data.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - s3Bucket: <p>Amazon S3 bucket name where the .zip file containing your deployment package is stored. This bucket must reside in the same AWS region where you are creating the Lambda function.</p>
      - s3Key: <p>The Amazon S3 object (the deployment package) key name you want to upload.</p>
      - s3ObjectVersion: <p>The Amazon S3 object (the deployment package) version you want to upload.</p>
      - zipFile: <p>The contents of your zip file containing your deployment package. If you are using the web API directly, the contents of the zip file must be base64-encoded. If you are using the AWS SDKs or the AWS CLI, the SDKs or CLI will do the encoding for you. For more information about creating a .zip file, go to <a href="http://docs.aws.amazon.com/lambda/latest/dg/intro-permission-model.html#lambda-intro-execution-role.html">Execution Permissions</a> in the <i>AWS Lambda Developer Guide</i>. </p>
 */
  public init(s3Bucket: String?, s3Key: String?, s3ObjectVersion: String?, zipFile: Data?) {
self.s3Bucket = s3Bucket
self.s3Key = s3Key
self.s3ObjectVersion = s3ObjectVersion
self.zipFile = zipFile
  }
}

/**
<p>The object for the Lambda function location.</p>
 */
public struct FunctionCodeLocation: AwswiftSerializable, AwswiftDeserializable {
/**
<p>The presigned URL you can use to download the function's .zip file that you previously uploaded. The URL is valid for up to 10 minutes.</p>
 */
  public let location: String?
/**
<p>The repository from which you can download the function.</p>
 */
  public let repositoryType: String?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if location != nil { body["Location"] = location! }
    if repositoryType != nil { body["RepositoryType"] = repositoryType! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let json = try! JSONSerialization.jsonObject(with: data, options: [])
  return .json(json)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> FunctionCodeLocation {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return FunctionCodeLocation(
        location: jsonDict["Location"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      repositoryType: jsonDict["RepositoryType"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - location: <p>The presigned URL you can use to download the function's .zip file that you previously uploaded. The URL is valid for up to 10 minutes.</p>
      - repositoryType: <p>The repository from which you can download the function.</p>
 */
  public init(location: String?, repositoryType: String?) {
self.location = location
self.repositoryType = repositoryType
  }
}

/**
<p>A complex type that describes function metadata.</p>
 */
public struct FunctionConfiguration: AwswiftSerializable, AwswiftDeserializable {
/**
<p>It is the SHA256 hash of your function deployment package.</p>
 */
  public let codeSha256: String?
/**
<p>The size, in bytes, of the function .zip file you uploaded.</p>
 */
  public let codeSize: Int?
/**
<p>The user-provided description.</p>
 */
  public let description: String?
/**
<p>The Amazon Resource Name (ARN) assigned to the function.</p>
 */
  public let functionArn: String?
/**
<p>The name of the function.</p>
 */
  public let functionName: String?
/**
<p>The function Lambda calls to begin executing your function.</p>
 */
  public let handler: String?
/**
<p>The time stamp of the last time you updated the function.</p>
 */
  public let lastModified: String?
/**
<p>The memory size, in MB, you configured for the function. Must be a multiple of 64 MB.</p>
 */
  public let memorySize: Int?
/**
<p>The Amazon Resource Name (ARN) of the IAM role that Lambda assumes when it executes your function to access any other Amazon Web Services (AWS) resources.</p>
 */
  public let role: String?
/**
<p>The runtime environment for the Lambda function.</p> <p>To use the Node.js runtime v4.3, set the value to "nodejs4.3". To use earlier runtime (v0.10.42), set the value to "nodejs".</p>
 */
  public let runtime: Runtime?
/**
<p>The function execution time at which Lambda should terminate the function. Because the execution time has cost implications, we recommend you set this value based on your expected execution time. The default is 3 seconds.</p>
 */
  public let timeout: Int?
/**
<p>The version of the Lambda function.</p>
 */
  public let version: String?
/**
<p>VPC configuration associated with your Lambda function.</p>
 */
  public let vpcConfig: VpcConfigResponse?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if codeSha256 != nil { body["CodeSha256"] = codeSha256! }
    if codeSize != nil { body["CodeSize"] = codeSize! }
    if description != nil { body["Description"] = description! }
    if functionArn != nil { body["FunctionArn"] = functionArn! }
    if functionName != nil { body["FunctionName"] = functionName! }
    if handler != nil { body["Handler"] = handler! }
    if lastModified != nil { body["LastModified"] = lastModified! }
    if memorySize != nil { body["MemorySize"] = memorySize! }
    if role != nil { body["Role"] = role! }
    if runtime != nil { body["Runtime"] = runtime! }
    if timeout != nil { body["Timeout"] = timeout! }
    if version != nil { body["Version"] = version! }
    if vpcConfig != nil { body["VpcConfig"] = vpcConfig! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let json = try! JSONSerialization.jsonObject(with: data, options: [])
  return .json(json)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> FunctionConfiguration {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return FunctionConfiguration(
        codeSha256: jsonDict["CodeSha256"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      codeSize: jsonDict["CodeSize"].flatMap { ($0 is NSNull) ? nil : Int.deserialize(response: response, body: .json($0)) },
      description: jsonDict["Description"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      functionArn: jsonDict["FunctionArn"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      functionName: jsonDict["FunctionName"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      handler: jsonDict["Handler"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      lastModified: jsonDict["LastModified"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      memorySize: jsonDict["MemorySize"].flatMap { ($0 is NSNull) ? nil : Int.deserialize(response: response, body: .json($0)) },
      role: jsonDict["Role"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      runtime: jsonDict["Runtime"].flatMap { ($0 is NSNull) ? nil : Runtime.deserialize(response: response, body: .json($0)) },
      timeout: jsonDict["Timeout"].flatMap { ($0 is NSNull) ? nil : Int.deserialize(response: response, body: .json($0)) },
      version: jsonDict["Version"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      vpcConfig: jsonDict["VpcConfig"].flatMap { ($0 is NSNull) ? nil : VpcConfigResponse.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - codeSha256: <p>It is the SHA256 hash of your function deployment package.</p>
      - codeSize: <p>The size, in bytes, of the function .zip file you uploaded.</p>
      - description: <p>The user-provided description.</p>
      - functionArn: <p>The Amazon Resource Name (ARN) assigned to the function.</p>
      - functionName: <p>The name of the function.</p>
      - handler: <p>The function Lambda calls to begin executing your function.</p>
      - lastModified: <p>The time stamp of the last time you updated the function.</p>
      - memorySize: <p>The memory size, in MB, you configured for the function. Must be a multiple of 64 MB.</p>
      - role: <p>The Amazon Resource Name (ARN) of the IAM role that Lambda assumes when it executes your function to access any other Amazon Web Services (AWS) resources.</p>
      - runtime: <p>The runtime environment for the Lambda function.</p> <p>To use the Node.js runtime v4.3, set the value to "nodejs4.3". To use earlier runtime (v0.10.42), set the value to "nodejs".</p>
      - timeout: <p>The function execution time at which Lambda should terminate the function. Because the execution time has cost implications, we recommend you set this value based on your expected execution time. The default is 3 seconds.</p>
      - version: <p>The version of the Lambda function.</p>
      - vpcConfig: <p>VPC configuration associated with your Lambda function.</p>
 */
  public init(codeSha256: String?, codeSize: Int?, description: String?, functionArn: String?, functionName: String?, handler: String?, lastModified: String?, memorySize: Int?, role: String?, runtime: Runtime?, timeout: Int?, version: String?, vpcConfig: VpcConfigResponse?) {
self.codeSha256 = codeSha256
self.codeSize = codeSize
self.description = description
self.functionArn = functionArn
self.functionName = functionName
self.handler = handler
self.lastModified = lastModified
self.memorySize = memorySize
self.role = role
self.runtime = runtime
self.timeout = timeout
self.version = version
self.vpcConfig = vpcConfig
  }
}



public struct GetAliasRequest: AwswiftSerializable {
/**
<p>Function name for which the alias is created. An alias is a subresource that exists only in the context of an existing Lambda function so you must specify the function name.</p>
 */
  public let functionName: String
/**
<p>Name of the alias for which you want to retrieve information.</p>
 */
  public let name: String

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
    uri["FunctionName"] = "\(functionName)"
    uri["Name"] = "\(name)"
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - functionName: <p>Function name for which the alias is created. An alias is a subresource that exists only in the context of an existing Lambda function so you must specify the function name.</p>
      - name: <p>Name of the alias for which you want to retrieve information.</p>
 */
  public init(functionName: String, name: String) {
self.functionName = functionName
self.name = name
  }
}

/**
<p/>
 */
public struct GetEventSourceMappingRequest: AwswiftSerializable {
/**
<p>The AWS Lambda assigned ID of the event source mapping.</p>
 */
  public let uUID: String

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
    uri["UUID"] = "\(uUID)"
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - uUID: <p>The AWS Lambda assigned ID of the event source mapping.</p>
 */
  public init(uUID: String) {
self.uUID = uUID
  }
}

/**
<p/>
 */
public struct GetFunctionConfigurationRequest: AwswiftSerializable {
/**
<p>The name of the Lambda function for which you want to retrieve the configuration information.</p> <p> You can specify a function name (for example, <code>Thumbnail</code>) or you can specify Amazon Resource Name (ARN) of the function (for example, <code>arn:aws:lambda:us-west-2:account-id:function:ThumbNail</code>). AWS Lambda also allows you to specify a partial ARN (for example, <code>account-id:Thumbnail</code>). Note that the length constraint applies only to the ARN. If you specify only the function name, it is limited to 64 character in length. </p>
 */
  public let functionName: String
/**
<p>Using this optional parameter you can specify a function version or an alias name. If you specify function version, the API uses qualified function ARN and returns information about the specific function version. If you specify an alias name, the API uses the alias ARN and returns information about the function version to which the alias points.</p> <p>If you don't specify this parameter, the API uses unqualified function ARN, and returns information about the <code>$LATEST</code> function version.</p>
 */
  public let qualifier: String?

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    var querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
    uri["FunctionName"] = "\(functionName)"
    if qualifier != nil { querystring["Qualifier"] = "\(qualifier!)" }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - functionName: <p>The name of the Lambda function for which you want to retrieve the configuration information.</p> <p> You can specify a function name (for example, <code>Thumbnail</code>) or you can specify Amazon Resource Name (ARN) of the function (for example, <code>arn:aws:lambda:us-west-2:account-id:function:ThumbNail</code>). AWS Lambda also allows you to specify a partial ARN (for example, <code>account-id:Thumbnail</code>). Note that the length constraint applies only to the ARN. If you specify only the function name, it is limited to 64 character in length. </p>
      - qualifier: <p>Using this optional parameter you can specify a function version or an alias name. If you specify function version, the API uses qualified function ARN and returns information about the specific function version. If you specify an alias name, the API uses the alias ARN and returns information about the function version to which the alias points.</p> <p>If you don't specify this parameter, the API uses unqualified function ARN, and returns information about the <code>$LATEST</code> function version.</p>
 */
  public init(functionName: String, qualifier: String?) {
self.functionName = functionName
self.qualifier = qualifier
  }
}

/**
<p/>
 */
public struct GetFunctionRequest: AwswiftSerializable {
/**
<p>The Lambda function name.</p> <p> You can specify a function name (for example, <code>Thumbnail</code>) or you can specify Amazon Resource Name (ARN) of the function (for example, <code>arn:aws:lambda:us-west-2:account-id:function:ThumbNail</code>). AWS Lambda also allows you to specify a partial ARN (for example, <code>account-id:Thumbnail</code>). Note that the length constraint applies only to the ARN. If you specify only the function name, it is limited to 64 character in length. </p>
 */
  public let functionName: String
/**
<p>Using this optional parameter to specify a function version or an alias name. If you specify function version, the API uses qualified function ARN for the request and returns information about the specific Lambda function version. If you specify an alias name, the API uses the alias ARN and returns information about the function version to which the alias points. If you don't provide this parameter, the API uses unqualified function ARN and returns information about the <code>$LATEST</code> version of the Lambda function.</p>
 */
  public let qualifier: String?

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    var querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
    uri["FunctionName"] = "\(functionName)"
    if qualifier != nil { querystring["Qualifier"] = "\(qualifier!)" }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - functionName: <p>The Lambda function name.</p> <p> You can specify a function name (for example, <code>Thumbnail</code>) or you can specify Amazon Resource Name (ARN) of the function (for example, <code>arn:aws:lambda:us-west-2:account-id:function:ThumbNail</code>). AWS Lambda also allows you to specify a partial ARN (for example, <code>account-id:Thumbnail</code>). Note that the length constraint applies only to the ARN. If you specify only the function name, it is limited to 64 character in length. </p>
      - qualifier: <p>Using this optional parameter to specify a function version or an alias name. If you specify function version, the API uses qualified function ARN for the request and returns information about the specific Lambda function version. If you specify an alias name, the API uses the alias ARN and returns information about the function version to which the alias points. If you don't provide this parameter, the API uses unqualified function ARN and returns information about the <code>$LATEST</code> version of the Lambda function.</p>
 */
  public init(functionName: String, qualifier: String?) {
self.functionName = functionName
self.qualifier = qualifier
  }
}

/**
<p>This response contains the object for the Lambda function location (see .</p>
 */
public struct GetFunctionResponse: AwswiftDeserializable {
/**

 */
  public let code: FunctionCodeLocation?
/**

 */
  public let configuration: FunctionConfiguration?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let json = try! JSONSerialization.jsonObject(with: data, options: [])
  return .json(json)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> GetFunctionResponse {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return GetFunctionResponse(
        code: jsonDict["Code"].flatMap { ($0 is NSNull) ? nil : FunctionCodeLocation.deserialize(response: response, body: .json($0)) },
      configuration: jsonDict["Configuration"].flatMap { ($0 is NSNull) ? nil : FunctionConfiguration.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - code: 
      - configuration: 
 */
  public init(code: FunctionCodeLocation?, configuration: FunctionConfiguration?) {
self.code = code
self.configuration = configuration
  }
}

/**
<p/>
 */
public struct GetPolicyRequest: AwswiftSerializable {
/**
<p>Function name whose resource policy you want to retrieve.</p> <p> You can specify the function name (for example, <code>Thumbnail</code>) or you can specify Amazon Resource Name (ARN) of the function (for example, <code>arn:aws:lambda:us-west-2:account-id:function:ThumbNail</code>). If you are using versioning, you can also provide a qualified function ARN (ARN that is qualified with function version or alias name as suffix). AWS Lambda also allows you to specify only the function name with the account ID qualifier (for example, <code>account-id:Thumbnail</code>). Note that the length constraint applies only to the ARN. If you specify only the function name, it is limited to 64 character in length. </p>
 */
  public let functionName: String
/**
<p>You can specify this optional query parameter to specify a function version or an alias name in which case this API will return all permissions associated with the specific qualified ARN. If you don't provide this parameter, the API will return permissions that apply to the unqualified function ARN.</p>
 */
  public let qualifier: String?

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    var querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
    uri["FunctionName"] = "\(functionName)"
    if qualifier != nil { querystring["Qualifier"] = "\(qualifier!)" }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - functionName: <p>Function name whose resource policy you want to retrieve.</p> <p> You can specify the function name (for example, <code>Thumbnail</code>) or you can specify Amazon Resource Name (ARN) of the function (for example, <code>arn:aws:lambda:us-west-2:account-id:function:ThumbNail</code>). If you are using versioning, you can also provide a qualified function ARN (ARN that is qualified with function version or alias name as suffix). AWS Lambda also allows you to specify only the function name with the account ID qualifier (for example, <code>account-id:Thumbnail</code>). Note that the length constraint applies only to the ARN. If you specify only the function name, it is limited to 64 character in length. </p>
      - qualifier: <p>You can specify this optional query parameter to specify a function version or an alias name in which case this API will return all permissions associated with the specific qualified ARN. If you don't provide this parameter, the API will return permissions that apply to the unqualified function ARN.</p>
 */
  public init(functionName: String, qualifier: String?) {
self.functionName = functionName
self.qualifier = qualifier
  }
}

/**
<p/>
 */
public struct GetPolicyResponse: AwswiftDeserializable {
/**
<p>The resource policy associated with the specified function. The response returns the same as a string using a backslash ("\") as an escape character in the JSON.</p>
 */
  public let policy: String?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let json = try! JSONSerialization.jsonObject(with: data, options: [])
  return .json(json)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> GetPolicyResponse {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return GetPolicyResponse(
        policy: jsonDict["Policy"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - policy: <p>The resource policy associated with the specified function. The response returns the same as a string using a backslash ("\") as an escape character in the JSON.</p>
 */
  public init(policy: String?) {
self.policy = policy
  }
}




/**
<p>One of the parameters in the request is invalid. For example, if you provided an IAM role for AWS Lambda to assume in the <code>CreateFunction</code> or the <code>UpdateFunctionConfiguration</code> API, that AWS Lambda is unable to assume you will get this exception. </p>
 */
public struct InvalidParameterValueException: Error, AwswiftDeserializable {
/**
<p/>
 */
  public let lambdaType: String?
/**
<p/>
 */
  public let message: String?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let json = try! JSONSerialization.jsonObject(with: data, options: [])
  return .json(json)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> InvalidParameterValueException {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return InvalidParameterValueException(
        lambdaType: jsonDict["Type"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      message: jsonDict["message"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - lambdaType: <p/>
      - message: <p/>
 */
  public init(lambdaType: String?, message: String?) {
self.lambdaType = lambdaType
self.message = message
  }
}

/**
<p>The request body could not be parsed as JSON.</p>
 */
public struct InvalidRequestContentException: Error, AwswiftDeserializable {
/**
<p/>
 */
  public let lambdaType: String?
/**
<p/>
 */
  public let message: String?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let json = try! JSONSerialization.jsonObject(with: data, options: [])
  return .json(json)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> InvalidRequestContentException {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return InvalidRequestContentException(
        lambdaType: jsonDict["Type"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      message: jsonDict["message"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - lambdaType: <p/>
      - message: <p/>
 */
  public init(lambdaType: String?, message: String?) {
self.lambdaType = lambdaType
self.message = message
  }
}

/**
<p>The Security Group ID provided in the Lambda function VPC configuration is invalid.</p>
 */
public struct InvalidSecurityGroupIDException: Error, AwswiftDeserializable {
/**

 */
  public let message: String?
/**

 */
  public let lambdaType: String?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let json = try! JSONSerialization.jsonObject(with: data, options: [])
  return .json(json)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> InvalidSecurityGroupIDException {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return InvalidSecurityGroupIDException(
        message: jsonDict["Message"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      lambdaType: jsonDict["Type"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - message: 
      - lambdaType: 
 */
  public init(message: String?, lambdaType: String?) {
self.message = message
self.lambdaType = lambdaType
  }
}

/**
<p>The Subnet ID provided in the Lambda function VPC configuration is invalid.</p>
 */
public struct InvalidSubnetIDException: Error, AwswiftDeserializable {
/**

 */
  public let message: String?
/**

 */
  public let lambdaType: String?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let json = try! JSONSerialization.jsonObject(with: data, options: [])
  return .json(json)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> InvalidSubnetIDException {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return InvalidSubnetIDException(
        message: jsonDict["Message"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      lambdaType: jsonDict["Type"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - message: 
      - lambdaType: 
 */
  public init(message: String?, lambdaType: String?) {
self.message = message
self.lambdaType = lambdaType
  }
}

/**
<p>AWS Lambda could not unzip the function zip file.</p>
 */
public struct InvalidZipFileException: Error, AwswiftDeserializable {
/**

 */
  public let message: String?
/**

 */
  public let lambdaType: String?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let json = try! JSONSerialization.jsonObject(with: data, options: [])
  return .json(json)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> InvalidZipFileException {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return InvalidZipFileException(
        message: jsonDict["Message"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      lambdaType: jsonDict["Type"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - message: 
      - lambdaType: 
 */
  public init(message: String?, lambdaType: String?) {
self.message = message
self.lambdaType = lambdaType
  }
}

/**
<p/>
 */
public struct InvocationRequest: AwswiftSerializable {
/**
<p>Using the <code>ClientContext</code> you can pass client-specific information to the Lambda function you are invoking. You can then process the client information in your Lambda function as you choose through the context variable. For an example of a <code>ClientContext</code> JSON, see <a href="http://docs.aws.amazon.com/mobileanalytics/latest/ug/PutEvents.html">PutEvents</a> in the <i>Amazon Mobile Analytics API Reference and User Guide</i>.</p> <p>The ClientContext JSON must be base64-encoded.</p>
 */
  public let clientContext: String?
/**
<p>The Lambda function name.</p> <p> You can specify a function name (for example, <code>Thumbnail</code>) or you can specify Amazon Resource Name (ARN) of the function (for example, <code>arn:aws:lambda:us-west-2:account-id:function:ThumbNail</code>). AWS Lambda also allows you to specify a partial ARN (for example, <code>account-id:Thumbnail</code>). Note that the length constraint applies only to the ARN. If you specify only the function name, it is limited to 64 character in length. </p>
 */
  public let functionName: String
/**
<p>By default, the <code>Invoke</code> API assumes <code>RequestResponse</code> invocation type. You can optionally request asynchronous execution by specifying <code>Event</code> as the <code>InvocationType</code>. You can also use this parameter to request AWS Lambda to not execute the function but do some verification, such as if the caller is authorized to invoke the function and if the inputs are valid. You request this by specifying <code>DryRun</code> as the <code>InvocationType</code>. This is useful in a cross-account scenario when you want to verify access to a function without running it. </p>
 */
  public let invocationType: Invocationtype?
/**
<p>You can set this optional parameter to <code>Tail</code> in the request only if you specify the <code>InvocationType</code> parameter with value <code>RequestResponse</code>. In this case, AWS Lambda returns the base64-encoded last 4 KB of log data produced by your Lambda function in the <code>x-amz-log-result</code> header. </p>
 */
  public let logType: Logtype?
/**
<p>JSON that you want to provide to your Lambda function as input.</p>
 */
  public let payload: Data?
/**
<p>You can use this optional parameter to specify a Lambda function version or alias name. If you specify a function version, the API uses the qualified function ARN to invoke a specific Lambda function. If you specify an alias name, the API uses the alias ARN to invoke the Lambda function version to which the alias points.</p> <p>If you don't provide this parameter, then the API uses unqualified function ARN which results in invocation of the <code>$LATEST</code> version.</p>
 */
  public let qualifier: String?

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    var querystring: [String: String] = [:]
    var header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    uri["FunctionName"] = "\(functionName)"
    if qualifier != nil { querystring["Qualifier"] = "\(qualifier!)" }
    if clientContext != nil { header["X-Amz-Client-Context"] = "\(clientContext!)" }
    if invocationType != nil { header["X-Amz-Invocation-Type"] = "\(invocationType!)" }
    if logType != nil { header["X-Amz-Log-Type"] = "\(logType!)" }
    if payload != nil { body["Payload"] = payload! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - clientContext: <p>Using the <code>ClientContext</code> you can pass client-specific information to the Lambda function you are invoking. You can then process the client information in your Lambda function as you choose through the context variable. For an example of a <code>ClientContext</code> JSON, see <a href="http://docs.aws.amazon.com/mobileanalytics/latest/ug/PutEvents.html">PutEvents</a> in the <i>Amazon Mobile Analytics API Reference and User Guide</i>.</p> <p>The ClientContext JSON must be base64-encoded.</p>
      - functionName: <p>The Lambda function name.</p> <p> You can specify a function name (for example, <code>Thumbnail</code>) or you can specify Amazon Resource Name (ARN) of the function (for example, <code>arn:aws:lambda:us-west-2:account-id:function:ThumbNail</code>). AWS Lambda also allows you to specify a partial ARN (for example, <code>account-id:Thumbnail</code>). Note that the length constraint applies only to the ARN. If you specify only the function name, it is limited to 64 character in length. </p>
      - invocationType: <p>By default, the <code>Invoke</code> API assumes <code>RequestResponse</code> invocation type. You can optionally request asynchronous execution by specifying <code>Event</code> as the <code>InvocationType</code>. You can also use this parameter to request AWS Lambda to not execute the function but do some verification, such as if the caller is authorized to invoke the function and if the inputs are valid. You request this by specifying <code>DryRun</code> as the <code>InvocationType</code>. This is useful in a cross-account scenario when you want to verify access to a function without running it. </p>
      - logType: <p>You can set this optional parameter to <code>Tail</code> in the request only if you specify the <code>InvocationType</code> parameter with value <code>RequestResponse</code>. In this case, AWS Lambda returns the base64-encoded last 4 KB of log data produced by your Lambda function in the <code>x-amz-log-result</code> header. </p>
      - payload: <p>JSON that you want to provide to your Lambda function as input.</p>
      - qualifier: <p>You can use this optional parameter to specify a Lambda function version or alias name. If you specify a function version, the API uses the qualified function ARN to invoke a specific Lambda function. If you specify an alias name, the API uses the alias ARN to invoke the Lambda function version to which the alias points.</p> <p>If you don't provide this parameter, then the API uses unqualified function ARN which results in invocation of the <code>$LATEST</code> version.</p>
 */
  public init(clientContext: String?, functionName: String, invocationType: Invocationtype?, logType: Logtype?, payload: Data?, qualifier: String?) {
self.clientContext = clientContext
self.functionName = functionName
self.invocationType = invocationType
self.logType = logType
self.payload = payload
self.qualifier = qualifier
  }
}

/**
<p>Upon success, returns an empty response. Otherwise, throws an exception.</p>
 */
public struct InvocationResponse: AwswiftDeserializable {
/**
<p>Indicates whether an error occurred while executing the Lambda function. If an error occurred this field will have one of two values; <code>Handled</code> or <code>Unhandled</code>. <code>Handled</code> errors are errors that are reported by the function while the <code>Unhandled</code> errors are those detected and reported by AWS Lambda. Unhandled errors include out of memory errors and function timeouts. For information about how to report an <code>Handled</code> error, see <a href="http://docs.aws.amazon.com/lambda/latest/dg/programming-model.html">Programming Model</a>. </p>
 */
  public let functionError: String?
/**
<p> It is the base64-encoded logs for the Lambda function invocation. This is present only if the invocation type is <code>RequestResponse</code> and the logs were requested. </p>
 */
  public let logResult: String?
/**
<p> It is the JSON representation of the object returned by the Lambda function. In This is present only if the invocation type is <code>RequestResponse</code>. </p> <p>In the event of a function error this field contains a message describing the error. For the <code>Handled</code> errors the Lambda function will report this message. For <code>Unhandled</code> errors AWS Lambda reports the message. </p>
 */
  public let payload: Data?
/**
<p>The HTTP status code will be in the 200 range for successful request. For the <code>RequestResonse</code> invocation type this status code will be 200. For the <code>Event</code> invocation type this status code will be 202. For the <code>DryRun</code> invocation type the status code will be 204. </p>
 */
  public let statusCode: Int?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let json = try! JSONSerialization.jsonObject(with: data, options: [])
  return .json(json)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> InvocationResponse {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return InvocationResponse(
        functionError: response.allHeaderFields["X-Amz-Function-Error"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      logResult: response.allHeaderFields["X-Amz-Log-Result"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      payload: jsonDict["Payload"].flatMap { ($0 is NSNull) ? nil : Data.deserialize(response: response, body: .json($0)) },
      statusCode: response.statusCode
    )
  }

/**
    - parameters:
      - functionError: <p>Indicates whether an error occurred while executing the Lambda function. If an error occurred this field will have one of two values; <code>Handled</code> or <code>Unhandled</code>. <code>Handled</code> errors are errors that are reported by the function while the <code>Unhandled</code> errors are those detected and reported by AWS Lambda. Unhandled errors include out of memory errors and function timeouts. For information about how to report an <code>Handled</code> error, see <a href="http://docs.aws.amazon.com/lambda/latest/dg/programming-model.html">Programming Model</a>. </p>
      - logResult: <p> It is the base64-encoded logs for the Lambda function invocation. This is present only if the invocation type is <code>RequestResponse</code> and the logs were requested. </p>
      - payload: <p> It is the JSON representation of the object returned by the Lambda function. In This is present only if the invocation type is <code>RequestResponse</code>. </p> <p>In the event of a function error this field contains a message describing the error. For the <code>Handled</code> errors the Lambda function will report this message. For <code>Unhandled</code> errors AWS Lambda reports the message. </p>
      - statusCode: <p>The HTTP status code will be in the 200 range for successful request. For the <code>RequestResonse</code> invocation type this status code will be 200. For the <code>Event</code> invocation type this status code will be 202. For the <code>DryRun</code> invocation type the status code will be 204. </p>
 */
  public init(functionError: String?, logResult: String?, payload: Data?, statusCode: Int?) {
self.functionError = functionError
self.logResult = logResult
self.payload = payload
self.statusCode = statusCode
  }
}

enum Invocationtype: String, AwswiftDeserializable, AwswiftSerializable {
  case `event` = "Event"
  case `requestResponse` = "RequestResponse"
  case `dryRun` = "DryRun"

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Invocationtype {
    switch body { 
    case .json(let json): return Invocationtype(rawValue: json as! String)!
    case .xml(let node): return Invocationtype(rawValue: node.stringValue!)!
    }
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}

/**
<p/>
 */
public struct InvokeAsyncRequest: AwswiftSerializable {
/**
<p>The Lambda function name.</p>
 */
  public let functionName: String
/**
<p>JSON that you want to provide to your Lambda function as input.</p>
 */
  public let invokeArgs: Data

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    uri["FunctionName"] = "\(functionName)"
    body["InvokeArgs"] = invokeArgs
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - functionName: <p>The Lambda function name.</p>
      - invokeArgs: <p>JSON that you want to provide to your Lambda function as input.</p>
 */
  public init(functionName: String, invokeArgs: Data) {
self.functionName = functionName
self.invokeArgs = invokeArgs
  }
}

/**
<p>Upon success, it returns empty response. Otherwise, throws an exception.</p>
 */
public struct InvokeAsyncResponse: AwswiftDeserializable {
/**
<p>It will be 202 upon success.</p>
 */
  public let status: Int?


  static func deserializableBody(data: Data) -> DeserializableBody {
    fatalError()
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> InvokeAsyncResponse {
  
    return InvokeAsyncResponse(
        status: response.statusCode
    )
  }

/**
    - parameters:
      - status: <p>It will be 202 upon success.</p>
 */
  public init(status: Int?) {
self.status = status
  }
}

public struct ListAliasesRequest: AwswiftSerializable {
/**
<p>Lambda function name for which the alias is created.</p>
 */
  public let functionName: String
/**
<p>If you specify this optional parameter, the API returns only the aliases that are pointing to the specific Lambda function version, otherwise the API returns all of the aliases created for the Lambda function.</p>
 */
  public let functionVersion: String?
/**
<p>Optional string. An opaque pagination token returned from a previous <code>ListAliases</code> operation. If present, indicates where to continue the listing.</p>
 */
  public let marker: String?
/**
<p>Optional integer. Specifies the maximum number of aliases to return in response. This parameter value must be greater than 0.</p>
 */
  public let maxItems: Int?

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    var querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
    uri["FunctionName"] = "\(functionName)"
    if functionVersion != nil { querystring["FunctionVersion"] = "\(functionVersion!)" }
    if marker != nil { querystring["Marker"] = "\(marker!)" }
    if maxItems != nil { querystring["MaxItems"] = "\(maxItems!)" }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - functionName: <p>Lambda function name for which the alias is created.</p>
      - functionVersion: <p>If you specify this optional parameter, the API returns only the aliases that are pointing to the specific Lambda function version, otherwise the API returns all of the aliases created for the Lambda function.</p>
      - marker: <p>Optional string. An opaque pagination token returned from a previous <code>ListAliases</code> operation. If present, indicates where to continue the listing.</p>
      - maxItems: <p>Optional integer. Specifies the maximum number of aliases to return in response. This parameter value must be greater than 0.</p>
 */
  public init(functionName: String, functionVersion: String?, marker: String?, maxItems: Int?) {
self.functionName = functionName
self.functionVersion = functionVersion
self.marker = marker
self.maxItems = maxItems
  }
}

public struct ListAliasesResponse: AwswiftDeserializable {
/**
<p>A list of aliases.</p>
 */
  public let aliases: [AliasConfiguration]?
/**
<p>A string, present if there are more aliases.</p>
 */
  public let nextMarker: String?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let json = try! JSONSerialization.jsonObject(with: data, options: [])
  return .json(json)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> ListAliasesResponse {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return ListAliasesResponse(
        aliases: jsonDict["Aliases"].flatMap { ($0 is NSNull) ? nil : [AliasConfiguration].deserialize(response: response, body: .json($0)) },
      nextMarker: jsonDict["NextMarker"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - aliases: <p>A list of aliases.</p>
      - nextMarker: <p>A string, present if there are more aliases.</p>
 */
  public init(aliases: [AliasConfiguration]?, nextMarker: String?) {
self.aliases = aliases
self.nextMarker = nextMarker
  }
}

/**
<p/>
 */
public struct ListEventSourceMappingsRequest: AwswiftSerializable {
/**
<p>The Amazon Resource Name (ARN) of the Amazon Kinesis stream. (This parameter is optional.)</p>
 */
  public let eventSourceArn: String?
/**
<p>The name of the Lambda function.</p> <p> You can specify the function name (for example, <code>Thumbnail</code>) or you can specify Amazon Resource Name (ARN) of the function (for example, <code>arn:aws:lambda:us-west-2:account-id:function:ThumbNail</code>). If you are using versioning, you can also provide a qualified function ARN (ARN that is qualified with function version or alias name as suffix). AWS Lambda also allows you to specify only the function name with the account ID qualifier (for example, <code>account-id:Thumbnail</code>). Note that the length constraint applies only to the ARN. If you specify only the function name, it is limited to 64 character in length. </p>
 */
  public let functionName: String?
/**
<p>Optional string. An opaque pagination token returned from a previous <code>ListEventSourceMappings</code> operation. If present, specifies to continue the list from where the returning call left off. </p>
 */
  public let marker: String?
/**
<p>Optional integer. Specifies the maximum number of event sources to return in response. This value must be greater than 0.</p>
 */
  public let maxItems: Int?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    var querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
    if eventSourceArn != nil { querystring["EventSourceArn"] = "\(eventSourceArn!)" }
    if functionName != nil { querystring["FunctionName"] = "\(functionName!)" }
    if marker != nil { querystring["Marker"] = "\(marker!)" }
    if maxItems != nil { querystring["MaxItems"] = "\(maxItems!)" }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - eventSourceArn: <p>The Amazon Resource Name (ARN) of the Amazon Kinesis stream. (This parameter is optional.)</p>
      - functionName: <p>The name of the Lambda function.</p> <p> You can specify the function name (for example, <code>Thumbnail</code>) or you can specify Amazon Resource Name (ARN) of the function (for example, <code>arn:aws:lambda:us-west-2:account-id:function:ThumbNail</code>). If you are using versioning, you can also provide a qualified function ARN (ARN that is qualified with function version or alias name as suffix). AWS Lambda also allows you to specify only the function name with the account ID qualifier (for example, <code>account-id:Thumbnail</code>). Note that the length constraint applies only to the ARN. If you specify only the function name, it is limited to 64 character in length. </p>
      - marker: <p>Optional string. An opaque pagination token returned from a previous <code>ListEventSourceMappings</code> operation. If present, specifies to continue the list from where the returning call left off. </p>
      - maxItems: <p>Optional integer. Specifies the maximum number of event sources to return in response. This value must be greater than 0.</p>
 */
  public init(eventSourceArn: String?, functionName: String?, marker: String?, maxItems: Int?) {
self.eventSourceArn = eventSourceArn
self.functionName = functionName
self.marker = marker
self.maxItems = maxItems
  }
}

/**
<p>Contains a list of event sources (see )</p>
 */
public struct ListEventSourceMappingsResponse: AwswiftDeserializable {
/**
<p>An array of <code>EventSourceMappingConfiguration</code> objects.</p>
 */
  public let eventSourceMappings: [EventSourceMappingConfiguration]?
/**
<p>A string, present if there are more event source mappings.</p>
 */
  public let nextMarker: String?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let json = try! JSONSerialization.jsonObject(with: data, options: [])
  return .json(json)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> ListEventSourceMappingsResponse {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return ListEventSourceMappingsResponse(
        eventSourceMappings: jsonDict["EventSourceMappings"].flatMap { ($0 is NSNull) ? nil : [EventSourceMappingConfiguration].deserialize(response: response, body: .json($0)) },
      nextMarker: jsonDict["NextMarker"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - eventSourceMappings: <p>An array of <code>EventSourceMappingConfiguration</code> objects.</p>
      - nextMarker: <p>A string, present if there are more event source mappings.</p>
 */
  public init(eventSourceMappings: [EventSourceMappingConfiguration]?, nextMarker: String?) {
self.eventSourceMappings = eventSourceMappings
self.nextMarker = nextMarker
  }
}

/**
<p/>
 */
public struct ListFunctionsRequest: AwswiftSerializable {
/**
<p>Optional string. An opaque pagination token returned from a previous <code>ListFunctions</code> operation. If present, indicates where to continue the listing. </p>
 */
  public let marker: String?
/**
<p>Optional integer. Specifies the maximum number of AWS Lambda functions to return in response. This parameter value must be greater than 0.</p>
 */
  public let maxItems: Int?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    var querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
    if marker != nil { querystring["Marker"] = "\(marker!)" }
    if maxItems != nil { querystring["MaxItems"] = "\(maxItems!)" }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - marker: <p>Optional string. An opaque pagination token returned from a previous <code>ListFunctions</code> operation. If present, indicates where to continue the listing. </p>
      - maxItems: <p>Optional integer. Specifies the maximum number of AWS Lambda functions to return in response. This parameter value must be greater than 0.</p>
 */
  public init(marker: String?, maxItems: Int?) {
self.marker = marker
self.maxItems = maxItems
  }
}

/**
<p>Contains a list of AWS Lambda function configurations (see <a>FunctionConfiguration</a>.</p>
 */
public struct ListFunctionsResponse: AwswiftDeserializable {
/**
<p>A list of Lambda functions.</p>
 */
  public let functions: [FunctionConfiguration]?
/**
<p>A string, present if there are more functions.</p>
 */
  public let nextMarker: String?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let json = try! JSONSerialization.jsonObject(with: data, options: [])
  return .json(json)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> ListFunctionsResponse {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return ListFunctionsResponse(
        functions: jsonDict["Functions"].flatMap { ($0 is NSNull) ? nil : [FunctionConfiguration].deserialize(response: response, body: .json($0)) },
      nextMarker: jsonDict["NextMarker"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - functions: <p>A list of Lambda functions.</p>
      - nextMarker: <p>A string, present if there are more functions.</p>
 */
  public init(functions: [FunctionConfiguration]?, nextMarker: String?) {
self.functions = functions
self.nextMarker = nextMarker
  }
}

/**
<p/>
 */
public struct ListVersionsByFunctionRequest: AwswiftSerializable {
/**
<p>Function name whose versions to list. You can specify a function name (for example, <code>Thumbnail</code>) or you can specify Amazon Resource Name (ARN) of the function (for example, <code>arn:aws:lambda:us-west-2:account-id:function:ThumbNail</code>). AWS Lambda also allows you to specify a partial ARN (for example, <code>account-id:Thumbnail</code>). Note that the length constraint applies only to the ARN. If you specify only the function name, it is limited to 64 character in length. </p>
 */
  public let functionName: String
/**
<p> Optional string. An opaque pagination token returned from a previous <code>ListVersionsByFunction</code> operation. If present, indicates where to continue the listing. </p>
 */
  public let marker: String?
/**
<p>Optional integer. Specifies the maximum number of AWS Lambda function versions to return in response. This parameter value must be greater than 0.</p>
 */
  public let maxItems: Int?

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    var querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
    uri["FunctionName"] = "\(functionName)"
    if marker != nil { querystring["Marker"] = "\(marker!)" }
    if maxItems != nil { querystring["MaxItems"] = "\(maxItems!)" }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - functionName: <p>Function name whose versions to list. You can specify a function name (for example, <code>Thumbnail</code>) or you can specify Amazon Resource Name (ARN) of the function (for example, <code>arn:aws:lambda:us-west-2:account-id:function:ThumbNail</code>). AWS Lambda also allows you to specify a partial ARN (for example, <code>account-id:Thumbnail</code>). Note that the length constraint applies only to the ARN. If you specify only the function name, it is limited to 64 character in length. </p>
      - marker: <p> Optional string. An opaque pagination token returned from a previous <code>ListVersionsByFunction</code> operation. If present, indicates where to continue the listing. </p>
      - maxItems: <p>Optional integer. Specifies the maximum number of AWS Lambda function versions to return in response. This parameter value must be greater than 0.</p>
 */
  public init(functionName: String, marker: String?, maxItems: Int?) {
self.functionName = functionName
self.marker = marker
self.maxItems = maxItems
  }
}

/**
<p/>
 */
public struct ListVersionsByFunctionResponse: AwswiftDeserializable {
/**
<p>A string, present if there are more function versions.</p>
 */
  public let nextMarker: String?
/**
<p>A list of Lambda function versions.</p>
 */
  public let versions: [FunctionConfiguration]?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let json = try! JSONSerialization.jsonObject(with: data, options: [])
  return .json(json)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> ListVersionsByFunctionResponse {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return ListVersionsByFunctionResponse(
        nextMarker: jsonDict["NextMarker"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      versions: jsonDict["Versions"].flatMap { ($0 is NSNull) ? nil : [FunctionConfiguration].deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - nextMarker: <p>A string, present if there are more function versions.</p>
      - versions: <p>A list of Lambda function versions.</p>
 */
  public init(nextMarker: String?, versions: [FunctionConfiguration]?) {
self.nextMarker = nextMarker
self.versions = versions
  }
}

enum Logtype: String, AwswiftDeserializable, AwswiftSerializable {
  case `none` = "None"
  case `tail` = "Tail"

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Logtype {
    switch body { 
    case .json(let json): return Logtype(rawValue: json as! String)!
    case .xml(let node): return Logtype(rawValue: node.stringValue!)!
    }
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}




/**
<p>Lambda function access policy is limited to 20 KB.</p>
 */
public struct PolicyLengthExceededException: Error, AwswiftDeserializable {
/**

 */
  public let lambdaType: String?
/**

 */
  public let message: String?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let json = try! JSONSerialization.jsonObject(with: data, options: [])
  return .json(json)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> PolicyLengthExceededException {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return PolicyLengthExceededException(
        lambdaType: jsonDict["Type"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      message: jsonDict["message"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - lambdaType: 
      - message: 
 */
  public init(lambdaType: String?, message: String?) {
self.lambdaType = lambdaType
self.message = message
  }
}


/**
<p/>
 */
public struct PublishVersionRequest: AwswiftSerializable {
/**
<p>The SHA256 hash of the deployment package you want to publish. This provides validation on the code you are publishing. If you provide this parameter value must match the SHA256 of the $LATEST version for the publication to succeed.</p>
 */
  public let codeSha256: String?
/**
<p>The description for the version you are publishing. If not provided, AWS Lambda copies the description from the $LATEST version.</p>
 */
  public let description: String?
/**
<p>The Lambda function name. You can specify a function name (for example, <code>Thumbnail</code>) or you can specify Amazon Resource Name (ARN) of the function (for example, <code>arn:aws:lambda:us-west-2:account-id:function:ThumbNail</code>). AWS Lambda also allows you to specify a partial ARN (for example, <code>account-id:Thumbnail</code>). Note that the length constraint applies only to the ARN. If you specify only the function name, it is limited to 64 character in length. </p>
 */
  public let functionName: String

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    uri["FunctionName"] = "\(functionName)"
    if codeSha256 != nil { body["CodeSha256"] = codeSha256! }
    if description != nil { body["Description"] = description! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - codeSha256: <p>The SHA256 hash of the deployment package you want to publish. This provides validation on the code you are publishing. If you provide this parameter value must match the SHA256 of the $LATEST version for the publication to succeed.</p>
      - description: <p>The description for the version you are publishing. If not provided, AWS Lambda copies the description from the $LATEST version.</p>
      - functionName: <p>The Lambda function name. You can specify a function name (for example, <code>Thumbnail</code>) or you can specify Amazon Resource Name (ARN) of the function (for example, <code>arn:aws:lambda:us-west-2:account-id:function:ThumbNail</code>). AWS Lambda also allows you to specify a partial ARN (for example, <code>account-id:Thumbnail</code>). Note that the length constraint applies only to the ARN. If you specify only the function name, it is limited to 64 character in length. </p>
 */
  public init(codeSha256: String?, description: String?, functionName: String) {
self.codeSha256 = codeSha256
self.description = description
self.functionName = functionName
  }
}


/**
<p/>
 */
public struct RemovePermissionRequest: AwswiftSerializable {
/**
<p>Lambda function whose resource policy you want to remove a permission from.</p> <p> You can specify a function name (for example, <code>Thumbnail</code>) or you can specify Amazon Resource Name (ARN) of the function (for example, <code>arn:aws:lambda:us-west-2:account-id:function:ThumbNail</code>). AWS Lambda also allows you to specify a partial ARN (for example, <code>account-id:Thumbnail</code>). Note that the length constraint applies only to the ARN. If you specify only the function name, it is limited to 64 character in length. </p>
 */
  public let functionName: String
/**
<p>You can specify this optional parameter to remove permission associated with a specific function version or function alias. If you don't specify this parameter, the API removes permission associated with the unqualified function ARN.</p>
 */
  public let qualifier: String?
/**
<p>Statement ID of the permission to remove.</p>
 */
  public let statementId: String

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    var querystring: [String: String] = [:]
    let header: [String: String] = [:]
    
  
    uri["FunctionName"] = "\(functionName)"
    uri["StatementId"] = "\(statementId)"
    if qualifier != nil { querystring["Qualifier"] = "\(qualifier!)" }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .empty)
  }


/**
    - parameters:
      - functionName: <p>Lambda function whose resource policy you want to remove a permission from.</p> <p> You can specify a function name (for example, <code>Thumbnail</code>) or you can specify Amazon Resource Name (ARN) of the function (for example, <code>arn:aws:lambda:us-west-2:account-id:function:ThumbNail</code>). AWS Lambda also allows you to specify a partial ARN (for example, <code>account-id:Thumbnail</code>). Note that the length constraint applies only to the ARN. If you specify only the function name, it is limited to 64 character in length. </p>
      - qualifier: <p>You can specify this optional parameter to remove permission associated with a specific function version or function alias. If you don't specify this parameter, the API removes permission associated with the unqualified function ARN.</p>
      - statementId: <p>Statement ID of the permission to remove.</p>
 */
  public init(functionName: String, qualifier: String?, statementId: String) {
self.functionName = functionName
self.qualifier = qualifier
self.statementId = statementId
  }
}

/**
<p>The request payload exceeded the <code>Invoke</code> request body JSON input limit. For more information, see <a href="http://docs.aws.amazon.com/lambda/latest/dg/limits.html">Limits</a>. </p>
 */
public struct RequestTooLargeException: Error, AwswiftDeserializable {
/**

 */
  public let lambdaType: String?
/**

 */
  public let message: String?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let json = try! JSONSerialization.jsonObject(with: data, options: [])
  return .json(json)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> RequestTooLargeException {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return RequestTooLargeException(
        lambdaType: jsonDict["Type"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      message: jsonDict["message"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - lambdaType: 
      - message: 
 */
  public init(lambdaType: String?, message: String?) {
self.lambdaType = lambdaType
self.message = message
  }
}

/**
<p>The resource already exists.</p>
 */
public struct ResourceConflictException: Error, AwswiftDeserializable {
/**
<p/>
 */
  public let lambdaType: String?
/**
<p/>
 */
  public let message: String?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let json = try! JSONSerialization.jsonObject(with: data, options: [])
  return .json(json)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> ResourceConflictException {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return ResourceConflictException(
        lambdaType: jsonDict["Type"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      message: jsonDict["message"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - lambdaType: <p/>
      - message: <p/>
 */
  public init(lambdaType: String?, message: String?) {
self.lambdaType = lambdaType
self.message = message
  }
}

/**
<p>The resource (for example, a Lambda function or access policy statement) specified in the request does not exist.</p>
 */
public struct ResourceNotFoundException: Error, AwswiftDeserializable {
/**

 */
  public let message: String?
/**

 */
  public let lambdaType: String?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let json = try! JSONSerialization.jsonObject(with: data, options: [])
  return .json(json)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> ResourceNotFoundException {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return ResourceNotFoundException(
        message: jsonDict["Message"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      lambdaType: jsonDict["Type"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - message: 
      - lambdaType: 
 */
  public init(message: String?, lambdaType: String?) {
self.message = message
self.lambdaType = lambdaType
  }
}


enum Runtime: String, AwswiftDeserializable, AwswiftSerializable {
  case `nodejs` = "nodejs"
  case `nodejs43` = "nodejs4.3"
  case `java8` = "java8"
  case `python27` = "python2.7"

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Runtime {
    switch body { 
    case .json(let json): return Runtime(rawValue: json as! String)!
    case .xml(let node): return Runtime(rawValue: node.stringValue!)!
    }
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}






/**
<p>The AWS Lambda service encountered an internal error.</p>
 */
public struct ServiceException: Error, AwswiftDeserializable {
/**

 */
  public let message: String?
/**

 */
  public let lambdaType: String?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let json = try! JSONSerialization.jsonObject(with: data, options: [])
  return .json(json)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> ServiceException {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return ServiceException(
        message: jsonDict["Message"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      lambdaType: jsonDict["Type"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - message: 
      - lambdaType: 
 */
  public init(message: String?, lambdaType: String?) {
self.message = message
self.lambdaType = lambdaType
  }
}




/**
<p>AWS Lambda was not able to set up VPC access for the Lambda function because one or more configured subnets has no available IP addresses.</p>
 */
public struct SubnetIPAddressLimitReachedException: Error, AwswiftDeserializable {
/**

 */
  public let message: String?
/**

 */
  public let lambdaType: String?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let json = try! JSONSerialization.jsonObject(with: data, options: [])
  return .json(json)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> SubnetIPAddressLimitReachedException {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return SubnetIPAddressLimitReachedException(
        message: jsonDict["Message"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      lambdaType: jsonDict["Type"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - message: 
      - lambdaType: 
 */
  public init(message: String?, lambdaType: String?) {
self.message = message
self.lambdaType = lambdaType
  }
}



enum Throttlereason: String, AwswiftDeserializable, AwswiftSerializable {
  case `concurrentInvocationLimitExceeded` = "ConcurrentInvocationLimitExceeded"
  case `functionInvocationRateLimitExceeded` = "FunctionInvocationRateLimitExceeded"
  case `callerRateLimitExceeded` = "CallerRateLimitExceeded"

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> Throttlereason {
    switch body { 
    case .json(let json): return Throttlereason(rawValue: json as! String)!
    case .xml(let node): return Throttlereason(rawValue: node.stringValue!)!
    }
  }

  func serialize() -> SerializedForm {
    return SerializedForm(uri: [:], queryString: [:], header: [:], body: .raw(rawValue.data(using: .utf8)!))
  }
}



/**
<p/>
 */
public struct TooManyRequestsException: Error, AwswiftDeserializable {
/**

 */
  public let reason: Throttlereason?
/**

 */
  public let lambdaType: String?
/**

 */
  public let message: String?
/**
<p>The number of seconds the caller should wait before retrying.</p>
 */
  public let retryAfterSeconds: String?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let json = try! JSONSerialization.jsonObject(with: data, options: [])
  return .json(json)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> TooManyRequestsException {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return TooManyRequestsException(
        reason: jsonDict["Reason"].flatMap { ($0 is NSNull) ? nil : Throttlereason.deserialize(response: response, body: .json($0)) },
      lambdaType: jsonDict["Type"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      message: jsonDict["message"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      retryAfterSeconds: response.allHeaderFields["Retry-After"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - reason: 
      - lambdaType: 
      - message: 
      - retryAfterSeconds: <p>The number of seconds the caller should wait before retrying.</p>
 */
  public init(reason: Throttlereason?, lambdaType: String?, message: String?, retryAfterSeconds: String?) {
self.reason = reason
self.lambdaType = lambdaType
self.message = message
self.retryAfterSeconds = retryAfterSeconds
  }
}

/**
<p>The content type of the <code>Invoke</code> request body is not JSON.</p>
 */
public struct UnsupportedMediaTypeException: Error, AwswiftDeserializable {
/**

 */
  public let lambdaType: String?
/**

 */
  public let message: String?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let json = try! JSONSerialization.jsonObject(with: data, options: [])
  return .json(json)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> UnsupportedMediaTypeException {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return UnsupportedMediaTypeException(
        lambdaType: jsonDict["Type"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) },
      message: jsonDict["message"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - lambdaType: 
      - message: 
 */
  public init(lambdaType: String?, message: String?) {
self.lambdaType = lambdaType
self.message = message
  }
}

public struct UpdateAliasRequest: AwswiftSerializable {
/**
<p>You can change the description of the alias using this parameter.</p>
 */
  public let description: String?
/**
<p>The function name for which the alias is created.</p>
 */
  public let functionName: String
/**
<p>Using this parameter you can change the Lambda function version to which the alias points.</p>
 */
  public let functionVersion: String?
/**
<p>The alias name.</p>
 */
  public let name: String

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    uri["FunctionName"] = "\(functionName)"
    uri["Name"] = "\(name)"
    if description != nil { body["Description"] = description! }
    if functionVersion != nil { body["FunctionVersion"] = functionVersion! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - description: <p>You can change the description of the alias using this parameter.</p>
      - functionName: <p>The function name for which the alias is created.</p>
      - functionVersion: <p>Using this parameter you can change the Lambda function version to which the alias points.</p>
      - name: <p>The alias name.</p>
 */
  public init(description: String?, functionName: String, functionVersion: String?, name: String) {
self.description = description
self.functionName = functionName
self.functionVersion = functionVersion
self.name = name
  }
}

/**
<p/>
 */
public struct UpdateEventSourceMappingRequest: AwswiftSerializable {
/**
<p>The maximum number of stream records that can be sent to your Lambda function for a single invocation.</p>
 */
  public let batchSize: Int?
/**
<p>Specifies whether AWS Lambda should actively poll the stream or not. If disabled, AWS Lambda will not poll the stream.</p>
 */
  public let enabled: Bool?
/**
<p>The Lambda function to which you want the stream records sent.</p> <p> You can specify a function name (for example, <code>Thumbnail</code>) or you can specify Amazon Resource Name (ARN) of the function (for example, <code>arn:aws:lambda:us-west-2:account-id:function:ThumbNail</code>). AWS Lambda also allows you to specify a partial ARN (for example, <code>account-id:Thumbnail</code>). </p> <p>If you are using versioning, you can also provide a qualified function ARN (ARN that is qualified with function version or alias name as suffix). For more information about versioning, see <a href="http://docs.aws.amazon.com/lambda/latest/dg/versioning-aliases.html">AWS Lambda Function Versioning and Aliases</a> </p> <p>Note that the length constraint applies only to the ARN. If you specify only the function name, it is limited to 64 character in length.</p>
 */
  public let functionName: String?
/**
<p>The event source mapping identifier.</p>
 */
  public let uUID: String

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    uri["UUID"] = "\(uUID)"
    if batchSize != nil { body["BatchSize"] = batchSize! }
    if enabled != nil { body["Enabled"] = enabled! }
    if functionName != nil { body["FunctionName"] = functionName! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - batchSize: <p>The maximum number of stream records that can be sent to your Lambda function for a single invocation.</p>
      - enabled: <p>Specifies whether AWS Lambda should actively poll the stream or not. If disabled, AWS Lambda will not poll the stream.</p>
      - functionName: <p>The Lambda function to which you want the stream records sent.</p> <p> You can specify a function name (for example, <code>Thumbnail</code>) or you can specify Amazon Resource Name (ARN) of the function (for example, <code>arn:aws:lambda:us-west-2:account-id:function:ThumbNail</code>). AWS Lambda also allows you to specify a partial ARN (for example, <code>account-id:Thumbnail</code>). </p> <p>If you are using versioning, you can also provide a qualified function ARN (ARN that is qualified with function version or alias name as suffix). For more information about versioning, see <a href="http://docs.aws.amazon.com/lambda/latest/dg/versioning-aliases.html">AWS Lambda Function Versioning and Aliases</a> </p> <p>Note that the length constraint applies only to the ARN. If you specify only the function name, it is limited to 64 character in length.</p>
      - uUID: <p>The event source mapping identifier.</p>
 */
  public init(batchSize: Int?, enabled: Bool?, functionName: String?, uUID: String) {
self.batchSize = batchSize
self.enabled = enabled
self.functionName = functionName
self.uUID = uUID
  }
}

/**
<p/>
 */
public struct UpdateFunctionCodeRequest: AwswiftSerializable {
/**
<p>The existing Lambda function name whose code you want to replace.</p> <p> You can specify a function name (for example, <code>Thumbnail</code>) or you can specify Amazon Resource Name (ARN) of the function (for example, <code>arn:aws:lambda:us-west-2:account-id:function:ThumbNail</code>). AWS Lambda also allows you to specify a partial ARN (for example, <code>account-id:Thumbnail</code>). Note that the length constraint applies only to the ARN. If you specify only the function name, it is limited to 64 character in length. </p>
 */
  public let functionName: String
/**
<p>This boolean parameter can be used to request AWS Lambda to update the Lambda function and publish a version as an atomic operation.</p>
 */
  public let publish: Bool?
/**
<p>Amazon S3 bucket name where the .zip file containing your deployment package is stored. This bucket must reside in the same AWS region where you are creating the Lambda function.</p>
 */
  public let s3Bucket: String?
/**
<p>The Amazon S3 object (the deployment package) key name you want to upload.</p>
 */
  public let s3Key: String?
/**
<p>The Amazon S3 object (the deployment package) version you want to upload.</p>
 */
  public let s3ObjectVersion: String?
/**
<p>The contents of your zip file containing your deployment package. If you are using the web API directly, the contents of the zip file must be base64-encoded. If you are using the AWS SDKs or the AWS CLI, the SDKs or CLI will do the encoding for you. For more information about creating a .zip file, go to <a href="http://docs.aws.amazon.com/lambda/latest/dg/intro-permission-model.html#lambda-intro-execution-role.html">Execution Permissions</a> in the <i>AWS Lambda Developer Guide</i>. </p>
 */
  public let zipFile: Data?

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    uri["FunctionName"] = "\(functionName)"
    if publish != nil { body["Publish"] = publish! }
    if s3Bucket != nil { body["S3Bucket"] = s3Bucket! }
    if s3Key != nil { body["S3Key"] = s3Key! }
    if s3ObjectVersion != nil { body["S3ObjectVersion"] = s3ObjectVersion! }
    if zipFile != nil { body["ZipFile"] = zipFile! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - functionName: <p>The existing Lambda function name whose code you want to replace.</p> <p> You can specify a function name (for example, <code>Thumbnail</code>) or you can specify Amazon Resource Name (ARN) of the function (for example, <code>arn:aws:lambda:us-west-2:account-id:function:ThumbNail</code>). AWS Lambda also allows you to specify a partial ARN (for example, <code>account-id:Thumbnail</code>). Note that the length constraint applies only to the ARN. If you specify only the function name, it is limited to 64 character in length. </p>
      - publish: <p>This boolean parameter can be used to request AWS Lambda to update the Lambda function and publish a version as an atomic operation.</p>
      - s3Bucket: <p>Amazon S3 bucket name where the .zip file containing your deployment package is stored. This bucket must reside in the same AWS region where you are creating the Lambda function.</p>
      - s3Key: <p>The Amazon S3 object (the deployment package) key name you want to upload.</p>
      - s3ObjectVersion: <p>The Amazon S3 object (the deployment package) version you want to upload.</p>
      - zipFile: <p>The contents of your zip file containing your deployment package. If you are using the web API directly, the contents of the zip file must be base64-encoded. If you are using the AWS SDKs or the AWS CLI, the SDKs or CLI will do the encoding for you. For more information about creating a .zip file, go to <a href="http://docs.aws.amazon.com/lambda/latest/dg/intro-permission-model.html#lambda-intro-execution-role.html">Execution Permissions</a> in the <i>AWS Lambda Developer Guide</i>. </p>
 */
  public init(functionName: String, publish: Bool?, s3Bucket: String?, s3Key: String?, s3ObjectVersion: String?, zipFile: Data?) {
self.functionName = functionName
self.publish = publish
self.s3Bucket = s3Bucket
self.s3Key = s3Key
self.s3ObjectVersion = s3ObjectVersion
self.zipFile = zipFile
  }
}

/**
<p/>
 */
public struct UpdateFunctionConfigurationRequest: AwswiftSerializable {
/**
<p>A short user-defined function description. AWS Lambda does not use this value. Assign a meaningful description as you see fit.</p>
 */
  public let description: String?
/**
<p>The name of the Lambda function.</p> <p> You can specify a function name (for example, <code>Thumbnail</code>) or you can specify Amazon Resource Name (ARN) of the function (for example, <code>arn:aws:lambda:us-west-2:account-id:function:ThumbNail</code>). AWS Lambda also allows you to specify a partial ARN (for example, <code>account-id:Thumbnail</code>). Note that the length constraint applies only to the ARN. If you specify only the function name, it is limited to 64 character in length. </p>
 */
  public let functionName: String
/**
<p>The function that Lambda calls to begin executing your function. For Node.js, it is the <code>module-name.export</code> value in your function. </p>
 */
  public let handler: String?
/**
<p>The amount of memory, in MB, your Lambda function is given. AWS Lambda uses this memory size to infer the amount of CPU allocated to your function. Your function use-case determines your CPU and memory requirements. For example, a database operation might need less memory compared to an image processing function. The default value is 128 MB. The value must be a multiple of 64 MB.</p>
 */
  public let memorySize: Int?
/**
<p>The Amazon Resource Name (ARN) of the IAM role that Lambda will assume when it executes your function.</p>
 */
  public let role: String?
/**
<p>The runtime environment for the Lambda function.</p> <p>To use the Node.js runtime v4.3, set the value to "nodejs4.3". To use earlier runtime (v0.10.42), set the value to "nodejs".</p>
 */
  public let runtime: Runtime?
/**
<p>The function execution time at which AWS Lambda should terminate the function. Because the execution time has cost implications, we recommend you set this value based on your expected execution time. The default is 3 seconds.</p>
 */
  public let timeout: Int?
/**

 */
  public let vpcConfig: VpcConfig?

  func serialize() -> SerializedForm {
    var uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    uri["FunctionName"] = "\(functionName)"
    if description != nil { body["Description"] = description! }
    if handler != nil { body["Handler"] = handler! }
    if memorySize != nil { body["MemorySize"] = memorySize! }
    if role != nil { body["Role"] = role! }
    if runtime != nil { body["Runtime"] = runtime! }
    if timeout != nil { body["Timeout"] = timeout! }
    if vpcConfig != nil { body["VpcConfig"] = vpcConfig! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }


/**
    - parameters:
      - description: <p>A short user-defined function description. AWS Lambda does not use this value. Assign a meaningful description as you see fit.</p>
      - functionName: <p>The name of the Lambda function.</p> <p> You can specify a function name (for example, <code>Thumbnail</code>) or you can specify Amazon Resource Name (ARN) of the function (for example, <code>arn:aws:lambda:us-west-2:account-id:function:ThumbNail</code>). AWS Lambda also allows you to specify a partial ARN (for example, <code>account-id:Thumbnail</code>). Note that the length constraint applies only to the ARN. If you specify only the function name, it is limited to 64 character in length. </p>
      - handler: <p>The function that Lambda calls to begin executing your function. For Node.js, it is the <code>module-name.export</code> value in your function. </p>
      - memorySize: <p>The amount of memory, in MB, your Lambda function is given. AWS Lambda uses this memory size to infer the amount of CPU allocated to your function. Your function use-case determines your CPU and memory requirements. For example, a database operation might need less memory compared to an image processing function. The default value is 128 MB. The value must be a multiple of 64 MB.</p>
      - role: <p>The Amazon Resource Name (ARN) of the IAM role that Lambda will assume when it executes your function.</p>
      - runtime: <p>The runtime environment for the Lambda function.</p> <p>To use the Node.js runtime v4.3, set the value to "nodejs4.3". To use earlier runtime (v0.10.42), set the value to "nodejs".</p>
      - timeout: <p>The function execution time at which AWS Lambda should terminate the function. Because the execution time has cost implications, we recommend you set this value based on your expected execution time. The default is 3 seconds.</p>
      - vpcConfig: 
 */
  public init(description: String?, functionName: String, handler: String?, memorySize: Int?, role: String?, runtime: Runtime?, timeout: Int?, vpcConfig: VpcConfig?) {
self.description = description
self.functionName = functionName
self.handler = handler
self.memorySize = memorySize
self.role = role
self.runtime = runtime
self.timeout = timeout
self.vpcConfig = vpcConfig
  }
}


/**
<p>If your Lambda function accesses resources in a VPC, you provide this parameter identifying the list of security group IDs and subnet IDs. These must belong to the same VPC. You must provide at least one security group and one subnet ID.</p>
 */
public struct VpcConfig: AwswiftSerializable, AwswiftDeserializable {
/**
<p>A list of one or more security groups IDs in your VPC.</p>
 */
  public let securityGroupIds: [String]?
/**
<p>A list of one or more subnet IDs in your VPC.</p>
 */
  public let subnetIds: [String]?

  func serialize() -> SerializedForm {
    let uri: [String: String] = [:]
    let querystring: [String: String] = [:]
    let header: [String: String] = [:]
    var body: [String: Any] = [:]
  
    if securityGroupIds != nil { body["SecurityGroupIds"] = securityGroupIds! }
    if subnetIds != nil { body["SubnetIds"] = subnetIds! }
  
    return SerializedForm(uri: uri, queryString: querystring, header: header, body: .json(body))
  }

  static func deserializableBody(data: Data) -> DeserializableBody {
    let json = try! JSONSerialization.jsonObject(with: data, options: [])
  return .json(json)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> VpcConfig {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return VpcConfig(
        securityGroupIds: jsonDict["SecurityGroupIds"].flatMap { ($0 is NSNull) ? nil : [String].deserialize(response: response, body: .json($0)) },
      subnetIds: jsonDict["SubnetIds"].flatMap { ($0 is NSNull) ? nil : [String].deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - securityGroupIds: <p>A list of one or more security groups IDs in your VPC.</p>
      - subnetIds: <p>A list of one or more subnet IDs in your VPC.</p>
 */
  public init(securityGroupIds: [String]?, subnetIds: [String]?) {
self.securityGroupIds = securityGroupIds
self.subnetIds = subnetIds
  }
}

/**
<p>VPC configuration associated with your Lambda function.</p>
 */
public struct VpcConfigResponse: AwswiftDeserializable {
/**
<p>A list of security group IDs associated with the Lambda function.</p>
 */
  public let securityGroupIds: [String]?
/**
<p>A list of subnet IDs associated with the Lambda function.</p>
 */
  public let subnetIds: [String]?
/**
<p>The VPC ID associated with you Lambda function.</p>
 */
  public let vpcId: String?


  static func deserializableBody(data: Data) -> DeserializableBody {
    let json = try! JSONSerialization.jsonObject(with: data, options: [])
  return .json(json)
  }

  static func deserialize(response: HTTPURLResponse, body: DeserializableBody) -> VpcConfigResponse {
    guard case let .json(json) = body else { fatalError() }
  let jsonDict = json as! [String: Any]
    return VpcConfigResponse(
        securityGroupIds: jsonDict["SecurityGroupIds"].flatMap { ($0 is NSNull) ? nil : [String].deserialize(response: response, body: .json($0)) },
      subnetIds: jsonDict["SubnetIds"].flatMap { ($0 is NSNull) ? nil : [String].deserialize(response: response, body: .json($0)) },
      vpcId: jsonDict["VpcId"].flatMap { ($0 is NSNull) ? nil : String.deserialize(response: response, body: .json($0)) }
    )
  }

/**
    - parameters:
      - securityGroupIds: <p>A list of security group IDs associated with the Lambda function.</p>
      - subnetIds: <p>A list of subnet IDs associated with the Lambda function.</p>
      - vpcId: <p>The VPC ID associated with you Lambda function.</p>
 */
  public init(securityGroupIds: [String]?, subnetIds: [String]?, vpcId: String?) {
self.securityGroupIds = securityGroupIds
self.subnetIds = subnetIds
self.vpcId = vpcId
  }
}


}
