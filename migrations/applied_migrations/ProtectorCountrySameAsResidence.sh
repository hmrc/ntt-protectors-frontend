#!/bin/bash

echo ""
echo "Applying migration ProtectorCountrySameAsResidence"

echo "Adding routes to conf/app.routes"

echo "" >> ../conf/app.routes
echo "GET        /protectorCountrySameAsResidence                        controllers.ProtectorCountrySameAsResidenceController.onPageLoad(mode: Mode = NormalMode)" >> ../conf/app.routes
echo "POST       /protectorCountrySameAsResidence                        controllers.ProtectorCountrySameAsResidenceController.onSubmit(mode: Mode = NormalMode)" >> ../conf/app.routes

echo "GET        /changeProtectorCountrySameAsResidence                  controllers.ProtectorCountrySameAsResidenceController.onPageLoad(mode: Mode = CheckMode)" >> ../conf/app.routes
echo "POST       /changeProtectorCountrySameAsResidence                  controllers.ProtectorCountrySameAsResidenceController.onSubmit(mode: Mode = CheckMode)" >> ../conf/app.routes

echo "Adding messages to conf.messages"
echo "" >> ../conf/messages.en
echo "protectorCountrySameAsResidence.title = protectorCountrySameAsResidence" >> ../conf/messages.en
echo "protectorCountrySameAsResidence.heading = protectorCountrySameAsResidence" >> ../conf/messages.en
echo "protectorCountrySameAsResidence.checkYourAnswersLabel = protectorCountrySameAsResidence" >> ../conf/messages.en
echo "protectorCountrySameAsResidence.error.required = Select yes if protectorCountrySameAsResidence" >> ../conf/messages.en

echo "Adding to UserAnswersEntryGenerators"
awk '/trait UserAnswersEntryGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryProtectorCountrySameAsResidenceUserAnswersEntry: Arbitrary[(ProtectorCountrySameAsResidencePage.type, JsValue)] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        page  <- arbitrary[ProtectorCountrySameAsResidencePage.type]";\
    print "        value <- arbitrary[Boolean].map(Json.toJson(_))";\
    print "      } yield (page, value)";\
    print "    }";\
    next }1' ../test/generators/UserAnswersEntryGenerators.scala > tmp && mv tmp ../test/generators/UserAnswersEntryGenerators.scala

echo "Adding to PageGenerators"
awk '/trait PageGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryProtectorCountrySameAsResidencePage: Arbitrary[ProtectorCountrySameAsResidencePage.type] =";\
    print "    Arbitrary(ProtectorCountrySameAsResidencePage)";\
    next }1' ../test/generators/PageGenerators.scala > tmp && mv tmp ../test/generators/PageGenerators.scala

echo "Adding to UserAnswersGenerator"
awk '/val generators/ {\
    print;\
    print "    arbitrary[(ProtectorCountrySameAsResidencePage.type, JsValue)] ::";\
    next }1' ../test/generators/UserAnswersGenerator.scala > tmp && mv tmp ../test/generators/UserAnswersGenerator.scala

echo "Adding helper method to CheckYourAnswersHelper"
awk '/class CheckYourAnswersHelper/ {\
     print;\
     print "";\
     print "  def protectorCountrySameAsResidence: Option[Row] = userAnswers.get(ProtectorCountrySameAsResidencePage) map {";\
     print "    answer =>";\
     print "      Row(";\
     print "        key     = Key(msg\"protectorCountrySameAsResidence.checkYourAnswersLabel\", classes = Seq(\"govuk-!-width-one-half\")),";\
     print "        value   = Value(yesOrNo(answer)),";\
     print "        actions = List(";\
     print "          Action(";\
     print "            content            = msg\"site.edit\",";\
     print "            href               = routes.ProtectorCountrySameAsResidenceController.onPageLoad(CheckMode).url,";\
     print "            visuallyHiddenText = Some(msg\"site.edit.hidden\".withArgs(msg\"protectorCountrySameAsResidence.checkYourAnswersLabel\"))";\
     print "          )";\
     print "        )";\
     print "      )";\
     print "  }";\
     next }1' ../app/utils/CheckYourAnswersHelper.scala > tmp && mv tmp ../app/utils/CheckYourAnswersHelper.scala

echo "Migration ProtectorCountrySameAsResidence completed"
