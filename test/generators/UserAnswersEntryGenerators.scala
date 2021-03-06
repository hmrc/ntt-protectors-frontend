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

import models._
import org.scalacheck.Arbitrary
import org.scalacheck.Arbitrary.arbitrary
import pages._
import play.api.libs.json.{JsValue, Json}

trait UserAnswersEntryGenerators extends PageGenerators with ModelGenerators {

  implicit lazy val arbitraryDoYouWantToAddAnotherProtectorUserAnswersEntry: Arbitrary[(DoYouWantToAddAnotherProtectorPage.type, JsValue)] =
    Arbitrary {
      for {
        page  <- arbitrary[DoYouWantToAddAnotherProtectorPage.type]
        value <- arbitrary[DoYouWantToAddAnotherProtector].map(Json.toJson(_))
      } yield (page, value)
    }

  implicit lazy val arbitraryWhatIsTheCountryCompanyHeadOfficeIsBasedUserAnswersEntry: Arbitrary[(WhatCountryIsTheHeadOfficeBasedInPage.type, JsValue)] =
    Arbitrary {
      for {
        page  <- arbitrary[WhatCountryIsTheHeadOfficeBasedInPage.type]
        value <- arbitrary[String].suchThat(_.nonEmpty).map(Json.toJson(_))
      } yield (page, value)
    }

  implicit lazy val arbitraryDoYouKnowTheCountryHeadOfficeIsInUserAnswersEntry: Arbitrary[(DoYouKnowTheCountryHeadOfficeIsInPage.type, JsValue)] =
    Arbitrary {
      for {
        page  <- arbitrary[DoYouKnowTheCountryHeadOfficeIsInPage.type]
        value <- arbitrary[Boolean].map(Json.toJson(_))
      } yield (page, value)
    }

  implicit lazy val arbitraryWhatIsTheNameOfTheCompanyUserAnswersEntry: Arbitrary[(WhatIsTheNameOfTheCompanyPage.type, JsValue)] =
    Arbitrary {
      for {
        page  <- arbitrary[WhatIsTheNameOfTheCompanyPage.type]
        value <- arbitrary[String].suchThat(_.nonEmpty).map(Json.toJson(_))
      } yield (page, value)
    }

  implicit lazy val arbitraryWhatIsTheirCountryOfResidencyUserAnswersEntry: Arbitrary[(WhatIsTheirCountryOfResidencyPage.type, JsValue)] =
    Arbitrary {
      for {
        page  <- arbitrary[WhatIsTheirCountryOfResidencyPage.type]
        value <- arbitrary[String].suchThat(_.nonEmpty).map(Json.toJson(_))
      } yield (page, value)
    }

  implicit lazy val arbitraryDoYouKnowTheirCountryOfResidencyUserAnswersEntry: Arbitrary[(DoYouKnowTheirCountryOfResidencyPage.type, JsValue)] =
    Arbitrary {
      for {
        page  <- arbitrary[DoYouKnowTheirCountryOfResidencyPage.type]
        value <- arbitrary[Boolean].map(Json.toJson(_))
      } yield (page, value)
    }

  implicit lazy val arbitraryProtectorCountrySameAsResidenceUserAnswersEntry: Arbitrary[(IsTheProtectorsCountrySameAsResidencePage.type, JsValue)] =
    Arbitrary {
      for {
        page  <- arbitrary[IsTheProtectorsCountrySameAsResidencePage.type]
        value <- arbitrary[Boolean].map(Json.toJson(_))
      } yield (page, value)
    }

  implicit lazy val arbitraryProtectorNationalityUserAnswersEntry: Arbitrary[(WhatIsProtectorNationalityPage.type, JsValue)] =
    Arbitrary {
      for {
        page  <- arbitrary[WhatIsProtectorNationalityPage.type]
        value <- arbitrary[String].suchThat(_.nonEmpty).map(Json.toJson(_))
      } yield (page, value)
    }

  implicit lazy val arbitraryProtectorDateOfBirthUserAnswersEntry: Arbitrary[(WhatIsProtectorDateOfBirthPage.type, JsValue)] =
    Arbitrary {
      for {
        page  <- arbitrary[WhatIsProtectorDateOfBirthPage.type]
        value <- arbitrary[Int].map(Json.toJson(_))
      } yield (page, value)
    }

  implicit lazy val arbitraryDoYouKnowTheirNationalityUserAnswersEntry: Arbitrary[(DoYouKnowTheirNationalityPage.type, JsValue)] =
    Arbitrary {
      for {
        page  <- arbitrary[DoYouKnowTheirNationalityPage.type]
        value <- arbitrary[Boolean].map(Json.toJson(_))
      } yield (page, value)
    }

  implicit lazy val arbitraryDoYouKnowProtectorDateOfBirthUserAnswersEntry: Arbitrary[(DoYouKnowProtectorDateOfBirthPage.type, JsValue)] =
    Arbitrary {
      for {
        page  <- arbitrary[DoYouKnowProtectorDateOfBirthPage.type]
        value <- arbitrary[Boolean].map(Json.toJson(_))
      } yield (page, value)
    }

  implicit lazy val arbitraryProtectorsNameUserAnswersEntry: Arbitrary[(WhatIsTheProtectorsNamePage.type, JsValue)] =
    Arbitrary {
      for {
        page  <- arbitrary[WhatIsTheProtectorsNamePage.type]
        value <- arbitrary[ProtectorsName].map(Json.toJson(_))
      } yield (page, value)
    }

  implicit lazy val arbitraryProtectorTypeUserAnswersEntry: Arbitrary[(ProtectorTypePage.type, JsValue)] =
    Arbitrary {
      for {
        page  <- arbitrary[ProtectorTypePage.type]
        value <- arbitrary[ProtectorType].map(Json.toJson(_))
      } yield (page, value)
    }
}
