#!/bin/bash

echo ""
echo "Applying migration ProtectorDateOfBirth"

echo "Adding routes to conf/app.routes"

echo "" >> ../conf/app.routes
echo "GET        /protectorDateOfBirth                  controllers.ProtectorDateOfBirthController.onPageLoad(mode: Mode = NormalMode)" >> ../conf/app.routes
echo "POST       /protectorDateOfBirth                  controllers.ProtectorDateOfBirthController.onSubmit(mode: Mode = NormalMode)" >> ../conf/app.routes

echo "GET        /changeProtectorDateOfBirth                        controllers.ProtectorDateOfBirthController.onPageLoad(mode: Mode = CheckMode)" >> ../conf/app.routes
echo "POST       /changeProtectorDateOfBirth                        controllers.ProtectorDateOfBirthController.onSubmit(mode: Mode = CheckMode)" >> ../conf/app.routes

echo "Adding messages to conf.messages"
echo "" >> ../conf/messages.en
echo "protectorDateOfBirth.title = ProtectorDateOfBirth" >> ../conf/messages.en
echo "protectorDateOfBirth.heading = ProtectorDateOfBirth" >> ../conf/messages.en
echo "protectorDateOfBirth.hint = For example, 12 11 2007" >> ../conf/messages.en
echo "protectorDateOfBirth.checkYourAnswersLabel = ProtectorDateOfBirth" >> ../conf/messages.en
echo "protectorDateOfBirth.error.required.all = Enter the protectorDateOfBirth" >> ../conf/messages.en
echo "protectorDateOfBirth.error.required.two = The protectorDateOfBirth" must include {0} and {1} >> ../conf/messages.en
echo "protectorDateOfBirth.error.required = The protectorDateOfBirth must include {0}" >> ../conf/messages.en
echo "protectorDateOfBirth.error.invalid = Enter a real ProtectorDateOfBirth" >> ../conf/messages.en

echo "Adding to UserAnswersEntryGenerators"
awk '/trait UserAnswersEntryGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryProtectorDateOfBirthUserAnswersEntry: Arbitrary[(ProtectorDateOfBirthPage.type, JsValue)] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        page  <- arbitrary[ProtectorDateOfBirthPage.type]";\
    print "        value <- arbitrary[Int].map(Json.toJson(_))";\
    print "      } yield (page, value)";\
    print "    }";\
    next }1' ../test/generators/UserAnswersEntryGenerators.scala > tmp && mv tmp ../test/generators/UserAnswersEntryGenerators.scala

echo "Adding to PageGenerators"
awk '/trait PageGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryProtectorDateOfBirthPage: Arbitrary[ProtectorDateOfBirthPage.type] =";\
    print "    Arbitrary(ProtectorDateOfBirthPage)";\
    next }1' ../test/generators/PageGenerators.scala > tmp && mv tmp ../test/generators/PageGenerators.scala

echo "Adding to UserAnswersGenerator"
awk '/val generators/ {\
    print;\
    print "    arbitrary[(ProtectorDateOfBirthPage.type, JsValue)] ::";\
    next }1' ../test/generators/UserAnswersGenerator.scala > tmp && mv tmp ../test/generators/UserAnswersGenerator.scala

echo "Adding helper method to CheckYourAnswersHelper"
awk '/class CheckYourAnswersHelper/ {\
     print;\
     print "";\
     print "  def protectorDateOfBirth: Option[Row] = userAnswers.get(ProtectorDateOfBirthPage) map {";\
     print "    answer =>";\
     print "      Row(";\
     print "        key     = Key(msg\"protectorDateOfBirth.checkYourAnswersLabel\", classes = Seq(\"govuk-!-width-one-half\")),";\
     print "        value   = Value(Literal(answer.format(dateFormatter))),";\
     print "        actions = List(";\
     print "          Action(";\
     print "            content            = msg\"site.edit\",";\
     print "            href               = routes.ProtectorDateOfBirthController.onPageLoad(CheckMode).url,";\
     print "            visuallyHiddenText = Some(msg\"site.edit.hidden\".withArgs(msg\"protectorDateOfBirth.checkYourAnswersLabel\"))";\
     print "          )";\
     print "        )";\
     print "      )";\
     print "  }";\
     next }1' ../app/utils/CheckYourAnswersHelper.scala > tmp && mv tmp ../app/utils/CheckYourAnswersHelper.scala

echo "Migration ProtectorDateOfBirth completed"
