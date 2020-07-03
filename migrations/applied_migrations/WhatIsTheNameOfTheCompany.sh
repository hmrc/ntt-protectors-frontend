#!/bin/bash

echo ""
echo "Applying migration WhatIsTheNameOfTheCompany"

echo "Adding routes to conf/app.routes"

echo "" >> ../conf/app.routes
echo "GET        /whatIsTheNameOfTheCompany                        controllers.WhatIsTheNameOfTheCompanyController.onPageLoad(mode: Mode = NormalMode)" >> ../conf/app.routes
echo "POST       /whatIsTheNameOfTheCompany                        controllers.WhatIsTheNameOfTheCompanyController.onSubmit(mode: Mode = NormalMode)" >> ../conf/app.routes

echo "GET        /changeWhatIsTheNameOfTheCompany                  controllers.WhatIsTheNameOfTheCompanyController.onPageLoad(mode: Mode = CheckMode)" >> ../conf/app.routes
echo "POST       /changeWhatIsTheNameOfTheCompany                  controllers.WhatIsTheNameOfTheCompanyController.onSubmit(mode: Mode = CheckMode)" >> ../conf/app.routes

echo "Adding messages to conf.messages"
echo "" >> ../conf/messages.en
echo "whatIsTheNameOfTheCompany.title = whatIsTheNameOfTheCompany" >> ../conf/messages.en
echo "whatIsTheNameOfTheCompany.heading = whatIsTheNameOfTheCompany" >> ../conf/messages.en
echo "whatIsTheNameOfTheCompany.checkYourAnswersLabel = whatIsTheNameOfTheCompany" >> ../conf/messages.en
echo "whatIsTheNameOfTheCompany.error.required = Enter whatIsTheNameOfTheCompany" >> ../conf/messages.en
echo "whatIsTheNameOfTheCompany.error.length = WhatIsTheNameOfTheCompany must be 100 characters or less" >> ../conf/messages.en

echo "Adding to UserAnswersEntryGenerators"
awk '/trait UserAnswersEntryGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryWhatIsTheNameOfTheCompanyUserAnswersEntry: Arbitrary[(WhatIsTheNameOfTheCompanyPage.type, JsValue)] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        page  <- arbitrary[WhatIsTheNameOfTheCompanyPage.type]";\
    print "        value <- arbitrary[String].suchThat(_.nonEmpty).map(Json.toJson(_))";\
    print "      } yield (page, value)";\
    print "    }";\
    next }1' ../test/generators/UserAnswersEntryGenerators.scala > tmp && mv tmp ../test/generators/UserAnswersEntryGenerators.scala

echo "Adding to PageGenerators"
awk '/trait PageGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryWhatIsTheNameOfTheCompanyPage: Arbitrary[WhatIsTheNameOfTheCompanyPage.type] =";\
    print "    Arbitrary(WhatIsTheNameOfTheCompanyPage)";\
    next }1' ../test/generators/PageGenerators.scala > tmp && mv tmp ../test/generators/PageGenerators.scala

echo "Adding to UserAnswersGenerator"
awk '/val generators/ {\
    print;\
    print "    arbitrary[(WhatIsTheNameOfTheCompanyPage.type, JsValue)] ::";\
    next }1' ../test/generators/UserAnswersGenerator.scala > tmp && mv tmp ../test/generators/UserAnswersGenerator.scala

echo "Adding helper method to CheckYourAnswersHelper"
awk '/class CheckYourAnswersHelper/ {\
     print;\
     print "";\
     print "  def whatIsTheNameOfTheCompany: Option[Row] = userAnswers.get(WhatIsTheNameOfTheCompanyPage) map {";\
     print "    answer =>";\
     print "      Row(";\
     print "        key     = Key(msg\"whatIsTheNameOfTheCompany.checkYourAnswersLabel\", classes = Seq(\"govuk-!-width-one-half\")),";\
     print "        value   = Value(lit\"$answer\"),";\
     print "        actions = List(";\
     print "          Action(";\
     print "            content            = msg\"site.edit\",";\
     print "            href               = routes.WhatIsTheNameOfTheCompanyController.onPageLoad(CheckMode).url,";\
     print "            visuallyHiddenText = Some(msg\"site.edit.hidden\".withArgs(msg\"whatIsTheNameOfTheCompany.checkYourAnswersLabel\"))";\
     print "          )";\
     print "        )";\
     print "      )";\
     print "  }";\
     next }1' ../app/utils/CheckYourAnswersHelper.scala > tmp && mv tmp ../app/utils/CheckYourAnswersHelper.scala

echo "Migration WhatIsTheNameOfTheCompany completed"
