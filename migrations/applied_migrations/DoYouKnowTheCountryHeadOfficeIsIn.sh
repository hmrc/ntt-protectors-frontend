#!/bin/bash

echo ""
echo "Applying migration DoYouKnowTheCountryHeadOfficeIsIn"

echo "Adding routes to conf/app.routes"

echo "" >> ../conf/app.routes
echo "GET        /doYouKnowTheCountryHeadOfficeIsIn                        controllers.DoYouKnowTheCountryHeadOfficeIsInController.onPageLoad(mode: Mode = NormalMode)" >> ../conf/app.routes
echo "POST       /doYouKnowTheCountryHeadOfficeIsIn                        controllers.DoYouKnowTheCountryHeadOfficeIsInController.onSubmit(mode: Mode = NormalMode)" >> ../conf/app.routes

echo "GET        /changeDoYouKnowTheCountryHeadOfficeIsIn                  controllers.DoYouKnowTheCountryHeadOfficeIsInController.onPageLoad(mode: Mode = CheckMode)" >> ../conf/app.routes
echo "POST       /changeDoYouKnowTheCountryHeadOfficeIsIn                  controllers.DoYouKnowTheCountryHeadOfficeIsInController.onSubmit(mode: Mode = CheckMode)" >> ../conf/app.routes

echo "Adding messages to conf.messages"
echo "" >> ../conf/messages.en
echo "doYouKnowTheCountryHeadOfficeIsIn.title = doYouKnowTheCountryHeadOfficeIsIn" >> ../conf/messages.en
echo "doYouKnowTheCountryHeadOfficeIsIn.heading = doYouKnowTheCountryHeadOfficeIsIn" >> ../conf/messages.en
echo "doYouKnowTheCountryHeadOfficeIsIn.checkYourAnswersLabel = doYouKnowTheCountryHeadOfficeIsIn" >> ../conf/messages.en
echo "doYouKnowTheCountryHeadOfficeIsIn.error.required = Select yes if doYouKnowTheCountryHeadOfficeIsIn" >> ../conf/messages.en

echo "Adding to UserAnswersEntryGenerators"
awk '/trait UserAnswersEntryGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryDoYouKnowTheCountryHeadOfficeIsInUserAnswersEntry: Arbitrary[(DoYouKnowTheCountryHeadOfficeIsInPage.type, JsValue)] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        page  <- arbitrary[DoYouKnowTheCountryHeadOfficeIsInPage.type]";\
    print "        value <- arbitrary[Boolean].map(Json.toJson(_))";\
    print "      } yield (page, value)";\
    print "    }";\
    next }1' ../test/generators/UserAnswersEntryGenerators.scala > tmp && mv tmp ../test/generators/UserAnswersEntryGenerators.scala

echo "Adding to PageGenerators"
awk '/trait PageGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryDoYouKnowTheCountryHeadOfficeIsInPage: Arbitrary[DoYouKnowTheCountryHeadOfficeIsInPage.type] =";\
    print "    Arbitrary(DoYouKnowTheCountryHeadOfficeIsInPage)";\
    next }1' ../test/generators/PageGenerators.scala > tmp && mv tmp ../test/generators/PageGenerators.scala

echo "Adding to UserAnswersGenerator"
awk '/val generators/ {\
    print;\
    print "    arbitrary[(DoYouKnowTheCountryHeadOfficeIsInPage.type, JsValue)] ::";\
    next }1' ../test/generators/UserAnswersGenerator.scala > tmp && mv tmp ../test/generators/UserAnswersGenerator.scala

echo "Adding helper method to CheckYourAnswersHelper"
awk '/class CheckYourAnswersHelper/ {\
     print;\
     print "";\
     print "  def doYouKnowTheCountryHeadOfficeIsIn: Option[Row] = userAnswers.get(DoYouKnowTheCountryHeadOfficeIsInPage) map {";\
     print "    answer =>";\
     print "      Row(";\
     print "        key     = Key(msg\"doYouKnowTheCountryHeadOfficeIsIn.checkYourAnswersLabel\", classes = Seq(\"govuk-!-width-one-half\")),";\
     print "        value   = Value(yesOrNo(answer)),";\
     print "        actions = List(";\
     print "          Action(";\
     print "            content            = msg\"site.edit\",";\
     print "            href               = routes.DoYouKnowTheCountryHeadOfficeIsInController.onPageLoad(CheckMode).url,";\
     print "            visuallyHiddenText = Some(msg\"site.edit.hidden\".withArgs(msg\"doYouKnowTheCountryHeadOfficeIsIn.checkYourAnswersLabel\"))";\
     print "          )";\
     print "        )";\
     print "      )";\
     print "  }";\
     next }1' ../app/utils/CheckYourAnswersHelper.scala > tmp && mv tmp ../app/utils/CheckYourAnswersHelper.scala

echo "Migration DoYouKnowTheCountryHeadOfficeIsIn completed"
