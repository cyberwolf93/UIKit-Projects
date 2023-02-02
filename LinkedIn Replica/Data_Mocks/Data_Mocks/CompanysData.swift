//
//  CompanysData.swift
//  Data_Mocks
//
//  Created by Ahmed Mohiy on 26/01/2023.
//

import Foundation

class CompanysData {
    var data: [[String: Any]] = []
    
    init() {
        createData()
    }
    
    //MARK: - Data creation
    private func createData() {
        createAmazon()
        createAlphabet()
        createJPMorgan()
        createWalmart()
        createIBM()
        createATAndT()
        createApple()
        createComcast()
        createGoogle()
    }
    
    func createAmazon() {
        data.append([
            "id": "ECA2A243-754A-426C-BE8F-F847C1FB25E3",
            "name": "Amazon",
            "profile_image_url": "",
            "cover_image_url": "",
            "industry": DataEnumsRefrence.industry_technology_information_and_internet,
            "number_of_followers": 29_263_159,
            "overView": "Amazon is guided by four principles: customer obsession rather than competitor focus, passion for invention, commitment to operational excellence, and long-term thinking. We are driven by the excitement of building technologies, inventing products, and providing services that change lives. We embrace new ways of doing things, make decisions quickly, and are not afraid to fail. We have the scope and capabilities of a large company, and the spirit and heart of a small one./n/nTogether, Amazonians research and develop new technologies from Amazon Web Services to Alexa on behalf of our customers: shoppers, sellers, content creators, and developers around the world./n/nOur mission is to be Earth's most customer-centric company. Our actions, goals, projects, programs, and inventions begin and end with the customer top of mind./n/nYou'll also hear us say that at Amazon, it's always \"Day 1.\"​ What do we mean? That our approach remains the same as it was on Amazon's very first day - to make smart, fast decisions, stay nimble, invent, and focus on delighting our customers.",
            "website": "https://www.aboutamazon.com/",
            "company_size": 10001,
            "headquarters": "Seattle, WA",
            "type": DataEnumsRefrence.company_type_public,
            "specialities": "e-Commerce, Retail, Operations, and Internet",
            "funding": [[
                "currency": "US",
                "number_of_round": 3,
                "last_round_date": Date.getDateFrom(date: "03/01/2023"),
                "number_of_investors": 2,
                "amount": 8_000_000_000,
                "type": DataEnumsRefrence.funding_type_raised
            ]],
            "locations": [
                ["address": "801 30 St NE, Calgary, AB T2A 5L7, CA",
              "is_primary": true,
                "latitude": "51.059394",
               "longitude": "-113.990228"
                ],
                ["address": "109 Braid St, New Westminster, BC V3L 5H4, CA",
              "is_primary": false,
                "latitude": "49.234125",
               "longitude": "-122.885121"
                ],
                ["address": "510 W Georgia St, Vancouver, BC V6B 0M3, CA",
              "is_primary": false,
                "latitude": "49.281134",
               "longitude": "-123.116984"
                ],
                ["address": "3610 NW Saint Helens Rd, Portland, OR 97210, US",
              "is_primary": false,
                "latitude": "45.532215",
               "longitude": "-122.707924"
                ],
                ["address": "1910 E Central Ave, San Bernardino, CA 92408, US",
              "is_primary": false,
                "latitude": "34.088391",
               "longitude": "-117.245938"
                ]
            ]
        ])
    }
    
    func createAlphabet() {
        data.append([
            "id": "6FE93E3D-F35D-4CC4-9010-12B2F5F58579",
            "name": "Alphabet Inc",
            "profile_image_url": "",
            "cover_image_url": "",
            "industry": DataEnumsRefrence.industry_it_services_and_it_consulting,
            "number_of_followers": 206_062,
            "overView": "Alphabet is a collection of companies, including Google, Verily Life Sciences, GV, Calico, and X./n/nIn October 2015, Alphabet became the parent holding company of Google, with the companies far afield of our main internet products contained in Alphabet.",
            "website": "http://www.abc.xyz",
            "company_size": 8,
            "headquarters": "Mountain View, CA",
            "type": DataEnumsRefrence.company_type_private,
            "specialities": "",
            "funding": [],
            "locations": [
                ["address": "1600 Amphitheatre Parkway, Mountain View, CA 94043, US",
              "is_primary": true,
                "latitude": "37.422117",
               "longitude": "-122.084134"
                ]
            ]
        ])
    }
    
    func createJPMorgan() {
        data.append([
            "id": "9594356E-C3B1-443F-B2A9-68038969EAEF",
            "name": "JPMorgan Chase & Co.",
            "profile_image_url": "",
            "cover_image_url": "",
            "industry": DataEnumsRefrence.industry_entertainment,
            "number_of_followers": 3_640_074,
            "overView": "For over 200 years, JPMorgan Chase & Co has provided innovative financial solutions for consumers, small businesses, corporations, governments and institutions around the world./n/nToday, we're a leading global financial services firm with operations servicing clients in more than 100 countries./n/nWhether we are serving customers, helping small businesses, or putting our skills to work with partners, we strive to identify issues and propose solutions that will propel the future and strengthen both our clients and our communities./n/n© 2017 JPMorgan Chase & Co.  JPMorgan Chase is an equal opportunity and affirmative action employer Disability/Veteran.",
            "website": "http://www.jpmorganchase.com",
            "company_size": 10001,
            "headquarters": "New York, NY",
            "type": DataEnumsRefrence.company_type_public,
            "specialities": "Consumer & Community Banking, Corporate and Investment Bank, Asset Management, Private Banking, and Commercial Banking",
            "funding": [],
            "locations": [
                ["address": "101 Duncan Mill Road, Toronto, ON M3B1Z3, CA",
              "is_primary": true,
                "latitude": "43.761175",
               "longitude": "-79.35553"
                ],
                ["address": "270 Park Avenue, New York, NY 10017-2014, US",
              "is_primary": false,
                "latitude": "40.755887",
               "longitude": "-73.975591"
                ],
                ["address": "4 Metrotech Center, Brooklyn, NY 11201, US",
              "is_primary": false,
                "latitude": "40.692989",
               "longitude": "-73.990768"
                ],
                ["address": "2200 Ross Ave, Dallas, TX 75201, US",
              "is_primary": false,
                "latitude": "32.787958",
               "longitude": "-96.79663"
                ],
                ["address": "100 N Tampa St, Tampa, FL 33602, US",
              "is_primary": false,
                "latitude": "27.953651",
               "longitude": "-82.458038"
                ]
            ]
        ])
    }
    
    func createWalmart() {
        data.append([
            "id": "B0B05555-F0AE-4017-952D-E8992B66A1B4",
            "name": "Walmart",
            "profile_image_url": "",
            "cover_image_url": "",
            "industry": DataEnumsRefrence.industry_retail_and_fashion,
            "number_of_followers": 4_217_875,
            "overView": "Sixty years ago, Sam Walton started a single mom-and-pop shop and transformed it into the world’s biggest retailer. Since those founding days, one thing has remained consistent: our commitment to helping our customers save money so they can live better. Today, we’re reinventing the shopping experience and our associates are at the heart of it. When you join our Walmart family of brands (Sam's Club, Bonobos, Moosejaw and many more!), you’ll play a crucial role in shaping the future of retail, improving millions of lives around the world./n/nThis is that place where your passions meet purpose. Join our family and build a career you’re proud of.",
            "website": "https://bit.ly/3IBowlZ",
            "company_size": 10001,
            "headquarters": "Bentonville, Arkansas",
            "type": DataEnumsRefrence.company_type_public,
            "specialities": "Retail, Technology, Transportation, Logistics, Merchandising, Marketing, Operations, Health & Wellness, eCommerce, and Management",
            "funding": [],
            "locations": [
                ["address": "850 Cherry Ave, San Bruno, CA 94066, US",
              "is_primary": true,
                "latitude": "37.625772",
               "longitude": "-122.426062"
                ],
                ["address": "840 W California Ave, Sunnyvale, CA 94086, US",
              "is_primary": false,
                "latitude": "37.381565",
               "longitude": "-122.037849"
                ],
                ["address": "702 SW 8th St, Bentonville, Arkansas 72712, US",
              "is_primary": false,
                "latitude": "36.365482",
               "longitude": "-94.217894"
                ],
                ["address": "Boulevard Manuel Ávila Camacho 647, Lomas de Sotelo, Distrito Federal 11200, MX",
              "is_primary": false,
                "latitude": "19.436941",
               "longitude": "-99.227127"
                ],
                ["address": "Avenida del Valle Sur 725, Huechuraba, Santiago Metropolitan 8580000, CL",
              "is_primary": false,
                "latitude": "-33.374462",
               "longitude": "-70.636299"
                ]
            ]
        ])
    }
    
    func createIBM() {
        data.append([
            "id": "0374B77B-9CF2-4567-93E8-0A0C5DEF692F",
            "name": "IBM",
            "profile_image_url": "",
            "cover_image_url": "",
            "industry": DataEnumsRefrence.industry_it_services_and_it_consulting,
            "number_of_followers": 14_988_202,
            "overView": "At IBM, we do more than work. We create. We create as technologists, developers, and engineers. We create with our partners. We create with our competitors. If you're searching for ways to make the world work better through technology and infrastructure, software and consulting, then we want to work with you./n/nWe're here to help every creator turn their \"what if\" into what is. Let's create something that will change everything.",
            "website": "http://www.ibm.com",
            "company_size": 10001,
            "headquarters": "Armonk, New York, NY",
            "type": DataEnumsRefrence.company_type_public,
            "specialities": "Cloud, Mobile, Cognitive, Security, Research, Watson, Analytics, Consulting, Commerce, Experience Design, Internet of Things, Technology support, Industry solutions, Systems services, Resiliency services, Financing, and IT infrastructure",
            "funding": [[
                "currency": "US",
                "number_of_round": 3,
                "last_round_date": Date.getDateFrom(date: "03/01/2023"),
                "number_of_investors": 2,
                "amount": 8_000_000_000,
                "type": DataEnumsRefrence.funding_type_raised
            ]],
            "locations": [
                ["address": "71 S Wacker Dr, Chicago, IL 60606, US",
              "is_primary": true,
                "latitude": "41.880992",
               "longitude": "-87.636027"
                ],
                ["address": "505 Howard St, San Francisco, CA 94105, US",
              "is_primary": false,
                "latitude": "37.787964",
               "longitude": "-122.396191"
                ],
                ["address": "1000 Belleview St, Dallas, TX 75215, US",
              "is_primary": false,
                "latitude": "32.768151",
               "longitude": "-96.793413"
                ],
                ["address": "14212 Cochran Rd SW, Huntsville, AL 35824, US",
              "is_primary": false,
                "latitude": "34.669076",
               "longitude": "-86.746459"
                ],
                ["address": "3031 N Rocky Point Dr W, Tampa, FL 33607, US",
              "is_primary": false,
                "latitude": "27.970336",
               "longitude": "-82.568586"
                ]
            ]
        ])
    }
    
    func createATAndT() {
        data.append([
            "id": "CB472C59-40E4-4F89-87A0-79E400920D18",
            "name": "AT&T",
            "profile_image_url": "",
            "cover_image_url": "",
            "industry": DataEnumsRefrence.industry_it_services_and_it_consulting,
            "number_of_followers": 1_635_924,
            "overView": "We understand that our customers want an easier, less complicated life./n/nWe’re using our network, labs, products, services, and people to create a world where everything works together seamlessly, and life is better as a result.  How will we continue to drive for this excellence in innovation?/n/nWith you./n/nOur people, and their passion to succeed, are at the heart of what we do. Today, we’re poised to connect millions of people with their world, delivering the human benefits of technology in ways that defy the imaginable./n/nWhat are you dreaming of doing with your career?/n/nFind stories about our talent, career advice, opportunities, company news, and innovations here on LinkedIn./n/nTo learn more about joining AT&T, visit: http://www.att.jobs/n/nWe provide in some of our posts links to articles or posts from third-party websites unaffiliated with AT&T.  In doing so, AT&T is not adopting, endorsing or otherwise approving the content of those articles or posts.  AT&T is providing this content for your information only.",
            "website": "http://www.att.com",
            "company_size": 10001,
            "headquarters": "Dallas, TX",
            "type": DataEnumsRefrence.company_type_public,
            "specialities": "Wireless Services, U-Verse, and Enterprise Applications & Managed Hosting Solutions",
            "funding": [],
            "locations": [
                ["address": "2250 E Imperial Hwy, El Segundo, CA 90245, US",
              "is_primary": true,
                "latitude": "33.93056",
               "longitude": "-118.38423"
                ],
                ["address": "208 S. Akard Street, Dallas, TX 75202, US",
              "is_primary": false,
                "latitude": "32.779604",
               "longitude": "-96.798777"
                ]
            ]
        ])
    }
    
    func createApple() {
        data.append([
            "id": "314D4FAB-7701-48A2-ACB8-6F0573922393",
            "name": "Apple",
            "profile_image_url": "",
            "cover_image_url": "",
            "industry": DataEnumsRefrence.industry_technology_information_and_internet,
            "number_of_followers": 18_120_615,
            "overView": "We’re a diverse collective of thinkers and doers, continually reimagining what’s possible to help us all do what we love in new ways. And the same innovation that goes into our products also applies to our practices — strengthening our commitment to leave the world better than we found it. This is where your work can make a difference in people’s lives. Including your own./n/nApple is an equal opportunity employer that is committed to inclusion and diversity. Visit apple.com/careers to learn more.",
            "website": "http://www.apple.com/careers",
            "company_size": 10001,
            "headquarters": "Cupertino, California",
            "type": DataEnumsRefrence.company_type_public,
            "specialities": "Innovative Product Development, World-Class Operations, Retail, and Telephone Support",
            "funding": [[
                "currency": "US",
                "last_update": Date.getDateFrom(date: "03/01/2023"),
                "type": DataEnumsRefrence.funding_type_stock,
                "last_price": 144.29,
                "sympol": "AAPL",
                "market": "NASDAQ",
                "gains": 1.29,
                "gains_percentage": 0.902,
                "open_price": 142.34,
                "price_day_high": 144.34,
                "price_day_low": 142.28
            ]],
            "locations": [
                ["address": "1 Apple Park Way, Cupertino, California 95014, US",
              "is_primary": true,
                "latitude": "37.329388",
               "longitude": "-122.008399"
                ]
            ]
        ])
    }
    
    func createComcast() {
        data.append([
            "id": "38879849-63ED-4627-883B-20AE2FFD0A59",
            "name": "Comcast",
            "profile_image_url": "",
            "cover_image_url": "",
            "industry": DataEnumsRefrence.industry_technology_information_and_internet,
            "number_of_followers": 542_617,
            "overView": "We're a global media and technology company with three primary businesses:  Comcast Cable, NBCUniversal, and Sky.  Comcast Cable is one of the United States’ largest video, high-speed internet, and phone providers to residential customers under the Xfinity brand, and also provides these services to businesses.  It also provides wireless and security and automation services to residential customers under the Xfinity brand.  NBCUniversal is global and operates news, entertainment and sports cable networks, the NBC and Telemundo broadcast networks, television production operations, television station groups, Universal Pictures, and Universal Parks and Resorts.  Sky is one of Europe's leading media and entertainment companies, connecting customers to a broad range of video content through its pay television services.  It also provides communications services, including residential high-speed internet, phone, and wireless services.  Sky operates the Sky News broadcast network and sports and entertainment networks, produces original content, and has exclusive content rights.",
            "website": "https://corporate.comcast.com/",
            "company_size": 10001,
            "headquarters": "Philadelphia, PA",
            "type": DataEnumsRefrence.company_type_public,
            "specialities": "",
            "funding": [[
                "currency": "US",
                "number_of_round": 4,
                "last_round_date": Date.getDateFrom(date: "10/07/2022"),
                "number_of_investors": 1,
                "amount": 7_700_000,
                "type": DataEnumsRefrence.funding_type_raised
            ]],
            "locations": [
                ["address": "Philadelphia, PA 19103, US",
              "is_primary": true,
                "latitude": "39.951965",
               "longitude": "-75.172646"
                ],
                ["address": "30 Rockefeller Plaza, New York, New York 10020, US",
              "is_primary": false,
                "latitude": "40.75975",
               "longitude": "-73.98056"
                ],
                ["address": "1050 Enterprise Way, Sunnyvale, California 94089, US",
              "is_primary": false,
                "latitude": "37.404596",
               "longitude": "-122.036026"
                ],
                ["address": "10 Universal City Plaza, Universal City, California 91608, US",
              "is_primary": false,
                "latitude": "34.137767",
               "longitude": "-118.361248"
                ],
                ["address": "1000 Universal Studios Plaza, Universal Parks & Resorts, Florida 32819, US",
              "is_primary": false,
                "latitude": "28.477264",
               "longitude": "-81.473601"
                ]
            ]
        ])
    }
    
    func createGoogle() {
        data.append([
            "id": "69f43a74-bf6a-4896-9cc5-2e9ef8811712",
            "name": "Google",
            "profile_image_url": "",
            "cover_image_url": "",
            "industry": DataEnumsRefrence.industry_technology_information_and_internet,
            "number_of_followers": 27_671_016,
            "overView": "A problem isn't truly solved until it's solved for all. Googlers build products that help create opportunities for everyone, whether down the street or across the globe. Bring your insight, imagination and a healthy disregard for the impossible. Bring everything that makes you unique. Together, we can build for everyone./n/nCheck out our career opportunities at careers.google.com. ",
            "website": "https://goo.gle/3m1IN7m",
            "company_size": 10001,
            "headquarters": "Mountain View, CA",
            "type": DataEnumsRefrence.company_type_public,
            "specialities": "search, ads, mobile, android, online video, apps, machine learning, virtual reality, cloud, hardware, artificial intelligence, youtube, and software",
            "funding": [[
                "currency": "US",
                "number_of_round": 3,
                "last_round_date": Date.getDateFrom(date: "06/06/1999"),
                "number_of_investors": 8,
                "amount": 25_000_000,
                "type": DataEnumsRefrence.funding_type_raised
            ]],
            "locations": [
                ["address": "777 6th St S, Kirkland, WA 98033, US",
              "is_primary": true,
                "latitude": "47.669659",
               "longitude": "-122.197372"
                ],
                ["address": "601 N 34th St, Seattle, WA 98103, US",
              "is_primary": false,
                "latitude": "47.649214",
               "longitude": "-122.35038"
                ],
                ["address": "2590 Pearl St, Boulder, CO 80302, US",
              "is_primary": false,
                "latitude": "40.021272",
               "longitude": "-105.261168"
                ],
                ["address": "1600 Amphitheatre Parkway, Mountain View, CA 94043, US",
              "is_primary": false,
                "latitude": "37.422117",
               "longitude": "-122.084134"
                ],
                ["address": "901 Cherry Ave, San Bruno, CA 94066, US",
              "is_primary": false,
                "latitude": "37.627994",
               "longitude": "-122.426311"
                ]
            ]
        ])
    }
    
}
