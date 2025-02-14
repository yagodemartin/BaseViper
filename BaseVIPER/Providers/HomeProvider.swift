/*
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THEs
POSSIBILITY OF SUCH DAMAGE.
*/

import Foundation
import MCVIPER

struct UserInformationRequest {
    
    static func getRequest(params: BaseProviderParamsDTO? = nil, headers: [String: String]?) -> BaseProviderDTO {
        
        BaseProviderDTO(params: params?.encode(), method: .get, domain: "", endpoint: "/users", baseUrl: "https://jsonplaceholder.typicode.com", acceptType: .json)
    }
}
protocol HomeProviderProtocol {
    func getUserInformation(completion: @escaping (Result<[HomeServerModel]?, BaseErrorModel>) -> Void)
}

final class HomeProvider: BaseProvider, HomeProviderProtocol {
    
    func getUserInformation(completion: @escaping (Result<[HomeServerModel]?, BaseErrorModel>) -> Void) {
        _ = self.request(requestDto: UserInformationRequest.getRequest(params: nil, headers: nil), completion: { result in
            switch result {
            case .success(let data):
                let serverModel = BaseProviderUtils.parseArrayToServerModel(parserModel: [HomeServerModel].self, data: data)
                completion(.success(serverModel))
                
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
