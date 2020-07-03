#!/bin/bash

echo ""
echo "Applying migration DoYouKnowTheirCountryOfResidency"

echo "Adding routes to conf/app.routes"

echo "" >> ../conf/app.routes
echo "GET        /doYouKnowTheirCountryOfResidency                        controllers.DoYouKnowTheirCountryOfResidencyController.onPageLoad(mode: Mode = NormalMode)" >> ../conf/app.routes
echo "POST       /doYouKnowTheirCountryOfResidency                        controllers.DoYouKnowTheirCountryOfResidencyController.onSubmit(mode: Mode = NormalMode)" >> ../conf/app.routes

echo "GET        /changeDoYouKnowTheirCountryOfResidency                  controllers.DoYouKnowTheirCountryOfResidencyController.onPageLoad(mode: Mode = CheckMode)" >> ../conf/app.routes
echo "POST       /changeDoYouKnowTheirCountryOfResidency                  controllers.DoYouKnowTheirCountryOfResidencyController.onSubmit(mode: Mode = CheckMode)" >> ../conf/app.routes

echo "Adding messages to conf.messages"
echo "" >> ../conf/messages.en
echo "doYouKnowTheirCountryOfResidency.title = doYouKnowTheirCountryOfResidency" >> ../conf/messages.en
echo "doYouKnowTheirCountryOfResidency.heading = doYouKnowTheirCountryOfResidency" >> ../conf/messages.en
echo "doYouKnowTheirCountryOfResidency.checkYourAnswersLabel = doYouKnowTheirCountryOfResidency" >> ../conf/messages.en
echo "doYouKnowTheirCountryOfResidency.error.required = Select yes if doYouKnowTheirCountryOfResidency" >> ../conf/messages.en

echo "Adding to UserAnswersEntryGenerators"
awk '/trait UserAnswersEntryGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryDoYouKnowTheirCountryOfResidencyUserAnswersEntry: Arbitrary[(DoYouKnowTheirCountryOfResidencyPage.type, JsValue)] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        page  <- arbitrary[DoYouKnowTheirCountryOfResidencyPage.type]";\
    print "        value <- arbitrary[Boolean].map(Json.toJson(_))";\
    print "      } yield (page, value)";\
    print "    }";\
    next }1' ../test/generators/UserAnswersEntryGenerators.scala > tmp && mv tmp ../test/generators/UserAnswersEntryGenerators.scala

echo "Adding to PageGenerators"
awk '/trait PageGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryDoYouKnowTheirCountryOfResidencyPage: Arbitrary[DoYouKnowTheirCountryOfResidencyPage.type] =";\
    print "    Arbitrary(DoYouKnowTheirCountryOfResidencyPage)";\
    next }1' ../test/generators/PageGenerators.scala > tmp && mv tmp ../test/generators/PageGenerators.scala

echo "Adding to UserAnswersGenerator"
awk '/val generators/ {\
    print;\
    print "    arbitrary[(DoYouKnowTheirCountryOfResidencyPage.type, JsValue)] ::";\
    next }1' ../test/generators/UserAnswersGenerator.scala > tmp && mv tmp ../test/generators/UserAnswersGenerator.scala

echo "Adding helper method to CheckYourAnswersHelper"
awk '/class CheckYourAnswersHelper/ {\
     print;\
     print "";\
     print "  def doYouKnowTheirCountryOfResidency: Option[Row] = userAnswers.get(DoYouKnowTheirCountryOfResidencyPage) map {";\
     print "    answer =>";\
     print "      Row(";\
     print "        key     = Key(msg\"doYouKnowTheirCountryOfResidency.checkYourAnswersLabel\", classes = Seq(\"govuk-!-width-one-half\")),";\
     print "        value   = Value(yesOrNo(answer)),";\
     print "        actions = List(";\
     print "          Action(";\
     print "            content            = msg\"site.edit\",";\
     print "            href               = routes.DoYouKnowTheirCountryOfResidencyController.onPageLoad(CheckMode).url,";\
     print "            visuallyHiddenText = Some(msg\"site.edit.hidden\".withArgs(msg\"doYouKnowTheirCountryOfResidency.checkYourAnswersLabel\"))";\
     print "          )";\
     print "        )";\
     print "      )";\
     print "  }";\
     next }1' ../app/utils/CheckYourAnswersHelper.scala > tmp && mv tmp ../app/utils/CheckYourAnswersHelper.scala

echo "Migration DoYouKnowTheirCountryOfResidency completed"
