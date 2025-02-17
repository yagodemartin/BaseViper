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
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.
*/

import Foundation
import MCVIPER

protocol HomeInteractorInputProtocol: BaseInteractorInputProtocol {
    var assemblyDTO: HomeAssemblyDTO? { get }
    
    func getUserData()
}

final class HomeInteractor: BaseInteractor {
    
    // MARK: VIPER Dependencies
    weak var presenter: HomeInteractorOutputProtocol? { super.basePresenter as? HomeInteractorOutputProtocol }
    var provider: HomeProviderProtocol?
    var assemblyDTO: HomeAssemblyDTO?
}

extension HomeInteractor: HomeInteractorInputProtocol {
    
    func getUserData() {
        
        self.provider?.getUserInformation(completion: { result in
            switch result {
            case .success(let serverModel):
                guard let businessModel = BaseInteractor.parseToBusinessModel(parserModel: HomeBusinessModel.self,
                                                                              serverModel: serverModel?.first) else {
                    return
                }
                self.presenter?.userInformationRecovered(businessModel)
                
            case .failure(let error):
                print(error)
            }
        })
    }
}
