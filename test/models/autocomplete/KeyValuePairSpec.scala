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

package models.autocomplete

import org.scalatestplus.play.PlaySpec
import play.api.libs.json.Json

class NameValuePairSpec extends PlaySpec {

  val exampleJson =
    """
      | [
      |    [
      |      "Country 1",
      |      "country:1"
      |    ],
      |    [
      |      "Country 2",
      |      "country:2"
      |    ]
      | ]
    """.stripMargin

  val exampleModel = Seq(
    NameValuePair("Country 1", "country:1"),
    NameValuePair("Country 2", "country:2"))

  "The location list" must {
    "deserialise correctly into the model" in {
      Json.parse(exampleJson).as[Seq[NameValuePair]] mustBe exampleModel
    }

    "serialise into the correct Json" in {
      Json.toJson(exampleModel) mustBe Json.parse(exampleJson)
    }
  }

}