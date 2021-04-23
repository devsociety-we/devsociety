import 'package:devsociety/Wdigets/MyAppBar.dart';
import 'package:devsociety/Wdigets/SocialButtons.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: KAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello ✋ \nHow are you guys doing?\n\nWhat's there in the text below \n1) What is Dev Society?\n2) Who Created it?\n3) Why it was Created?\n",
                textScaleFactor: 2,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("So, if you're ready to read, here we go.",
                  textScaleFactor: 1.5),
              SizedBox(
                height: 20,
              ),
              Text(
                  "1 - Dev Society is an Organization/Community of Developers and freelancers where we'll connect with each other and take projects from all around the world of any technology with each other's help and not to worry, each one of us will never be bound by any restrictions other than the client's deadline, which Ofcourse is necessary in terms of freelancing. There is also a common Business card for everyone, where you can print it with your name on it.",
                  textScaleFactor: 1.5),
              Text(
                "2 - A Group of Anonymous People, who are tired of all the exploitation of devs, improper and incomplete sense of knowledge and not finding ourselves a path to follow on.  Originated from  Maharashtra, India.",
                textScaleFactor: 1.5,
              ),
              Text(
                  "3 - So the most important question is why? What's the benifit, so the benifit is that every Freelancer is now backed by a team of developers, which may in future grow to million people, now everyone has a brand name with their name where they are not employee of the brand, rather the brand is the recognition of their efforts. Mentorship to crave your own path, self-evaluate and self-realize your worth in terms of knowledge, skills and earning. Many devs are constantly exploited in terms of money and labor time, if we want to eradicate this then we must be confident enough to say \"NO\".. and that's the confidence everyone will gain here. ",
                  textScaleFactor: 1.5),
              SizedBox(
                height: 20,
              ),
              Text(
                  "If you've read this far it means you're interested I guess,  and it also means you might be one of our base members, so I'll request you to help us make this next big thing, we'll take the initiative to start adding projects from the sources we have. So, let's see this thing through together.",
                  textScaleFactor: 1.5),
              SizedBox(
                height: 20,
              ),
              Text("Further Protocols and Flow will be Shared Soon. ",
                  textScaleFactor: 1.5),
              SizedBox(
                height: 20,
              ),
              Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.center,
                spacing: 5,
                runSpacing: 5,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      launch("mailto:devsociety.we@gmail.com");
                    },
                    icon: Icon(Icons.mail),
                    label: Text(
                      "Mail Us",
                      textScaleFactor: 3,
                    ),
                  ),
                  TelegramButton(),
                  InkWell(
                    onTap: () {
                      launch("https://www.linkedin.com/in/dev-society");
                    },
                    child: Text(
                      "Connect On LinkedIn",
                      textScaleFactor: 3,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
