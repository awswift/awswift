import Foundation
import Signer

struct cloudformation {
    struct Client {
        let region: String
        let credentialsProvider: AwsCredentialsProvider
        let session: URLSession
        let queue: DispatchQueue

        init(region: String) {
            self.region = region
            self.credentialsProvider = DefaultChainProvider()
            self.session = URLSession(configuration: URLSessionConfiguration.default)
            self.queue = DispatchQueue(label: "awswift.cloudformation.Client.queue")
        }

        func scope() -> AwsCredentialsScope {
           return AwsCredentialsScope(url: baseURL())!
        }

        func credentials() -> AwsCredentials {
            return credentialsProvider.provideAwsCredentials()!
        }

        func baseURL() -> URL {
            return URL(string: "https://cloudformation.\(region).amazonaws.com/")!
        }

        func awsApiCallTask<O: AwswiftDeserializable>(request: QueryRequest, completionHandler: @escaping (_: O?, _: Error?) -> ()) -> URLSessionTask {
            let unsignedRequest = QueryRequestSerializer(input: request, baseURL: baseURL())
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

        
        func CancelUpdateStack(input: CancelUpdateStackInput, completionHandler: @escaping (_: AwsApiVoidOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.querySerialize()

            let request = QueryRequest(
                action: "CancelUpdateStack",
                method: "POST",
                relativeUrl: "/",
                params: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func ContinueUpdateRollback(input: ContinueUpdateRollbackInput, completionHandler: @escaping (_: ContinueUpdateRollbackOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.querySerialize()

            let request = QueryRequest(
                action: "ContinueUpdateRollback",
                method: "POST",
                relativeUrl: "/",
                params: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func CreateChangeSet(input: CreateChangeSetInput, completionHandler: @escaping (_: CreateChangeSetOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.querySerialize()

            let request = QueryRequest(
                action: "CreateChangeSet",
                method: "POST",
                relativeUrl: "/",
                params: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func CreateStack(input: CreateStackInput, completionHandler: @escaping (_: CreateStackOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.querySerialize()

            let request = QueryRequest(
                action: "CreateStack",
                method: "POST",
                relativeUrl: "/",
                params: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func DeleteChangeSet(input: DeleteChangeSetInput, completionHandler: @escaping (_: DeleteChangeSetOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.querySerialize()

            let request = QueryRequest(
                action: "DeleteChangeSet",
                method: "POST",
                relativeUrl: "/",
                params: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func DeleteStack(input: DeleteStackInput, completionHandler: @escaping (_: AwsApiVoidOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.querySerialize()

            let request = QueryRequest(
                action: "DeleteStack",
                method: "POST",
                relativeUrl: "/",
                params: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func DescribeAccountLimits(input: DescribeAccountLimitsInput, completionHandler: @escaping (_: DescribeAccountLimitsOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.querySerialize()

            let request = QueryRequest(
                action: "DescribeAccountLimits",
                method: "POST",
                relativeUrl: "/",
                params: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func DescribeChangeSet(input: DescribeChangeSetInput, completionHandler: @escaping (_: DescribeChangeSetOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.querySerialize()

            let request = QueryRequest(
                action: "DescribeChangeSet",
                method: "POST",
                relativeUrl: "/",
                params: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func DescribeStackEvents(input: DescribeStackEventsInput, completionHandler: @escaping (_: DescribeStackEventsOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.querySerialize()

            let request = QueryRequest(
                action: "DescribeStackEvents",
                method: "POST",
                relativeUrl: "/",
                params: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func DescribeStackResource(input: DescribeStackResourceInput, completionHandler: @escaping (_: DescribeStackResourceOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.querySerialize()

            let request = QueryRequest(
                action: "DescribeStackResource",
                method: "POST",
                relativeUrl: "/",
                params: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func DescribeStackResources(input: DescribeStackResourcesInput, completionHandler: @escaping (_: DescribeStackResourcesOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.querySerialize()

            let request = QueryRequest(
                action: "DescribeStackResources",
                method: "POST",
                relativeUrl: "/",
                params: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func DescribeStacks(input: DescribeStacksInput, completionHandler: @escaping (_: DescribeStacksOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.querySerialize()

            let request = QueryRequest(
                action: "DescribeStacks",
                method: "POST",
                relativeUrl: "/",
                params: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func EstimateTemplateCost(input: EstimateTemplateCostInput, completionHandler: @escaping (_: EstimateTemplateCostOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.querySerialize()

            let request = QueryRequest(
                action: "EstimateTemplateCost",
                method: "POST",
                relativeUrl: "/",
                params: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func ExecuteChangeSet(input: ExecuteChangeSetInput, completionHandler: @escaping (_: ExecuteChangeSetOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.querySerialize()

            let request = QueryRequest(
                action: "ExecuteChangeSet",
                method: "POST",
                relativeUrl: "/",
                params: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func GetStackPolicy(input: GetStackPolicyInput, completionHandler: @escaping (_: GetStackPolicyOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.querySerialize()

            let request = QueryRequest(
                action: "GetStackPolicy",
                method: "POST",
                relativeUrl: "/",
                params: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func GetTemplate(input: GetTemplateInput, completionHandler: @escaping (_: GetTemplateOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.querySerialize()

            let request = QueryRequest(
                action: "GetTemplate",
                method: "POST",
                relativeUrl: "/",
                params: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func GetTemplateSummary(input: GetTemplateSummaryInput, completionHandler: @escaping (_: GetTemplateSummaryOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.querySerialize()

            let request = QueryRequest(
                action: "GetTemplateSummary",
                method: "POST",
                relativeUrl: "/",
                params: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func ListChangeSets(input: ListChangeSetsInput, completionHandler: @escaping (_: ListChangeSetsOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.querySerialize()

            let request = QueryRequest(
                action: "ListChangeSets",
                method: "POST",
                relativeUrl: "/",
                params: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func ListExports(input: ListExportsInput, completionHandler: @escaping (_: ListExportsOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.querySerialize()

            let request = QueryRequest(
                action: "ListExports",
                method: "POST",
                relativeUrl: "/",
                params: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func ListStackResources(input: ListStackResourcesInput, completionHandler: @escaping (_: ListStackResourcesOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.querySerialize()

            let request = QueryRequest(
                action: "ListStackResources",
                method: "POST",
                relativeUrl: "/",
                params: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func ListStacks(input: ListStacksInput, completionHandler: @escaping (_: ListStacksOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.querySerialize()

            let request = QueryRequest(
                action: "ListStacks",
                method: "POST",
                relativeUrl: "/",
                params: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func SetStackPolicy(input: SetStackPolicyInput, completionHandler: @escaping (_: AwsApiVoidOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.querySerialize()

            let request = QueryRequest(
                action: "SetStackPolicy",
                method: "POST",
                relativeUrl: "/",
                params: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func SignalResource(input: SignalResourceInput, completionHandler: @escaping (_: AwsApiVoidOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.querySerialize()

            let request = QueryRequest(
                action: "SignalResource",
                method: "POST",
                relativeUrl: "/",
                params: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func UpdateStack(input: UpdateStackInput, completionHandler: @escaping (_: UpdateStackOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.querySerialize()

            let request = QueryRequest(
                action: "UpdateStack",
                method: "POST",
                relativeUrl: "/",
                params: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
        func ValidateTemplate(input: ValidateTemplateInput, completionHandler: @escaping (_: ValidateTemplateOutput?, _: Error?) -> ()) -> URLSessionTask {
            let serial = input.querySerialize()

            let request = QueryRequest(
                action: "ValidateTemplate",
                method: "POST",
                relativeUrl: "/",
                params: serial
            )
            
            return awsApiCallTask(request: request, completionHandler: completionHandler)
        }
        
    }

    
    struct AccountLimit: QuerySerializable, AwswiftDeserializable {
        public let name: String?
        public let value: Int?
        

        init(
            name: String?,
            value: Int?
            
        ) {
            self.name = name
            self.value = value
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "Name": name?.querySerialize(),
            
                "Value": value?.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> AccountLimit {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let name = try! body.nodes(forXPath: "Name").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let value = try! body.nodes(forXPath: "Value").first.flatMapNoNulls { v in
                return Int.deserialize(response: response, body: v)
            }
            

            return AccountLimit(
                
                name: name,
                
                value: value
                
            )
        }
        
    }
    
    struct AlreadyExistsException: QuerySerializable, AwswiftDeserializable {
        

        init(
            
        ) {
            
        }

        func querySerialize() -> QueryFieldValue {
            
            return .object([:])
            
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> AlreadyExistsException {
            guard let body = body as? XMLElement else { fatalError() }
            
            

            return AlreadyExistsException(
                
            )
        }
        
    }
    
    struct CancelUpdateStackInput: QuerySerializable, AwswiftDeserializable {
        public let stackname: String
        

        init(
            stackname: String
            
        ) {
            self.stackname = stackname
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "StackName": stackname.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> CancelUpdateStackInput {
            fatalError()
        }
        
        
    }
    
    struct Change: QuerySerializable, AwswiftDeserializable {
        public let resourcechange: ResourceChange?
        public let cloudformationtype: ChangeType?
        

        init(
            resourcechange: ResourceChange?,
            cloudformationtype: ChangeType?
            
        ) {
            self.resourcechange = resourcechange
            self.cloudformationtype = cloudformationtype
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "ResourceChange": resourcechange?.querySerialize(),
            
                "Type": cloudformationtype?.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> Change {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let resourcechange = try! body.nodes(forXPath: "ResourceChange").first.flatMapNoNulls { v in
                return ResourceChange.deserialize(response: response, body: v)
            }
            
            let cloudformationtype = try! body.nodes(forXPath: "Type").first.flatMapNoNulls { v in
                return ChangeType.deserialize(response: response, body: v)
            }
            

            return Change(
                
                resourcechange: resourcechange,
                
                cloudformationtype: cloudformationtype
                
            )
        }
        
    }
    
    struct ChangeSetNotFoundException: QuerySerializable, AwswiftDeserializable {
        

        init(
            
        ) {
            
        }

        func querySerialize() -> QueryFieldValue {
            
            return .object([:])
            
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> ChangeSetNotFoundException {
            guard let body = body as? XMLElement else { fatalError() }
            
            

            return ChangeSetNotFoundException(
                
            )
        }
        
    }
    
    struct ChangeSetSummary: QuerySerializable, AwswiftDeserializable {
        public let changesetid: String?
        public let changesetname: String?
        public let creationtime: Date?
        public let description: String?
        public let executionstatus: ExecutionStatus?
        public let stackid: String?
        public let stackname: String?
        public let status: ChangeSetStatus?
        public let statusreason: String?
        

        init(
            changesetid: String?,
            changesetname: String?,
            creationtime: Date?,
            description: String?,
            executionstatus: ExecutionStatus?,
            stackid: String?,
            stackname: String?,
            status: ChangeSetStatus?,
            statusreason: String?
            
        ) {
            self.changesetid = changesetid
            self.changesetname = changesetname
            self.creationtime = creationtime
            self.description = description
            self.executionstatus = executionstatus
            self.stackid = stackid
            self.stackname = stackname
            self.status = status
            self.statusreason = statusreason
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "ChangeSetId": changesetid?.querySerialize(),
            
                "ChangeSetName": changesetname?.querySerialize(),
            
                "CreationTime": creationtime?.querySerialize(),
            
                "Description": description?.querySerialize(),
            
                "ExecutionStatus": executionstatus?.querySerialize(),
            
                "StackId": stackid?.querySerialize(),
            
                "StackName": stackname?.querySerialize(),
            
                "Status": status?.querySerialize(),
            
                "StatusReason": statusreason?.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> ChangeSetSummary {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let changesetid = try! body.nodes(forXPath: "ChangeSetId").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let changesetname = try! body.nodes(forXPath: "ChangeSetName").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let creationtime = try! body.nodes(forXPath: "CreationTime").first.flatMapNoNulls { v in
                return Date.deserialize(response: response, body: v)
            }
            
            let description = try! body.nodes(forXPath: "Description").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let executionstatus = try! body.nodes(forXPath: "ExecutionStatus").first.flatMapNoNulls { v in
                return ExecutionStatus.deserialize(response: response, body: v)
            }
            
            let stackid = try! body.nodes(forXPath: "StackId").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let stackname = try! body.nodes(forXPath: "StackName").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let status = try! body.nodes(forXPath: "Status").first.flatMapNoNulls { v in
                return ChangeSetStatus.deserialize(response: response, body: v)
            }
            
            let statusreason = try! body.nodes(forXPath: "StatusReason").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return ChangeSetSummary(
                
                changesetid: changesetid,
                
                changesetname: changesetname,
                
                creationtime: creationtime,
                
                description: description,
                
                executionstatus: executionstatus,
                
                stackid: stackid,
                
                stackname: stackname,
                
                status: status,
                
                statusreason: statusreason
                
            )
        }
        
    }
    
    struct ContinueUpdateRollbackInput: QuerySerializable, AwswiftDeserializable {
        public let resourcestoskip: [String]?
        public let rolearn: String?
        public let stackname: String
        

        init(
            resourcestoskip: [String]?,
            rolearn: String?,
            stackname: String
            
        ) {
            self.resourcestoskip = resourcestoskip
            self.rolearn = rolearn
            self.stackname = stackname
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "ResourcesToSkip": resourcestoskip?.querySerialize(),
            
                "RoleARN": rolearn?.querySerialize(),
            
                "StackName": stackname.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> ContinueUpdateRollbackInput {
            fatalError()
        }
        
        
    }
    
    struct ContinueUpdateRollbackOutput: QuerySerializable, AwswiftDeserializable {
        

        init(
            
        ) {
            
        }

        func querySerialize() -> QueryFieldValue {
            
            return .object([:])
            
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> ContinueUpdateRollbackOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            

            return ContinueUpdateRollbackOutput(
                
            )
        }
        
    }
    
    struct CreateChangeSetInput: QuerySerializable, AwswiftDeserializable {
        public let capabilities: [Capability]?
        public let changesetname: String
        public let changesettype: ChangeSetType?
        public let clienttoken: String?
        public let description: String?
        public let notificationarns: [String]?
        public let parameters: [Parameter]?
        public let resourcetypes: [String]?
        public let rolearn: String?
        public let stackname: String
        public let tags: [Tag]?
        public let templatebody: String?
        public let templateurl: String?
        public let useprevioustemplate: Bool?
        

        init(
            capabilities: [Capability]?,
            changesetname: String,
            changesettype: ChangeSetType?,
            clienttoken: String?,
            description: String?,
            notificationarns: [String]?,
            parameters: [Parameter]?,
            resourcetypes: [String]?,
            rolearn: String?,
            stackname: String,
            tags: [Tag]?,
            templatebody: String?,
            templateurl: String?,
            useprevioustemplate: Bool?
            
        ) {
            self.capabilities = capabilities
            self.changesetname = changesetname
            self.changesettype = changesettype
            self.clienttoken = clienttoken
            self.description = description
            self.notificationarns = notificationarns
            self.parameters = parameters
            self.resourcetypes = resourcetypes
            self.rolearn = rolearn
            self.stackname = stackname
            self.tags = tags
            self.templatebody = templatebody
            self.templateurl = templateurl
            self.useprevioustemplate = useprevioustemplate
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "Capabilities": capabilities?.querySerialize(),
            
                "ChangeSetName": changesetname.querySerialize(),
            
                "ChangeSetType": changesettype?.querySerialize(),
            
                "ClientToken": clienttoken?.querySerialize(),
            
                "Description": description?.querySerialize(),
            
                "NotificationARNs": notificationarns?.querySerialize(),
            
                "Parameters": parameters?.querySerialize(),
            
                "ResourceTypes": resourcetypes?.querySerialize(),
            
                "RoleARN": rolearn?.querySerialize(),
            
                "StackName": stackname.querySerialize(),
            
                "Tags": tags?.querySerialize(),
            
                "TemplateBody": templatebody?.querySerialize(),
            
                "TemplateURL": templateurl?.querySerialize(),
            
                "UsePreviousTemplate": useprevioustemplate?.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> CreateChangeSetInput {
            fatalError()
        }
        
        
    }
    
    struct CreateChangeSetOutput: QuerySerializable, AwswiftDeserializable {
        public let id: String?
        public let stackid: String?
        

        init(
            id: String?,
            stackid: String?
            
        ) {
            self.id = id
            self.stackid = stackid
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "Id": id?.querySerialize(),
            
                "StackId": stackid?.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> CreateChangeSetOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let id = try! body.nodes(forXPath: "Id").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let stackid = try! body.nodes(forXPath: "StackId").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return CreateChangeSetOutput(
                
                id: id,
                
                stackid: stackid
                
            )
        }
        
    }
    
    struct CreateStackInput: QuerySerializable, AwswiftDeserializable {
        public let capabilities: [Capability]?
        public let disablerollback: Bool?
        public let notificationarns: [String]?
        public let onfailure: OnFailure?
        public let parameters: [Parameter]?
        public let resourcetypes: [String]?
        public let rolearn: String?
        public let stackname: String
        public let stackpolicybody: String?
        public let stackpolicyurl: String?
        public let tags: [Tag]?
        public let templatebody: String?
        public let templateurl: String?
        public let timeoutinminutes: Int?
        

        init(
            capabilities: [Capability]?,
            disablerollback: Bool?,
            notificationarns: [String]?,
            onfailure: OnFailure?,
            parameters: [Parameter]?,
            resourcetypes: [String]?,
            rolearn: String?,
            stackname: String,
            stackpolicybody: String?,
            stackpolicyurl: String?,
            tags: [Tag]?,
            templatebody: String?,
            templateurl: String?,
            timeoutinminutes: Int?
            
        ) {
            self.capabilities = capabilities
            self.disablerollback = disablerollback
            self.notificationarns = notificationarns
            self.onfailure = onfailure
            self.parameters = parameters
            self.resourcetypes = resourcetypes
            self.rolearn = rolearn
            self.stackname = stackname
            self.stackpolicybody = stackpolicybody
            self.stackpolicyurl = stackpolicyurl
            self.tags = tags
            self.templatebody = templatebody
            self.templateurl = templateurl
            self.timeoutinminutes = timeoutinminutes
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "Capabilities": capabilities?.querySerialize(),
            
                "DisableRollback": disablerollback?.querySerialize(),
            
                "NotificationARNs": notificationarns?.querySerialize(),
            
                "OnFailure": onfailure?.querySerialize(),
            
                "Parameters": parameters?.querySerialize(),
            
                "ResourceTypes": resourcetypes?.querySerialize(),
            
                "RoleARN": rolearn?.querySerialize(),
            
                "StackName": stackname.querySerialize(),
            
                "StackPolicyBody": stackpolicybody?.querySerialize(),
            
                "StackPolicyURL": stackpolicyurl?.querySerialize(),
            
                "Tags": tags?.querySerialize(),
            
                "TemplateBody": templatebody?.querySerialize(),
            
                "TemplateURL": templateurl?.querySerialize(),
            
                "TimeoutInMinutes": timeoutinminutes?.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> CreateStackInput {
            fatalError()
        }
        
        
    }
    
    struct CreateStackOutput: QuerySerializable, AwswiftDeserializable {
        public let stackid: String?
        

        init(
            stackid: String?
            
        ) {
            self.stackid = stackid
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "StackId": stackid?.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> CreateStackOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let stackid = try! body.nodes(forXPath: "StackId").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return CreateStackOutput(
                
                stackid: stackid
                
            )
        }
        
    }
    
    struct DeleteChangeSetInput: QuerySerializable, AwswiftDeserializable {
        public let changesetname: String
        public let stackname: String?
        

        init(
            changesetname: String,
            stackname: String?
            
        ) {
            self.changesetname = changesetname
            self.stackname = stackname
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "ChangeSetName": changesetname.querySerialize(),
            
                "StackName": stackname?.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> DeleteChangeSetInput {
            fatalError()
        }
        
        
    }
    
    struct DeleteChangeSetOutput: QuerySerializable, AwswiftDeserializable {
        

        init(
            
        ) {
            
        }

        func querySerialize() -> QueryFieldValue {
            
            return .object([:])
            
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> DeleteChangeSetOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            

            return DeleteChangeSetOutput(
                
            )
        }
        
    }
    
    struct DeleteStackInput: QuerySerializable, AwswiftDeserializable {
        public let retainresources: [String]?
        public let rolearn: String?
        public let stackname: String
        

        init(
            retainresources: [String]?,
            rolearn: String?,
            stackname: String
            
        ) {
            self.retainresources = retainresources
            self.rolearn = rolearn
            self.stackname = stackname
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "RetainResources": retainresources?.querySerialize(),
            
                "RoleARN": rolearn?.querySerialize(),
            
                "StackName": stackname.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> DeleteStackInput {
            fatalError()
        }
        
        
    }
    
    struct DescribeAccountLimitsInput: QuerySerializable, AwswiftDeserializable {
        public let nexttoken: String?
        

        init(
            nexttoken: String?
            
        ) {
            self.nexttoken = nexttoken
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "NextToken": nexttoken?.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> DescribeAccountLimitsInput {
            fatalError()
        }
        
        
    }
    
    struct DescribeAccountLimitsOutput: QuerySerializable, AwswiftDeserializable {
        public let accountlimits: [AccountLimit]?
        public let nexttoken: String?
        

        init(
            accountlimits: [AccountLimit]?,
            nexttoken: String?
            
        ) {
            self.accountlimits = accountlimits
            self.nexttoken = nexttoken
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "AccountLimits": accountlimits?.querySerialize(),
            
                "NextToken": nexttoken?.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> DescribeAccountLimitsOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let accountlimits = try! body.nodes(forXPath: "AccountLimits").first.flatMapNoNulls { v in
                return [AccountLimit].deserialize(response: response, body: v)
            }
            
            let nexttoken = try! body.nodes(forXPath: "NextToken").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return DescribeAccountLimitsOutput(
                
                accountlimits: accountlimits,
                
                nexttoken: nexttoken
                
            )
        }
        
    }
    
    struct DescribeChangeSetInput: QuerySerializable, AwswiftDeserializable {
        public let changesetname: String
        public let nexttoken: String?
        public let stackname: String?
        

        init(
            changesetname: String,
            nexttoken: String?,
            stackname: String?
            
        ) {
            self.changesetname = changesetname
            self.nexttoken = nexttoken
            self.stackname = stackname
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "ChangeSetName": changesetname.querySerialize(),
            
                "NextToken": nexttoken?.querySerialize(),
            
                "StackName": stackname?.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> DescribeChangeSetInput {
            fatalError()
        }
        
        
    }
    
    struct DescribeChangeSetOutput: QuerySerializable, AwswiftDeserializable {
        public let capabilities: [Capability]?
        public let changesetid: String?
        public let changesetname: String?
        public let changes: [Change]?
        public let creationtime: Date?
        public let description: String?
        public let executionstatus: ExecutionStatus?
        public let nexttoken: String?
        public let notificationarns: [String]?
        public let parameters: [Parameter]?
        public let stackid: String?
        public let stackname: String?
        public let status: ChangeSetStatus?
        public let statusreason: String?
        public let tags: [Tag]?
        

        init(
            capabilities: [Capability]?,
            changesetid: String?,
            changesetname: String?,
            changes: [Change]?,
            creationtime: Date?,
            description: String?,
            executionstatus: ExecutionStatus?,
            nexttoken: String?,
            notificationarns: [String]?,
            parameters: [Parameter]?,
            stackid: String?,
            stackname: String?,
            status: ChangeSetStatus?,
            statusreason: String?,
            tags: [Tag]?
            
        ) {
            self.capabilities = capabilities
            self.changesetid = changesetid
            self.changesetname = changesetname
            self.changes = changes
            self.creationtime = creationtime
            self.description = description
            self.executionstatus = executionstatus
            self.nexttoken = nexttoken
            self.notificationarns = notificationarns
            self.parameters = parameters
            self.stackid = stackid
            self.stackname = stackname
            self.status = status
            self.statusreason = statusreason
            self.tags = tags
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "Capabilities": capabilities?.querySerialize(),
            
                "ChangeSetId": changesetid?.querySerialize(),
            
                "ChangeSetName": changesetname?.querySerialize(),
            
                "Changes": changes?.querySerialize(),
            
                "CreationTime": creationtime?.querySerialize(),
            
                "Description": description?.querySerialize(),
            
                "ExecutionStatus": executionstatus?.querySerialize(),
            
                "NextToken": nexttoken?.querySerialize(),
            
                "NotificationARNs": notificationarns?.querySerialize(),
            
                "Parameters": parameters?.querySerialize(),
            
                "StackId": stackid?.querySerialize(),
            
                "StackName": stackname?.querySerialize(),
            
                "Status": status?.querySerialize(),
            
                "StatusReason": statusreason?.querySerialize(),
            
                "Tags": tags?.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> DescribeChangeSetOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let capabilities = try! body.nodes(forXPath: "Capabilities").first.flatMapNoNulls { v in
                return [Capability].deserialize(response: response, body: v)
            }
            
            let changesetid = try! body.nodes(forXPath: "ChangeSetId").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let changesetname = try! body.nodes(forXPath: "ChangeSetName").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let changes = try! body.nodes(forXPath: "Changes").first.flatMapNoNulls { v in
                return [Change].deserialize(response: response, body: v)
            }
            
            let creationtime = try! body.nodes(forXPath: "CreationTime").first.flatMapNoNulls { v in
                return Date.deserialize(response: response, body: v)
            }
            
            let description = try! body.nodes(forXPath: "Description").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let executionstatus = try! body.nodes(forXPath: "ExecutionStatus").first.flatMapNoNulls { v in
                return ExecutionStatus.deserialize(response: response, body: v)
            }
            
            let nexttoken = try! body.nodes(forXPath: "NextToken").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let notificationarns = try! body.nodes(forXPath: "NotificationARNs").first.flatMapNoNulls { v in
                return [String].deserialize(response: response, body: v)
            }
            
            let parameters = try! body.nodes(forXPath: "Parameters").first.flatMapNoNulls { v in
                return [Parameter].deserialize(response: response, body: v)
            }
            
            let stackid = try! body.nodes(forXPath: "StackId").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let stackname = try! body.nodes(forXPath: "StackName").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let status = try! body.nodes(forXPath: "Status").first.flatMapNoNulls { v in
                return ChangeSetStatus.deserialize(response: response, body: v)
            }
            
            let statusreason = try! body.nodes(forXPath: "StatusReason").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let tags = try! body.nodes(forXPath: "Tags").first.flatMapNoNulls { v in
                return [Tag].deserialize(response: response, body: v)
            }
            

            return DescribeChangeSetOutput(
                
                capabilities: capabilities,
                
                changesetid: changesetid,
                
                changesetname: changesetname,
                
                changes: changes,
                
                creationtime: creationtime,
                
                description: description,
                
                executionstatus: executionstatus,
                
                nexttoken: nexttoken,
                
                notificationarns: notificationarns,
                
                parameters: parameters,
                
                stackid: stackid,
                
                stackname: stackname,
                
                status: status,
                
                statusreason: statusreason,
                
                tags: tags
                
            )
        }
        
    }
    
    struct DescribeStackEventsInput: QuerySerializable, AwswiftDeserializable {
        public let nexttoken: String?
        public let stackname: String?
        

        init(
            nexttoken: String?,
            stackname: String?
            
        ) {
            self.nexttoken = nexttoken
            self.stackname = stackname
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "NextToken": nexttoken?.querySerialize(),
            
                "StackName": stackname?.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> DescribeStackEventsInput {
            fatalError()
        }
        
        
    }
    
    struct DescribeStackEventsOutput: QuerySerializable, AwswiftDeserializable {
        public let nexttoken: String?
        public let stackevents: [StackEvent]?
        

        init(
            nexttoken: String?,
            stackevents: [StackEvent]?
            
        ) {
            self.nexttoken = nexttoken
            self.stackevents = stackevents
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "NextToken": nexttoken?.querySerialize(),
            
                "StackEvents": stackevents?.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> DescribeStackEventsOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let nexttoken = try! body.nodes(forXPath: "NextToken").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let stackevents = try! body.nodes(forXPath: "StackEvents").first.flatMapNoNulls { v in
                return [StackEvent].deserialize(response: response, body: v)
            }
            

            return DescribeStackEventsOutput(
                
                nexttoken: nexttoken,
                
                stackevents: stackevents
                
            )
        }
        
    }
    
    struct DescribeStackResourceInput: QuerySerializable, AwswiftDeserializable {
        public let logicalresourceid: String
        public let stackname: String
        

        init(
            logicalresourceid: String,
            stackname: String
            
        ) {
            self.logicalresourceid = logicalresourceid
            self.stackname = stackname
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "LogicalResourceId": logicalresourceid.querySerialize(),
            
                "StackName": stackname.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> DescribeStackResourceInput {
            fatalError()
        }
        
        
    }
    
    struct DescribeStackResourceOutput: QuerySerializable, AwswiftDeserializable {
        public let stackresourcedetail: StackResourceDetail?
        

        init(
            stackresourcedetail: StackResourceDetail?
            
        ) {
            self.stackresourcedetail = stackresourcedetail
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "StackResourceDetail": stackresourcedetail?.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> DescribeStackResourceOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let stackresourcedetail = try! body.nodes(forXPath: "StackResourceDetail").first.flatMapNoNulls { v in
                return StackResourceDetail.deserialize(response: response, body: v)
            }
            

            return DescribeStackResourceOutput(
                
                stackresourcedetail: stackresourcedetail
                
            )
        }
        
    }
    
    struct DescribeStackResourcesInput: QuerySerializable, AwswiftDeserializable {
        public let logicalresourceid: String?
        public let physicalresourceid: String?
        public let stackname: String?
        

        init(
            logicalresourceid: String?,
            physicalresourceid: String?,
            stackname: String?
            
        ) {
            self.logicalresourceid = logicalresourceid
            self.physicalresourceid = physicalresourceid
            self.stackname = stackname
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "LogicalResourceId": logicalresourceid?.querySerialize(),
            
                "PhysicalResourceId": physicalresourceid?.querySerialize(),
            
                "StackName": stackname?.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> DescribeStackResourcesInput {
            fatalError()
        }
        
        
    }
    
    struct DescribeStackResourcesOutput: QuerySerializable, AwswiftDeserializable {
        public let stackresources: [StackResource]?
        

        init(
            stackresources: [StackResource]?
            
        ) {
            self.stackresources = stackresources
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "StackResources": stackresources?.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> DescribeStackResourcesOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let stackresources = try! body.nodes(forXPath: "StackResources").first.flatMapNoNulls { v in
                return [StackResource].deserialize(response: response, body: v)
            }
            

            return DescribeStackResourcesOutput(
                
                stackresources: stackresources
                
            )
        }
        
    }
    
    struct DescribeStacksInput: QuerySerializable, AwswiftDeserializable {
        public let nexttoken: String?
        public let stackname: String?
        

        init(
            nexttoken: String?,
            stackname: String?
            
        ) {
            self.nexttoken = nexttoken
            self.stackname = stackname
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "NextToken": nexttoken?.querySerialize(),
            
                "StackName": stackname?.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> DescribeStacksInput {
            fatalError()
        }
        
        
    }
    
    struct DescribeStacksOutput: QuerySerializable, AwswiftDeserializable {
        public let nexttoken: String?
        public let stacks: [Stack]?
        

        init(
            nexttoken: String?,
            stacks: [Stack]?
            
        ) {
            self.nexttoken = nexttoken
            self.stacks = stacks
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "NextToken": nexttoken?.querySerialize(),
            
                "Stacks": stacks?.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> DescribeStacksOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let nexttoken = try! body.nodes(forXPath: "NextToken").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let stacks = try! body.nodes(forXPath: "Stacks").first.flatMapNoNulls { v in
                return [Stack].deserialize(response: response, body: v)
            }
            

            return DescribeStacksOutput(
                
                nexttoken: nexttoken,
                
                stacks: stacks
                
            )
        }
        
    }
    
    struct EstimateTemplateCostInput: QuerySerializable, AwswiftDeserializable {
        public let parameters: [Parameter]?
        public let templatebody: String?
        public let templateurl: String?
        

        init(
            parameters: [Parameter]?,
            templatebody: String?,
            templateurl: String?
            
        ) {
            self.parameters = parameters
            self.templatebody = templatebody
            self.templateurl = templateurl
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "Parameters": parameters?.querySerialize(),
            
                "TemplateBody": templatebody?.querySerialize(),
            
                "TemplateURL": templateurl?.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> EstimateTemplateCostInput {
            fatalError()
        }
        
        
    }
    
    struct EstimateTemplateCostOutput: QuerySerializable, AwswiftDeserializable {
        public let url: String?
        

        init(
            url: String?
            
        ) {
            self.url = url
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "Url": url?.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> EstimateTemplateCostOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let url = try! body.nodes(forXPath: "Url").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return EstimateTemplateCostOutput(
                
                url: url
                
            )
        }
        
    }
    
    struct ExecuteChangeSetInput: QuerySerializable, AwswiftDeserializable {
        public let changesetname: String
        public let stackname: String?
        

        init(
            changesetname: String,
            stackname: String?
            
        ) {
            self.changesetname = changesetname
            self.stackname = stackname
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "ChangeSetName": changesetname.querySerialize(),
            
                "StackName": stackname?.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> ExecuteChangeSetInput {
            fatalError()
        }
        
        
    }
    
    struct ExecuteChangeSetOutput: QuerySerializable, AwswiftDeserializable {
        

        init(
            
        ) {
            
        }

        func querySerialize() -> QueryFieldValue {
            
            return .object([:])
            
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> ExecuteChangeSetOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            

            return ExecuteChangeSetOutput(
                
            )
        }
        
    }
    
    struct Export: QuerySerializable, AwswiftDeserializable {
        public let exportingstackid: String?
        public let name: String?
        public let value: String?
        

        init(
            exportingstackid: String?,
            name: String?,
            value: String?
            
        ) {
            self.exportingstackid = exportingstackid
            self.name = name
            self.value = value
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "ExportingStackId": exportingstackid?.querySerialize(),
            
                "Name": name?.querySerialize(),
            
                "Value": value?.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> Export {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let exportingstackid = try! body.nodes(forXPath: "ExportingStackId").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let name = try! body.nodes(forXPath: "Name").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let value = try! body.nodes(forXPath: "Value").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return Export(
                
                exportingstackid: exportingstackid,
                
                name: name,
                
                value: value
                
            )
        }
        
    }
    
    struct GetStackPolicyInput: QuerySerializable, AwswiftDeserializable {
        public let stackname: String
        

        init(
            stackname: String
            
        ) {
            self.stackname = stackname
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "StackName": stackname.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> GetStackPolicyInput {
            fatalError()
        }
        
        
    }
    
    struct GetStackPolicyOutput: QuerySerializable, AwswiftDeserializable {
        public let stackpolicybody: String?
        

        init(
            stackpolicybody: String?
            
        ) {
            self.stackpolicybody = stackpolicybody
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "StackPolicyBody": stackpolicybody?.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> GetStackPolicyOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let stackpolicybody = try! body.nodes(forXPath: "StackPolicyBody").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return GetStackPolicyOutput(
                
                stackpolicybody: stackpolicybody
                
            )
        }
        
    }
    
    struct GetTemplateInput: QuerySerializable, AwswiftDeserializable {
        public let changesetname: String?
        public let stackname: String?
        public let templatestage: TemplateStage?
        

        init(
            changesetname: String?,
            stackname: String?,
            templatestage: TemplateStage?
            
        ) {
            self.changesetname = changesetname
            self.stackname = stackname
            self.templatestage = templatestage
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "ChangeSetName": changesetname?.querySerialize(),
            
                "StackName": stackname?.querySerialize(),
            
                "TemplateStage": templatestage?.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> GetTemplateInput {
            fatalError()
        }
        
        
    }
    
    struct GetTemplateOutput: QuerySerializable, AwswiftDeserializable {
        public let stagesavailable: [TemplateStage]?
        public let templatebody: String?
        

        init(
            stagesavailable: [TemplateStage]?,
            templatebody: String?
            
        ) {
            self.stagesavailable = stagesavailable
            self.templatebody = templatebody
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "StagesAvailable": stagesavailable?.querySerialize(),
            
                "TemplateBody": templatebody?.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> GetTemplateOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let stagesavailable = try! body.nodes(forXPath: "StagesAvailable").first.flatMapNoNulls { v in
                return [TemplateStage].deserialize(response: response, body: v)
            }
            
            let templatebody = try! body.nodes(forXPath: "TemplateBody").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return GetTemplateOutput(
                
                stagesavailable: stagesavailable,
                
                templatebody: templatebody
                
            )
        }
        
    }
    
    struct GetTemplateSummaryInput: QuerySerializable, AwswiftDeserializable {
        public let stackname: String?
        public let templatebody: String?
        public let templateurl: String?
        

        init(
            stackname: String?,
            templatebody: String?,
            templateurl: String?
            
        ) {
            self.stackname = stackname
            self.templatebody = templatebody
            self.templateurl = templateurl
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "StackName": stackname?.querySerialize(),
            
                "TemplateBody": templatebody?.querySerialize(),
            
                "TemplateURL": templateurl?.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> GetTemplateSummaryInput {
            fatalError()
        }
        
        
    }
    
    struct GetTemplateSummaryOutput: QuerySerializable, AwswiftDeserializable {
        public let capabilities: [Capability]?
        public let capabilitiesreason: String?
        public let declaredtransforms: [String]?
        public let description: String?
        public let metadata: String?
        public let parameters: [ParameterDeclaration]?
        public let resourcetypes: [String]?
        public let version: String?
        

        init(
            capabilities: [Capability]?,
            capabilitiesreason: String?,
            declaredtransforms: [String]?,
            description: String?,
            metadata: String?,
            parameters: [ParameterDeclaration]?,
            resourcetypes: [String]?,
            version: String?
            
        ) {
            self.capabilities = capabilities
            self.capabilitiesreason = capabilitiesreason
            self.declaredtransforms = declaredtransforms
            self.description = description
            self.metadata = metadata
            self.parameters = parameters
            self.resourcetypes = resourcetypes
            self.version = version
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "Capabilities": capabilities?.querySerialize(),
            
                "CapabilitiesReason": capabilitiesreason?.querySerialize(),
            
                "DeclaredTransforms": declaredtransforms?.querySerialize(),
            
                "Description": description?.querySerialize(),
            
                "Metadata": metadata?.querySerialize(),
            
                "Parameters": parameters?.querySerialize(),
            
                "ResourceTypes": resourcetypes?.querySerialize(),
            
                "Version": version?.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> GetTemplateSummaryOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let capabilities = try! body.nodes(forXPath: "Capabilities").first.flatMapNoNulls { v in
                return [Capability].deserialize(response: response, body: v)
            }
            
            let capabilitiesreason = try! body.nodes(forXPath: "CapabilitiesReason").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let declaredtransforms = try! body.nodes(forXPath: "DeclaredTransforms").first.flatMapNoNulls { v in
                return [String].deserialize(response: response, body: v)
            }
            
            let description = try! body.nodes(forXPath: "Description").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let metadata = try! body.nodes(forXPath: "Metadata").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let parameters = try! body.nodes(forXPath: "Parameters").first.flatMapNoNulls { v in
                return [ParameterDeclaration].deserialize(response: response, body: v)
            }
            
            let resourcetypes = try! body.nodes(forXPath: "ResourceTypes").first.flatMapNoNulls { v in
                return [String].deserialize(response: response, body: v)
            }
            
            let version = try! body.nodes(forXPath: "Version").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return GetTemplateSummaryOutput(
                
                capabilities: capabilities,
                
                capabilitiesreason: capabilitiesreason,
                
                declaredtransforms: declaredtransforms,
                
                description: description,
                
                metadata: metadata,
                
                parameters: parameters,
                
                resourcetypes: resourcetypes,
                
                version: version
                
            )
        }
        
    }
    
    struct InsufficientCapabilitiesException: QuerySerializable, AwswiftDeserializable {
        

        init(
            
        ) {
            
        }

        func querySerialize() -> QueryFieldValue {
            
            return .object([:])
            
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> InsufficientCapabilitiesException {
            guard let body = body as? XMLElement else { fatalError() }
            
            

            return InsufficientCapabilitiesException(
                
            )
        }
        
    }
    
    struct InvalidChangeSetStatusException: QuerySerializable, AwswiftDeserializable {
        

        init(
            
        ) {
            
        }

        func querySerialize() -> QueryFieldValue {
            
            return .object([:])
            
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> InvalidChangeSetStatusException {
            guard let body = body as? XMLElement else { fatalError() }
            
            

            return InvalidChangeSetStatusException(
                
            )
        }
        
    }
    
    struct LimitExceededException: QuerySerializable, AwswiftDeserializable {
        

        init(
            
        ) {
            
        }

        func querySerialize() -> QueryFieldValue {
            
            return .object([:])
            
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> LimitExceededException {
            guard let body = body as? XMLElement else { fatalError() }
            
            

            return LimitExceededException(
                
            )
        }
        
    }
    
    struct ListChangeSetsInput: QuerySerializable, AwswiftDeserializable {
        public let nexttoken: String?
        public let stackname: String
        

        init(
            nexttoken: String?,
            stackname: String
            
        ) {
            self.nexttoken = nexttoken
            self.stackname = stackname
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "NextToken": nexttoken?.querySerialize(),
            
                "StackName": stackname.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> ListChangeSetsInput {
            fatalError()
        }
        
        
    }
    
    struct ListChangeSetsOutput: QuerySerializable, AwswiftDeserializable {
        public let nexttoken: String?
        public let summaries: [ChangeSetSummary]?
        

        init(
            nexttoken: String?,
            summaries: [ChangeSetSummary]?
            
        ) {
            self.nexttoken = nexttoken
            self.summaries = summaries
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "NextToken": nexttoken?.querySerialize(),
            
                "Summaries": summaries?.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> ListChangeSetsOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let nexttoken = try! body.nodes(forXPath: "NextToken").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let summaries = try! body.nodes(forXPath: "Summaries").first.flatMapNoNulls { v in
                return [ChangeSetSummary].deserialize(response: response, body: v)
            }
            

            return ListChangeSetsOutput(
                
                nexttoken: nexttoken,
                
                summaries: summaries
                
            )
        }
        
    }
    
    struct ListExportsInput: QuerySerializable, AwswiftDeserializable {
        public let nexttoken: String?
        

        init(
            nexttoken: String?
            
        ) {
            self.nexttoken = nexttoken
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "NextToken": nexttoken?.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> ListExportsInput {
            fatalError()
        }
        
        
    }
    
    struct ListExportsOutput: QuerySerializable, AwswiftDeserializable {
        public let exports: [Export]?
        public let nexttoken: String?
        

        init(
            exports: [Export]?,
            nexttoken: String?
            
        ) {
            self.exports = exports
            self.nexttoken = nexttoken
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "Exports": exports?.querySerialize(),
            
                "NextToken": nexttoken?.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> ListExportsOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let exports = try! body.nodes(forXPath: "Exports").first.flatMapNoNulls { v in
                return [Export].deserialize(response: response, body: v)
            }
            
            let nexttoken = try! body.nodes(forXPath: "NextToken").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return ListExportsOutput(
                
                exports: exports,
                
                nexttoken: nexttoken
                
            )
        }
        
    }
    
    struct ListStackResourcesInput: QuerySerializable, AwswiftDeserializable {
        public let nexttoken: String?
        public let stackname: String
        

        init(
            nexttoken: String?,
            stackname: String
            
        ) {
            self.nexttoken = nexttoken
            self.stackname = stackname
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "NextToken": nexttoken?.querySerialize(),
            
                "StackName": stackname.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> ListStackResourcesInput {
            fatalError()
        }
        
        
    }
    
    struct ListStackResourcesOutput: QuerySerializable, AwswiftDeserializable {
        public let nexttoken: String?
        public let stackresourcesummaries: [StackResourceSummary]?
        

        init(
            nexttoken: String?,
            stackresourcesummaries: [StackResourceSummary]?
            
        ) {
            self.nexttoken = nexttoken
            self.stackresourcesummaries = stackresourcesummaries
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "NextToken": nexttoken?.querySerialize(),
            
                "StackResourceSummaries": stackresourcesummaries?.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> ListStackResourcesOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let nexttoken = try! body.nodes(forXPath: "NextToken").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let stackresourcesummaries = try! body.nodes(forXPath: "StackResourceSummaries").first.flatMapNoNulls { v in
                return [StackResourceSummary].deserialize(response: response, body: v)
            }
            

            return ListStackResourcesOutput(
                
                nexttoken: nexttoken,
                
                stackresourcesummaries: stackresourcesummaries
                
            )
        }
        
    }
    
    struct ListStacksInput: QuerySerializable, AwswiftDeserializable {
        public let nexttoken: String?
        public let stackstatusfilter: [StackStatus]?
        

        init(
            nexttoken: String?,
            stackstatusfilter: [StackStatus]?
            
        ) {
            self.nexttoken = nexttoken
            self.stackstatusfilter = stackstatusfilter
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "NextToken": nexttoken?.querySerialize(),
            
                "StackStatusFilter": stackstatusfilter?.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> ListStacksInput {
            fatalError()
        }
        
        
    }
    
    struct ListStacksOutput: QuerySerializable, AwswiftDeserializable {
        public let nexttoken: String?
        public let stacksummaries: [StackSummary]?
        

        init(
            nexttoken: String?,
            stacksummaries: [StackSummary]?
            
        ) {
            self.nexttoken = nexttoken
            self.stacksummaries = stacksummaries
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "NextToken": nexttoken?.querySerialize(),
            
                "StackSummaries": stacksummaries?.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> ListStacksOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let nexttoken = try! body.nodes(forXPath: "NextToken").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let stacksummaries = try! body.nodes(forXPath: "StackSummaries").first.flatMapNoNulls { v in
                return [StackSummary].deserialize(response: response, body: v)
            }
            

            return ListStacksOutput(
                
                nexttoken: nexttoken,
                
                stacksummaries: stacksummaries
                
            )
        }
        
    }
    
    struct Output: QuerySerializable, AwswiftDeserializable {
        public let description: String?
        public let outputkey: String?
        public let outputvalue: String?
        

        init(
            description: String?,
            outputkey: String?,
            outputvalue: String?
            
        ) {
            self.description = description
            self.outputkey = outputkey
            self.outputvalue = outputvalue
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "Description": description?.querySerialize(),
            
                "OutputKey": outputkey?.querySerialize(),
            
                "OutputValue": outputvalue?.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> Output {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let description = try! body.nodes(forXPath: "Description").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let outputkey = try! body.nodes(forXPath: "OutputKey").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let outputvalue = try! body.nodes(forXPath: "OutputValue").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return Output(
                
                description: description,
                
                outputkey: outputkey,
                
                outputvalue: outputvalue
                
            )
        }
        
    }
    
    struct Parameter: QuerySerializable, AwswiftDeserializable {
        public let parameterkey: String?
        public let parametervalue: String?
        public let usepreviousvalue: Bool?
        

        init(
            parameterkey: String?,
            parametervalue: String?,
            usepreviousvalue: Bool?
            
        ) {
            self.parameterkey = parameterkey
            self.parametervalue = parametervalue
            self.usepreviousvalue = usepreviousvalue
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "ParameterKey": parameterkey?.querySerialize(),
            
                "ParameterValue": parametervalue?.querySerialize(),
            
                "UsePreviousValue": usepreviousvalue?.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> Parameter {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let parameterkey = try! body.nodes(forXPath: "ParameterKey").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let parametervalue = try! body.nodes(forXPath: "ParameterValue").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let usepreviousvalue = try! body.nodes(forXPath: "UsePreviousValue").first.flatMapNoNulls { v in
                return Bool.deserialize(response: response, body: v)
            }
            

            return Parameter(
                
                parameterkey: parameterkey,
                
                parametervalue: parametervalue,
                
                usepreviousvalue: usepreviousvalue
                
            )
        }
        
    }
    
    struct ParameterConstraints: QuerySerializable, AwswiftDeserializable {
        public let allowedvalues: [String]?
        

        init(
            allowedvalues: [String]?
            
        ) {
            self.allowedvalues = allowedvalues
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "AllowedValues": allowedvalues?.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> ParameterConstraints {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let allowedvalues = try! body.nodes(forXPath: "AllowedValues").first.flatMapNoNulls { v in
                return [String].deserialize(response: response, body: v)
            }
            

            return ParameterConstraints(
                
                allowedvalues: allowedvalues
                
            )
        }
        
    }
    
    struct ParameterDeclaration: QuerySerializable, AwswiftDeserializable {
        public let defaultvalue: String?
        public let description: String?
        public let noecho: Bool?
        public let parameterconstraints: ParameterConstraints?
        public let parameterkey: String?
        public let parametertype: String?
        

        init(
            defaultvalue: String?,
            description: String?,
            noecho: Bool?,
            parameterconstraints: ParameterConstraints?,
            parameterkey: String?,
            parametertype: String?
            
        ) {
            self.defaultvalue = defaultvalue
            self.description = description
            self.noecho = noecho
            self.parameterconstraints = parameterconstraints
            self.parameterkey = parameterkey
            self.parametertype = parametertype
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "DefaultValue": defaultvalue?.querySerialize(),
            
                "Description": description?.querySerialize(),
            
                "NoEcho": noecho?.querySerialize(),
            
                "ParameterConstraints": parameterconstraints?.querySerialize(),
            
                "ParameterKey": parameterkey?.querySerialize(),
            
                "ParameterType": parametertype?.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> ParameterDeclaration {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let defaultvalue = try! body.nodes(forXPath: "DefaultValue").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let description = try! body.nodes(forXPath: "Description").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let noecho = try! body.nodes(forXPath: "NoEcho").first.flatMapNoNulls { v in
                return Bool.deserialize(response: response, body: v)
            }
            
            let parameterconstraints = try! body.nodes(forXPath: "ParameterConstraints").first.flatMapNoNulls { v in
                return ParameterConstraints.deserialize(response: response, body: v)
            }
            
            let parameterkey = try! body.nodes(forXPath: "ParameterKey").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let parametertype = try! body.nodes(forXPath: "ParameterType").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return ParameterDeclaration(
                
                defaultvalue: defaultvalue,
                
                description: description,
                
                noecho: noecho,
                
                parameterconstraints: parameterconstraints,
                
                parameterkey: parameterkey,
                
                parametertype: parametertype
                
            )
        }
        
    }
    
    struct ResourceChange: QuerySerializable, AwswiftDeserializable {
        public let action: ChangeAction?
        public let details: [ResourceChangeDetail]?
        public let logicalresourceid: String?
        public let physicalresourceid: String?
        public let replacement: Replacement?
        public let resourcetype: String?
        public let scope: [ResourceAttribute]?
        

        init(
            action: ChangeAction?,
            details: [ResourceChangeDetail]?,
            logicalresourceid: String?,
            physicalresourceid: String?,
            replacement: Replacement?,
            resourcetype: String?,
            scope: [ResourceAttribute]?
            
        ) {
            self.action = action
            self.details = details
            self.logicalresourceid = logicalresourceid
            self.physicalresourceid = physicalresourceid
            self.replacement = replacement
            self.resourcetype = resourcetype
            self.scope = scope
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "Action": action?.querySerialize(),
            
                "Details": details?.querySerialize(),
            
                "LogicalResourceId": logicalresourceid?.querySerialize(),
            
                "PhysicalResourceId": physicalresourceid?.querySerialize(),
            
                "Replacement": replacement?.querySerialize(),
            
                "ResourceType": resourcetype?.querySerialize(),
            
                "Scope": scope?.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> ResourceChange {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let action = try! body.nodes(forXPath: "Action").first.flatMapNoNulls { v in
                return ChangeAction.deserialize(response: response, body: v)
            }
            
            let details = try! body.nodes(forXPath: "Details").first.flatMapNoNulls { v in
                return [ResourceChangeDetail].deserialize(response: response, body: v)
            }
            
            let logicalresourceid = try! body.nodes(forXPath: "LogicalResourceId").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let physicalresourceid = try! body.nodes(forXPath: "PhysicalResourceId").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let replacement = try! body.nodes(forXPath: "Replacement").first.flatMapNoNulls { v in
                return Replacement.deserialize(response: response, body: v)
            }
            
            let resourcetype = try! body.nodes(forXPath: "ResourceType").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let scope = try! body.nodes(forXPath: "Scope").first.flatMapNoNulls { v in
                return [ResourceAttribute].deserialize(response: response, body: v)
            }
            

            return ResourceChange(
                
                action: action,
                
                details: details,
                
                logicalresourceid: logicalresourceid,
                
                physicalresourceid: physicalresourceid,
                
                replacement: replacement,
                
                resourcetype: resourcetype,
                
                scope: scope
                
            )
        }
        
    }
    
    struct ResourceChangeDetail: QuerySerializable, AwswiftDeserializable {
        public let causingentity: String?
        public let changesource: ChangeSource?
        public let evaluation: EvaluationType?
        public let target: ResourceTargetDefinition?
        

        init(
            causingentity: String?,
            changesource: ChangeSource?,
            evaluation: EvaluationType?,
            target: ResourceTargetDefinition?
            
        ) {
            self.causingentity = causingentity
            self.changesource = changesource
            self.evaluation = evaluation
            self.target = target
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "CausingEntity": causingentity?.querySerialize(),
            
                "ChangeSource": changesource?.querySerialize(),
            
                "Evaluation": evaluation?.querySerialize(),
            
                "Target": target?.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> ResourceChangeDetail {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let causingentity = try! body.nodes(forXPath: "CausingEntity").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let changesource = try! body.nodes(forXPath: "ChangeSource").first.flatMapNoNulls { v in
                return ChangeSource.deserialize(response: response, body: v)
            }
            
            let evaluation = try! body.nodes(forXPath: "Evaluation").first.flatMapNoNulls { v in
                return EvaluationType.deserialize(response: response, body: v)
            }
            
            let target = try! body.nodes(forXPath: "Target").first.flatMapNoNulls { v in
                return ResourceTargetDefinition.deserialize(response: response, body: v)
            }
            

            return ResourceChangeDetail(
                
                causingentity: causingentity,
                
                changesource: changesource,
                
                evaluation: evaluation,
                
                target: target
                
            )
        }
        
    }
    
    struct ResourceTargetDefinition: QuerySerializable, AwswiftDeserializable {
        public let attribute: ResourceAttribute?
        public let name: String?
        public let requiresrecreation: RequiresRecreation?
        

        init(
            attribute: ResourceAttribute?,
            name: String?,
            requiresrecreation: RequiresRecreation?
            
        ) {
            self.attribute = attribute
            self.name = name
            self.requiresrecreation = requiresrecreation
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "Attribute": attribute?.querySerialize(),
            
                "Name": name?.querySerialize(),
            
                "RequiresRecreation": requiresrecreation?.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> ResourceTargetDefinition {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let attribute = try! body.nodes(forXPath: "Attribute").first.flatMapNoNulls { v in
                return ResourceAttribute.deserialize(response: response, body: v)
            }
            
            let name = try! body.nodes(forXPath: "Name").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let requiresrecreation = try! body.nodes(forXPath: "RequiresRecreation").first.flatMapNoNulls { v in
                return RequiresRecreation.deserialize(response: response, body: v)
            }
            

            return ResourceTargetDefinition(
                
                attribute: attribute,
                
                name: name,
                
                requiresrecreation: requiresrecreation
                
            )
        }
        
    }
    
    struct SetStackPolicyInput: QuerySerializable, AwswiftDeserializable {
        public let stackname: String
        public let stackpolicybody: String?
        public let stackpolicyurl: String?
        

        init(
            stackname: String,
            stackpolicybody: String?,
            stackpolicyurl: String?
            
        ) {
            self.stackname = stackname
            self.stackpolicybody = stackpolicybody
            self.stackpolicyurl = stackpolicyurl
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "StackName": stackname.querySerialize(),
            
                "StackPolicyBody": stackpolicybody?.querySerialize(),
            
                "StackPolicyURL": stackpolicyurl?.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> SetStackPolicyInput {
            fatalError()
        }
        
        
    }
    
    struct SignalResourceInput: QuerySerializable, AwswiftDeserializable {
        public let logicalresourceid: String
        public let stackname: String
        public let status: ResourceSignalStatus
        public let uniqueid: String
        

        init(
            logicalresourceid: String,
            stackname: String,
            status: ResourceSignalStatus,
            uniqueid: String
            
        ) {
            self.logicalresourceid = logicalresourceid
            self.stackname = stackname
            self.status = status
            self.uniqueid = uniqueid
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "LogicalResourceId": logicalresourceid.querySerialize(),
            
                "StackName": stackname.querySerialize(),
            
                "Status": status.querySerialize(),
            
                "UniqueId": uniqueid.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> SignalResourceInput {
            fatalError()
        }
        
        
    }
    
    struct Stack: QuerySerializable, AwswiftDeserializable {
        public let capabilities: [Capability]?
        public let changesetid: String?
        public let creationtime: Date
        public let description: String?
        public let disablerollback: Bool?
        public let lastupdatedtime: Date?
        public let notificationarns: [String]?
        public let outputs: [Output]?
        public let parameters: [Parameter]?
        public let rolearn: String?
        public let stackid: String?
        public let stackname: String
        public let stackstatus: StackStatus
        public let stackstatusreason: String?
        public let tags: [Tag]?
        public let timeoutinminutes: Int?
        

        init(
            capabilities: [Capability]?,
            changesetid: String?,
            creationtime: Date,
            description: String?,
            disablerollback: Bool?,
            lastupdatedtime: Date?,
            notificationarns: [String]?,
            outputs: [Output]?,
            parameters: [Parameter]?,
            rolearn: String?,
            stackid: String?,
            stackname: String,
            stackstatus: StackStatus,
            stackstatusreason: String?,
            tags: [Tag]?,
            timeoutinminutes: Int?
            
        ) {
            self.capabilities = capabilities
            self.changesetid = changesetid
            self.creationtime = creationtime
            self.description = description
            self.disablerollback = disablerollback
            self.lastupdatedtime = lastupdatedtime
            self.notificationarns = notificationarns
            self.outputs = outputs
            self.parameters = parameters
            self.rolearn = rolearn
            self.stackid = stackid
            self.stackname = stackname
            self.stackstatus = stackstatus
            self.stackstatusreason = stackstatusreason
            self.tags = tags
            self.timeoutinminutes = timeoutinminutes
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "Capabilities": capabilities?.querySerialize(),
            
                "ChangeSetId": changesetid?.querySerialize(),
            
                "CreationTime": creationtime.querySerialize(),
            
                "Description": description?.querySerialize(),
            
                "DisableRollback": disablerollback?.querySerialize(),
            
                "LastUpdatedTime": lastupdatedtime?.querySerialize(),
            
                "NotificationARNs": notificationarns?.querySerialize(),
            
                "Outputs": outputs?.querySerialize(),
            
                "Parameters": parameters?.querySerialize(),
            
                "RoleARN": rolearn?.querySerialize(),
            
                "StackId": stackid?.querySerialize(),
            
                "StackName": stackname.querySerialize(),
            
                "StackStatus": stackstatus.querySerialize(),
            
                "StackStatusReason": stackstatusreason?.querySerialize(),
            
                "Tags": tags?.querySerialize(),
            
                "TimeoutInMinutes": timeoutinminutes?.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> Stack {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let capabilities = try! body.nodes(forXPath: "Capabilities").first.flatMapNoNulls { v in
                return [Capability].deserialize(response: response, body: v)
            }
            
            let changesetid = try! body.nodes(forXPath: "ChangeSetId").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let creationtime = try! body.nodes(forXPath: "CreationTime").first.flatMapNoNulls { v in
                return Date.deserialize(response: response, body: v)
            }
            
            let description = try! body.nodes(forXPath: "Description").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let disablerollback = try! body.nodes(forXPath: "DisableRollback").first.flatMapNoNulls { v in
                return Bool.deserialize(response: response, body: v)
            }
            
            let lastupdatedtime = try! body.nodes(forXPath: "LastUpdatedTime").first.flatMapNoNulls { v in
                return Date.deserialize(response: response, body: v)
            }
            
            let notificationarns = try! body.nodes(forXPath: "NotificationARNs").first.flatMapNoNulls { v in
                return [String].deserialize(response: response, body: v)
            }
            
            let outputs = try! body.nodes(forXPath: "Outputs").first.flatMapNoNulls { v in
                return [Output].deserialize(response: response, body: v)
            }
            
            let parameters = try! body.nodes(forXPath: "Parameters").first.flatMapNoNulls { v in
                return [Parameter].deserialize(response: response, body: v)
            }
            
            let rolearn = try! body.nodes(forXPath: "RoleARN").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let stackid = try! body.nodes(forXPath: "StackId").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let stackname = try! body.nodes(forXPath: "StackName").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let stackstatus = try! body.nodes(forXPath: "StackStatus").first.flatMapNoNulls { v in
                return StackStatus.deserialize(response: response, body: v)
            }
            
            let stackstatusreason = try! body.nodes(forXPath: "StackStatusReason").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let tags = try! body.nodes(forXPath: "Tags").first.flatMapNoNulls { v in
                return [Tag].deserialize(response: response, body: v)
            }
            
            let timeoutinminutes = try! body.nodes(forXPath: "TimeoutInMinutes").first.flatMapNoNulls { v in
                return Int.deserialize(response: response, body: v)
            }
            

            return Stack(
                
                capabilities: capabilities,
                
                changesetid: changesetid,
                
                creationtime: creationtime!,
                
                description: description,
                
                disablerollback: disablerollback,
                
                lastupdatedtime: lastupdatedtime,
                
                notificationarns: notificationarns,
                
                outputs: outputs,
                
                parameters: parameters,
                
                rolearn: rolearn,
                
                stackid: stackid,
                
                stackname: stackname!,
                
                stackstatus: stackstatus!,
                
                stackstatusreason: stackstatusreason,
                
                tags: tags,
                
                timeoutinminutes: timeoutinminutes
                
            )
        }
        
    }
    
    struct StackEvent: QuerySerializable, AwswiftDeserializable {
        public let eventid: String
        public let logicalresourceid: String?
        public let physicalresourceid: String?
        public let resourceproperties: String?
        public let resourcestatus: ResourceStatus?
        public let resourcestatusreason: String?
        public let resourcetype: String?
        public let stackid: String
        public let stackname: String
        public let timestamp: Date
        

        init(
            eventid: String,
            logicalresourceid: String?,
            physicalresourceid: String?,
            resourceproperties: String?,
            resourcestatus: ResourceStatus?,
            resourcestatusreason: String?,
            resourcetype: String?,
            stackid: String,
            stackname: String,
            timestamp: Date
            
        ) {
            self.eventid = eventid
            self.logicalresourceid = logicalresourceid
            self.physicalresourceid = physicalresourceid
            self.resourceproperties = resourceproperties
            self.resourcestatus = resourcestatus
            self.resourcestatusreason = resourcestatusreason
            self.resourcetype = resourcetype
            self.stackid = stackid
            self.stackname = stackname
            self.timestamp = timestamp
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "EventId": eventid.querySerialize(),
            
                "LogicalResourceId": logicalresourceid?.querySerialize(),
            
                "PhysicalResourceId": physicalresourceid?.querySerialize(),
            
                "ResourceProperties": resourceproperties?.querySerialize(),
            
                "ResourceStatus": resourcestatus?.querySerialize(),
            
                "ResourceStatusReason": resourcestatusreason?.querySerialize(),
            
                "ResourceType": resourcetype?.querySerialize(),
            
                "StackId": stackid.querySerialize(),
            
                "StackName": stackname.querySerialize(),
            
                "Timestamp": timestamp.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> StackEvent {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let eventid = try! body.nodes(forXPath: "EventId").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let logicalresourceid = try! body.nodes(forXPath: "LogicalResourceId").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let physicalresourceid = try! body.nodes(forXPath: "PhysicalResourceId").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let resourceproperties = try! body.nodes(forXPath: "ResourceProperties").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let resourcestatus = try! body.nodes(forXPath: "ResourceStatus").first.flatMapNoNulls { v in
                return ResourceStatus.deserialize(response: response, body: v)
            }
            
            let resourcestatusreason = try! body.nodes(forXPath: "ResourceStatusReason").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let resourcetype = try! body.nodes(forXPath: "ResourceType").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let stackid = try! body.nodes(forXPath: "StackId").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let stackname = try! body.nodes(forXPath: "StackName").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let timestamp = try! body.nodes(forXPath: "Timestamp").first.flatMapNoNulls { v in
                return Date.deserialize(response: response, body: v)
            }
            

            return StackEvent(
                
                eventid: eventid!,
                
                logicalresourceid: logicalresourceid,
                
                physicalresourceid: physicalresourceid,
                
                resourceproperties: resourceproperties,
                
                resourcestatus: resourcestatus,
                
                resourcestatusreason: resourcestatusreason,
                
                resourcetype: resourcetype,
                
                stackid: stackid!,
                
                stackname: stackname!,
                
                timestamp: timestamp!
                
            )
        }
        
    }
    
    struct StackResource: QuerySerializable, AwswiftDeserializable {
        public let description: String?
        public let logicalresourceid: String
        public let physicalresourceid: String?
        public let resourcestatus: ResourceStatus
        public let resourcestatusreason: String?
        public let resourcetype: String
        public let stackid: String?
        public let stackname: String?
        public let timestamp: Date
        

        init(
            description: String?,
            logicalresourceid: String,
            physicalresourceid: String?,
            resourcestatus: ResourceStatus,
            resourcestatusreason: String?,
            resourcetype: String,
            stackid: String?,
            stackname: String?,
            timestamp: Date
            
        ) {
            self.description = description
            self.logicalresourceid = logicalresourceid
            self.physicalresourceid = physicalresourceid
            self.resourcestatus = resourcestatus
            self.resourcestatusreason = resourcestatusreason
            self.resourcetype = resourcetype
            self.stackid = stackid
            self.stackname = stackname
            self.timestamp = timestamp
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "Description": description?.querySerialize(),
            
                "LogicalResourceId": logicalresourceid.querySerialize(),
            
                "PhysicalResourceId": physicalresourceid?.querySerialize(),
            
                "ResourceStatus": resourcestatus.querySerialize(),
            
                "ResourceStatusReason": resourcestatusreason?.querySerialize(),
            
                "ResourceType": resourcetype.querySerialize(),
            
                "StackId": stackid?.querySerialize(),
            
                "StackName": stackname?.querySerialize(),
            
                "Timestamp": timestamp.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> StackResource {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let description = try! body.nodes(forXPath: "Description").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let logicalresourceid = try! body.nodes(forXPath: "LogicalResourceId").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let physicalresourceid = try! body.nodes(forXPath: "PhysicalResourceId").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let resourcestatus = try! body.nodes(forXPath: "ResourceStatus").first.flatMapNoNulls { v in
                return ResourceStatus.deserialize(response: response, body: v)
            }
            
            let resourcestatusreason = try! body.nodes(forXPath: "ResourceStatusReason").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let resourcetype = try! body.nodes(forXPath: "ResourceType").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let stackid = try! body.nodes(forXPath: "StackId").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let stackname = try! body.nodes(forXPath: "StackName").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let timestamp = try! body.nodes(forXPath: "Timestamp").first.flatMapNoNulls { v in
                return Date.deserialize(response: response, body: v)
            }
            

            return StackResource(
                
                description: description,
                
                logicalresourceid: logicalresourceid!,
                
                physicalresourceid: physicalresourceid,
                
                resourcestatus: resourcestatus!,
                
                resourcestatusreason: resourcestatusreason,
                
                resourcetype: resourcetype!,
                
                stackid: stackid,
                
                stackname: stackname,
                
                timestamp: timestamp!
                
            )
        }
        
    }
    
    struct StackResourceDetail: QuerySerializable, AwswiftDeserializable {
        public let description: String?
        public let lastupdatedtimestamp: Date
        public let logicalresourceid: String
        public let metadata: String?
        public let physicalresourceid: String?
        public let resourcestatus: ResourceStatus
        public let resourcestatusreason: String?
        public let resourcetype: String
        public let stackid: String?
        public let stackname: String?
        

        init(
            description: String?,
            lastupdatedtimestamp: Date,
            logicalresourceid: String,
            metadata: String?,
            physicalresourceid: String?,
            resourcestatus: ResourceStatus,
            resourcestatusreason: String?,
            resourcetype: String,
            stackid: String?,
            stackname: String?
            
        ) {
            self.description = description
            self.lastupdatedtimestamp = lastupdatedtimestamp
            self.logicalresourceid = logicalresourceid
            self.metadata = metadata
            self.physicalresourceid = physicalresourceid
            self.resourcestatus = resourcestatus
            self.resourcestatusreason = resourcestatusreason
            self.resourcetype = resourcetype
            self.stackid = stackid
            self.stackname = stackname
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "Description": description?.querySerialize(),
            
                "LastUpdatedTimestamp": lastupdatedtimestamp.querySerialize(),
            
                "LogicalResourceId": logicalresourceid.querySerialize(),
            
                "Metadata": metadata?.querySerialize(),
            
                "PhysicalResourceId": physicalresourceid?.querySerialize(),
            
                "ResourceStatus": resourcestatus.querySerialize(),
            
                "ResourceStatusReason": resourcestatusreason?.querySerialize(),
            
                "ResourceType": resourcetype.querySerialize(),
            
                "StackId": stackid?.querySerialize(),
            
                "StackName": stackname?.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> StackResourceDetail {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let description = try! body.nodes(forXPath: "Description").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let lastupdatedtimestamp = try! body.nodes(forXPath: "LastUpdatedTimestamp").first.flatMapNoNulls { v in
                return Date.deserialize(response: response, body: v)
            }
            
            let logicalresourceid = try! body.nodes(forXPath: "LogicalResourceId").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let metadata = try! body.nodes(forXPath: "Metadata").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let physicalresourceid = try! body.nodes(forXPath: "PhysicalResourceId").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let resourcestatus = try! body.nodes(forXPath: "ResourceStatus").first.flatMapNoNulls { v in
                return ResourceStatus.deserialize(response: response, body: v)
            }
            
            let resourcestatusreason = try! body.nodes(forXPath: "ResourceStatusReason").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let resourcetype = try! body.nodes(forXPath: "ResourceType").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let stackid = try! body.nodes(forXPath: "StackId").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let stackname = try! body.nodes(forXPath: "StackName").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return StackResourceDetail(
                
                description: description,
                
                lastupdatedtimestamp: lastupdatedtimestamp!,
                
                logicalresourceid: logicalresourceid!,
                
                metadata: metadata,
                
                physicalresourceid: physicalresourceid,
                
                resourcestatus: resourcestatus!,
                
                resourcestatusreason: resourcestatusreason,
                
                resourcetype: resourcetype!,
                
                stackid: stackid,
                
                stackname: stackname
                
            )
        }
        
    }
    
    struct StackResourceSummary: QuerySerializable, AwswiftDeserializable {
        public let lastupdatedtimestamp: Date
        public let logicalresourceid: String
        public let physicalresourceid: String?
        public let resourcestatus: ResourceStatus
        public let resourcestatusreason: String?
        public let resourcetype: String
        

        init(
            lastupdatedtimestamp: Date,
            logicalresourceid: String,
            physicalresourceid: String?,
            resourcestatus: ResourceStatus,
            resourcestatusreason: String?,
            resourcetype: String
            
        ) {
            self.lastupdatedtimestamp = lastupdatedtimestamp
            self.logicalresourceid = logicalresourceid
            self.physicalresourceid = physicalresourceid
            self.resourcestatus = resourcestatus
            self.resourcestatusreason = resourcestatusreason
            self.resourcetype = resourcetype
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "LastUpdatedTimestamp": lastupdatedtimestamp.querySerialize(),
            
                "LogicalResourceId": logicalresourceid.querySerialize(),
            
                "PhysicalResourceId": physicalresourceid?.querySerialize(),
            
                "ResourceStatus": resourcestatus.querySerialize(),
            
                "ResourceStatusReason": resourcestatusreason?.querySerialize(),
            
                "ResourceType": resourcetype.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> StackResourceSummary {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let lastupdatedtimestamp = try! body.nodes(forXPath: "LastUpdatedTimestamp").first.flatMapNoNulls { v in
                return Date.deserialize(response: response, body: v)
            }
            
            let logicalresourceid = try! body.nodes(forXPath: "LogicalResourceId").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let physicalresourceid = try! body.nodes(forXPath: "PhysicalResourceId").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let resourcestatus = try! body.nodes(forXPath: "ResourceStatus").first.flatMapNoNulls { v in
                return ResourceStatus.deserialize(response: response, body: v)
            }
            
            let resourcestatusreason = try! body.nodes(forXPath: "ResourceStatusReason").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let resourcetype = try! body.nodes(forXPath: "ResourceType").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return StackResourceSummary(
                
                lastupdatedtimestamp: lastupdatedtimestamp!,
                
                logicalresourceid: logicalresourceid!,
                
                physicalresourceid: physicalresourceid,
                
                resourcestatus: resourcestatus!,
                
                resourcestatusreason: resourcestatusreason,
                
                resourcetype: resourcetype!
                
            )
        }
        
    }
    
    struct StackSummary: QuerySerializable, AwswiftDeserializable {
        public let creationtime: Date
        public let deletiontime: Date?
        public let lastupdatedtime: Date?
        public let stackid: String?
        public let stackname: String
        public let stackstatus: StackStatus
        public let stackstatusreason: String?
        public let templatedescription: String?
        

        init(
            creationtime: Date,
            deletiontime: Date?,
            lastupdatedtime: Date?,
            stackid: String?,
            stackname: String,
            stackstatus: StackStatus,
            stackstatusreason: String?,
            templatedescription: String?
            
        ) {
            self.creationtime = creationtime
            self.deletiontime = deletiontime
            self.lastupdatedtime = lastupdatedtime
            self.stackid = stackid
            self.stackname = stackname
            self.stackstatus = stackstatus
            self.stackstatusreason = stackstatusreason
            self.templatedescription = templatedescription
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "CreationTime": creationtime.querySerialize(),
            
                "DeletionTime": deletiontime?.querySerialize(),
            
                "LastUpdatedTime": lastupdatedtime?.querySerialize(),
            
                "StackId": stackid?.querySerialize(),
            
                "StackName": stackname.querySerialize(),
            
                "StackStatus": stackstatus.querySerialize(),
            
                "StackStatusReason": stackstatusreason?.querySerialize(),
            
                "TemplateDescription": templatedescription?.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> StackSummary {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let creationtime = try! body.nodes(forXPath: "CreationTime").first.flatMapNoNulls { v in
                return Date.deserialize(response: response, body: v)
            }
            
            let deletiontime = try! body.nodes(forXPath: "DeletionTime").first.flatMapNoNulls { v in
                return Date.deserialize(response: response, body: v)
            }
            
            let lastupdatedtime = try! body.nodes(forXPath: "LastUpdatedTime").first.flatMapNoNulls { v in
                return Date.deserialize(response: response, body: v)
            }
            
            let stackid = try! body.nodes(forXPath: "StackId").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let stackname = try! body.nodes(forXPath: "StackName").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let stackstatus = try! body.nodes(forXPath: "StackStatus").first.flatMapNoNulls { v in
                return StackStatus.deserialize(response: response, body: v)
            }
            
            let stackstatusreason = try! body.nodes(forXPath: "StackStatusReason").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let templatedescription = try! body.nodes(forXPath: "TemplateDescription").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return StackSummary(
                
                creationtime: creationtime!,
                
                deletiontime: deletiontime,
                
                lastupdatedtime: lastupdatedtime,
                
                stackid: stackid,
                
                stackname: stackname!,
                
                stackstatus: stackstatus!,
                
                stackstatusreason: stackstatusreason,
                
                templatedescription: templatedescription
                
            )
        }
        
    }
    
    struct Tag: QuerySerializable, AwswiftDeserializable {
        public let key: String?
        public let value: String?
        

        init(
            key: String?,
            value: String?
            
        ) {
            self.key = key
            self.value = value
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "Key": key?.querySerialize(),
            
                "Value": value?.querySerialize()
            
            ]
            return .object(fields)
            
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
                
                key: key,
                
                value: value
                
            )
        }
        
    }
    
    struct TemplateParameter: QuerySerializable, AwswiftDeserializable {
        public let defaultvalue: String?
        public let description: String?
        public let noecho: Bool?
        public let parameterkey: String?
        

        init(
            defaultvalue: String?,
            description: String?,
            noecho: Bool?,
            parameterkey: String?
            
        ) {
            self.defaultvalue = defaultvalue
            self.description = description
            self.noecho = noecho
            self.parameterkey = parameterkey
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "DefaultValue": defaultvalue?.querySerialize(),
            
                "Description": description?.querySerialize(),
            
                "NoEcho": noecho?.querySerialize(),
            
                "ParameterKey": parameterkey?.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> TemplateParameter {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let defaultvalue = try! body.nodes(forXPath: "DefaultValue").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let description = try! body.nodes(forXPath: "Description").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let noecho = try! body.nodes(forXPath: "NoEcho").first.flatMapNoNulls { v in
                return Bool.deserialize(response: response, body: v)
            }
            
            let parameterkey = try! body.nodes(forXPath: "ParameterKey").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return TemplateParameter(
                
                defaultvalue: defaultvalue,
                
                description: description,
                
                noecho: noecho,
                
                parameterkey: parameterkey
                
            )
        }
        
    }
    
    struct UpdateStackInput: QuerySerializable, AwswiftDeserializable {
        public let capabilities: [Capability]?
        public let notificationarns: [String]?
        public let parameters: [Parameter]?
        public let resourcetypes: [String]?
        public let rolearn: String?
        public let stackname: String
        public let stackpolicybody: String?
        public let stackpolicyduringupdatebody: String?
        public let stackpolicyduringupdateurl: String?
        public let stackpolicyurl: String?
        public let tags: [Tag]?
        public let templatebody: String?
        public let templateurl: String?
        public let useprevioustemplate: Bool?
        

        init(
            capabilities: [Capability]?,
            notificationarns: [String]?,
            parameters: [Parameter]?,
            resourcetypes: [String]?,
            rolearn: String?,
            stackname: String,
            stackpolicybody: String?,
            stackpolicyduringupdatebody: String?,
            stackpolicyduringupdateurl: String?,
            stackpolicyurl: String?,
            tags: [Tag]?,
            templatebody: String?,
            templateurl: String?,
            useprevioustemplate: Bool?
            
        ) {
            self.capabilities = capabilities
            self.notificationarns = notificationarns
            self.parameters = parameters
            self.resourcetypes = resourcetypes
            self.rolearn = rolearn
            self.stackname = stackname
            self.stackpolicybody = stackpolicybody
            self.stackpolicyduringupdatebody = stackpolicyduringupdatebody
            self.stackpolicyduringupdateurl = stackpolicyduringupdateurl
            self.stackpolicyurl = stackpolicyurl
            self.tags = tags
            self.templatebody = templatebody
            self.templateurl = templateurl
            self.useprevioustemplate = useprevioustemplate
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "Capabilities": capabilities?.querySerialize(),
            
                "NotificationARNs": notificationarns?.querySerialize(),
            
                "Parameters": parameters?.querySerialize(),
            
                "ResourceTypes": resourcetypes?.querySerialize(),
            
                "RoleARN": rolearn?.querySerialize(),
            
                "StackName": stackname.querySerialize(),
            
                "StackPolicyBody": stackpolicybody?.querySerialize(),
            
                "StackPolicyDuringUpdateBody": stackpolicyduringupdatebody?.querySerialize(),
            
                "StackPolicyDuringUpdateURL": stackpolicyduringupdateurl?.querySerialize(),
            
                "StackPolicyURL": stackpolicyurl?.querySerialize(),
            
                "Tags": tags?.querySerialize(),
            
                "TemplateBody": templatebody?.querySerialize(),
            
                "TemplateURL": templateurl?.querySerialize(),
            
                "UsePreviousTemplate": useprevioustemplate?.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> UpdateStackInput {
            fatalError()
        }
        
        
    }
    
    struct UpdateStackOutput: QuerySerializable, AwswiftDeserializable {
        public let stackid: String?
        

        init(
            stackid: String?
            
        ) {
            self.stackid = stackid
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "StackId": stackid?.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> UpdateStackOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let stackid = try! body.nodes(forXPath: "StackId").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            

            return UpdateStackOutput(
                
                stackid: stackid
                
            )
        }
        
    }
    
    struct ValidateTemplateInput: QuerySerializable, AwswiftDeserializable {
        public let templatebody: String?
        public let templateurl: String?
        

        init(
            templatebody: String?,
            templateurl: String?
            
        ) {
            self.templatebody = templatebody
            self.templateurl = templateurl
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "TemplateBody": templatebody?.querySerialize(),
            
                "TemplateURL": templateurl?.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> ValidateTemplateInput {
            fatalError()
        }
        
        
    }
    
    struct ValidateTemplateOutput: QuerySerializable, AwswiftDeserializable {
        public let capabilities: [Capability]?
        public let capabilitiesreason: String?
        public let declaredtransforms: [String]?
        public let description: String?
        public let parameters: [TemplateParameter]?
        

        init(
            capabilities: [Capability]?,
            capabilitiesreason: String?,
            declaredtransforms: [String]?,
            description: String?,
            parameters: [TemplateParameter]?
            
        ) {
            self.capabilities = capabilities
            self.capabilitiesreason = capabilitiesreason
            self.declaredtransforms = declaredtransforms
            self.description = description
            self.parameters = parameters
            
        }

        func querySerialize() -> QueryFieldValue {
            
            
            let fields = [
            
                "Capabilities": capabilities?.querySerialize(),
            
                "CapabilitiesReason": capabilitiesreason?.querySerialize(),
            
                "DeclaredTransforms": declaredtransforms?.querySerialize(),
            
                "Description": description?.querySerialize(),
            
                "Parameters": parameters?.querySerialize()
            
            ]
            return .object(fields)
            
        }

        
        
        static func deserialize(response: HTTPURLResponse, body: Any?) -> ValidateTemplateOutput {
            guard let body = body as? XMLElement else { fatalError() }
            
            
            let capabilities = try! body.nodes(forXPath: "Capabilities").first.flatMapNoNulls { v in
                return [Capability].deserialize(response: response, body: v)
            }
            
            let capabilitiesreason = try! body.nodes(forXPath: "CapabilitiesReason").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let declaredtransforms = try! body.nodes(forXPath: "DeclaredTransforms").first.flatMapNoNulls { v in
                return [String].deserialize(response: response, body: v)
            }
            
            let description = try! body.nodes(forXPath: "Description").first.flatMapNoNulls { v in
                return String.deserialize(response: response, body: v)
            }
            
            let parameters = try! body.nodes(forXPath: "Parameters").first.flatMapNoNulls { v in
                return [TemplateParameter].deserialize(response: response, body: v)
            }
            

            return ValidateTemplateOutput(
                
                capabilities: capabilities,
                
                capabilitiesreason: capabilitiesreason,
                
                declaredtransforms: declaredtransforms,
                
                description: description,
                
                parameters: parameters
                
            )
        }
        
    }
    

    
    enum Capability: String, QuerySerializable, AwswiftDeserializable {
        case capabilityIam = "CAPABILITY_IAM"
        case capabilityNamedIam = "CAPABILITY_NAMED_IAM"
        

        static func deserialize(response: HTTPURLResponse, body: Any?) -> Capability {
            guard let body = body as? XMLNode else { fatalError() }

            if let e = Capability(rawValue: body.stringValue!) {
                return e
            } else {
                fatalError()
            }
        }

        func querySerialize() -> QueryFieldValue {
            return .string(rawValue)
        }
    }
    
    enum ChangeAction: String, QuerySerializable, AwswiftDeserializable {
        case add = "Add"
        case modify = "Modify"
        case remove = "Remove"
        

        static func deserialize(response: HTTPURLResponse, body: Any?) -> ChangeAction {
            guard let body = body as? XMLNode else { fatalError() }

            if let e = ChangeAction(rawValue: body.stringValue!) {
                return e
            } else {
                fatalError()
            }
        }

        func querySerialize() -> QueryFieldValue {
            return .string(rawValue)
        }
    }
    
    enum ChangeSetStatus: String, QuerySerializable, AwswiftDeserializable {
        case createPending = "CREATE_PENDING"
        case createInProgress = "CREATE_IN_PROGRESS"
        case createComplete = "CREATE_COMPLETE"
        case deleteComplete = "DELETE_COMPLETE"
        case failed = "FAILED"
        

        static func deserialize(response: HTTPURLResponse, body: Any?) -> ChangeSetStatus {
            guard let body = body as? XMLNode else { fatalError() }

            if let e = ChangeSetStatus(rawValue: body.stringValue!) {
                return e
            } else {
                fatalError()
            }
        }

        func querySerialize() -> QueryFieldValue {
            return .string(rawValue)
        }
    }
    
    enum ChangeSetType: String, QuerySerializable, AwswiftDeserializable {
        case create = "CREATE"
        case update = "UPDATE"
        

        static func deserialize(response: HTTPURLResponse, body: Any?) -> ChangeSetType {
            guard let body = body as? XMLNode else { fatalError() }

            if let e = ChangeSetType(rawValue: body.stringValue!) {
                return e
            } else {
                fatalError()
            }
        }

        func querySerialize() -> QueryFieldValue {
            return .string(rawValue)
        }
    }
    
    enum ChangeSource: String, QuerySerializable, AwswiftDeserializable {
        case resourcereference = "ResourceReference"
        case parameterreference = "ParameterReference"
        case resourceattribute = "ResourceAttribute"
        case directmodification = "DirectModification"
        case automatic = "Automatic"
        

        static func deserialize(response: HTTPURLResponse, body: Any?) -> ChangeSource {
            guard let body = body as? XMLNode else { fatalError() }

            if let e = ChangeSource(rawValue: body.stringValue!) {
                return e
            } else {
                fatalError()
            }
        }

        func querySerialize() -> QueryFieldValue {
            return .string(rawValue)
        }
    }
    
    enum ChangeType: String, QuerySerializable, AwswiftDeserializable {
        case resource = "Resource"
        

        static func deserialize(response: HTTPURLResponse, body: Any?) -> ChangeType {
            guard let body = body as? XMLNode else { fatalError() }

            if let e = ChangeType(rawValue: body.stringValue!) {
                return e
            } else {
                fatalError()
            }
        }

        func querySerialize() -> QueryFieldValue {
            return .string(rawValue)
        }
    }
    
    enum EvaluationType: String, QuerySerializable, AwswiftDeserializable {
        case cloudformationstatic = "Static"
        case cloudformationdynamic = "Dynamic"
        

        static func deserialize(response: HTTPURLResponse, body: Any?) -> EvaluationType {
            guard let body = body as? XMLNode else { fatalError() }

            if let e = EvaluationType(rawValue: body.stringValue!) {
                return e
            } else {
                fatalError()
            }
        }

        func querySerialize() -> QueryFieldValue {
            return .string(rawValue)
        }
    }
    
    enum ExecutionStatus: String, QuerySerializable, AwswiftDeserializable {
        case unavailable = "UNAVAILABLE"
        case available = "AVAILABLE"
        case executeInProgress = "EXECUTE_IN_PROGRESS"
        case executeComplete = "EXECUTE_COMPLETE"
        case executeFailed = "EXECUTE_FAILED"
        case obsolete = "OBSOLETE"
        

        static func deserialize(response: HTTPURLResponse, body: Any?) -> ExecutionStatus {
            guard let body = body as? XMLNode else { fatalError() }

            if let e = ExecutionStatus(rawValue: body.stringValue!) {
                return e
            } else {
                fatalError()
            }
        }

        func querySerialize() -> QueryFieldValue {
            return .string(rawValue)
        }
    }
    
    enum OnFailure: String, QuerySerializable, AwswiftDeserializable {
        case doNothing = "DO_NOTHING"
        case rollback = "ROLLBACK"
        case delete = "DELETE"
        

        static func deserialize(response: HTTPURLResponse, body: Any?) -> OnFailure {
            guard let body = body as? XMLNode else { fatalError() }

            if let e = OnFailure(rawValue: body.stringValue!) {
                return e
            } else {
                fatalError()
            }
        }

        func querySerialize() -> QueryFieldValue {
            return .string(rawValue)
        }
    }
    
    enum Replacement: String, QuerySerializable, AwswiftDeserializable {
        case cloudformationtrue = "True"
        case cloudformationfalse = "False"
        case conditional = "Conditional"
        

        static func deserialize(response: HTTPURLResponse, body: Any?) -> Replacement {
            guard let body = body as? XMLNode else { fatalError() }

            if let e = Replacement(rawValue: body.stringValue!) {
                return e
            } else {
                fatalError()
            }
        }

        func querySerialize() -> QueryFieldValue {
            return .string(rawValue)
        }
    }
    
    enum RequiresRecreation: String, QuerySerializable, AwswiftDeserializable {
        case never = "Never"
        case conditionally = "Conditionally"
        case always = "Always"
        

        static func deserialize(response: HTTPURLResponse, body: Any?) -> RequiresRecreation {
            guard let body = body as? XMLNode else { fatalError() }

            if let e = RequiresRecreation(rawValue: body.stringValue!) {
                return e
            } else {
                fatalError()
            }
        }

        func querySerialize() -> QueryFieldValue {
            return .string(rawValue)
        }
    }
    
    enum ResourceAttribute: String, QuerySerializable, AwswiftDeserializable {
        case properties = "Properties"
        case metadata = "Metadata"
        case creationpolicy = "CreationPolicy"
        case updatepolicy = "UpdatePolicy"
        case deletionpolicy = "DeletionPolicy"
        case tags = "Tags"
        

        static func deserialize(response: HTTPURLResponse, body: Any?) -> ResourceAttribute {
            guard let body = body as? XMLNode else { fatalError() }

            if let e = ResourceAttribute(rawValue: body.stringValue!) {
                return e
            } else {
                fatalError()
            }
        }

        func querySerialize() -> QueryFieldValue {
            return .string(rawValue)
        }
    }
    
    enum ResourceSignalStatus: String, QuerySerializable, AwswiftDeserializable {
        case success = "SUCCESS"
        case failure = "FAILURE"
        

        static func deserialize(response: HTTPURLResponse, body: Any?) -> ResourceSignalStatus {
            guard let body = body as? XMLNode else { fatalError() }

            if let e = ResourceSignalStatus(rawValue: body.stringValue!) {
                return e
            } else {
                fatalError()
            }
        }

        func querySerialize() -> QueryFieldValue {
            return .string(rawValue)
        }
    }
    
    enum ResourceStatus: String, QuerySerializable, AwswiftDeserializable {
        case createInProgress = "CREATE_IN_PROGRESS"
        case createFailed = "CREATE_FAILED"
        case createComplete = "CREATE_COMPLETE"
        case deleteInProgress = "DELETE_IN_PROGRESS"
        case deleteFailed = "DELETE_FAILED"
        case deleteComplete = "DELETE_COMPLETE"
        case deleteSkipped = "DELETE_SKIPPED"
        case updateInProgress = "UPDATE_IN_PROGRESS"
        case updateFailed = "UPDATE_FAILED"
        case updateComplete = "UPDATE_COMPLETE"
        

        static func deserialize(response: HTTPURLResponse, body: Any?) -> ResourceStatus {
            guard let body = body as? XMLNode else { fatalError() }

            if let e = ResourceStatus(rawValue: body.stringValue!) {
                return e
            } else {
                fatalError()
            }
        }

        func querySerialize() -> QueryFieldValue {
            return .string(rawValue)
        }
    }
    
    enum StackStatus: String, QuerySerializable, AwswiftDeserializable {
        case createInProgress = "CREATE_IN_PROGRESS"
        case createFailed = "CREATE_FAILED"
        case createComplete = "CREATE_COMPLETE"
        case rollbackInProgress = "ROLLBACK_IN_PROGRESS"
        case rollbackFailed = "ROLLBACK_FAILED"
        case rollbackComplete = "ROLLBACK_COMPLETE"
        case deleteInProgress = "DELETE_IN_PROGRESS"
        case deleteFailed = "DELETE_FAILED"
        case deleteComplete = "DELETE_COMPLETE"
        case updateInProgress = "UPDATE_IN_PROGRESS"
        case updateCompleteCleanupInProgress = "UPDATE_COMPLETE_CLEANUP_IN_PROGRESS"
        case updateComplete = "UPDATE_COMPLETE"
        case updateRollbackInProgress = "UPDATE_ROLLBACK_IN_PROGRESS"
        case updateRollbackFailed = "UPDATE_ROLLBACK_FAILED"
        case updateRollbackCompleteCleanupInProgress = "UPDATE_ROLLBACK_COMPLETE_CLEANUP_IN_PROGRESS"
        case updateRollbackComplete = "UPDATE_ROLLBACK_COMPLETE"
        case reviewInProgress = "REVIEW_IN_PROGRESS"
        

        static func deserialize(response: HTTPURLResponse, body: Any?) -> StackStatus {
            guard let body = body as? XMLNode else { fatalError() }

            if let e = StackStatus(rawValue: body.stringValue!) {
                return e
            } else {
                fatalError()
            }
        }

        func querySerialize() -> QueryFieldValue {
            return .string(rawValue)
        }
    }
    
    enum TemplateStage: String, QuerySerializable, AwswiftDeserializable {
        case original = "Original"
        case processed = "Processed"
        

        static func deserialize(response: HTTPURLResponse, body: Any?) -> TemplateStage {
            guard let body = body as? XMLNode else { fatalError() }

            if let e = TemplateStage(rawValue: body.stringValue!) {
                return e
            } else {
                fatalError()
            }
        }

        func querySerialize() -> QueryFieldValue {
            return .string(rawValue)
        }
    }
    
}
