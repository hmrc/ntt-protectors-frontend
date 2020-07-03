#!/bin/bash

echo ""
echo "Applying migration DoYouKnowProtectorDateOfBirth"

echo "Adding routes to conf/app.routes"

echo "" >> ../conf/app.routes
echo "GET        /doYouKnowProtectorDateOfBirth                        controllers.DoYouKnowProtectorDateOfBirthController.onPageLoad(mode: Mode = NormalMode)" >> ../conf/app.routes
echo "POST       /doYouKnowProtectorDateOfBirth                        controllers.DoYouKnowProtectorDateOfBirthController.onSubmit(mode: Mode = NormalMode)" >> ../conf/app.routes

echo "GET        /changeDoYouKnowProtectorDateOfBirth                  controllers.DoYouKnowProtectorDateOfBirthController.onPageLoad(mode: Mode = CheckMode)" >> ../conf/app.routes
echo "POST       /changeDoYouKnowProtectorDateOfBirth                  controllers.DoYouKnowProtectorDateOfBirthController.onSubmit(mode: Mode = CheckMode)" >> ../conf/app.routes

echo "Adding messages to conf.messages"
echo "" >> ../conf/messages.en
echo "doYouKnowProtectorDateOfBirth.title = doYouKnowProtectorDateOfBirth" >> ../conf/messages.en
echo "doYouKnowProtectorDateOfBirth.heading = doYouKnowProtectorDateOfBirth" >> ../conf/messages.en
echo "doYouKnowProtectorDateOfBirth.checkYourAnswersLabel = doYouKnowProtectorDateOfBirth" >> ../conf/messages.en
echo "doYouKnowProtectorDateOfBirth.error.required = Select yes if doYouKnowProtectorDateOfBirth" >> ../conf/messages.en

echo "Adding to UserAnswersEntryGenerators"
awk '/trait UserAnswersEntryGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryDoYouKnowProtectorDateOfBirthUserAnswersEntry: Arbitrary[(DoYouKnowProtectorDateOfBirthPage.type, JsValue)] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        page  <- arbitrary[DoYouKnowProtectorDateOfBirthPage.type]";\
    print "        value <- arbitrary[Boolean].map(Json.toJson(_))";\
    print "      } yield (page, value)";\
    print "    }";\
    next }1' ../test/generators/UserAnswersEntryGenerators.scala > tmp && mv tmp ../test/generators/UserAnswersEntryGenerators.scala

echo "Adding to PageGenerators"
awk '/trait PageGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryDoYouKnowProtectorDateOfBirthPage: Arbitrary[DoYouKnowProtectorDateOfBirthPage.type] =";\
    print "    Arbitrary(DoYouKnowProtectorDateOfBirthPage)";\
    next }1' ../test/generators/PageGenerators.scala > tmp && mv tmp ../test/generators/PageGenerators.scala

echo "Adding to UserAnswersGenerator"
awk '/val generators/ {\
    print;\
    print "    arbitrary[(DoYouKnowProtectorDateOfBirthPage.type, JsValue)] ::";\
    next }1' ../test/generators/UserAnswersGenerator.scala > tmp && mv tmp ../test/generators/UserAnswersGenerator.scala

echo "Adding helper method to CheckYourAnswersHelper"
awk '/class CheckYourAnswersHelper/ {\
     print;\
     print "";\
     print "  def doYouKnowProtectorDateOfBirth: Option[Row] = userAnswers.get(DoYouKnowProtectorDateOfBirthPage) map {";\
     print "    answer =>";\
     print "      Row(";\
     print "        key     = Key(msg\"doYouKnowProtectorDateOfBirth.checkYourAnswersLabel\", classes = Seq(\"govuk-!-width-one-half\")),";\
     print "        value   = Value(yesOrNo(answer)),";\
     print "        actions = List(";\
     print "          Action(";\
     print "            content            = msg\"site.edit\",";\
     print "            href               = routes.DoYouKnowProtectorDateOfBirthController.onPageLoad(CheckMode).url,";\
     print "            visuallyHiddenText = Some(msg\"site.edit.hidden\".withArgs(msg\"doYouKnowProtectorDateOfBirth.checkYourAnswersLabel\"))";\
     print "          )";\
     print "        )";\
     print "      )";\
     print "  }";\
     next }1' ../app/utils/CheckYourAnswersHelper.scala > tmp && mv tmp ../app/utils/CheckYourAnswersHelper.scala

echo "Migration DoYouKnowProtectorDateOfBirth completed"
