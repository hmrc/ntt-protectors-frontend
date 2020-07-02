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

package forms

import javax.inject.Inject

import forms.mappings.Mappings
import play.api.data.Form
import play.api.data.Forms._
import models.ProtectorsName

class ProtectorsNameFormProvider @Inject() extends Mappings {

   def apply(): Form[ProtectorsName] = Form(
     mapping(
      "FirstName" -> text("protectorsName.error.firstName.required")
        .verifying(maxLength(100, "protectorsName.error.firstName.length")),
      "MiddleName" -> optional(text("protectorsName.error.middleName.required")
        .verifying(maxLength(100, "protectorsName.error.middleName.length"))),
       "LastName" -> text("protectorsName.error.lastName.required")
         .verifying(maxLength(100, "protectorsName.error.lastName.length"))
    )(ProtectorsName.apply)(ProtectorsName.unapply)
   )
 }
