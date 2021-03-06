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
import org.scalacheck.Arbitrary.arbitrary
import org.scalacheck.{Arbitrary, Gen}

trait ModelGenerators {

  implicit lazy val arbitraryDoYouWantToAddAnotherProtector: Arbitrary[DoYouWantToAddAnotherProtector] =
    Arbitrary {
      Gen.oneOf(DoYouWantToAddAnotherProtector.values.toSeq)
    }

  implicit lazy val arbitraryProtectorsName: Arbitrary[ProtectorsName] =
    Arbitrary {
      for {
        FirstName <- arbitrary[String]
        MiddleName <- arbitrary[Option[String]]
        LastName <- arbitrary[String]
      } yield ProtectorsName(FirstName, MiddleName, LastName)
    }

  implicit lazy val arbitraryProtectorType: Arbitrary[ProtectorType] =
    Arbitrary {
      Gen.oneOf(ProtectorType.values.toSeq)
    }
}
