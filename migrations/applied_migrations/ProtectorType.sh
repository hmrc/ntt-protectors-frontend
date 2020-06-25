#!/bin/bash

echo ""
echo "Applying migration ProtectorType"

echo "Adding routes to conf/app.routes"

echo "" >> ../conf/app.routes
echo "GET        /protectorType                        controllers.ProtectorTypeController.onPageLoad(mode: Mode = NormalMode)" >> ../conf/app.routes
echo "POST       /protectorType                        controllers.ProtectorTypeController.onSubmit(mode: Mode = NormalMode)" >> ../conf/app.routes

echo "GET        /changeProtectorType                  controllers.ProtectorTypeController.onPageLoad(mode: Mode = CheckMode)" >> ../conf/app.routes
echo "POST       /changeProtectorType                  controllers.ProtectorTypeController.onSubmit(mode: Mode = CheckMode)" >> ../conf/app.routes

echo "Adding messages to conf.messages"
echo "" >> ../conf/messages.en
echo "protectorType.title = protectorType" >> ../conf/messages.en
echo "protectorType.heading = protectorType" >> ../conf/messages.en
echo "protectorType.individual = Individual" >> ../conf/messages.en
echo "protectorType.business = Business" >> ../conf/messages.en
echo "protectorType.checkYourAnswersLabel = protectorType" >> ../conf/messages.en
echo "protectorType.error.required = Select protectorType" >> ../conf/messages.en

echo "Adding to UserAnswersEntryGenerators"
awk '/trait UserAnswersEntryGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryProtectorTypeUserAnswersEntry: Arbitrary[(ProtectorTypePage.type, JsValue)] =";\
    print "    Arbitrary {";\
    print "      for {";\
    print "        page  <- arbitrary[ProtectorTypePage.type]";\
    print "        value <- arbitrary[ProtectorType].map(Json.toJson(_))";\
    print "      } yield (page, value)";\
    print "    }";\
    next }1' ../test/generators/UserAnswersEntryGenerators.scala > tmp && mv tmp ../test/generators/UserAnswersEntryGenerators.scala

echo "Adding to PageGenerators"
awk '/trait PageGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryProtectorTypePage: Arbitrary[ProtectorTypePage.type] =";\
    print "    Arbitrary(ProtectorTypePage)";\
    next }1' ../test/generators/PageGenerators.scala > tmp && mv tmp ../test/generators/PageGenerators.scala

echo "Adding to ModelGenerators"
awk '/trait ModelGenerators/ {\
    print;\
    print "";\
    print "  implicit lazy val arbitraryProtectorType: Arbitrary[ProtectorType] =";\
    print "    Arbitrary {";\
    print "      Gen.oneOf(ProtectorType.values.toSeq)";\
    print "    }";\
    next }1' ../test/generators/ModelGenerators.scala > tmp && mv tmp ../test/generators/ModelGenerators.scala

echo "Adding to UserAnswersGenerator"
awk '/val generators/ {\
    print;\
    print "    arbitrary[(ProtectorTypePage.type, JsValue)] ::";\
    next }1' ../test/generators/UserAnswersGenerator.scala > tmp && mv tmp ../test/generators/UserAnswersGenerator.scala

echo "Adding helper method to CheckYourAnswersHelper"
awk '/class CheckYourAnswersHelper/ {\
     print;\
     print "";\
     print "  def protectorType: Option[Row] = userAnswers.get(ProtectorTypePage) map {";\
     print "    answer =>";\
     print "      Row(";\
     print "        key     = Key(msg\"protectorType.checkYourAnswersLabel\", classes = Seq(\"govuk-!-width-one-half\")),";\
     print "        value   = Value(msg\"protectorType.$answer\"),";\
     print "        actions = List(";\
     print "          Action(";\
     print "            content            = msg\"site.edit\",";\
     print "            href               = routes.ProtectorTypeController.onPageLoad(CheckMode).url,";\
     print "            visuallyHiddenText = Some(msg\"site.edit.hidden\".withArgs(msg\"protectorType.checkYourAnswersLabel\"))";\
     print "          )";\
     print "        )";\
     print "      )";\
     print "  }";\
     next }1' ../app/utils/CheckYourAnswersHelper.scala > tmp && mv tmp ../app/utils/CheckYourAnswersHelper.scala

echo "Migration ProtectorType completed"
