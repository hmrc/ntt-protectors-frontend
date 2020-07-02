#!/bin/bash

echo ""
echo "Applying migration DoYouWantToAddAnotherProtector"

echo "Adding routes to conf/app.routes"

echo "" >> ../conf/app.routes
echo "GET        /doYouWantToAddAnotherProtector                        controllers.DoYouWantToAddAnotherProtectorController.onPageLoad(mode: Mode = NormalMode)" >> ../conf/app.routes
echo "POST       /doYouWantToAddAnotherProtector                        controllers.DoYouWantToAddAnotherProtectorController.onSubmit(mode: Mode = NormalMode)" >> ../conf/app.routes

echo "GET        /changeDoYouWantToAddAnotherProtector                  controllers.DoYouWantToAddAnotherProtectorController.onPageLoad(mode: Mode = CheckMode)" >> ../conf/app.routes
echo "POST       /changeDoYouWantToAddAnotherProtector                  controllers.DoYouWantToAddAnotherProtectorController.onSubmit(mode: Mode = CheckMode)" >> ../conf/app.routes

echo "Adding messages to conf.messages"
echo "" >> ../conf/messages.en
echo "doYouWantToAddAnotherProtector.title = doYouWantToAddAnotherProtector" >> ../conf/messages.en
echo "doYouWantToAddAnotherProtector.heading = doYouWantToAddAnotherProtector" >> ../conf/messages.en
echo "doYouWantToAddAnotherProtector.yesIWantToAddThemNow = YesIWantToAddThemNow" >> ../conf/messages.en
echo "doYouWantToAddAnotherProtector.noIHaveAddedAllProtectors = NoIHaveAddedAllProtectors" >> ../conf/messages.en
echo "doYouWantToAddAnotherProtector.checkYourAnswersLabel = doYouWantToAddAnotherProtector" >> ../conf/messages.en
echo "doYouWantToAddAnotherProtector.error.required = Select doYouWantToAddAnotherProtector" >> ../conf/messages.en

echo "Adding to UserAnswersEntryGenerators"
awk '/trait UserAnswersEntryGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryDoYouWantToAddAnotherProtectorUserAnswersEntry: Arbitrary[(DoYouWantToAddAnotherProtectorPage.type, JsValue)] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        page  <- arbitrary[DoYouWantToAddAnotherProtectorPage.type]";\
    print "        value <- arbitrary[DoYouWantToAddAnotherProtector].map(Json.toJson(_))";\
    print "      } yield (page, value)";\
    print "    }";\
    next }1' ../test/generators/UserAnswersEntryGenerators.scala > tmp && mv tmp ../test/generators/UserAnswersEntryGenerators.scala

echo "Adding to PageGenerators"
awk '/trait PageGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryDoYouWantToAddAnotherProtectorPage: Arbitrary[DoYouWantToAddAnotherProtectorPage.type] =";\
    print "    Arbitrary(DoYouWantToAddAnotherProtectorPage)";\
    next }1' ../test/generators/PageGenerators.scala > tmp && mv tmp ../test/generators/PageGenerators.scala

echo "Adding to ModelGenerators"
awk '/trait ModelGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryDoYouWantToAddAnotherProtector: Arbitrary[DoYouWantToAddAnotherProtector] =";\
    print "    Arbitrary {";\
    print "      Gen.oneOf(DoYouWantToAddAnotherProtector.values.toSeq)";\
    print "    }";\
    next }1' ../test/generators/ModelGenerators.scala > tmp && mv tmp ../test/generators/ModelGenerators.scala

echo "Adding to UserAnswersGenerator"
awk '/val generators/ {\
    print;\
    print "    arbitrary[(DoYouWantToAddAnotherProtectorPage.type, JsValue)] ::";\
    next }1' ../test/generators/UserAnswersGenerator.scala > tmp && mv tmp ../test/generators/UserAnswersGenerator.scala

echo "Adding helper method to CheckYourAnswersHelper"
awk '/class CheckYourAnswersHelper/ {\
     print;\
     print "";\
     print "  def doYouWantToAddAnotherProtector: Option[Row] = userAnswers.get(DoYouWantToAddAnotherProtectorPage) map {";\
     print "    answer =>";\
     print "      Row(";\
     print "        key     = Key(msg\"doYouWantToAddAnotherProtector.checkYourAnswersLabel\", classes = Seq(\"govuk-!-width-one-half\")),";\
     print "        value   = Value(msg\"doYouWantToAddAnotherProtector.$answer\"),";\
     print "        actions = List(";\
     print "          Action(";\
     print "            content            = msg\"site.edit\",";\
     print "            href               = routes.DoYouWantToAddAnotherProtectorController.onPageLoad(CheckMode).url,";\
     print "            visuallyHiddenText = Some(msg\"site.edit.hidden\".withArgs(msg\"doYouWantToAddAnotherProtector.checkYourAnswersLabel\"))";\
     print "          )";\
     print "        )";\
     print "      )";\
     print "  }";\
     next }1' ../app/utils/CheckYourAnswersHelper.scala > tmp && mv tmp ../app/utils/CheckYourAnswersHelper.scala

echo "Migration DoYouWantToAddAnotherProtector completed"
