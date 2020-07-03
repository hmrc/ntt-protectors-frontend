#!/bin/bash

echo ""
echo "Applying migration WhatIsTheirCountryOfResidency"

echo "Adding routes to conf/app.routes"

echo "" >> ../conf/app.routes
echo "GET        /whatIsTheirCountryOfResidency                        controllers.WhatIsTheirCountryOfResidencyController.onPageLoad(mode: Mode = NormalMode)" >> ../conf/app.routes
echo "POST       /whatIsTheirCountryOfResidency                        controllers.WhatIsTheirCountryOfResidencyController.onSubmit(mode: Mode = NormalMode)" >> ../conf/app.routes

echo "GET        /changeWhatIsTheirCountryOfResidency                  controllers.WhatIsTheirCountryOfResidencyController.onPageLoad(mode: Mode = CheckMode)" >> ../conf/app.routes
echo "POST       /changeWhatIsTheirCountryOfResidency                  controllers.WhatIsTheirCountryOfResidencyController.onSubmit(mode: Mode = CheckMode)" >> ../conf/app.routes

echo "Adding messages to conf.messages"
echo "" >> ../conf/messages.en
echo "whatIsTheirCountryOfResidency.title = whatIsTheirCountryOfResidency" >> ../conf/messages.en
echo "whatIsTheirCountryOfResidency.heading = whatIsTheirCountryOfResidency" >> ../conf/messages.en
echo "whatIsTheirCountryOfResidency.checkYourAnswersLabel = whatIsTheirCountryOfResidency" >> ../conf/messages.en
echo "whatIsTheirCountryOfResidency.error.required = Enter whatIsTheirCountryOfResidency" >> ../conf/messages.en
echo "whatIsTheirCountryOfResidency.error.length = WhatIsTheirCountryOfResidency must be 100 characters or less" >> ../conf/messages.en

echo "Adding to UserAnswersEntryGenerators"
awk '/trait UserAnswersEntryGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryWhatIsTheirCountryOfResidencyUserAnswersEntry: Arbitrary[(WhatIsTheirCountryOfResidencyPage.type, JsValue)] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        page  <- arbitrary[WhatIsTheirCountryOfResidencyPage.type]";\
    print "        value <- arbitrary[String].suchThat(_.nonEmpty).map(Json.toJson(_))";\
    print "      } yield (page, value)";\
    print "    }";\
    next }1' ../test/generators/UserAnswersEntryGenerators.scala > tmp && mv tmp ../test/generators/UserAnswersEntryGenerators.scala

echo "Adding to PageGenerators"
awk '/trait PageGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryWhatIsTheirCountryOfResidencyPage: Arbitrary[WhatIsTheirCountryOfResidencyPage.type] =";\
    print "    Arbitrary(WhatIsTheirCountryOfResidencyPage)";\
    next }1' ../test/generators/PageGenerators.scala > tmp && mv tmp ../test/generators/PageGenerators.scala

echo "Adding to UserAnswersGenerator"
awk '/val generators/ {\
    print;\
    print "    arbitrary[(WhatIsTheirCountryOfResidencyPage.type, JsValue)] ::";\
    next }1' ../test/generators/UserAnswersGenerator.scala > tmp && mv tmp ../test/generators/UserAnswersGenerator.scala

echo "Adding helper method to CheckYourAnswersHelper"
awk '/class CheckYourAnswersHelper/ {\
     print;\
     print "";\
     print "  def whatIsTheirCountryOfResidency: Option[Row] = userAnswers.get(WhatIsTheirCountryOfResidencyPage) map {";\
     print "    answer =>";\
     print "      Row(";\
     print "        key     = Key(msg\"whatIsTheirCountryOfResidency.checkYourAnswersLabel\", classes = Seq(\"govuk-!-width-one-half\")),";\
     print "        value   = Value(lit\"$answer\"),";\
     print "        actions = List(";\
     print "          Action(";\
     print "            content            = msg\"site.edit\",";\
     print "            href               = routes.WhatIsTheirCountryOfResidencyController.onPageLoad(CheckMode).url,";\
     print "            visuallyHiddenText = Some(msg\"site.edit.hidden\".withArgs(msg\"whatIsTheirCountryOfResidency.checkYourAnswersLabel\"))";\
     print "          )";\
     print "        )";\
     print "      )";\
     print "  }";\
     next }1' ../app/utils/CheckYourAnswersHelper.scala > tmp && mv tmp ../app/utils/CheckYourAnswersHelper.scala

echo "Migration WhatIsTheirCountryOfResidency completed"
