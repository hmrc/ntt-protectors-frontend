/*
 * Copyright 2020 HM Revenue & Customs
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package navigation

import controllers.routes
import models.{NormalMode, UserAnswers}
import pages.{DoYouKnowProtectorDateOfBirthPage, DoYouKnowTheCountryHeadOfficeIsInPage, DoYouKnowTheirCountryOfResidencyPage, DoYouKnowTheirNationalityPage, DoYouWantToAddAnotherProtectorPage, IsTheProtectorsCountrySameAsResidencePage, Page, ProtectorTypePage, WhatIsProtectorDateOfBirthPage, WhatIsProtectorNationalityPage, WhatIsTheCountryCompanyHeadOfficeIsBasedPage, WhatIsTheNameOfTheCompanyPage, WhatIsTheProtectorsNamePage, WhatIsTheirCountryOfResidencyPage}
import play.api.mvc.Call

object NormalModeRoutes {
  val normalRoutes: Page => UserAnswers => Call = {
    case ProtectorTypePage                            => _ => routes.WhatIsTheProtectorsNameController.onPageLoad(NormalMode)
    case WhatIsTheProtectorsNamePage                  => _ => routes.DoYouKnowProtectorDateOfBirthController.onPageLoad(NormalMode)
    case DoYouKnowProtectorDateOfBirthPage            => _ => routes.WhatIsProtectorDateOfBirthController.onPageLoad(NormalMode)
    case WhatIsProtectorDateOfBirthPage               => _ => routes.DoYouKnowTheirNationalityController.onPageLoad(NormalMode)
    case DoYouKnowTheirNationalityPage                => _ => routes.WhatIsProtectorsNationalityController.onPageLoad(NormalMode)
    case WhatIsProtectorNationalityPage               => _ => routes.IsTheProtectorsCountrySameAsResidenceController.onPageLoad(NormalMode)
    case IsTheProtectorsCountrySameAsResidencePage    => _ => routes.DoYouKnowTheirCountryOfResidencyController.onPageLoad(NormalMode)
    case DoYouKnowTheirCountryOfResidencyPage         => _ => routes.WhatIsTheirCountryOfResidencyController.onPageLoad(NormalMode)
    case WhatIsTheirCountryOfResidencyPage            => _ => routes.WhatIsTheNameOfTheCompanyController.onPageLoad(NormalMode)
    case WhatIsTheNameOfTheCompanyPage                => _ => routes.DoYouKnowTheCountryHeadOfficeIsInController.onPageLoad(NormalMode)
    case DoYouKnowTheCountryHeadOfficeIsInPage        => _ => routes.WhatIsTheCountryCompanyHeadOfficeIsBasedController.onPageLoad((NormalMode))
    case WhatIsTheCountryCompanyHeadOfficeIsBasedPage => _ => routes.DoYouWantToAddAnotherProtectorController.onPageLoad(NormalMode)
    case DoYouWantToAddAnotherProtectorPage           => _ => routes.CheckYourAnswersController.onPageLoad()
    case _                                            => _ => routes.IndexController.onPageLoad()
  }
}
