#!/bin/bash

echo ""
echo "Applying migration ProtectorsName"

echo "Adding routes to conf/app.routes"

echo "" >> ../conf/app.routes
echo "GET        /protectorsName                        controllers.ProtectorsNameController.onPageLoad(mode: Mode = NormalMode)" >> ../conf/app.routes
echo "POST       /protectorsName                        controllers.ProtectorsNameController.onSubmit(mode: Mode = NormalMode)" >> ../conf/app.routes

echo "GET        /changeProtectorsName                  controllers.ProtectorsNameController.onPageLoad(mode: Mode = CheckMode)" >> ../conf/app.routes
echo "POST       /changeProtectorsName                  controllers.ProtectorsNameController.onSubmit(mode: Mode = CheckMode)" >> ../conf/app.routes

echo "Adding messages to conf.messages"
echo "" >> ../conf/messages.en
echo "protectorsName.title = protectorsName" >> ../conf/messages.en
echo "protectorsName.heading = protectorsName" >> ../conf/messages.en
echo "protectorsName.FirstName = FirstName" >> ../conf/messages.en
echo "protectorsName.MiddleName = MiddleName" >> ../conf/messages.en
echo "protectorsName.checkYourAnswersLabel = protectorsName" >> ../conf/messages.en
echo "protectorsName.error.FirstName.required = Enter FirstName" >> ../conf/messages.en
echo "protectorsName.error.MiddleName.required = Enter MiddleName" >> ../conf/messages.en
echo "protectorsName.error.FirstName.length = FirstName must be 100 characters or less" >> ../conf/messages.en
echo "protectorsName.error.MiddleName.length = MiddleName must be 100 characters or less" >> ../conf/messages.en

echo "Adding to UserAnswersEntryGenerators"
awk '/trait UserAnswersEntryGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryProtectorsNameUserAnswersEntry: Arbitrary[(ProtectorsNamePage.type, JsValue)] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        page  <- arbitrary[ProtectorsNamePage.type]";\
    print "        value <- arbitrary[ProtectorsName].map(Json.toJson(_))";\
    print "      } yield (page, value)";\
    print "    }";\
    next }1' ../test/generators/UserAnswersEntryGenerators.scala > tmp && mv tmp ../test/generators/UserAnswersEntryGenerators.scala

echo "Adding to PageGenerators"
awk '/trait PageGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryProtectorsNamePage: Arbitrary[ProtectorsNamePage.type] =";\
    print "    Arbitrary(ProtectorsNamePage)";\
    next }1' ../test/generators/PageGenerators.scala > tmp && mv tmp ../test/generators/PageGenerators.scala

echo "Adding to ModelGenerators"
awk '/trait ModelGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryProtectorsName: Arbitrary[ProtectorsName] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        FirstName <- arbitrary[String]";\
    print "        MiddleName <- arbitrary[String]";\
    print "      } yield ProtectorsName(FirstName, MiddleName)";\
    print "    }";\
    next }1' ../test/generators/ModelGenerators.scala > tmp && mv tmp ../test/generators/ModelGenerators.scala

echo "Adding to UserAnswersGenerator"
awk '/val generators/ {\
    print;\
    print "    arbitrary[(ProtectorsNamePage.type, JsValue)] ::";\
    next }1' ../test/generators/UserAnswersGenerator.scala > tmp && mv tmp ../test/generators/UserAnswersGenerator.scala

echo "Adding helper method to CheckYourAnswersHelper"
awk '/class CheckYourAnswersHelper/ {\
     print;\
     print "";\
     print "  def protectorsName: Option[Row] = userAnswers.get(ProtectorsNamePage) map {";\
     print "    answer =>";\
     print "      Row(";\
     print "        key     = Key(msg\"protectorsName.checkYourAnswersLabel\", classes = Seq(\"govuk-!-width-one-half\")),";\
     print "        value   = Value(lit\"${answer.FirstName} ${answer.MiddleName}\"),";\
     print "        actions = List(";\
     print "          Action(";\
     print "            content            = msg\"site.edit\",";\
     print "            href               = routes.ProtectorsNameController.onPageLoad(CheckMode).url,";\
     print "            visuallyHiddenText = Some(msg\"site.edit.hidden\".withArgs(msg\"protectorsName.checkYourAnswersLabel\"))";\
     print "          )";\
     print "        )";\
     print "      )";\
     print "  }";\
     next }1' ../app/utils/CheckYourAnswersHelper.scala > tmp && mv tmp ../app/utils/CheckYourAnswersHelper.scala

echo "Migration ProtectorsName completed"
