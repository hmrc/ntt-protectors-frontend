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

package utils

import java.time.format.DateTimeFormatter

import controllers.routes
import models.{CheckMode, UserAnswers}
import pages._
import play.api.i18n.Messages
import CheckYourAnswersHelper._
import services.CountryService
import uk.gov.hmrc.viewmodels._
import uk.gov.hmrc.viewmodels.SummaryList._
import uk.gov.hmrc.viewmodels.Text.Literal

class CheckYourAnswersHelper(userAnswers: UserAnswers, countryService: CountryService)(implicit messages: Messages) {

  def doYouWantToAddAnotherProtector: Option[Row] = userAnswers.get(DoYouWantToAddAnotherProtectorPage) map {
    answer =>
      Row(
        key     = Key(msg"doYouWantToAddAnotherProtector.checkYourAnswersLabel", classes = Seq("govuk-!-width-one-half")),
        value   = Value(msg"doYouWantToAddAnotherProtector.$answer"),
        actions = List(
          Action(
            content            = msg"site.edit",
            href               = routes.DoYouWantToAddAnotherProtectorController.onPageLoad(CheckMode).url,
            visuallyHiddenText = Some(msg"site.edit.hidden".withArgs(msg"doYouWantToAddAnotherProtector.checkYourAnswersLabel"))
          )
        )
      )
  }

  def whatCountryIsTheHeadOfficeBasedIn: Option[Row] = userAnswers.get(WhatCountryIsTheHeadOfficeBasedInPage) map {
    answer =>
      Row(
        key     = Key(msg"whatCountryIsTheHeadOfficeBasedIn.checkYourAnswersLabel", classes = Seq("govuk-!-width-one-half")),
        value   = Value(country(answer)),
        actions = List(
          Action(
            content            = msg"site.edit",
            href               = routes.WhatCountryIsTheHeadOfficeBasedInController.onPageLoad(CheckMode).url,
            visuallyHiddenText = Some(msg"site.edit.hidden".withArgs(msg"whatCountryIsTheHeadOfficeBasedIn.checkYourAnswersLabel"))
          )
        )
      )
  }

  def doYouKnowTheCountryHeadOfficeIsIn: Option[Row] = userAnswers.get(DoYouKnowTheCountryHeadOfficeIsInPage) map {
    answer =>
      Row(
        key     = Key(msg"doYouKnowTheCountryHeadOfficeIsIn.checkYourAnswersLabel", classes = Seq("govuk-!-width-one-half")),
        value   = Value(yesOrNo(answer)),
        actions = List(
          Action(
            content            = msg"site.edit",
            href               = routes.DoYouKnowTheCountryHeadOfficeIsInController.onPageLoad(CheckMode).url,
            visuallyHiddenText = Some(msg"site.edit.hidden".withArgs(msg"doYouKnowTheCountryHeadOfficeIsIn.checkYourAnswersLabel"))
          )
        )
      )
  }

  def whatIsTheNameOfTheCompany: Option[Row] = userAnswers.get(WhatIsTheNameOfTheCompanyPage) map {
    answer =>
      Row(
        key     = Key(msg"whatIsTheNameOfTheCompany.checkYourAnswersLabel", classes = Seq("govuk-!-width-one-half")),
        value   = Value(lit"$answer"),
        actions = List(
          Action(
            content            = msg"site.edit",
            href               = routes.WhatIsTheNameOfTheCompanyController.onPageLoad(CheckMode).url,
            visuallyHiddenText = Some(msg"site.edit.hidden".withArgs(msg"whatIsTheNameOfTheCompany.checkYourAnswersLabel"))
          )
        )
      )
  }

  def whatIsTheirCountryOfResidency: Option[Row] = userAnswers.get(WhatIsTheirCountryOfResidencyPage) map {
    answer =>
      Row(
        key     = Key(msg"whatIsTheirCountryOfResidency.checkYourAnswersLabel", classes = Seq("govuk-!-width-one-half")),
        value   = Value(country(answer)),
        actions = List(
          Action(
            content            = msg"site.edit",
            href               = routes.WhatIsTheirCountryOfResidencyController.onPageLoad(CheckMode).url,
            visuallyHiddenText = Some(msg"site.edit.hidden".withArgs(msg"whatIsTheirCountryOfResidency.checkYourAnswersLabel"))
          )
        )
      )
  }

  def doYouKnowTheirCountryOfResidency: Option[Row] = userAnswers.get(DoYouKnowTheirCountryOfResidencyPage) map {
    answer =>
      Row(
        key     = Key(msg"doYouKnowTheirCountryOfResidency.checkYourAnswersLabel", classes = Seq("govuk-!-width-one-half")),
        value   = Value(yesOrNo(answer)),
        actions = List(
          Action(
            content            = msg"site.edit",
            href               = routes.DoYouKnowTheirCountryOfResidencyController.onPageLoad(CheckMode).url,
            visuallyHiddenText = Some(msg"site.edit.hidden".withArgs(msg"doYouKnowTheirCountryOfResidency.checkYourAnswersLabel"))
          )
        )
      )
  }

  def protectorCountrySameAsResidence: Option[Row] = userAnswers.get(IsTheProtectorsCountrySameAsResidencePage) map {
    answer =>
      Row(
        key     = Key(msg"protectorCountrySameAsResidence.checkYourAnswersLabel", classes = Seq("govuk-!-width-one-half")),
        value   = Value(yesOrNo(answer)),
        actions = List(
          Action(
            content            = msg"site.edit",
            href               = routes.IsTheProtectorsCountrySameAsResidenceController.onPageLoad(CheckMode).url,
            visuallyHiddenText = Some(msg"site.edit.hidden".withArgs(msg"protectorCountrySameAsResidence.checkYourAnswersLabel"))
          )
        )
      )
  }

  def protectorNationality: Option[Row] = userAnswers.get(WhatIsProtectorNationalityPage) map {
    answer =>
      Row(
        key     = Key(msg"protectorNationality.checkYourAnswersLabel", classes = Seq("govuk-!-width-one-half")),
        value   = Value(country(answer)),
        actions = List(
          Action(
            content            = msg"site.edit",
            href               = routes.WhatIsProtectorsNationalityController.onPageLoad(CheckMode).url,
            visuallyHiddenText = Some(msg"site.edit.hidden".withArgs(msg"protectorNationality.checkYourAnswersLabel"))
          )
        )
      )
  }

  def protectorDateOfBirth: Option[Row] = userAnswers.get(WhatIsProtectorDateOfBirthPage) map {
    answer =>
      Row(
        key     = Key(msg"protectorDateOfBirth.checkYourAnswersLabel", classes = Seq("govuk-!-width-one-half")),
        value   = Value(Literal(answer.format(dateFormatter))),
        actions = List(
          Action(
            content            = msg"site.edit",
            href               = routes.WhatIsProtectorDateOfBirthController.onPageLoad(CheckMode).url,
            visuallyHiddenText = Some(msg"site.edit.hidden".withArgs(msg"protectorDateOfBirth.checkYourAnswersLabel"))
          )
        )
      )
  }

  def doYouKnowTheirNationality: Option[Row] = userAnswers.get(DoYouKnowTheirNationalityPage) map {
    answer =>
      Row(
        key     = Key(msg"doYouKnowTheirNationality.checkYourAnswersLabel", classes = Seq("govuk-!-width-one-half")),
        value   = Value(yesOrNo(answer)),
        actions = List(
          Action(
            content            = msg"site.edit",
            href               = routes.DoYouKnowTheirNationalityController.onPageLoad(CheckMode).url,
            visuallyHiddenText = Some(msg"site.edit.hidden".withArgs(msg"doYouKnowTheirNationality.checkYourAnswersLabel"))
          )
        )
      )
  }

  def doYouKnowProtectorDateOfBirth: Option[Row] = userAnswers.get(DoYouKnowProtectorDateOfBirthPage) map {
    answer =>
      Row(
        key     = Key(msg"doYouKnowProtectorDateOfBirth.checkYourAnswersLabel", classes = Seq("govuk-!-width-one-half")),
        value   = Value(yesOrNo(answer)),
        actions = List(
          Action(
            content            = msg"site.edit",
            href               = routes.DoYouKnowProtectorDateOfBirthController.onPageLoad(CheckMode).url,
            visuallyHiddenText = Some(msg"site.edit.hidden".withArgs(msg"doYouKnowProtectorDateOfBirth.checkYourAnswersLabel"))
          )
        )
      )
  }

  def protectorsName: Option[Row] = userAnswers.get(WhatIsTheProtectorsNamePage) map {
    answer =>
      Row(
        key     = Key(msg"protectorsName.checkYourAnswersLabel", classes = Seq("govuk-!-width-one-half")),
        value   = Value(lit"${answer.FirstName} ${answer.MiddleName}"),
        actions = List(
          Action(
            content            = msg"site.edit",
            href               = routes.WhatIsTheProtectorsNameController.onPageLoad(CheckMode).url,
            visuallyHiddenText = Some(msg"site.edit.hidden".withArgs(msg"protectorsName.checkYourAnswersLabel"))
          )
        )
      )
  }

  def protectorType: Option[Row] = userAnswers.get(ProtectorTypePage) map {
    answer =>
      Row(
        key     = Key(msg"protectorType.checkYourAnswersLabel", classes = Seq("govuk-!-width-one-half")),
        value   = Value(msg"protectorType.$answer"),
        actions = List(
          Action(
            content            = msg"site.edit",
            href               = routes.ProtectorTypeController.onPageLoad(CheckMode).url,
            visuallyHiddenText = Some(msg"site.edit.hidden".withArgs(msg"protectorType.checkYourAnswersLabel"))
          )
        )
      )
  }

  private def country(code: String): Content =
    lit"${countryService.getCountryByCode(code).getOrElse("")}"

  private def yesOrNo(answer: Boolean): Content =
    if (answer) {
      msg"site.yes"
    } else {
      msg"site.no"
    }
}

object CheckYourAnswersHelper {

  private val dateFormatter = DateTimeFormatter.ofPattern("d MMMM yyyy")
}
