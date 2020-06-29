#!/bin/bash

echo ""
echo "Applying migration WhatIsTheCountryCompanyHeadOfficeIsBased"

echo "Adding routes to conf/app.routes"

echo "" >> ../conf/app.routes
echo "GET        /whatIsTheCountryCompanyHeadOfficeIsBased                        controllers.WhatIsTheCountryCompanyHeadOfficeIsBasedController.onPageLoad(mode: Mode = NormalMode)" >> ../conf/app.routes
echo "POST       /whatIsTheCountryCompanyHeadOfficeIsBased                        controllers.WhatIsTheCountryCompanyHeadOfficeIsBasedController.onSubmit(mode: Mode = NormalMode)" >> ../conf/app.routes

echo "GET        /changeWhatIsTheCountryCompanyHeadOfficeIsBased                  controllers.WhatIsTheCountryCompanyHeadOfficeIsBasedController.onPageLoad(mode: Mode = CheckMode)" >> ../conf/app.routes
echo "POST       /changeWhatIsTheCountryCompanyHeadOfficeIsBased                  controllers.WhatIsTheCountryCompanyHeadOfficeIsBasedController.onSubmit(mode: Mode = CheckMode)" >> ../conf/app.routes

echo "Adding messages to conf.messages"
echo "" >> ../conf/messages.en
echo "whatIsTheCountryCompanyHeadOfficeIsBased.title = whatIsTheCountryCompanyHeadOfficeIsBased" >> ../conf/messages.en
echo "whatIsTheCountryCompanyHeadOfficeIsBased.heading = whatIsTheCountryCompanyHeadOfficeIsBased" >> ../conf/messages.en
echo "whatIsTheCountryCompanyHeadOfficeIsBased.checkYourAnswersLabel = whatIsTheCountryCompanyHeadOfficeIsBased" >> ../conf/messages.en
echo "whatIsTheCountryCompanyHeadOfficeIsBased.error.required = Enter whatIsTheCountryCompanyHeadOfficeIsBased" >> ../conf/messages.en
echo "whatIsTheCountryCompanyHeadOfficeIsBased.error.length = WhatIsTheCountryCompanyHeadOfficeIsBased must be 100 characters or less" >> ../conf/messages.en

echo "Adding to UserAnswersEntryGenerators"
awk '/trait UserAnswersEntryGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryWhatIsTheCountryCompanyHeadOfficeIsBasedUserAnswersEntry: Arbitrary[(WhatIsTheCountryCompanyHeadOfficeIsBasedPage.type, JsValue)] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        page  <- arbitrary[WhatIsTheCountryCompanyHeadOfficeIsBasedPage.type]";\
    print "        value <- arbitrary[String].suchThat(_.nonEmpty).map(Json.toJson(_))";\
    print "      } yield (page, value)";\
    print "    }";\
    next }1' ../test/generators/UserAnswersEntryGenerators.scala > tmp && mv tmp ../test/generators/UserAnswersEntryGenerators.scala

echo "Adding to PageGenerators"
awk '/trait PageGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryWhatIsTheCountryCompanyHeadOfficeIsBasedPage: Arbitrary[WhatIsTheCountryCompanyHeadOfficeIsBasedPage.type] =";\
    print "    Arbitrary(WhatIsTheCountryCompanyHeadOfficeIsBasedPage)";\
    next }1' ../test/generators/PageGenerators.scala > tmp && mv tmp ../test/generators/PageGenerators.scala

echo "Adding to UserAnswersGenerator"
awk '/val generators/ {\
    print;\
    print "    arbitrary[(WhatIsTheCountryCompanyHeadOfficeIsBasedPage.type, JsValue)] ::";\
    next }1' ../test/generators/UserAnswersGenerator.scala > tmp && mv tmp ../test/generators/UserAnswersGenerator.scala

echo "Adding helper method to CheckYourAnswersHelper"
awk '/class CheckYourAnswersHelper/ {\
     print;\
     print "";\
     print "  def whatIsTheCountryCompanyHeadOfficeIsBased: Option[Row] = userAnswers.get(WhatIsTheCountryCompanyHeadOfficeIsBasedPage) map {";\
     print "    answer =>";\
     print "      Row(";\
     print "        key     = Key(msg\"whatIsTheCountryCompanyHeadOfficeIsBased.checkYourAnswersLabel\", classes = Seq(\"govuk-!-width-one-half\")),";\
     print "        value   = Value(lit\"$answer\"),";\
     print "        actions = List(";\
     print "          Action(";\
     print "            content            = msg\"site.edit\",";\
     print "            href               = routes.WhatIsTheCountryCompanyHeadOfficeIsBasedController.onPageLoad(CheckMode).url,";\
     print "            visuallyHiddenText = Some(msg\"site.edit.hidden\".withArgs(msg\"whatIsTheCountryCompanyHeadOfficeIsBased.checkYourAnswersLabel\"))";\
     print "          )";\
     print "        )";\
     print "      )";\
     print "  }";\
     next }1' ../app/utils/CheckYourAnswersHelper.scala > tmp && mv tmp ../app/utils/CheckYourAnswersHelper.scala

echo "Migration WhatIsTheCountryCompanyHeadOfficeIsBased completed"
