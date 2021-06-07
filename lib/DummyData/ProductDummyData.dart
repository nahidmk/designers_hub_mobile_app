
import '../Model/design_image.dart';
import '../Model/fabric_mixing.dart';
import '../Model/fabric.dart';
import '../Model/design.dart';
import '../Model/user.dart';


List<Design> products = [

  // new Product(
  //     id: 101,
  //     name: "xyz",
  //     price: 123,
  //     disabled: false,
  //     descriptions: "hello",
  //     thumbnail: "abc/xyz.png",
  //     favCount: 1,
  //     designImages: [
  //       new DesignImage(1, "abc/xyz.png"),
  //       new DesignImage(2, "efg/xyz.png"),
  //       new DesignImage(3, "est/xyz.png")
  //     ],
  //     fabrics: [
  //       new Fabric(
  //           available: false,
  //           baseColor: "black",
  //           descriptions: "hello fabrics",
  //           disabled: false,
  //           favCount: 1,
  //           id: 1,
  //           name: "xyz",
  //           pricePerYard: 123,
  //           slug: "slug",
  //           fabricMixings: [
  //             new FabricMixing(
  //                 id: 1,
  //                 percentage: 20,
  //                 fabricMixingType: FabricMixingType.POLYESTER,
  //                 fabricWeave: FabricWeave.SINGLE
  //             ),
  //             new FabricMixing(
  //                 id: 2,
  //                 percentage: 30,
  //                 fabricMixingType: FabricMixingType.COTTON,
  //                 fabricWeave: FabricWeave.SINGLE
  //             )
  //           ],
  //           thumbnail: "xyz/abc.png",
  //       ),
  //       new Fabric(
  //           available: false,
  //           baseColor: "Blue",
  //           descriptions: "hello fabrics 2",
  //           disabled: false,
  //           favCount: 2,
  //           id: 2,
  //           name: "abc",
  //           pricePerYard: 526,
  //           slug: "slug_slug",
  //           fabricMixings: [
  //             new FabricMixing(
  //                 id: 6,
  //                 percentage: 62,
  //                 fabricMixingType: FabricMixingType.VISCOSE,
  //                 fabricWeave: FabricWeave.SINGLE
  //             ),
  //             new FabricMixing(
  //                 id: 6,
  //                 percentage: 30,
  //                 fabricMixingType: FabricMixingType.COTTON,
  //                 fabricWeave: FabricWeave.SINGLE
  //             )
  //           ],
  //           thumbnail: "xyz/opk.png",
  //       ),
  //
  //     ],
  //     user: new User(
  //         active: false,
  //         address: "Chanpur",
  //         banned: false,
  //         dateOfBirth: DateTime.now(),
  //         disabled: false,
  //         email: "email@gmail.com",
  //         fullName: "Nahidul Islam",
  //         gender: Gender.FEMALE,
  //         id: 1,
  //         nid: "20130450",
  //         nidPictureBack: "abc/abc.gpj",
  //         nidPictureFront: "abc/abc.gpj",
  //         password: "islam_mk",
  //         primaryNumber: "021356487501",
  //         profilePicture: "xyz/bcd.gpj",
  //         provider: Provider.github,
  //         providerId: "abc",
  //         secondaryNumber: "62525658142"
  //     )
  // ),
  // new Product(
  //     id: 201,
  //     name: "www",
  //     price: 625,
  //     disabled: false,
  //     descriptions: "how are you",
  //     thumbnail: "abc/xyz.png",
  //     favCount: 2,
  //     designImage: [
  //       new DesignImage(1, "abc/xyz.png"),
  //       new DesignImage(2, "efg/xyz.png"),
  //       new DesignImage(3, "est/xyz.png")
  //     ],
  //     fabrics: [
  //       new Fabrics(
  //           available: false,
  //           baseColor: "black",
  //           descriptions: "hello fabrics",
  //           disable: false,
  //           favCount: 1,
  //           id: 1,
  //           name: "xyz",
  //           pricePerYard: 123,
  //           slug: "slug",
  //           fabricMixing: [
  //             new FabricMixing(
  //                 id: 1,
  //                 percentage: 20,
  //                 fabricMixingType: FabricMixingType.POLYESTER,
  //                 fabricWeave: FabricWeave.SINGLE
  //             ),
  //             new FabricMixing(
  //                 id: 2,
  //                 percentage: 30,
  //                 fabricMixingType: FabricMixingType.COTTON,
  //                 fabricWeave: FabricWeave.SINGLE
  //             )
  //           ],
  //           thumbnail: "xyz/abc.png",
  //           user: new User(
  //               active: false,
  //               address: "Chanpur",
  //               banned: false,
  //               dateOfBirth: DateTime.now(),
  //               disabled: false,
  //               email: "email@gmail.com",
  //               fullName: "Nahidul Islam",
  //               gender: Gender.FEMALE,
  //               id: 1,
  //               nid: "20130450",
  //               nidPictureBack: "abc/abc.gpj",
  //               nidPictureFront: "abc/abc.gpj",
  //               password: "islam_mk",
  //               primaryNumber: "021356487501",
  //               profilePicture: "xyz/bcd.gpj",
  //               provider: Provider.github,
  //               providerId: "abc",
  //               secondaryNumber: "62525658142"
  //           )
  //       ),
  //       new Fabrics(
  //           available: false,
  //           baseColor: "Blue",
  //           descriptions: "hello fabrics 2",
  //           disable: false,
  //           favCount: 2,
  //           id: 2,
  //           name: "abc",
  //           pricePerYard: 526,
  //           slug: "slug_slug",
  //           fabricMixing: [
  //             new FabricMixing(
  //                 id: 6,
  //                 percentage: 62,
  //                 fabricMixingType: FabricMixingType.VISCOSE,
  //                 fabricWeave: FabricWeave.SINGLE
  //             ),
  //             new FabricMixing(
  //                 id: 6,
  //                 percentage: 30,
  //                 fabricMixingType: FabricMixingType.COTTON,
  //                 fabricWeave: FabricWeave.SINGLE
  //             )
  //           ],
  //           thumbnail: "xyz/opk.png",
  //           user: new User(
  //               active: false,
  //               address: "Faridganj",
  //               banned: false,
  //               dateOfBirth: DateTime.now(),
  //               disabled: false,
  //               email: "joniyed@gmail.com",
  //               fullName: "Joniyed Bhuiyan",
  //               gender: Gender.FEMALE,
  //               id: 1,
  //               nid: "20130450",
  //               nidPictureBack: "abc/abc.gpj",
  //               nidPictureFront: "abc/abc.gpj",
  //               password: "islam_mk",
  //               primaryNumber: "021356487501",
  //               profilePicture: "xyz/bcd.gpj",
  //               provider: Provider.github,
  //               providerId: "abc",
  //               secondaryNumber: "62525658142"
  //           )
  //       ),
  //
  //     ],
  //     user: new User(
  //         active: false,
  //         address: "comilla",
  //         banned: false,
  //         dateOfBirth: DateTime.now(),
  //         disabled: false,
  //         email: "arif@gmail.com",
  //         fullName: "Arif",
  //         gender: Gender.FEMALE,
  //         id: 6,
  //         nid: "2565652580130450",
  //         nidPictureBack: "abc/abc.gpj",
  //         nidPictureFront: "lkjho/abc.gpj",
  //         password: "islam_mk",
  //         primaryNumber: "625984542361",
  //         profilePicture: "xyz/bcd.gpj",
  //         provider: Provider.github,
  //         providerId: "abc",
  //         secondaryNumber: "625984542361"
  //     )
  // ),
  // new Product(
  //     id: 693,
  //     name: "ppp",
  //     price: 695,
  //     disabled: false,
  //     descriptions: "this is good",
  //     thumbnail: "abc/xyz.png",
  //     favCount: 1,
  //     designImage: [
  //       new DesignImage(6, "abc/xyz.png"),
  //       new DesignImage(7, "efg/xyz.png"),
  //       new DesignImage(8, "est/xyz.png")
  //     ],
  //     fabrics: [
  //       new Fabrics(
  //           available: false,
  //           baseColor: "Blue",
  //           descriptions: "hello fabrics",
  //           disable: false,
  //           favCount: 6,
  //           id: 5,
  //           name: "lmn",
  //           pricePerYard: 123,
  //           slug: "slug",
  //           fabricMixing: [
  //             new FabricMixing(
  //                 id: 9,
  //                 percentage: 69,
  //                 fabricMixingType: FabricMixingType.POLYESTER,
  //                 fabricWeave: FabricWeave.SINGLE
  //             ),
  //             new FabricMixing(
  //                 id: 12,
  //                 percentage: 69,
  //                 fabricMixingType: FabricMixingType.LINEN,
  //                 fabricWeave: FabricWeave.SINGLE
  //             )
  //           ],
  //           thumbnail: "xyz/abc.png",
  //           user: new User(
  //               active: false,
  //               address: "Chanpur",
  //               banned: false,
  //               dateOfBirth: DateTime.now(),
  //               disabled: false,
  //               email: "email@gmail.com",
  //               fullName: "Nahidul Islam",
  //               gender: Gender.FEMALE,
  //               id: 1,
  //               nid: "20130450",
  //               nidPictureBack: "abc/abc.gpj",
  //               nidPictureFront: "abc/abc.gpj",
  //               password: "islam_mk",
  //               primaryNumber: "021356487501",
  //               profilePicture: "xyz/bcd.gpj",
  //               provider: Provider.github,
  //               providerId: "abc",
  //               secondaryNumber: "62525658142"
  //           )
  //       ),
  //       new Fabrics(
  //           available: false,
  //           baseColor: "Blue",
  //           descriptions: "hello fabrics 2",
  //           disable: false,
  //           favCount: 2,
  //           id: 2,
  //           name: "abc",
  //           pricePerYard: 526,
  //           slug: "slug_slug",
  //           fabricMixing: [
  //             new FabricMixing(
  //                 id: 6,
  //                 percentage: 62,
  //                 fabricMixingType: FabricMixingType.VISCOSE,
  //                 fabricWeave: FabricWeave.SINGLE
  //             ),
  //             new FabricMixing(
  //                 id: 6,
  //                 percentage: 30,
  //                 fabricMixingType: FabricMixingType.COTTON,
  //                 fabricWeave: FabricWeave.SINGLE
  //             )
  //           ],
  //           thumbnail: "xyz/opk.png",
  //           user: new User(
  //               active: false,
  //               address: "Faridganj",
  //               banned: false,
  //               dateOfBirth: DateTime.now(),
  //               disabled: false,
  //               email: "email@gmail.com",
  //               fullName: "Joniyed Bhuiyan",
  //               gender: Gender.FEMALE,
  //               id: 1,
  //               nid: "20130450",
  //               nidPictureBack: "abc/abc.gpj",
  //               nidPictureFront: "abc/abc.gpj",
  //               password: "islam_mk",
  //               primaryNumber: "021356487501",
  //               profilePicture: "xyz/bcd.gpj",
  //               provider: Provider.github,
  //               providerId: "abc",
  //               secondaryNumber: "62525658142"
  //           )
  //       ),
  //
  //     ],
  //     user: new User(
  //         active: false,
  //         address: "kisorgonj",
  //         banned: false,
  //         dateOfBirth: DateTime.now(),
  //         disabled: false,
  //         email: "juwel@gmail.com",
  //         fullName: "Juwel Shekh",
  //         gender: Gender.FEMALE,
  //         id: 1,
  //         nid: "20130451452",
  //         nidPictureBack: "abc/abc.gpj",
  //         nidPictureFront: "abc/abc.gpj",
  //         password: "islam_mk",
  //         primaryNumber: "01236547896",
  //         profilePicture: "xyz/bcd.gpj",
  //         provider: Provider.google,
  //         providerId: "eggjh",
  //         secondaryNumber: "01236547896"
  //     )
  // )

];