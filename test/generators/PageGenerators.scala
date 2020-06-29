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

package generators

import org.scalacheck.Arbitrary
import pages._

trait PageGenerators {

  implicit lazy val arbitraryWhatIsTheNameOfTheCompanyPage: Arbitrary[WhatIsTheNameOfTheCompanyPage.type] =
    Arbitrary(WhatIsTheNameOfTheCompanyPage)

  implicit lazy val arbitraryWhatIsTheirCountryOfResidencyPage: Arbitrary[WhatIsTheirCountryOfResidencyPage.type] =
    Arbitrary(WhatIsTheirCountryOfResidencyPage)

  implicit lazy val arbitraryDoYouKnowTheirCountryOfResidencyPage: Arbitrary[DoYouKnowTheirCountryOfResidencyPage.type] =
    Arbitrary(DoYouKnowTheirCountryOfResidencyPage)

  implicit lazy val arbitraryProtectorCountrySameAsResidencePage: Arbitrary[IsTheProtectorsCountrySameAsResidencePage.type] =
    Arbitrary(IsTheProtectorsCountrySameAsResidencePage)

  implicit lazy val arbitraryProtectorNationalityPage: Arbitrary[WhatIsProtectorNationalityPage.type] =
    Arbitrary(WhatIsProtectorNationalityPage)

  implicit lazy val arbitraryProtectorDateOfBirthPage: Arbitrary[WhatIsProtectorDateOfBirthPage.type] =
    Arbitrary(WhatIsProtectorDateOfBirthPage)

  implicit lazy val arbitraryDoYouKnowTheirNationalityPage: Arbitrary[DoYouKnowTheirNationalityPage.type] =
    Arbitrary(DoYouKnowTheirNationalityPage)

  implicit lazy val arbitraryDoYouKnowProtectorDateOfBirthPage: Arbitrary[DoYouKnowProtectorDateOfBirthPage.type] =
    Arbitrary(DoYouKnowProtectorDateOfBirthPage)

  implicit lazy val arbitraryProtectorsNamePage: Arbitrary[WhatIsTheProtectorsNamePage.type] =
    Arbitrary(WhatIsTheProtectorsNamePage)

  implicit lazy val arbitraryProtectorTypePage: Arbitrary[ProtectorTypePage.type] =
    Arbitrary(ProtectorTypePage)
}
