import Foundation
import Signer

struct lambda {
    struct Client {
        let region: String
        let credentialsProvider: AwsCredentialsProvider
        let session: URLSession
        let queue: DispatchQueue

        init(region: String) {
            self.region = region
            self.credentialsProvider = DefaultChainProvider()
            self.session = URLSession(configuration: URLSessionConfiguration.default)
            self.queue = DispatchQueue(label: "awswift.lambda.Client.queue")
        }

        func scope() -> AwsCredentialsScope {
           return AwsCredentialsScope(url: baseURL())!
        }

        func credentials() -> AwsCredentials {
            return credentialsProvider.provideAwsCredentials()!
        }

        func baseURL() -> URL {
            return URL(string: "https://lambda.\(region).amazonaws.com/")!
        }

        func awsApiCallTask<O: AwswiftDeserializable>(request: RestJsonRequest, completionHandler: @escaping (_: O?, _: Error?) -> ()) -> URLSessionTask {
            let unsignedRequest = RestJsonRequestSerializer(input: request, baseURL: baseURL())
            let httpRequest = dateAndSignRequest(request: unsignedRequest, credentials: credentials(), scope: scope())
            
            return session.dataTask(with: httpRequest, completionHandler: { (data, response, error) in
                self.queue.async {
                    let http = response as! HTTPURLResponse
                    if error != nil {
                        completionHandler(nil, error)
                    } else if request.expectedStatus == nil || http.statusCode == request.expectedStatus {
                        let json = try! JSONSerialization.jsonObject(with: data!, options: [])
                        let ret = O.deserialize(response: http, body: json)
                        completionHandler(ret, nil)
                    } else {
                        completionHandler(nil, UnexpectedStatusResponse(response: http, data: data))
                    }
                }
            })
        }

        
        func AddPermission(input: AddPermissionRequest, completionHandler: @escaping (_: AddPermissionResponse?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restJsonSerialize()
            guard case let .object(fields) = serial else { fatalError() }

            let request = RestJsonRequest(
                method: "POST",
                relativeUrl: "/2015-03-31/functions/{FunctionName}/policy",
                expectedStatus: 201,
                fields: fields
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func CreateAlias(input: CreateAliasRequest, completionHandler: @escaping (_: AliasConfiguration?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restJsonSerialize()
            guard case let .object(fields) = serial else { fatalError() }

            let request = RestJsonRequest(
                method: "POST",
                relativeUrl: "/2015-03-31/functions/{FunctionName}/aliases",
                expectedStatus: 201,
                fields: fields
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func CreateEventSourceMapping(input: CreateEventSourceMappingRequest, completionHandler: @escaping (_: EventSourceMappingConfiguration?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restJsonSerialize()
            guard case let .object(fields) = serial else { fatalError() }

            let request = RestJsonRequest(
                method: "POST",
                relativeUrl: "/2015-03-31/event-source-mappings/",
                expectedStatus: 202,
                fields: fields
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func CreateFunction(input: CreateFunctionRequest, completionHandler: @escaping (_: FunctionConfiguration?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restJsonSerialize()
            guard case let .object(fields) = serial else { fatalError() }

            let request = RestJsonRequest(
                method: "POST",
                relativeUrl: "/2015-03-31/functions",
                expectedStatus: 201,
                fields: fields
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func DeleteAlias(input: DeleteAliasRequest, completionHandler: @escaping (_: AwsApiVoidOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restJsonSerialize()
            guard case let .object(fields) = serial else { fatalError() }

            let request = RestJsonRequest(
                method: "DELETE",
                relativeUrl: "/2015-03-31/functions/{FunctionName}/aliases/{Name}",
                expectedStatus: 204,
                fields: fields
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func DeleteEventSourceMapping(input: DeleteEventSourceMappingRequest, completionHandler: @escaping (_: EventSourceMappingConfiguration?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restJsonSerialize()
            guard case let .object(fields) = serial else { fatalError() }

            let request = RestJsonRequest(
                method: "DELETE",
                relativeUrl: "/2015-03-31/event-source-mappings/{UUID}",
                expectedStatus: 202,
                fields: fields
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func DeleteFunction(input: DeleteFunctionRequest, completionHandler: @escaping (_: AwsApiVoidOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restJsonSerialize()
            guard case let .object(fields) = serial else { fatalError() }

            let request = RestJsonRequest(
                method: "DELETE",
                relativeUrl: "/2015-03-31/functions/{FunctionName}",
                expectedStatus: 204,
                fields: fields
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func GetAlias(input: GetAliasRequest, completionHandler: @escaping (_: AliasConfiguration?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restJsonSerialize()
            guard case let .object(fields) = serial else { fatalError() }

            let request = RestJsonRequest(
                method: "GET",
                relativeUrl: "/2015-03-31/functions/{FunctionName}/aliases/{Name}",
                expectedStatus: 200,
                fields: fields
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func GetEventSourceMapping(input: GetEventSourceMappingRequest, completionHandler: @escaping (_: EventSourceMappingConfiguration?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restJsonSerialize()
            guard case let .object(fields) = serial else { fatalError() }

            let request = RestJsonRequest(
                method: "GET",
                relativeUrl: "/2015-03-31/event-source-mappings/{UUID}",
                expectedStatus: 200,
                fields: fields
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func GetFunction(input: GetFunctionRequest, completionHandler: @escaping (_: GetFunctionResponse?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restJsonSerialize()
            guard case let .object(fields) = serial else { fatalError() }

            let request = RestJsonRequest(
                method: "GET",
                relativeUrl: "/2015-03-31/functions/{FunctionName}",
                expectedStatus: 200,
                fields: fields
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func GetFunctionConfiguration(input: GetFunctionConfigurationRequest, completionHandler: @escaping (_: FunctionConfiguration?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restJsonSerialize()
            guard case let .object(fields) = serial else { fatalError() }

            let request = RestJsonRequest(
                method: "GET",
                relativeUrl: "/2015-03-31/functions/{FunctionName}/configuration",
                expectedStatus: 200,
                fields: fields
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func GetPolicy(input: GetPolicyRequest, completionHandler: @escaping (_: GetPolicyResponse?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restJsonSerialize()
            guard case let .object(fields) = serial else { fatalError() }

            let request = RestJsonRequest(
                method: "GET",
                relativeUrl: "/2015-03-31/functions/{FunctionName}/policy",
                expectedStatus: 200,
                fields: fields
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func Invoke(input: InvocationRequest, completionHandler: @escaping (_: InvocationResponse?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restJsonSerialize()
            guard case let .object(fields) = serial else { fatalError() }

            let request = RestJsonRequest(
                method: "POST",
                relativeUrl: "/2015-03-31/functions/{FunctionName}/invocations",
                expectedStatus: nil,
                fields: fields
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func InvokeAsync(input: InvokeAsyncRequest, completionHandler: @escaping (_: InvokeAsyncResponse?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restJsonSerialize()
            guard case let .object(fields) = serial else { fatalError() }

            let request = RestJsonRequest(
                method: "POST",
                relativeUrl: "/2014-11-13/functions/{FunctionName}/invoke-async/",
                expectedStatus: 202,
                fields: fields
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func ListAliases(input: ListAliasesRequest, completionHandler: @escaping (_: ListAliasesResponse?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restJsonSerialize()
            guard case let .object(fields) = serial else { fatalError() }

            let request = RestJsonRequest(
                method: "GET",
                relativeUrl: "/2015-03-31/functions/{FunctionName}/aliases",
                expectedStatus: 200,
                fields: fields
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func ListEventSourceMappings(input: ListEventSourceMappingsRequest, completionHandler: @escaping (_: ListEventSourceMappingsResponse?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restJsonSerialize()
            guard case let .object(fields) = serial else { fatalError() }

            let request = RestJsonRequest(
                method: "GET",
                relativeUrl: "/2015-03-31/event-source-mappings/",
                expectedStatus: 200,
                fields: fields
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func ListFunctions(input: ListFunctionsRequest, completionHandler: @escaping (_: ListFunctionsResponse?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restJsonSerialize()
            guard case let .object(fields) = serial else { fatalError() }

            let request = RestJsonRequest(
                method: "GET",
                relativeUrl: "/2015-03-31/functions/",
                expectedStatus: 200,
                fields: fields
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func ListVersionsByFunction(input: ListVersionsByFunctionRequest, completionHandler: @escaping (_: ListVersionsByFunctionResponse?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restJsonSerialize()
            guard case let .object(fields) = serial else { fatalError() }

            let request = RestJsonRequest(
                method: "GET",
                relativeUrl: "/2015-03-31/functions/{FunctionName}/versions",
                expectedStatus: 200,
                fields: fields
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func PublishVersion(input: PublishVersionRequest, completionHandler: @escaping (_: FunctionConfiguration?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restJsonSerialize()
            guard case let .object(fields) = serial else { fatalError() }

            let request = RestJsonRequest(
                method: "POST",
                relativeUrl: "/2015-03-31/functions/{FunctionName}/versions",
                expectedStatus: 201,
                fields: fields
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func RemovePermission(input: RemovePermissionRequest, completionHandler: @escaping (_: AwsApiVoidOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restJsonSerialize()
            guard case let .object(fields) = serial else { fatalError() }

            let request = RestJsonRequest(
                method: "DELETE",
                relativeUrl: "/2015-03-31/functions/{FunctionName}/policy/{StatementId}",
                expectedStatus: 204,
                fields: fields
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func UpdateAlias(input: UpdateAliasRequest, completionHandler: @escaping (_: AliasConfiguration?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restJsonSerialize()
            guard case let .object(fields) = serial else { fatalError() }

            let request = RestJsonRequest(
                method: "PUT",
                relativeUrl: "/2015-03-31/functions/{FunctionName}/aliases/{Name}",
                expectedStatus: 200,
                fields: fields
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func UpdateEventSourceMapping(input: UpdateEventSourceMappingRequest, completionHandler: @escaping (_: EventSourceMappingConfiguration?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restJsonSerialize()
            guard case let .object(fields) = serial else { fatalError() }

            let request = RestJsonRequest(
                method: "PUT",
                relativeUrl: "/2015-03-31/event-source-mappings/{UUID}",
                expectedStatus: 202,
                fields: fields
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func UpdateFunctionCode(input: UpdateFunctionCodeRequest, completionHandler: @escaping (_: FunctionConfiguration?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restJsonSerialize()
            guard case let .object(fields) = serial else { fatalError() }

            let request = RestJsonRequest(
                method: "PUT",
                relativeUrl: "/2015-03-31/functions/{FunctionName}/code",
                expectedStatus: 200,
                fields: fields
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func UpdateFunctionConfiguration(input: UpdateFunctionConfigurationRequest, completionHandler: @escaping (_: FunctionConfiguration?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.restJsonSerialize()
            guard case let .object(fields) = serial else { fatalError() }

            let request = RestJsonRequest(
                method: "PUT",
                relativeUrl: "/2015-03-31/functions/{FunctionName}/configuration",
                expectedStatus: 200,
                fields: fields
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
    }

    
    struct AddPermissionRequest: RestJsonSerializable, AwswiftDeserializable {
        public let action: String
        public let eventsourcetoken: String?
        public let functionname: String
        public let principal: String
        public let qualifier: String?
        public let sourceaccount: String?
        public let sourcearn: String?
        public let statementid: String
        

        init(
            action: String,
            eventsourcetoken: String?,
            functionname: String,
            principal: String,
            qualifier: String?,
            sourceaccount: String?,
            sourcearn: String?,
            statementid: String
            
        ) {
            self.action = action
            self.eventsourcetoken = eventsourcetoken
            self.functionname = functionname
            self.principal = principal
            self.qualifier = qualifier
            self.sourceaccount = sourceaccount
            self.sourcearn = sourcearn
            self.statementid = statementid
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "Action", location: .body, value: action.restJsonSerialize()),
            
                RestJsonField(name: "EventSourceToken", location: .body, value: eventsourcetoken?.restJsonSerialize()),
            
                RestJsonField(name: "FunctionName", location: .uri, value: functionname.restJsonSerialize()),
            
                RestJsonField(name: "Principal", location: .body, value: principal.restJsonSerialize()),
            
                RestJsonField(name: "Qualifier", location: .querystring, value: qualifier?.restJsonSerialize()),
            
                RestJsonField(name: "SourceAccount", location: .body, value: sourceaccount?.restJsonSerialize()),
            
                RestJsonField(name: "SourceArn", location: .body, value: sourcearn?.restJsonSerialize()),
            
                RestJsonField(name: "StatementId", location: .body, value: statementid.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> AddPermissionRequest {
            fatalError()
        }
        
        
    }
    
    struct AddPermissionResponse: RestJsonSerializable, AwswiftDeserializable {
        public let statement: String?
        

        init(
            statement: String?
            
        ) {
            self.statement = statement
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "Statement", location: .body, value: statement?.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> AddPermissionResponse {
            guard let body = body as? [String: Any] else { fatalError() }
            
            
            let statement = body["Statement"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            
            

            return AddPermissionResponse(
                
                statement: statement
                
            )
        }
        
    }
    
    struct AliasConfiguration: RestJsonSerializable, AwswiftDeserializable {
        public let aliasarn: String?
        public let description: String?
        public let functionversion: String?
        public let name: String?
        

        init(
            aliasarn: String?,
            description: String?,
            functionversion: String?,
            name: String?
            
        ) {
            self.aliasarn = aliasarn
            self.description = description
            self.functionversion = functionversion
            self.name = name
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "AliasArn", location: .body, value: aliasarn?.restJsonSerialize()),
            
                RestJsonField(name: "Description", location: .body, value: description?.restJsonSerialize()),
            
                RestJsonField(name: "FunctionVersion", location: .body, value: functionversion?.restJsonSerialize()),
            
                RestJsonField(name: "Name", location: .body, value: name?.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> AliasConfiguration {
            guard let body = body as? [String: Any] else { fatalError() }
            
            
            let aliasarn = body["AliasArn"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let description = body["Description"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let functionversion = body["FunctionVersion"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let name = body["Name"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            
            

            return AliasConfiguration(
                
                aliasarn: aliasarn,
                
                description: description,
                
                functionversion: functionversion,
                
                name: name
                
            )
        }
        
    }
    
    struct CodeStorageExceededException: RestJsonSerializable, AwswiftDeserializable {
        public let lambdatype: String?
        public let message: String?
        

        init(
            lambdatype: String?,
            message: String?
            
        ) {
            self.lambdatype = lambdatype
            self.message = message
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "Type", location: .body, value: lambdatype?.restJsonSerialize()),
            
                RestJsonField(name: "message", location: .body, value: message?.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> CodeStorageExceededException {
            guard let body = body as? [String: Any] else { fatalError() }
            
            
            let lambdatype = body["Type"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let message = body["message"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            
            

            return CodeStorageExceededException(
                
                lambdatype: lambdatype,
                
                message: message
                
            )
        }
        
    }
    
    struct CreateAliasRequest: RestJsonSerializable, AwswiftDeserializable {
        public let description: String?
        public let functionname: String
        public let functionversion: String
        public let name: String
        

        init(
            description: String?,
            functionname: String,
            functionversion: String,
            name: String
            
        ) {
            self.description = description
            self.functionname = functionname
            self.functionversion = functionversion
            self.name = name
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "Description", location: .body, value: description?.restJsonSerialize()),
            
                RestJsonField(name: "FunctionName", location: .uri, value: functionname.restJsonSerialize()),
            
                RestJsonField(name: "FunctionVersion", location: .body, value: functionversion.restJsonSerialize()),
            
                RestJsonField(name: "Name", location: .body, value: name.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> CreateAliasRequest {
            fatalError()
        }
        
        
    }
    
    struct CreateEventSourceMappingRequest: RestJsonSerializable, AwswiftDeserializable {
        public let batchsize: Int?
        public let enabled: Bool?
        public let eventsourcearn: String
        public let functionname: String
        public let startingposition: EventSourcePosition
        

        init(
            batchsize: Int?,
            enabled: Bool?,
            eventsourcearn: String,
            functionname: String,
            startingposition: EventSourcePosition
            
        ) {
            self.batchsize = batchsize
            self.enabled = enabled
            self.eventsourcearn = eventsourcearn
            self.functionname = functionname
            self.startingposition = startingposition
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "BatchSize", location: .body, value: batchsize?.restJsonSerialize()),
            
                RestJsonField(name: "Enabled", location: .body, value: enabled?.restJsonSerialize()),
            
                RestJsonField(name: "EventSourceArn", location: .body, value: eventsourcearn.restJsonSerialize()),
            
                RestJsonField(name: "FunctionName", location: .body, value: functionname.restJsonSerialize()),
            
                RestJsonField(name: "StartingPosition", location: .body, value: startingposition.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> CreateEventSourceMappingRequest {
            fatalError()
        }
        
        
    }
    
    struct CreateFunctionRequest: RestJsonSerializable, AwswiftDeserializable {
        public let code: FunctionCode
        public let description: String?
        public let functionname: String
        public let handler: String
        public let memorysize: Int?
        public let publish: Bool?
        public let role: String
        public let runtime: Runtime
        public let timeout: Int?
        public let vpcconfig: VpcConfig?
        

        init(
            code: FunctionCode,
            description: String?,
            functionname: String,
            handler: String,
            memorysize: Int?,
            publish: Bool?,
            role: String,
            runtime: Runtime,
            timeout: Int?,
            vpcconfig: VpcConfig?
            
        ) {
            self.code = code
            self.description = description
            self.functionname = functionname
            self.handler = handler
            self.memorysize = memorysize
            self.publish = publish
            self.role = role
            self.runtime = runtime
            self.timeout = timeout
            self.vpcconfig = vpcconfig
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "Code", location: .body, value: code.restJsonSerialize()),
            
                RestJsonField(name: "Description", location: .body, value: description?.restJsonSerialize()),
            
                RestJsonField(name: "FunctionName", location: .body, value: functionname.restJsonSerialize()),
            
                RestJsonField(name: "Handler", location: .body, value: handler.restJsonSerialize()),
            
                RestJsonField(name: "MemorySize", location: .body, value: memorysize?.restJsonSerialize()),
            
                RestJsonField(name: "Publish", location: .body, value: publish?.restJsonSerialize()),
            
                RestJsonField(name: "Role", location: .body, value: role.restJsonSerialize()),
            
                RestJsonField(name: "Runtime", location: .body, value: runtime.restJsonSerialize()),
            
                RestJsonField(name: "Timeout", location: .body, value: timeout?.restJsonSerialize()),
            
                RestJsonField(name: "VpcConfig", location: .body, value: vpcconfig?.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> CreateFunctionRequest {
            fatalError()
        }
        
        
    }
    
    struct DeleteAliasRequest: RestJsonSerializable, AwswiftDeserializable {
        public let functionname: String
        public let name: String
        

        init(
            functionname: String,
            name: String
            
        ) {
            self.functionname = functionname
            self.name = name
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "FunctionName", location: .uri, value: functionname.restJsonSerialize()),
            
                RestJsonField(name: "Name", location: .uri, value: name.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> DeleteAliasRequest {
            fatalError()
        }
        
        
    }
    
    struct DeleteEventSourceMappingRequest: RestJsonSerializable, AwswiftDeserializable {
        public let uuid: String
        

        init(
            uuid: String
            
        ) {
            self.uuid = uuid
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "UUID", location: .uri, value: uuid.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> DeleteEventSourceMappingRequest {
            fatalError()
        }
        
        
    }
    
    struct DeleteFunctionRequest: RestJsonSerializable, AwswiftDeserializable {
        public let functionname: String
        public let qualifier: String?
        

        init(
            functionname: String,
            qualifier: String?
            
        ) {
            self.functionname = functionname
            self.qualifier = qualifier
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "FunctionName", location: .uri, value: functionname.restJsonSerialize()),
            
                RestJsonField(name: "Qualifier", location: .querystring, value: qualifier?.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> DeleteFunctionRequest {
            fatalError()
        }
        
        
    }
    
    struct EC2AccessDeniedException: RestJsonSerializable, AwswiftDeserializable {
        public let message: String?
        public let lambdatype: String?
        

        init(
            message: String?,
            lambdatype: String?
            
        ) {
            self.message = message
            self.lambdatype = lambdatype
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "Message", location: .body, value: message?.restJsonSerialize()),
            
                RestJsonField(name: "Type", location: .body, value: lambdatype?.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> EC2AccessDeniedException {
            guard let body = body as? [String: Any] else { fatalError() }
            
            
            let message = body["Message"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let lambdatype = body["Type"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            
            

            return EC2AccessDeniedException(
                
                message: message,
                
                lambdatype: lambdatype
                
            )
        }
        
    }
    
    struct EC2ThrottledException: RestJsonSerializable, AwswiftDeserializable {
        public let message: String?
        public let lambdatype: String?
        

        init(
            message: String?,
            lambdatype: String?
            
        ) {
            self.message = message
            self.lambdatype = lambdatype
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "Message", location: .body, value: message?.restJsonSerialize()),
            
                RestJsonField(name: "Type", location: .body, value: lambdatype?.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> EC2ThrottledException {
            guard let body = body as? [String: Any] else { fatalError() }
            
            
            let message = body["Message"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let lambdatype = body["Type"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            
            

            return EC2ThrottledException(
                
                message: message,
                
                lambdatype: lambdatype
                
            )
        }
        
    }
    
    struct EC2UnexpectedException: RestJsonSerializable, AwswiftDeserializable {
        public let ec2Errorcode: String?
        public let message: String?
        public let lambdatype: String?
        

        init(
            ec2Errorcode: String?,
            message: String?,
            lambdatype: String?
            
        ) {
            self.ec2Errorcode = ec2Errorcode
            self.message = message
            self.lambdatype = lambdatype
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "EC2ErrorCode", location: .body, value: ec2Errorcode?.restJsonSerialize()),
            
                RestJsonField(name: "Message", location: .body, value: message?.restJsonSerialize()),
            
                RestJsonField(name: "Type", location: .body, value: lambdatype?.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> EC2UnexpectedException {
            guard let body = body as? [String: Any] else { fatalError() }
            
            
            let ec2Errorcode = body["EC2ErrorCode"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let message = body["Message"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let lambdatype = body["Type"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            
            

            return EC2UnexpectedException(
                
                ec2Errorcode: ec2Errorcode,
                
                message: message,
                
                lambdatype: lambdatype
                
            )
        }
        
    }
    
    struct ENILimitReachedException: RestJsonSerializable, AwswiftDeserializable {
        public let message: String?
        public let lambdatype: String?
        

        init(
            message: String?,
            lambdatype: String?
            
        ) {
            self.message = message
            self.lambdatype = lambdatype
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "Message", location: .body, value: message?.restJsonSerialize()),
            
                RestJsonField(name: "Type", location: .body, value: lambdatype?.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> ENILimitReachedException {
            guard let body = body as? [String: Any] else { fatalError() }
            
            
            let message = body["Message"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let lambdatype = body["Type"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            
            

            return ENILimitReachedException(
                
                message: message,
                
                lambdatype: lambdatype
                
            )
        }
        
    }
    
    struct EventSourceMappingConfiguration: RestJsonSerializable, AwswiftDeserializable {
        public let batchsize: Int?
        public let eventsourcearn: String?
        public let functionarn: String?
        public let lastmodified: Date?
        public let lastprocessingresult: String?
        public let state: String?
        public let statetransitionreason: String?
        public let uuid: String?
        

        init(
            batchsize: Int?,
            eventsourcearn: String?,
            functionarn: String?,
            lastmodified: Date?,
            lastprocessingresult: String?,
            state: String?,
            statetransitionreason: String?,
            uuid: String?
            
        ) {
            self.batchsize = batchsize
            self.eventsourcearn = eventsourcearn
            self.functionarn = functionarn
            self.lastmodified = lastmodified
            self.lastprocessingresult = lastprocessingresult
            self.state = state
            self.statetransitionreason = statetransitionreason
            self.uuid = uuid
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "BatchSize", location: .body, value: batchsize?.restJsonSerialize()),
            
                RestJsonField(name: "EventSourceArn", location: .body, value: eventsourcearn?.restJsonSerialize()),
            
                RestJsonField(name: "FunctionArn", location: .body, value: functionarn?.restJsonSerialize()),
            
                RestJsonField(name: "LastModified", location: .body, value: lastmodified?.restJsonSerialize()),
            
                RestJsonField(name: "LastProcessingResult", location: .body, value: lastprocessingresult?.restJsonSerialize()),
            
                RestJsonField(name: "State", location: .body, value: state?.restJsonSerialize()),
            
                RestJsonField(name: "StateTransitionReason", location: .body, value: statetransitionreason?.restJsonSerialize()),
            
                RestJsonField(name: "UUID", location: .body, value: uuid?.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> EventSourceMappingConfiguration {
            guard let body = body as? [String: Any] else { fatalError() }
            
            
            let batchsize = body["BatchSize"].flatMapNoNulls { v in
                return Int.deserialize(response: response, body: v)
            }
            
            let eventsourcearn = body["EventSourceArn"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let functionarn = body["FunctionArn"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let lastmodified = body["LastModified"].flatMapNoNulls { v in
                return Date.deserialize(response: response, body: v)
            }
            
            let lastprocessingresult = body["LastProcessingResult"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let state = body["State"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let statetransitionreason = body["StateTransitionReason"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let uuid = body["UUID"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            
            

            return EventSourceMappingConfiguration(
                
                batchsize: batchsize,
                
                eventsourcearn: eventsourcearn,
                
                functionarn: functionarn,
                
                lastmodified: lastmodified,
                
                lastprocessingresult: lastprocessingresult,
                
                state: state,
                
                statetransitionreason: statetransitionreason,
                
                uuid: uuid
                
            )
        }
        
    }
    
    struct FunctionCode: RestJsonSerializable, AwswiftDeserializable {
        public let s3Bucket: String?
        public let s3Key: String?
        public let s3Objectversion: String?
        public let zipfile: Data?
        

        init(
            s3Bucket: String?,
            s3Key: String?,
            s3Objectversion: String?,
            zipfile: Data?
            
        ) {
            self.s3Bucket = s3Bucket
            self.s3Key = s3Key
            self.s3Objectversion = s3Objectversion
            self.zipfile = zipfile
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "S3Bucket", location: .body, value: s3Bucket?.restJsonSerialize()),
            
                RestJsonField(name: "S3Key", location: .body, value: s3Key?.restJsonSerialize()),
            
                RestJsonField(name: "S3ObjectVersion", location: .body, value: s3Objectversion?.restJsonSerialize()),
            
                RestJsonField(name: "ZipFile", location: .body, value: zipfile?.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> FunctionCode {
            guard let body = body as? [String: Any] else { fatalError() }
            
            
            let s3Bucket = body["S3Bucket"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let s3Key = body["S3Key"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let s3Objectversion = body["S3ObjectVersion"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let zipfile = body["ZipFile"].flatMapNoNulls { v in
                return Data.deserialize(response: response, body: v)
            }
            
            
            

            return FunctionCode(
                
                s3Bucket: s3Bucket,
                
                s3Key: s3Key,
                
                s3Objectversion: s3Objectversion,
                
                zipfile: zipfile
                
            )
        }
        
    }
    
    struct FunctionCodeLocation: RestJsonSerializable, AwswiftDeserializable {
        public let location: String?
        public let repositorytype: String?
        

        init(
            location: String?,
            repositorytype: String?
            
        ) {
            self.location = location
            self.repositorytype = repositorytype
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "Location", location: .body, value: location?.restJsonSerialize()),
            
                RestJsonField(name: "RepositoryType", location: .body, value: repositorytype?.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> FunctionCodeLocation {
            guard let body = body as? [String: Any] else { fatalError() }
            
            
            let location = body["Location"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let repositorytype = body["RepositoryType"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            
            

            return FunctionCodeLocation(
                
                location: location,
                
                repositorytype: repositorytype
                
            )
        }
        
    }
    
    struct FunctionConfiguration: RestJsonSerializable, AwswiftDeserializable {
        public let codesha256: String?
        public let codesize: Int?
        public let description: String?
        public let functionarn: String?
        public let functionname: String?
        public let handler: String?
        public let lastmodified: String?
        public let memorysize: Int?
        public let role: String?
        public let runtime: Runtime?
        public let timeout: Int?
        public let version: String?
        public let vpcconfig: VpcConfigResponse?
        

        init(
            codesha256: String?,
            codesize: Int?,
            description: String?,
            functionarn: String?,
            functionname: String?,
            handler: String?,
            lastmodified: String?,
            memorysize: Int?,
            role: String?,
            runtime: Runtime?,
            timeout: Int?,
            version: String?,
            vpcconfig: VpcConfigResponse?
            
        ) {
            self.codesha256 = codesha256
            self.codesize = codesize
            self.description = description
            self.functionarn = functionarn
            self.functionname = functionname
            self.handler = handler
            self.lastmodified = lastmodified
            self.memorysize = memorysize
            self.role = role
            self.runtime = runtime
            self.timeout = timeout
            self.version = version
            self.vpcconfig = vpcconfig
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "CodeSha256", location: .body, value: codesha256?.restJsonSerialize()),
            
                RestJsonField(name: "CodeSize", location: .body, value: codesize?.restJsonSerialize()),
            
                RestJsonField(name: "Description", location: .body, value: description?.restJsonSerialize()),
            
                RestJsonField(name: "FunctionArn", location: .body, value: functionarn?.restJsonSerialize()),
            
                RestJsonField(name: "FunctionName", location: .body, value: functionname?.restJsonSerialize()),
            
                RestJsonField(name: "Handler", location: .body, value: handler?.restJsonSerialize()),
            
                RestJsonField(name: "LastModified", location: .body, value: lastmodified?.restJsonSerialize()),
            
                RestJsonField(name: "MemorySize", location: .body, value: memorysize?.restJsonSerialize()),
            
                RestJsonField(name: "Role", location: .body, value: role?.restJsonSerialize()),
            
                RestJsonField(name: "Runtime", location: .body, value: runtime?.restJsonSerialize()),
            
                RestJsonField(name: "Timeout", location: .body, value: timeout?.restJsonSerialize()),
            
                RestJsonField(name: "Version", location: .body, value: version?.restJsonSerialize()),
            
                RestJsonField(name: "VpcConfig", location: .body, value: vpcconfig?.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> FunctionConfiguration {
            guard let body = body as? [String: Any] else { fatalError() }
            
            
            let codesha256 = body["CodeSha256"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let codesize = body["CodeSize"].flatMapNoNulls { v in
                return Int.deserialize(response: response, body: v)
            }
            
            let description = body["Description"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let functionarn = body["FunctionArn"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let functionname = body["FunctionName"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let handler = body["Handler"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let lastmodified = body["LastModified"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let memorysize = body["MemorySize"].flatMapNoNulls { v in
                return Int.deserialize(response: response, body: v)
            }
            
            let role = body["Role"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let runtime = body["Runtime"].flatMapNoNulls { v in
                return Runtime.deserialize(response: response, body: v)
            }
            
            let timeout = body["Timeout"].flatMapNoNulls { v in
                return Int.deserialize(response: response, body: v)
            }
            
            let version = body["Version"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let vpcconfig = body["VpcConfig"].flatMapNoNulls { v in
                return VpcConfigResponse.deserialize(response: response, body: v)
            }
            
            
            

            return FunctionConfiguration(
                
                codesha256: codesha256,
                
                codesize: codesize,
                
                description: description,
                
                functionarn: functionarn,
                
                functionname: functionname,
                
                handler: handler,
                
                lastmodified: lastmodified,
                
                memorysize: memorysize,
                
                role: role,
                
                runtime: runtime,
                
                timeout: timeout,
                
                version: version,
                
                vpcconfig: vpcconfig
                
            )
        }
        
    }
    
    struct GetAliasRequest: RestJsonSerializable, AwswiftDeserializable {
        public let functionname: String
        public let name: String
        

        init(
            functionname: String,
            name: String
            
        ) {
            self.functionname = functionname
            self.name = name
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "FunctionName", location: .uri, value: functionname.restJsonSerialize()),
            
                RestJsonField(name: "Name", location: .uri, value: name.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> GetAliasRequest {
            fatalError()
        }
        
        
    }
    
    struct GetEventSourceMappingRequest: RestJsonSerializable, AwswiftDeserializable {
        public let uuid: String
        

        init(
            uuid: String
            
        ) {
            self.uuid = uuid
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "UUID", location: .uri, value: uuid.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> GetEventSourceMappingRequest {
            fatalError()
        }
        
        
    }
    
    struct GetFunctionConfigurationRequest: RestJsonSerializable, AwswiftDeserializable {
        public let functionname: String
        public let qualifier: String?
        

        init(
            functionname: String,
            qualifier: String?
            
        ) {
            self.functionname = functionname
            self.qualifier = qualifier
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "FunctionName", location: .uri, value: functionname.restJsonSerialize()),
            
                RestJsonField(name: "Qualifier", location: .querystring, value: qualifier?.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> GetFunctionConfigurationRequest {
            fatalError()
        }
        
        
    }
    
    struct GetFunctionRequest: RestJsonSerializable, AwswiftDeserializable {
        public let functionname: String
        public let qualifier: String?
        

        init(
            functionname: String,
            qualifier: String?
            
        ) {
            self.functionname = functionname
            self.qualifier = qualifier
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "FunctionName", location: .uri, value: functionname.restJsonSerialize()),
            
                RestJsonField(name: "Qualifier", location: .querystring, value: qualifier?.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> GetFunctionRequest {
            fatalError()
        }
        
        
    }
    
    struct GetFunctionResponse: RestJsonSerializable, AwswiftDeserializable {
        public let code: FunctionCodeLocation?
        public let configuration: FunctionConfiguration?
        

        init(
            code: FunctionCodeLocation?,
            configuration: FunctionConfiguration?
            
        ) {
            self.code = code
            self.configuration = configuration
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "Code", location: .body, value: code?.restJsonSerialize()),
            
                RestJsonField(name: "Configuration", location: .body, value: configuration?.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> GetFunctionResponse {
            guard let body = body as? [String: Any] else { fatalError() }
            
            
            let code = body["Code"].flatMapNoNulls { v in
                return FunctionCodeLocation.deserialize(response: response, body: v)
            }
            
            let configuration = body["Configuration"].flatMapNoNulls { v in
                return FunctionConfiguration.deserialize(response: response, body: v)
            }
            
            
            

            return GetFunctionResponse(
                
                code: code,
                
                configuration: configuration
                
            )
        }
        
    }
    
    struct GetPolicyRequest: RestJsonSerializable, AwswiftDeserializable {
        public let functionname: String
        public let qualifier: String?
        

        init(
            functionname: String,
            qualifier: String?
            
        ) {
            self.functionname = functionname
            self.qualifier = qualifier
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "FunctionName", location: .uri, value: functionname.restJsonSerialize()),
            
                RestJsonField(name: "Qualifier", location: .querystring, value: qualifier?.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> GetPolicyRequest {
            fatalError()
        }
        
        
    }
    
    struct GetPolicyResponse: RestJsonSerializable, AwswiftDeserializable {
        public let policy: String?
        

        init(
            policy: String?
            
        ) {
            self.policy = policy
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "Policy", location: .body, value: policy?.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> GetPolicyResponse {
            guard let body = body as? [String: Any] else { fatalError() }
            
            
            let policy = body["Policy"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            
            

            return GetPolicyResponse(
                
                policy: policy
                
            )
        }
        
    }
    
    struct InvalidParameterValueException: RestJsonSerializable, AwswiftDeserializable {
        public let lambdatype: String?
        public let message: String?
        

        init(
            lambdatype: String?,
            message: String?
            
        ) {
            self.lambdatype = lambdatype
            self.message = message
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "Type", location: .body, value: lambdatype?.restJsonSerialize()),
            
                RestJsonField(name: "message", location: .body, value: message?.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> InvalidParameterValueException {
            guard let body = body as? [String: Any] else { fatalError() }
            
            
            let lambdatype = body["Type"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let message = body["message"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            
            

            return InvalidParameterValueException(
                
                lambdatype: lambdatype,
                
                message: message
                
            )
        }
        
    }
    
    struct InvalidRequestContentException: RestJsonSerializable, AwswiftDeserializable {
        public let lambdatype: String?
        public let message: String?
        

        init(
            lambdatype: String?,
            message: String?
            
        ) {
            self.lambdatype = lambdatype
            self.message = message
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "Type", location: .body, value: lambdatype?.restJsonSerialize()),
            
                RestJsonField(name: "message", location: .body, value: message?.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> InvalidRequestContentException {
            guard let body = body as? [String: Any] else { fatalError() }
            
            
            let lambdatype = body["Type"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let message = body["message"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            
            

            return InvalidRequestContentException(
                
                lambdatype: lambdatype,
                
                message: message
                
            )
        }
        
    }
    
    struct InvalidSecurityGroupIDException: RestJsonSerializable, AwswiftDeserializable {
        public let message: String?
        public let lambdatype: String?
        

        init(
            message: String?,
            lambdatype: String?
            
        ) {
            self.message = message
            self.lambdatype = lambdatype
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "Message", location: .body, value: message?.restJsonSerialize()),
            
                RestJsonField(name: "Type", location: .body, value: lambdatype?.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> InvalidSecurityGroupIDException {
            guard let body = body as? [String: Any] else { fatalError() }
            
            
            let message = body["Message"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let lambdatype = body["Type"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            
            

            return InvalidSecurityGroupIDException(
                
                message: message,
                
                lambdatype: lambdatype
                
            )
        }
        
    }
    
    struct InvalidSubnetIDException: RestJsonSerializable, AwswiftDeserializable {
        public let message: String?
        public let lambdatype: String?
        

        init(
            message: String?,
            lambdatype: String?
            
        ) {
            self.message = message
            self.lambdatype = lambdatype
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "Message", location: .body, value: message?.restJsonSerialize()),
            
                RestJsonField(name: "Type", location: .body, value: lambdatype?.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> InvalidSubnetIDException {
            guard let body = body as? [String: Any] else { fatalError() }
            
            
            let message = body["Message"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let lambdatype = body["Type"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            
            

            return InvalidSubnetIDException(
                
                message: message,
                
                lambdatype: lambdatype
                
            )
        }
        
    }
    
    struct InvalidZipFileException: RestJsonSerializable, AwswiftDeserializable {
        public let message: String?
        public let lambdatype: String?
        

        init(
            message: String?,
            lambdatype: String?
            
        ) {
            self.message = message
            self.lambdatype = lambdatype
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "Message", location: .body, value: message?.restJsonSerialize()),
            
                RestJsonField(name: "Type", location: .body, value: lambdatype?.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> InvalidZipFileException {
            guard let body = body as? [String: Any] else { fatalError() }
            
            
            let message = body["Message"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let lambdatype = body["Type"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            
            

            return InvalidZipFileException(
                
                message: message,
                
                lambdatype: lambdatype
                
            )
        }
        
    }
    
    struct InvocationRequest: RestJsonSerializable, AwswiftDeserializable {
        public let clientcontext: String?
        public let functionname: String
        public let invocationtype: InvocationType?
        public let logtype: LogType?
        public let payload: Data?
        public let qualifier: String?
        

        init(
            clientcontext: String?,
            functionname: String,
            invocationtype: InvocationType?,
            logtype: LogType?,
            payload: Data?,
            qualifier: String?
            
        ) {
            self.clientcontext = clientcontext
            self.functionname = functionname
            self.invocationtype = invocationtype
            self.logtype = logtype
            self.payload = payload
            self.qualifier = qualifier
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "X-Amz-Client-Context", location: .header, value: clientcontext?.restJsonSerialize()),
            
                RestJsonField(name: "FunctionName", location: .uri, value: functionname.restJsonSerialize()),
            
                RestJsonField(name: "X-Amz-Invocation-Type", location: .header, value: invocationtype?.restJsonSerialize()),
            
                RestJsonField(name: "X-Amz-Log-Type", location: .header, value: logtype?.restJsonSerialize()),
            
                RestJsonField(name: "Payload", location: .body, value: payload?.restJsonSerialize()),
            
                RestJsonField(name: "Qualifier", location: .querystring, value: qualifier?.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> InvocationRequest {
            fatalError()
        }
        
        
    }
    
    struct InvocationResponse: RestJsonSerializable, AwswiftDeserializable {
        public let functionerror: String?
        public let logresult: String?
        public let payload: Data?
        public let statuscode: Int?
        

        init(
            functionerror: String?,
            logresult: String?,
            payload: Data?,
            statuscode: Int?
            
        ) {
            self.functionerror = functionerror
            self.logresult = logresult
            self.payload = payload
            self.statuscode = statuscode
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "X-Amz-Function-Error", location: .header, value: functionerror?.restJsonSerialize()),
            
                RestJsonField(name: "X-Amz-Log-Result", location: .header, value: logresult?.restJsonSerialize()),
            
                RestJsonField(name: "Payload", location: .body, value: payload?.restJsonSerialize()),
            
                RestJsonField(name: "StatusCode", location: .statusCode, value: statuscode?.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> InvocationResponse {
            guard let body = body as? [String: Any] else { fatalError() }
            
            
            let payload = body["Payload"].flatMapNoNulls { v in
                return Data.deserialize(response: response, body: v)
            }
            
            
            let functionerror = response.allHeaderFields["X-Amz-Function-Error"] as? String
            
            let logresult = response.allHeaderFields["X-Amz-Log-Result"] as? String
            
            
            let statuscode = response.statusCode            
            

            return InvocationResponse(
                
                functionerror: functionerror,
                
                logresult: logresult,
                
                payload: payload,
                
                statuscode: statuscode
                
            )
        }
        
    }
    
    struct InvokeAsyncRequest: RestJsonSerializable, AwswiftDeserializable {
        public let functionname: String
        public let invokeargs: Data
        

        init(
            functionname: String,
            invokeargs: Data
            
        ) {
            self.functionname = functionname
            self.invokeargs = invokeargs
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "FunctionName", location: .uri, value: functionname.restJsonSerialize()),
            
                RestJsonField(name: "InvokeArgs", location: .body, value: invokeargs.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> InvokeAsyncRequest {
            fatalError()
        }
        
        
    }
    
    struct InvokeAsyncResponse: RestJsonSerializable, AwswiftDeserializable {
        public let status: Int?
        

        init(
            status: Int?
            
        ) {
            self.status = status
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "Status", location: .statusCode, value: status?.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> InvokeAsyncResponse {
            guard let body = body as? [String: Any] else { fatalError() }
            
            
            
            
            let status = response.statusCode            
            

            return InvokeAsyncResponse(
                
                status: status
                
            )
        }
        
    }
    
    struct ListAliasesRequest: RestJsonSerializable, AwswiftDeserializable {
        public let functionname: String
        public let functionversion: String?
        public let marker: String?
        public let maxitems: Int?
        

        init(
            functionname: String,
            functionversion: String?,
            marker: String?,
            maxitems: Int?
            
        ) {
            self.functionname = functionname
            self.functionversion = functionversion
            self.marker = marker
            self.maxitems = maxitems
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "FunctionName", location: .uri, value: functionname.restJsonSerialize()),
            
                RestJsonField(name: "FunctionVersion", location: .querystring, value: functionversion?.restJsonSerialize()),
            
                RestJsonField(name: "Marker", location: .querystring, value: marker?.restJsonSerialize()),
            
                RestJsonField(name: "MaxItems", location: .querystring, value: maxitems?.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> ListAliasesRequest {
            fatalError()
        }
        
        
    }
    
    struct ListAliasesResponse: RestJsonSerializable, AwswiftDeserializable {
        public let aliases: [AliasConfiguration]?
        public let nextmarker: String?
        

        init(
            aliases: [AliasConfiguration]?,
            nextmarker: String?
            
        ) {
            self.aliases = aliases
            self.nextmarker = nextmarker
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "Aliases", location: .body, value: aliases?.restJsonSerialize()),
            
                RestJsonField(name: "NextMarker", location: .body, value: nextmarker?.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> ListAliasesResponse {
            guard let body = body as? [String: Any] else { fatalError() }
            
            
            let aliases = body["Aliases"].flatMapNoNulls { v in
                return [AliasConfiguration].deserialize(response: response, body: v)
            }
            
            let nextmarker = body["NextMarker"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            
            

            return ListAliasesResponse(
                
                aliases: aliases,
                
                nextmarker: nextmarker
                
            )
        }
        
    }
    
    struct ListEventSourceMappingsRequest: RestJsonSerializable, AwswiftDeserializable {
        public let eventsourcearn: String?
        public let functionname: String?
        public let marker: String?
        public let maxitems: Int?
        

        init(
            eventsourcearn: String?,
            functionname: String?,
            marker: String?,
            maxitems: Int?
            
        ) {
            self.eventsourcearn = eventsourcearn
            self.functionname = functionname
            self.marker = marker
            self.maxitems = maxitems
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "EventSourceArn", location: .querystring, value: eventsourcearn?.restJsonSerialize()),
            
                RestJsonField(name: "FunctionName", location: .querystring, value: functionname?.restJsonSerialize()),
            
                RestJsonField(name: "Marker", location: .querystring, value: marker?.restJsonSerialize()),
            
                RestJsonField(name: "MaxItems", location: .querystring, value: maxitems?.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> ListEventSourceMappingsRequest {
            fatalError()
        }
        
        
    }
    
    struct ListEventSourceMappingsResponse: RestJsonSerializable, AwswiftDeserializable {
        public let eventsourcemappings: [EventSourceMappingConfiguration]?
        public let nextmarker: String?
        

        init(
            eventsourcemappings: [EventSourceMappingConfiguration]?,
            nextmarker: String?
            
        ) {
            self.eventsourcemappings = eventsourcemappings
            self.nextmarker = nextmarker
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "EventSourceMappings", location: .body, value: eventsourcemappings?.restJsonSerialize()),
            
                RestJsonField(name: "NextMarker", location: .body, value: nextmarker?.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> ListEventSourceMappingsResponse {
            guard let body = body as? [String: Any] else { fatalError() }
            
            
            let eventsourcemappings = body["EventSourceMappings"].flatMapNoNulls { v in
                return [EventSourceMappingConfiguration].deserialize(response: response, body: v)
            }
            
            let nextmarker = body["NextMarker"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            
            

            return ListEventSourceMappingsResponse(
                
                eventsourcemappings: eventsourcemappings,
                
                nextmarker: nextmarker
                
            )
        }
        
    }
    
    struct ListFunctionsRequest: RestJsonSerializable, AwswiftDeserializable {
        public let marker: String?
        public let maxitems: Int?
        

        init(
            marker: String?,
            maxitems: Int?
            
        ) {
            self.marker = marker
            self.maxitems = maxitems
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "Marker", location: .querystring, value: marker?.restJsonSerialize()),
            
                RestJsonField(name: "MaxItems", location: .querystring, value: maxitems?.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> ListFunctionsRequest {
            fatalError()
        }
        
        
    }
    
    struct ListFunctionsResponse: RestJsonSerializable, AwswiftDeserializable {
        public let functions: [FunctionConfiguration]?
        public let nextmarker: String?
        

        init(
            functions: [FunctionConfiguration]?,
            nextmarker: String?
            
        ) {
            self.functions = functions
            self.nextmarker = nextmarker
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "Functions", location: .body, value: functions?.restJsonSerialize()),
            
                RestJsonField(name: "NextMarker", location: .body, value: nextmarker?.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> ListFunctionsResponse {
            guard let body = body as? [String: Any] else { fatalError() }
            
            
            let functions = body["Functions"].flatMapNoNulls { v in
                return [FunctionConfiguration].deserialize(response: response, body: v)
            }
            
            let nextmarker = body["NextMarker"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            
            

            return ListFunctionsResponse(
                
                functions: functions,
                
                nextmarker: nextmarker
                
            )
        }
        
    }
    
    struct ListVersionsByFunctionRequest: RestJsonSerializable, AwswiftDeserializable {
        public let functionname: String
        public let marker: String?
        public let maxitems: Int?
        

        init(
            functionname: String,
            marker: String?,
            maxitems: Int?
            
        ) {
            self.functionname = functionname
            self.marker = marker
            self.maxitems = maxitems
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "FunctionName", location: .uri, value: functionname.restJsonSerialize()),
            
                RestJsonField(name: "Marker", location: .querystring, value: marker?.restJsonSerialize()),
            
                RestJsonField(name: "MaxItems", location: .querystring, value: maxitems?.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> ListVersionsByFunctionRequest {
            fatalError()
        }
        
        
    }
    
    struct ListVersionsByFunctionResponse: RestJsonSerializable, AwswiftDeserializable {
        public let nextmarker: String?
        public let versions: [FunctionConfiguration]?
        

        init(
            nextmarker: String?,
            versions: [FunctionConfiguration]?
            
        ) {
            self.nextmarker = nextmarker
            self.versions = versions
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "NextMarker", location: .body, value: nextmarker?.restJsonSerialize()),
            
                RestJsonField(name: "Versions", location: .body, value: versions?.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> ListVersionsByFunctionResponse {
            guard let body = body as? [String: Any] else { fatalError() }
            
            
            let nextmarker = body["NextMarker"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let versions = body["Versions"].flatMapNoNulls { v in
                return [FunctionConfiguration].deserialize(response: response, body: v)
            }
            
            
            

            return ListVersionsByFunctionResponse(
                
                nextmarker: nextmarker,
                
                versions: versions
                
            )
        }
        
    }
    
    struct PolicyLengthExceededException: RestJsonSerializable, AwswiftDeserializable {
        public let lambdatype: String?
        public let message: String?
        

        init(
            lambdatype: String?,
            message: String?
            
        ) {
            self.lambdatype = lambdatype
            self.message = message
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "Type", location: .body, value: lambdatype?.restJsonSerialize()),
            
                RestJsonField(name: "message", location: .body, value: message?.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> PolicyLengthExceededException {
            guard let body = body as? [String: Any] else { fatalError() }
            
            
            let lambdatype = body["Type"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let message = body["message"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            
            

            return PolicyLengthExceededException(
                
                lambdatype: lambdatype,
                
                message: message
                
            )
        }
        
    }
    
    struct PublishVersionRequest: RestJsonSerializable, AwswiftDeserializable {
        public let codesha256: String?
        public let description: String?
        public let functionname: String
        

        init(
            codesha256: String?,
            description: String?,
            functionname: String
            
        ) {
            self.codesha256 = codesha256
            self.description = description
            self.functionname = functionname
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "CodeSha256", location: .body, value: codesha256?.restJsonSerialize()),
            
                RestJsonField(name: "Description", location: .body, value: description?.restJsonSerialize()),
            
                RestJsonField(name: "FunctionName", location: .uri, value: functionname.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> PublishVersionRequest {
            fatalError()
        }
        
        
    }
    
    struct RemovePermissionRequest: RestJsonSerializable, AwswiftDeserializable {
        public let functionname: String
        public let qualifier: String?
        public let statementid: String
        

        init(
            functionname: String,
            qualifier: String?,
            statementid: String
            
        ) {
            self.functionname = functionname
            self.qualifier = qualifier
            self.statementid = statementid
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "FunctionName", location: .uri, value: functionname.restJsonSerialize()),
            
                RestJsonField(name: "Qualifier", location: .querystring, value: qualifier?.restJsonSerialize()),
            
                RestJsonField(name: "StatementId", location: .uri, value: statementid.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> RemovePermissionRequest {
            fatalError()
        }
        
        
    }
    
    struct RequestTooLargeException: RestJsonSerializable, AwswiftDeserializable {
        public let lambdatype: String?
        public let message: String?
        

        init(
            lambdatype: String?,
            message: String?
            
        ) {
            self.lambdatype = lambdatype
            self.message = message
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "Type", location: .body, value: lambdatype?.restJsonSerialize()),
            
                RestJsonField(name: "message", location: .body, value: message?.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> RequestTooLargeException {
            guard let body = body as? [String: Any] else { fatalError() }
            
            
            let lambdatype = body["Type"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let message = body["message"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            
            

            return RequestTooLargeException(
                
                lambdatype: lambdatype,
                
                message: message
                
            )
        }
        
    }
    
    struct ResourceConflictException: RestJsonSerializable, AwswiftDeserializable {
        public let lambdatype: String?
        public let message: String?
        

        init(
            lambdatype: String?,
            message: String?
            
        ) {
            self.lambdatype = lambdatype
            self.message = message
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "Type", location: .body, value: lambdatype?.restJsonSerialize()),
            
                RestJsonField(name: "message", location: .body, value: message?.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> ResourceConflictException {
            guard let body = body as? [String: Any] else { fatalError() }
            
            
            let lambdatype = body["Type"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let message = body["message"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            
            

            return ResourceConflictException(
                
                lambdatype: lambdatype,
                
                message: message
                
            )
        }
        
    }
    
    struct ResourceNotFoundException: RestJsonSerializable, AwswiftDeserializable {
        public let message: String?
        public let lambdatype: String?
        

        init(
            message: String?,
            lambdatype: String?
            
        ) {
            self.message = message
            self.lambdatype = lambdatype
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "Message", location: .body, value: message?.restJsonSerialize()),
            
                RestJsonField(name: "Type", location: .body, value: lambdatype?.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> ResourceNotFoundException {
            guard let body = body as? [String: Any] else { fatalError() }
            
            
            let message = body["Message"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let lambdatype = body["Type"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            
            

            return ResourceNotFoundException(
                
                message: message,
                
                lambdatype: lambdatype
                
            )
        }
        
    }
    
    struct ServiceException: RestJsonSerializable, AwswiftDeserializable {
        public let message: String?
        public let lambdatype: String?
        

        init(
            message: String?,
            lambdatype: String?
            
        ) {
            self.message = message
            self.lambdatype = lambdatype
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "Message", location: .body, value: message?.restJsonSerialize()),
            
                RestJsonField(name: "Type", location: .body, value: lambdatype?.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> ServiceException {
            guard let body = body as? [String: Any] else { fatalError() }
            
            
            let message = body["Message"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let lambdatype = body["Type"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            
            

            return ServiceException(
                
                message: message,
                
                lambdatype: lambdatype
                
            )
        }
        
    }
    
    struct SubnetIPAddressLimitReachedException: RestJsonSerializable, AwswiftDeserializable {
        public let message: String?
        public let lambdatype: String?
        

        init(
            message: String?,
            lambdatype: String?
            
        ) {
            self.message = message
            self.lambdatype = lambdatype
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "Message", location: .body, value: message?.restJsonSerialize()),
            
                RestJsonField(name: "Type", location: .body, value: lambdatype?.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> SubnetIPAddressLimitReachedException {
            guard let body = body as? [String: Any] else { fatalError() }
            
            
            let message = body["Message"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let lambdatype = body["Type"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            
            

            return SubnetIPAddressLimitReachedException(
                
                message: message,
                
                lambdatype: lambdatype
                
            )
        }
        
    }
    
    struct TooManyRequestsException: RestJsonSerializable, AwswiftDeserializable {
        public let reason: ThrottleReason?
        public let lambdatype: String?
        public let message: String?
        public let retryafterseconds: String?
        

        init(
            reason: ThrottleReason?,
            lambdatype: String?,
            message: String?,
            retryafterseconds: String?
            
        ) {
            self.reason = reason
            self.lambdatype = lambdatype
            self.message = message
            self.retryafterseconds = retryafterseconds
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "Reason", location: .body, value: reason?.restJsonSerialize()),
            
                RestJsonField(name: "Type", location: .body, value: lambdatype?.restJsonSerialize()),
            
                RestJsonField(name: "message", location: .body, value: message?.restJsonSerialize()),
            
                RestJsonField(name: "Retry-After", location: .header, value: retryafterseconds?.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> TooManyRequestsException {
            guard let body = body as? [String: Any] else { fatalError() }
            
            
            let reason = body["Reason"].flatMapNoNulls { v in
                return ThrottleReason.deserialize(response: response, body: v)
            }
            
            let lambdatype = body["Type"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let message = body["message"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            
            let retryafterseconds = response.allHeaderFields["Retry-After"] as? String
            
            

            return TooManyRequestsException(
                
                reason: reason,
                
                lambdatype: lambdatype,
                
                message: message,
                
                retryafterseconds: retryafterseconds
                
            )
        }
        
    }
    
    struct UnsupportedMediaTypeException: RestJsonSerializable, AwswiftDeserializable {
        public let lambdatype: String?
        public let message: String?
        

        init(
            lambdatype: String?,
            message: String?
            
        ) {
            self.lambdatype = lambdatype
            self.message = message
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "Type", location: .body, value: lambdatype?.restJsonSerialize()),
            
                RestJsonField(name: "message", location: .body, value: message?.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> UnsupportedMediaTypeException {
            guard let body = body as? [String: Any] else { fatalError() }
            
            
            let lambdatype = body["Type"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let message = body["message"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            
            

            return UnsupportedMediaTypeException(
                
                lambdatype: lambdatype,
                
                message: message
                
            )
        }
        
    }
    
    struct UpdateAliasRequest: RestJsonSerializable, AwswiftDeserializable {
        public let description: String?
        public let functionname: String
        public let functionversion: String?
        public let name: String
        

        init(
            description: String?,
            functionname: String,
            functionversion: String?,
            name: String
            
        ) {
            self.description = description
            self.functionname = functionname
            self.functionversion = functionversion
            self.name = name
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "Description", location: .body, value: description?.restJsonSerialize()),
            
                RestJsonField(name: "FunctionName", location: .uri, value: functionname.restJsonSerialize()),
            
                RestJsonField(name: "FunctionVersion", location: .body, value: functionversion?.restJsonSerialize()),
            
                RestJsonField(name: "Name", location: .uri, value: name.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> UpdateAliasRequest {
            fatalError()
        }
        
        
    }
    
    struct UpdateEventSourceMappingRequest: RestJsonSerializable, AwswiftDeserializable {
        public let batchsize: Int?
        public let enabled: Bool?
        public let functionname: String?
        public let uuid: String
        

        init(
            batchsize: Int?,
            enabled: Bool?,
            functionname: String?,
            uuid: String
            
        ) {
            self.batchsize = batchsize
            self.enabled = enabled
            self.functionname = functionname
            self.uuid = uuid
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "BatchSize", location: .body, value: batchsize?.restJsonSerialize()),
            
                RestJsonField(name: "Enabled", location: .body, value: enabled?.restJsonSerialize()),
            
                RestJsonField(name: "FunctionName", location: .body, value: functionname?.restJsonSerialize()),
            
                RestJsonField(name: "UUID", location: .uri, value: uuid.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> UpdateEventSourceMappingRequest {
            fatalError()
        }
        
        
    }
    
    struct UpdateFunctionCodeRequest: RestJsonSerializable, AwswiftDeserializable {
        public let functionname: String
        public let publish: Bool?
        public let s3Bucket: String?
        public let s3Key: String?
        public let s3Objectversion: String?
        public let zipfile: Data?
        

        init(
            functionname: String,
            publish: Bool?,
            s3Bucket: String?,
            s3Key: String?,
            s3Objectversion: String?,
            zipfile: Data?
            
        ) {
            self.functionname = functionname
            self.publish = publish
            self.s3Bucket = s3Bucket
            self.s3Key = s3Key
            self.s3Objectversion = s3Objectversion
            self.zipfile = zipfile
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "FunctionName", location: .uri, value: functionname.restJsonSerialize()),
            
                RestJsonField(name: "Publish", location: .body, value: publish?.restJsonSerialize()),
            
                RestJsonField(name: "S3Bucket", location: .body, value: s3Bucket?.restJsonSerialize()),
            
                RestJsonField(name: "S3Key", location: .body, value: s3Key?.restJsonSerialize()),
            
                RestJsonField(name: "S3ObjectVersion", location: .body, value: s3Objectversion?.restJsonSerialize()),
            
                RestJsonField(name: "ZipFile", location: .body, value: zipfile?.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> UpdateFunctionCodeRequest {
            fatalError()
        }
        
        
    }
    
    struct UpdateFunctionConfigurationRequest: RestJsonSerializable, AwswiftDeserializable {
        public let description: String?
        public let functionname: String
        public let handler: String?
        public let memorysize: Int?
        public let role: String?
        public let runtime: Runtime?
        public let timeout: Int?
        public let vpcconfig: VpcConfig?
        

        init(
            description: String?,
            functionname: String,
            handler: String?,
            memorysize: Int?,
            role: String?,
            runtime: Runtime?,
            timeout: Int?,
            vpcconfig: VpcConfig?
            
        ) {
            self.description = description
            self.functionname = functionname
            self.handler = handler
            self.memorysize = memorysize
            self.role = role
            self.runtime = runtime
            self.timeout = timeout
            self.vpcconfig = vpcconfig
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "Description", location: .body, value: description?.restJsonSerialize()),
            
                RestJsonField(name: "FunctionName", location: .uri, value: functionname.restJsonSerialize()),
            
                RestJsonField(name: "Handler", location: .body, value: handler?.restJsonSerialize()),
            
                RestJsonField(name: "MemorySize", location: .body, value: memorysize?.restJsonSerialize()),
            
                RestJsonField(name: "Role", location: .body, value: role?.restJsonSerialize()),
            
                RestJsonField(name: "Runtime", location: .body, value: runtime?.restJsonSerialize()),
            
                RestJsonField(name: "Timeout", location: .body, value: timeout?.restJsonSerialize()),
            
                RestJsonField(name: "VpcConfig", location: .body, value: vpcconfig?.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> UpdateFunctionConfigurationRequest {
            fatalError()
        }
        
        
    }
    
    struct VpcConfig: RestJsonSerializable, AwswiftDeserializable {
        public let securitygroupids: [String]?
        public let subnetids: [String]?
        

        init(
            securitygroupids: [String]?,
            subnetids: [String]?
            
        ) {
            self.securitygroupids = securitygroupids
            self.subnetids = subnetids
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "SecurityGroupIds", location: .body, value: securitygroupids?.restJsonSerialize()),
            
                RestJsonField(name: "SubnetIds", location: .body, value: subnetids?.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> VpcConfig {
            guard let body = body as? [String: Any] else { fatalError() }
            
            
            let securitygroupids = body["SecurityGroupIds"].flatMapNoNulls { v in
                return [String].deserialize(response: response, body: v)
            }
            
            let subnetids = body["SubnetIds"].flatMapNoNulls { v in
                return [String].deserialize(response: response, body: v)
            }
            
            
            

            return VpcConfig(
                
                securitygroupids: securitygroupids,
                
                subnetids: subnetids
                
            )
        }
        
    }
    
    struct VpcConfigResponse: RestJsonSerializable, AwswiftDeserializable {
        public let securitygroupids: [String]?
        public let subnetids: [String]?
        public let vpcid: String?
        

        init(
            securitygroupids: [String]?,
            subnetids: [String]?,
            vpcid: String?
            
        ) {
            self.securitygroupids = securitygroupids
            self.subnetids = subnetids
            self.vpcid = vpcid
            
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            let fields = [
            
                RestJsonField(name: "SecurityGroupIds", location: .body, value: securitygroupids?.restJsonSerialize()),
            
                RestJsonField(name: "SubnetIds", location: .body, value: subnetids?.restJsonSerialize()),
            
                RestJsonField(name: "VpcId", location: .body, value: vpcid?.restJsonSerialize())
            
            ]
            return .object(fields)
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> VpcConfigResponse {
            guard let body = body as? [String: Any] else { fatalError() }
            
            
            let securitygroupids = body["SecurityGroupIds"].flatMapNoNulls { v in
                return [String].deserialize(response: response, body: v)
            }
            
            let subnetids = body["SubnetIds"].flatMapNoNulls { v in
                return [String].deserialize(response: response, body: v)
            }
            
            let vpcid = body["VpcId"].flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            
            

            return VpcConfigResponse(
                
                securitygroupids: securitygroupids,
                
                subnetids: subnetids,
                
                vpcid: vpcid
                
            )
        }
        
    }
    

    
    enum EventSourcePosition: String, RestJsonSerializable, AwswiftDeserializable {
        case trimHorizon = "TRIM_HORIZON"
        case latest = "LATEST"
        

        static func deserialize(response: HTTPURLResponse, body: Any?) -> EventSourcePosition {
            guard let body = body as? String else { fatalError() }
            if let e = EventSourcePosition(rawValue: body) {
                return e
            } else {
                fatalError()
            }
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            return .string(rawValue)
        }
    }
    
    enum InvocationType: String, RestJsonSerializable, AwswiftDeserializable {
        case event = "Event"
        case requestresponse = "RequestResponse"
        case dryrun = "DryRun"
        

        static func deserialize(response: HTTPURLResponse, body: Any?) -> InvocationType {
            guard let body = body as? String else { fatalError() }
            if let e = InvocationType(rawValue: body) {
                return e
            } else {
                fatalError()
            }
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            return .string(rawValue)
        }
    }
    
    enum LogType: String, RestJsonSerializable, AwswiftDeserializable {
        case none = "None"
        case tail = "Tail"
        

        static func deserialize(response: HTTPURLResponse, body: Any?) -> LogType {
            guard let body = body as? String else { fatalError() }
            if let e = LogType(rawValue: body) {
                return e
            } else {
                fatalError()
            }
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            return .string(rawValue)
        }
    }
    
    enum Runtime: String, RestJsonSerializable, AwswiftDeserializable {
        case nodejs = "nodejs"
        case nodejs43 = "nodejs4.3"
        case java8 = "java8"
        case python27 = "python2.7"
        

        static func deserialize(response: HTTPURLResponse, body: Any?) -> Runtime {
            guard let body = body as? String else { fatalError() }
            if let e = Runtime(rawValue: body) {
                return e
            } else {
                fatalError()
            }
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            return .string(rawValue)
        }
    }
    
    enum ThrottleReason: String, RestJsonSerializable, AwswiftDeserializable {
        case concurrentinvocationlimitexceeded = "ConcurrentInvocationLimitExceeded"
        case functioninvocationratelimitexceeded = "FunctionInvocationRateLimitExceeded"
        case callerratelimitexceeded = "CallerRateLimitExceeded"
        

        static func deserialize(response: HTTPURLResponse, body: Any?) -> ThrottleReason {
            guard let body = body as? String else { fatalError() }
            if let e = ThrottleReason(rawValue: body) {
                return e
            } else {
                fatalError()
            }
        }

        func restJsonSerialize() -> RestJsonFieldValue {
            return .string(rawValue)
        }
    }
    
}
