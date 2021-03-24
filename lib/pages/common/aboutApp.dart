import 'package:flutter/material.dart';
import 'package:health_bag/globals/myColors.dart';
import 'package:health_bag/globals/myFonts.dart';
import 'package:health_bag/globals/mySpaces.dart';
import 'package:health_bag/widgets/backgrounds/fourthBackground.dart';
import 'package:url_launcher/url_launcher.dart';

String aboutAppText =
    "Bu uygulama Coumadin ilacını kullanan hastaların "
    "INR takibini yapmak ve ilaç dozunu ayarlamak amacıyla hazırlanmıştır. "
    "INR sonucunuzu bu uygulama üzerinden hekiminiz ile paylaşarak, ilacınızın "
    "dozu hekiminiz tarafından ayarlanacak ve bu uygulama aracılığıyla bildirilecektir.\n\n"
    "Bu uygulama SBÜ Ahi Evren Göğüs Kalp ve Damar Cerrahisi EAH Kardiyovasküler "
    "Cerrahi (KVC) hekimleri ve INR takibi gerektiren Coumadin ilacını kullanan "
    "hastaların hekim-hasta iletişimini sağlamak amacıyla hazırlanmıştır. Bu uygulamanın "
    "yöneticileri ilgili hastanenin KVC hekimleri olup, size ait olan bilgileri sadece "
    "kendileri görmektedir. Uygulamada yer alan bilgiler araştırma amacıyla kullanılacaktır.  "
    "Bu araştırmada maruz kalacağınız risk veya rahatsızlık bulunmamaktadır. Kimliğinizi ortaya "
    "çıkaracak (ad,soyad vs ) bilgiler gizli tutulacaktır.\n\nCoumadin ne amaçla kullanıldığı, "
    "hangi besinlerle tüketileceği, nasıl kullanılacağı ve kullanırken nelere dikkat edileceği "
    "hakkında detaylı bilgi almak için ilgili linke tıklayınız."
    "\n\n";

const _url = 'https://file.tkd.org.tr/kilavuzlar/Coumadin_kilavuz.pdf';
void _launchURL() async =>
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';

class AboutApp extends StatelessWidget {
  static String id = 'about-app';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            FourthBackground(),
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.05,
                left: 20,
                right: 20,
              ),
              child: MyFonts().title1('About App', MyColors.white),
            ),
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.15,
                left: 20,
                right: 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    MyFonts().body(aboutAppText, MyColors.black),
                    GestureDetector(
                      onTap: (){
                        _launchURL();
                      },
                      child:MyFonts().body('https://file.tkd.org.tr/kilavuzlar/Coumadin_kilavuz.pdf', MyColors.blue),
                    ),
                    MySpaces.vLargeGapInBetween,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
