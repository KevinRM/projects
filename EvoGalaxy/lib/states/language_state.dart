import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LanguagesAvailables { es, en }

enum TextKeys {
  noTranslationAvailable,
  empty,
  copy,

  // Home
  menuHome,
  adBanner,
  projectDescription1,
  projectFeaturesTitle,
  projectFeature1Title,
  projectFeature2Title,
  projectFeature3Title,
  projectFeature4Title,
  projectFeature5Title,
  projectFeature6Title,
  projectFeature1,
  projectFeature2,
  projectFeature3,
  projectFeature4,
  projectFeature5,
  projectFeature6,
  roadmapTitle,
  roadmapDisclaimer,
  roadmapLastUpdate,
  roadmapWebsitePublish,
  roadmapAvatarInGame,
  roadmapPlayerAccounts,
  roadmapNFTcreation,
  roadmapMultiplayer,
  roadmapAlphaVersion1,
  roadmapAlphaVersion2,
  roadmapBetaVersion,
  roadmapMarketplace,
  roadmapTournaments,
  roadmapVR,
  roadmapAvatarCreation,
  roadmapSpaceshipBuilderSystem,
  roadmapShipControls,
  roadmapBuilderSystemNewAssets,
  roadmapGalaxyGeneratorAlgorithm,
  roadmapProgressionSystem,
  roadmapBattleSystem,
  roadmapRankingsSystem,
  roadmapSocialInteractions,
  roadmapPlayerInteractionsGalaxy,
  roadmapTokenAnnouncement,
  roadmapTokenIntegration,
  roadmapSmartContract,
  roadmapInGameEconomy,
  roadmapSpaceStations,
  roadmapElementsAI,
  aboutUsTitle,
  aboutUs1,
  aboutUs2,
  aboutUs3,
  aboutUs4,
  aboutUs5,
  donationTitle,
  donationText1,
  donationText2,
  donationText3,
  donationWalletBSC,
  donationSuppCoins,
  partnersTitle,
  partnersBecomePartner,
  faqTitle,
  faqDescription,
  footerTermsMenu,
  footerTermsTitle,
  footerTermsLastUpdated,
  footerTerms1,
  footerTerms2,
  footerPrivacyMenu,
  footerPrivacyTitle,
  footerPrivacyLastUpdated,
  footerPrivacy1,
  footerPrivacy2,
  footerPrivacy3,
  footerPrivacy4,
  footerSmartContractAddress,
  disclaimer1,
  disclaimer2,
  tokenUtilityTitle,
  tokenUtilityDescription,
  tokenUtility1,
  tokenUtility2,
  tokenUtility3,
  tokenUtility4,
  tokenUtility5,
  tokenUtilityMore,
  connect,

  // Errors
  unknownPage,
  noInternetAccess,

  signOutText,
  profileText,
  continueText,
  backText,
  notificationsText,
  insertUsername,
  insertPass,
  availableSoon,
  searchText,
  save,
  saved,
  total,
  name,
  surname,
  dniCif,
  address,
  addressNotification,
  email,
  phone,
  add,
  date,
  seeEdit,
  print,
  emptyData,
  copiedToClipboard,
  remove,
  removeQuestion,
  removed,
  actions,
  generalData,
  cancel,

  // Menu

  menuDashboard,
  menuUndCatchments,
  menuPool,
  menuPurifier,
  menuTank,
  menuSewagePipe,
  menuWaste,
  menuSettings,

  // Home
  welcomeMorningMessage,
  welcomeAfternoonMessage,
  nextEventsMessage,
  noNextEventsMessage,

  // Catchments
  catchmentTitle,
  catchmentAddNew,
  catchmentExpNumb,
  catchmentAcronym,
  catchmentName,
  catchmentOtherNames,
  catchmentOtherName,
  catchmentType,
  catchmentSubType,
  catchmentLocation,
  catchmentDanger,
  catchmentState,
  catchmentStateAdmin,
  catchmentRegisDate,
  catchmentUse,
  catchmentObservations,
  catchmentObservation,
  catchmentsOwnersManagerTitle,
  catchmentFirstOwner,
  catchmentCurrentOwner,
  catchmentManager,
  catchmentMeasurements,
  catchmentAuthMeasurement,
  catchmentExecMeasurement,
  catchmentMeasurementResult,
  catchmentFlow,
  catchmentFlows,

  // Catchment type
  catchmentTypeGallery,
  catchmentTypeSource,
  catchmentTypeWell,
  catchmentTypeWellGallery,
  // Catchment subtype
  catchmentSubTypeCistern,
  catchmentSubTypeCommon,
  catchmentSubTypeGallery,
  catchmentSubTypeSource,
  catchmentSubTypeWell,
  catchmentSubTypeSinkHole,
  // Catchment danger
  catchmentDangerVeryLow,
  catchmentDangerLow,
  catchmentDangerMedium,
  catchmentDangerHigh,
  catchmentDangerVeryHigh,
  // Catchment state
  catchmentStateActive,
  catchmentStateInactive,
  // Catchment admin state
  catchmentStateAdminMissingDoc,
  catchmentStateAdminRegistered,
  catchmentStateAdminNoExp,
  catchmentStateAdminTrans8,
  // Dimensions
  dimensionMain,
  dimensionDepth,
  dimensionLineUpMain,
  dimensionLenghtMain,
  dimensionForks,
  dimensionLineUpForks,
  dimensionLenghtForks,
  // Location
  locationSlope,
  locationMunicipality,
  locationSpot,
  locationPlace,
  locationCoordX,
  locationCoordY,
  locationCoordZ,
  locationSlopeNorth,
  locationSlopeSouth,
  locationSlopeEast,
  locationSlopeWest,
  locationSlopeNorthwest,
  locationSlopeNortheast,
  locationSlopeSoutheast,
  locationSlopeSouthweast,
  locationBarlovento,
  locationBrenaAlta,
  locationBrenaBaja,
  locationElPaso,
  locationFuencaliente,
  locationGarafia,
  locationLosLLanos,
  locationPuntagorda,
  locationPuntallana,
  locationSanAndresYSauces,
  locationSCLaPalma,
  locationTazacorte,
  locationTijarafe,
  locationVillaMazo,

  usernameNull,
  passNull,
  shortPass,
  matchPass,
  errorComServer,
  requiredField,
  mustBeNumber,
  errorFormFields,

  // Must be the same name as the value of ERRORS_CODE in the server
  defaultError,
  permissionDenied,
  incompleteData,
  userOrPassError,
  userDisabled,
  sessionExpired,
  errorGettingProfile,
  catchmentErrorSave,
  errorGettingCatchmentNotExist,
  errorGettingCatchments,
  flowErrorSave,
  errorGettingFlows,
  errorDeleting,
}

class LanguageState with ChangeNotifier {
  final LanguagesAvailables _defaultLanguage = LanguagesAvailables.en;
  static LanguagesAvailables languageSelected = LanguagesAvailables.en;

  final Map<LanguagesAvailables, Map<TextKeys, String>> _texts = {
    LanguagesAvailables.es: {
      TextKeys.noTranslationAvailable: "-> Sin traducción <-",
      TextKeys.empty: "",

      // ==========
      // Home =====
      // ==========
      TextKeys.menuHome: "Inicio",
      // Header
      TextKeys.adBanner: "EL TOKEN AÚN NO ESTÁ DISPONIBLE",
      TextKeys.projectDescription1:
          "Un metaverso galáctico único, free-to-play y play-to-earn",
      // Project info section
      TextKeys.projectFeature1:
          "Nuestro sistema de construcción te permite dar rienda suelta a la creatividad para hacer la nave perfecta para ti",
      TextKeys.projectFeature2:
          "Muévete por la galaxia en busca de recursos, tesoros, planetas... pero cuidado con lo que te puedes encontrar, no estamos solos",
      TextKeys.projectFeature3: "Juega con amigos y creced juntos",
      TextKeys.projectFeature4:
          "Lucha en batallas contra otros jugadores, tanto amistosas como por botín.",
      TextKeys.projectFeature5:
          "Progresa y escala posiciones en los diferentes rankings para ser conocido en todas las galaxias",
      // TextKeys.projectInfo:
      //     "Nos gusta el modelo de negocio free-to-play + play-to-earn. Queremos que todo el mundo pueda jugarlo sin necesidad de gastar dinero. Sin embargo, también tendrá su parte play-to-earn para los jugadores que deseen ir un paso más allá y obtener rendimientos con él, pero sin perder nuestra visión de crear un buen videojuego.",
      TextKeys.roadmapDisclaimer:
          "Nos encanta el proyecto y nos gustaría trabajar a tiempo completo en él, pero necesitamos vivir y para ello tenemos que trabajar en nuestros actuales empleos. En consecuencia, la hoja de ruta puede sufrir modificaciones o retrasos",
      TextKeys.aboutUsTitle: "Sobre nosotros",
      TextKeys.aboutUs1:
          "Actualmente, y bajo nuestro punto de vista, el sector play-to-earn está saturado con juegos simples, enfocados solamente en el dinero, dejando de lado la diversión y provocando rechazo en la comunidad",
      TextKeys.aboutUs2:
          "Somos un equipo joven pero con muchas ganas, conscientes de los errores que se están cometiendo actualmente en el sector y, por ello, queremos marcar la diferencia haciendo las cosas bien. Nuestra visión es clara en lo que queremos lograr con este proyecto, aprovechando la tecnología que se nos presenta en la actualidad y en los próximos años para hacer un juego bien diseñado, entretenido, con buenas mecánicas y que os de ganas de jugarlo, haciendo honor al nombre de videojuego",
      TextKeys.aboutUs3:
          "Queremos ser muy transparentes con nuestra comunidad, que forméis parte de todo el proceso de desarrollo, ya que sentimos que os lo debemos. Opinamos que los videojuegos no son solo de la compañía que los hace sino también de vosotros que los jugáis, por ello, compartiremos por nuestras redes sociales los trabajos que vamos realizando, os dejaros probar el juego en diferentes fases para que podáis opinar sobre él y sintáis el progreso que se va haciendo a lo largo del tiempo",
      TextKeys.aboutUs4:
          "Sin más, os pedimos que tengáis confianza en nosotros y que nos déis la posibilidad de crear algo grande para todos, juntos marcaremos la diferencia",
      TextKeys.connect: "Conectar",
      // ==========
      // ==========
      // =============
      TextKeys.signOutText: "Cerrar sesión",
      TextKeys.profileText: "Perfil",
      TextKeys.continueText: "Continuar",
      TextKeys.notificationsText: "Notificaciones",
      TextKeys.backText: "Volver",
      TextKeys.insertUsername: "Usuario",
      TextKeys.insertPass: "Contraseña",
      TextKeys.availableSoon: "Disponible próximamente",
      TextKeys.searchText: "Buscar",
      TextKeys.save: "Guardar",
      TextKeys.saved: "Guardado",
      TextKeys.total: "Total",
      TextKeys.name: "Nombre",
      TextKeys.surname: "Apellidos",
      TextKeys.dniCif: "DNI/CIF",
      TextKeys.address: "Dirección",
      TextKeys.addressNotification: "Dirección de notificaciones",
      TextKeys.email: "Correo electrónico",
      TextKeys.phone: "Teléfono",
      TextKeys.add: "Añadir",
      TextKeys.date: "Fecha",
      TextKeys.print: "Imprimir",
      TextKeys.seeEdit: "Ver / Editar",
      TextKeys.emptyData: "No hay datos",
      TextKeys.copy: "Copiar",
      TextKeys.copiedToClipboard: "Copiado",
      TextKeys.remove: "Eliminar",
      TextKeys.removeQuestion:
          "¿Seguro que quieres eliminar este elemento? La acción no se puede deshacer",
      TextKeys.removed: "Eliminado",
      TextKeys.actions: "Acciones",
      TextKeys.generalData: "Datos generales",
      TextKeys.cancel: "Cancelar",
      // Menu

      TextKeys.menuDashboard: "Panel de control",
      TextKeys.menuUndCatchments: "CAP. Subterráneas",
      TextKeys.menuPool: "Balsas",
      TextKeys.menuPurifier: "Depuradoras",
      TextKeys.menuTank: "Depósitos",
      TextKeys.menuSewagePipe: "Emisarios",
      TextKeys.menuWaste: "Vertidos",
      TextKeys.menuSettings: "Ajustes",
      // Home
      TextKeys.welcomeMorningMessage: "Buenos días",
      TextKeys.welcomeAfternoonMessage: "Buenas tardes",
      TextKeys.nextEventsMessage: "Estos son tus próximos eventos",
      TextKeys.noNextEventsMessage: "No tienes próximos eventos",
      // Catchments
      TextKeys.catchmentTitle: "CAP. Subterránea",
      TextKeys.catchmentAddNew: "Nueva CAP",
      TextKeys.catchmentExpNumb: "Expediente",
      TextKeys.catchmentAcronym: "Siglas",
      TextKeys.catchmentName: "Nombre",
      TextKeys.catchmentOtherNames: "Otros nombres",
      TextKeys.catchmentOtherName: "Otro nombre",
      TextKeys.catchmentType: "Tipo",
      TextKeys.catchmentSubType: "Subtipo",
      TextKeys.catchmentLocation: "Localización",
      TextKeys.catchmentDanger: "Peligro",
      TextKeys.catchmentState: "Estado",
      TextKeys.catchmentStateAdmin: "Estado administrativo",
      TextKeys.catchmentRegisDate: "Fecha registro",
      TextKeys.catchmentUse: "Uso",
      TextKeys.catchmentObservations: "Observaciones",
      TextKeys.catchmentObservation: "Observación",
      TextKeys.catchmentsOwnersManagerTitle: "Titulares/Representante",
      TextKeys.catchmentFirstOwner: "Primer titular",
      TextKeys.catchmentCurrentOwner: "Titular actual",
      TextKeys.catchmentManager: "Representante",
      TextKeys.catchmentMeasurements: "Trazas",
      TextKeys.catchmentAuthMeasurement: "Autorizadas",
      TextKeys.catchmentExecMeasurement: "Ejecutadas",
      TextKeys.catchmentMeasurementResult: "Resultado",
      TextKeys.catchmentFlow: "Caudal",
      TextKeys.catchmentFlows: "Caudales",

      TextKeys.catchmentTypeGallery: "Galería",
      TextKeys.catchmentTypeSource: "Naciente",
      TextKeys.catchmentTypeWell: "Pozo",
      TextKeys.catchmentTypeWellGallery: "Pozo-Galería",
      TextKeys.catchmentSubTypeCistern: "Aljibe",
      TextKeys.catchmentSubTypeCommon: "Convencional",
      TextKeys.catchmentSubTypeGallery: "Galería",
      TextKeys.catchmentSubTypeSource: "Naciente",
      TextKeys.catchmentSubTypeWell: "Pozo",
      TextKeys.catchmentSubTypeSinkHole: "Socavón",
      TextKeys.catchmentDangerVeryLow: "Muy bajo",
      TextKeys.catchmentDangerLow: "Bajo",
      TextKeys.catchmentDangerMedium: "Medio",
      TextKeys.catchmentDangerHigh: "Alto",
      TextKeys.catchmentDangerVeryHigh: "Muy alto",
      TextKeys.catchmentStateActive: "Activo",
      TextKeys.catchmentStateInactive: "Inactivo",
      TextKeys.catchmentStateAdminMissingDoc: "Falta documentación",
      TextKeys.catchmentStateAdminRegistered: "Inscrita",
      TextKeys.catchmentStateAdminNoExp: "Sin expediente",
      TextKeys.catchmentStateAdminTrans8: "Transitoria 8",

      // Dimensions
      TextKeys.dimensionMain: "Principal",
      TextKeys.dimensionDepth: "Profundidad",
      TextKeys.dimensionLineUpMain: "Alineaciones",
      TextKeys.dimensionLenghtMain: "Longitud",
      TextKeys.dimensionForks: "Ramales",
      TextKeys.dimensionLineUpForks: "Alineaciones",
      TextKeys.dimensionLenghtForks: "Longitud",

      // Location
      TextKeys.locationSlope: "Vertiente",
      TextKeys.locationMunicipality: "Municipio",
      TextKeys.locationSpot: "Paraje",
      TextKeys.locationPlace: "Lugar",
      TextKeys.locationCoordX: "Coordenada X",
      TextKeys.locationCoordY: "Coordenada Y",
      TextKeys.locationCoordZ: "Coordenada Z",
      TextKeys.locationSlopeNorth: "Norte",
      TextKeys.locationSlopeSouth: "Sur",
      TextKeys.locationSlopeEast: "Este",
      TextKeys.locationSlopeWest: "Oeste",
      TextKeys.locationSlopeNorthwest: "Noroeste",
      TextKeys.locationSlopeNortheast: "Noreste",
      TextKeys.locationSlopeSoutheast: "Sureste",
      TextKeys.locationSlopeSouthweast: "Suroeste",
      TextKeys.locationBarlovento: "Barlovento",
      TextKeys.locationBrenaAlta: "Breña Alta",
      TextKeys.locationBrenaBaja: "Breña Baja",
      TextKeys.locationElPaso: "El Paso",
      TextKeys.locationFuencaliente: "Fuencaliente",
      TextKeys.locationGarafia: "Garafía",
      TextKeys.locationLosLLanos: "Los Llanos de Aridane",
      TextKeys.locationPuntagorda: "Puntagorda",
      TextKeys.locationPuntallana: "Puntallana",
      TextKeys.locationSanAndresYSauces: "San Andrés y Sauces",
      TextKeys.locationSCLaPalma: "Santa Cruz de La Palma",
      TextKeys.locationTazacorte: "Tazacorte",
      TextKeys.locationTijarafe: "Tijarafe",
      TextKeys.locationVillaMazo: "Villa de Mazo",

      // Errors
      TextKeys.mustBeNumber: "El número introducido no es correcto",
      TextKeys.unknownPage: "Error 404: Esta página no existe",
      TextKeys.defaultError: "Error desconocido",
      TextKeys.noInternetAccess: "Su dispositivo no tiene acceso a internet",
      TextKeys.userOrPassError: "Usuario o contraseña incorrecto",
      TextKeys.usernameNull: "Por favor, introduce tu usuario",
      TextKeys.passNull: "Por favor, introduce tu contraseña",
      TextKeys.shortPass: "La contraseña es muy corta",
      TextKeys.matchPass: "Las contraseñas no coinciden",
      TextKeys.errorComServer: "Error en la comunicación con los servidores",
      TextKeys.requiredField: "Este campo es requerido",
      TextKeys.permissionDenied: "Permiso denegado",
      TextKeys.incompleteData:
          "Por favor, completa los datos y vuelve a intentarlo",
      TextKeys.userDisabled: "Usuario deshabilitado",
      TextKeys.sessionExpired: "Su sesión ha expirado, vuelva a iniciarla",
      TextKeys.errorGettingProfile:
          "No se ha podido obtener su perfil, inicia sesión de nuevo",
      TextKeys.errorFormFields: "Hay campos con errores.\nPor favor, revísalos",
      TextKeys.catchmentErrorSave: "Ha ocurrido un error al guardar",
      TextKeys.errorGettingCatchments:
          "No se ha podido obtener las captaciones",
      TextKeys.errorGettingCatchmentNotExist: "La captación no existe",
      TextKeys.flowErrorSave: "Ha ocurrido un error al guardar",
      TextKeys.errorGettingFlows: "No se ha podido obtener los caudales",
      TextKeys.errorDeleting: "No se ha podido eliminar",
    },
    LanguagesAvailables.en: {
      TextKeys.noTranslationAvailable: "-> No translation <-",
      TextKeys.empty: "",
      TextKeys.email: "Email",
      TextKeys.copy: "Copy",
      TextKeys.copiedToClipboard: "Copied to clipboard",
      TextKeys.backText: "Go back",

      // ================
      // ===== HOME =====
      // ================
      TextKeys.menuHome: "Home",
      // ==================
      // ===== Header =====
      // ==================
      TextKeys.adBanner: "TOKEN IS NOT AVAILABLE YET",
      TextKeys.projectDescription1:
          "A unique galactic metaverse, free-to-play and play-to-earn",
      // ============================
      // ===== Project features =====
      // ============================
      TextKeys.projectFeaturesTitle: "Features",
      TextKeys.projectFeature1Title: "Build your spaceships",
      TextKeys.projectFeature1:
          "Our construction system allows you to unleash your creativity to make the perfect spaceship for you",
      TextKeys.projectFeature2Title: "Trade with others",
      TextKeys.projectFeature2:
          "Use our marketplace to trade game items with other players",
      TextKeys.projectFeature3Title: "Exlore the galaxy",
      TextKeys.projectFeature3:
          "Move around the galaxy in search of resources, treasures, planets... but be careful what you can find, we are not alone",
      TextKeys.projectFeature4Title: "Meet up with friends",
      TextKeys.projectFeature4:
          "Playing with friends is always more fun. Meet them and progress together",
      TextKeys.projectFeature5Title: "Fight in battles",
      TextKeys.projectFeature5:
          "Fight in battles against other players, both friendly and for loot",
      TextKeys.projectFeature6Title: "Make a name for yourself",
      TextKeys.projectFeature6:
          "Progress and climb positions in the different rankings to be known throughout the galaxy",
      // TextKeys.projectInfo:
      //     "Nos gusta el modelo de negocio free-to-play + play-to-earn. Queremos que todo el mundo pueda jugarlo sin necesidad de gastar dinero. Sin embargo, también tendrá su parte play-to-earn para los jugadores que deseen ir un paso más allá y obtener rendimientos con él, pero sin perder nuestra visión de crear un buen videojuego.",
      // ===================
      // ===== Roadmap =====
      // ===================
      TextKeys.roadmapTitle: "Roadmap",
      TextKeys.roadmapDisclaimer:
          "We love the project and would like to work fulltime on it, but we need to live and for that we have to work at our currents jobs. As a result, the roadmap may be subject to changes or delays",
      TextKeys.roadmapLastUpdate: "Last Updated:",
      TextKeys.roadmapTokenAnnouncement:
          "The announcement and sale of our token can be anytime throughout this year, stay tuned to our social networks",
      TextKeys.roadmapWebsitePublish: "Publish website",
      TextKeys.roadmapNFTcreation: "Creation of NFTs by players",
      TextKeys.roadmapAlphaVersion1: "Access to Alpha 1.0",
      TextKeys.roadmapAlphaVersion2: "Access to Alpha 2.0",
      TextKeys.roadmapBetaVersion: "Access to Beta 1.0",
      TextKeys.roadmapMarketplace: "Marketplace",
      TextKeys.roadmapVR: "Virtual reality (VR) support",
      TextKeys.roadmapAvatarCreation: "Creation of custom avatars",
      TextKeys.roadmapAvatarInGame: "In-game avatar integration",
      TextKeys.roadmapSpaceshipBuilderSystem: "Spaceship construction system",
      TextKeys.roadmapShipControls: "Spaceship controls and physics",
      TextKeys.roadmapTournaments:
          "Game mode: tournaments of battles with rewards",
      TextKeys.roadmapMultiplayer:
          "Design and implementation of the multiplayer structure",
      TextKeys.roadmapProgressionSystem: "Game progression system",
      TextKeys.roadmapBuilderSystemNewAssets:
          "Adding new objects to the spaceship construction system",
      TextKeys.roadmapGalaxyGeneratorAlgorithm:
          "Algorithms to generate the galaxy",
      TextKeys.roadmapElementsAI:
          "Artificial Intelligence (AI) implementation for galaxy elements",
      TextKeys.roadmapBattleSystem: "Player battle system",
      TextKeys.roadmapRankingsSystem: "Leaderboards",
      TextKeys.roadmapSocialInteractions:
          "Interactions between players throughout the galaxy",
      TextKeys.roadmapTokenIntegration:
          "Integration of the token in the game and its economy",
      TextKeys.roadmapSmartContract: "Smart Contract development and iteration",
      TextKeys.roadmapInGameEconomy: "In-game economy",
      TextKeys.roadmapPlayerInteractionsGalaxy:
          "Player interaction with galaxy elements",
      TextKeys.roadmapPlayerAccounts: "Creation of player accounts",
      TextKeys.roadmapSpaceStations: "Players' private space stations",
      // ====================
      // ===== About us =====
      // ====================
      TextKeys.aboutUsTitle: "About us",
      TextKeys.aboutUs1:
          "Currently, and from our point of view, the play-to-earn sector is saturated with simple games, focused only on money, leaving fun aside and causing rejection in the community.",
      TextKeys.aboutUs2:
          "We are a young team but with a lot of desire, aware of the mistakes that are currently being made in the sector and, therefore, we want to make a difference by doing things well. Our vision is clear in what we want to achieve with this project, taking advantage of the technology that is presented to us today and in the coming years to make a game that is well designed, entertaining, with good mechanics and that makes you want to play it, honoring to the videogame name.",
      TextKeys.aboutUs3:
          "A game should be just that, a game, with all the aspects that it entails. After that, if you can also get some extra income for playing it, so much the better.",
      TextKeys.aboutUs4:
          "We want to be very transparent with our community and that you are part of the entire development process, as we feel we owe you. We believe that videogames are not only from the company that makes them but also from you who play them, for this reason, we will share the work that we are doing through our social networks, let you play the game in different phases so that you can test it, comment on it (we will hear all of you) and feel the progress that is being made over time.",
      TextKeys.aboutUs5:
          "We know it sounds very nice and that it is an ambitious project, but we ask you to trust us a little and give us the opportunity to create something great for everyone, together we will make a difference.",
      // ====================
      // ===== Donation =====
      // ====================
      TextKeys.donationTitle: "Help us",
      TextKeys.donationText1:
          "All help is welcome, whether it is material for development, money or any other form of collaboration",
      TextKeys.donationText2:
          "EVERYTHING WILL GO TO THE DEVELOPMENT OF THE PROJECT",
      TextKeys.donationText3:
          "If you wish, you can contribute anonymously or contact us to be part of the project partners.",
      TextKeys.donationWalletBSC: "BSC Network Address (BEP20)",
      TextKeys.donationSuppCoins: "*Supported coins",
      // ====================
      // ===== Partners =====
      // ====================
      TextKeys.partnersTitle: "Partners",
      TextKeys.partnersBecomePartner:
          "Partner applications are OPEN. Contact us at",
      // ===============
      // ===== FAQ =====
      // ===============
      TextKeys.faqTitle: "FAQ",
      TextKeys.faqDescription:
          "Here are the most frequently asked questions from the community and their answers.",

      // ==================
      // ===== Footer =====
      // ==================
      TextKeys.footerTermsMenu: "Terms",
      TextKeys.footerTermsTitle: "Terms of use",
      TextKeys.footerTermsLastUpdated: "Last Updated:",
      TextKeys.footerTerms1:
          "Please read these Terms of Use (the “Terms”) and our Privacy Policy (“Privacy Policy”) carefully because they govern your use of the website located at evogalaxy.com and the content and functionalities accessible via the Site (collectively, the “Site”).\nEvoGalaxy maintains the Site as a portal for information, news, updates and to play a part of the game. For the avoidance of doubt, EvoGalaxy does not control the blockchain on which our token are tradable or useable (the “Protocol”) and cannot control activity and data on the Protocol, the validation of transactions on the Protocol, or use of the Protocol. The Protocol is an open-source protocol that is maintained and processed by validators across the globe.\n\n\n1. Agreement to Terms. By using our Site, you agree to be bound by these Terms. If you don’t agree to be bound by these Terms, do not use the Site.\n\n\n2. Privacy Policy. Please review our Privacy Policy, which also governs your use of the Site, for information on how we collect, use, and share your information.\n\n\n3. Changes to these Terms or the Site. We may update the Terms from time to time at our sole discretion. If we do, we’ll let you know by posting the updated Terms on the Site. It’s important that you review the Terms whenever we update them or you use the Site. If you continue to use the Site after we have posted updated Terms it means that you accept and agree to the changes. If you don’t agree to be bound by the changes, you may not use the Site anymore. We may change or discontinue all or any part of the Site, at any time and without notice, at our sole discretion.\n\n\n4. Who May Use the Site? You may use the Site only if you are 18 years or older and capable of forming a binding contract with EvoGalaxy, and not otherwise barred from using the Site under applicable law.\n\n\n5. Feedback. We value your feedback on the Site, but please don’t send us suggestions for improvements, creative ideas, designs, pitch portfolios, or other materials (collectively “Unsolicited Ideas”). This policy is aimed at avoiding potential disputes or misunderstandings when our Site might seem similar to Unsolicited Ideas that people submit. We may currently be developing, have developed, or in the future will develop ideas or materials internally or receive ideas or materials from other parties that may be similar to Unsolicited Ideas. If you ignore this policy and send us your Unsolicited Ideas anyway, you grant us a non-exclusive, worldwide, perpetual, irrevocable, fully-paid, royalty-free, sublicensable and transferable license under any and all intellectual property or other rights that you own or control to use, copy, modify, create derivative works based upon, make, have made, sell, offer for sale, import, and otherwise exploit in any manner or medium whatsoever known now or in the future your Unsolicited Ideas for any purpose, without compensation to you.\n\n\n6. EvoGalaxy’s Intellectual Property. We may make available through the Site content that is subject to intellectual property rights. We or our licensors, or the third parties who otherwise own the intellectual property rights, retain all rights to that content.\n\n\n7. General Prohibitions and EvoGalaxy’s Enforcement Rights. You agree not to do any of the following:\n\n7.1 Use, display, mirror, or frame the Site or any individual element within the Site, Site’s name, any EvoGalaxy trademark, logo or other proprietary information, or the layout and design of any page or form contained on a page, without the EvoGalaxy’s express written consent\n\n7.2 Access, tamper with, or use non-public areas of the Site, EvoGalaxy’s computer systems, or the technical delivery systems of EvoGalaxy’s providers\n\n7.3 Attempt to probe, scan, or test the vulnerability of any EvoGalaxy’s system or network or breach any security or authentication measures\n\n7.4 Avoid, bypass, remove, deactivate, impair, descramble, or otherwise circumvent any technological measure implemented by EvoGalaxy or any of EvoGalaxy’s providers or any other third party (including another user) to protect the Site\n\n7.5 Attempt to access or search the Site or download content from the Site using any engine, software, tool, agent, device, or mechanism (including spiders, robots, crawlers, data mining tools, or the like) other than the software and/or search agents provided by the EvoGalaxy or other generally available third-party web browsers\n\n7.6 Use the Site, or any portion thereof, for any commercial purpose or for the benefit of any third party or in any manner not permitted by these Terms\n\n7.7 Attempt to decipher, decompile, disassemble, or reverse engineer any of the software used to provide the Site\n\n7.8 Interfere with, or attempt to interfere with, the access of any user, host, or network, including, without limitation, sending a virus, overloading, flooding, spamming, or mail-bombing the Site\n\n7.9 Impersonate or misrepresent your affiliation with any person or entity\n\n7.10 Violate any applicable law or regulation or\n\n7.11 Encourage or enable any other individual to do any of the foregoing\nEvoGalaxy is not obligated to monitor access to or use of the Site or to review or edit any content. However, we have the right to do so for the purpose of operating the Site, to ensure compliance with these Terms and to comply with applicable law or other legal requirements. We reserve the right, but are not obligated, to remove or disable access to any content, at any time and without notice, including, but not limited to, if we, at our sole discretion, consider it objectionable or in violation of these Terms. We have the right to investigate violations of these Terms or conduct that affects the Site. We may also consult and cooperate with law enforcement authorities to prosecute users who violate the law.\n\n\n8. Links to Third Party Websites or Resources. The Site may allow you to access third-party websites or other resources. We provide access only as a convenience and are not responsible for the content, products, or services on or available from those resources or links displayed on such websites. You acknowledge sole responsibility for, and assume all risk arising from, your use of any third-party resources\n\n\n9. Termination. We may suspend or terminate your access to and use of the Site at our sole discretion at any time and without notice to you. Upon any termination, discontinuation, or cancellation of these Terms or the Site, the following Sections will survive: 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, and 15\n\n\n10. Geographic Restrictions. EvoGalaxy is based in the Canary Islands. We make no claims that the Site or any of its content is accessible or appropriate outside of the Canary Islands. Access to the Site may not be legal by certain persons or in certain countries. If you access the Site from outside the Canary Islands, you do so on your own initiative and are responsible for compliance with local laws\n\n\n11. Warranty Disclaimers\n\n11.1 THE SITE IS PROVIDED “AS IS,” WITHOUT WARRANTY OF ANY KIND. WITHOUT LIMITING THE FOREGOING, WE EXPLICITLY DISCLAIM ANY IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, QUIET ENJOYMENT, AND NON-INFRINGEMENT, AND ANY WARRANTIES ARISING OUT OF COURSE OF DEALING OR USAGE OF TRADE. We make no warranty that the Site will meet your requirements or be available on an uninterrupted, secure, or error-free basis. We make no warranty regarding the quality, accuracy, timeliness, truthfulness, completeness, or reliability of any information or content on the Site. Any reliance you place on such information or content is strictly at your own risk\n\n11.2 To the extent the Site allows you to interact with the Protocol, you understand that your use of the Protocol is entirely at your own risk. The Protocol is available on an “as is” basis without warranties of any kind, either express or implied, including, but not limited to, warranties of merchantability, fitness for a particular purpose, quiet enjoyment, and non-infringement. You assume all risks associated with using the Protocol, and digital assets and decentralized systems generally, including, but not limited to, that digital assets are highly volatile; you may not have ready access to assets; and you may lose some or all of your tokens or other assets. You agree that you will have no recourse against EvoGalaxy or anyone else for any losses due to the use of the Protocol. For example, these losses may arise from or relate to: (i) lost funds; (ii) server failure or data loss; (iii) corrupted cryptocurrency wallet files; (iv) unauthorized access; (v) errors, mistakes, or inaccuracies; or (vi) third-party activities\n\n\n12. Indemnity. You will indemnify and hold EvoGalaxy and its officers, directors, employees, and agents, harmless from and against any claims, disputes, demands, liabilities, damages, losses, and costs and expenses, including, without limitation, reasonable legal and accounting fees arising out of or in any way connected with (a) your access to or use of the Site, or (b) your violation of these Terms",
      TextKeys.footerTerms2:
          "\n\n\n13. Limitation of Liability\n\n13.1 TO TO THE MAXIMUM EXTENT PERMITTED BY LAW, NEITHER EVOGALAXY NOR ITS SERVICE PROVIDERS INVOLVED IN CREATING, PRODUCING, OR DELIVERING THE SITE WILL BE LIABLE FOR ANY INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES, OR DAMAGES FOR LOST PROFITS, LOST REVENUES, LOST SAVINGS, LOST BUSINESS OPPORTUNITY, LOSS OF DATA OR GOODWILL, SERVICE INTERRUPTION, COMPUTER DAMAGE, OR SYSTEM FAILURE. OR THE COST OF SUBSTITUTE SERVICES OF ANY KIND ARISING OUT OF OR IN CONNECTION WITH THESE TERMS OR FROM THE USE OF OR INABILITY TO USE THE SITE, WHETHER BASED ON WARRANTY, CONTRACT, TORT (INCLUDING NEGLIGENCE), PRODUCT LIABILITY, OR ANY OTHER LEGAL THEORY, AND WHETHER OR NOT EVOGALAXY OR ITS SERVICE PROVIDERS HAVE BEEN INFORMED OF THE POSSIBILITY OF SUCH DAMAGE, EVEN IF A LIMITED REMEDY SET FORTH HEREIN IS FOUND TO HAVE FAILED OF ITS ESSENTIAL PURPOSE\n\n13.2 TO THE MAXIMUM EXTENT PERMITTED BY LAW, IN NO EVENT WILL EVOGALAXY’S TOTAL LIABILITY ARISING OUT OF OR IN CONNECTION WITH THESE TERMS OR FROM THE USE OF OR INABILITY TO USE THE SITE EXCEED ONE HUNDRED U.S. DOLLARS (\$100)\n\n13.3 THE EXCLUSIONS AND LIMITATIONS OF DAMAGES SET FORTH ABOVE ARE FUNDAMENTAL ELEMENTS OF THE BASIS OF THE BARGAIN BETWEEN EVOGALAXY AND YOU\n\n\n14. Governing Law and Forum Choice. These Terms and any action related thereto will be governed by the laws of the Canary Islands, without regard to its conflict of laws provisions. The parties expressly consent to personal and exclusive jurisdiction in the courts located in the Canary Islands, and you and EvoGalaxy each waive any objection to jurisdiction and venue in such courts\n\n\n15. General Terms\n\n15.1 Reservation of Rights. EvoGalaxy and its licensors exclusively own all right, title and interest in and to the Site, including all associated intellectual property rights. You acknowledge that the Site is protected by copyright, trademark, and other laws of the Canary Islands and other jurisdictions. You agree not to remove, alter, or obscure any copyright, trademark, service mark, or other proprietary rights notices incorporated in or accompanying the Site\n\n15.2 Entire Agreement. These Terms constitute the entire and exclusive understanding and agreement between EvoGalaxy and you regarding the Site, and these Terms supersede and replace all prior oral or written understandings or agreements between EvoGalaxy and you regarding the Site. If any provision of these Terms is held invalid or unenforceable by a court of competent jurisdiction, that provision will be enforced to the maximum extent permissible and the other provisions of these Terms will remain in full force and effect. Except where provided by applicable law in your jurisdiction, you may not assign or transfer these Terms, by operation of law or otherwise, without EvoGalaxy’s prior written consent. Any attempt by you to assign or transfer these Terms absent our consent or your statutory right without such consent will be null. EvoGalaxy may freely assign or transfer these Terms without restriction. Subject to the foregoing, these Terms will bind and insure to the benefit of the parties, their successors, and permitted assigns\n\n15.3 Notices. Any notices or other communications provided by EvoGalaxy under these Terms will be given by posting to the Site\n\n15.4 Waiver of Rights. EvoGalaxy’s failure to enforce any right or provision of these Terms will not be considered a waiver of such right or provision. The waiver of any such right or provision will be effective only if in writing and signed by a duly authorized representative of EvoGalaxy. Except as expressly set forth in these Terms, the exercise by either party of any of its remedies under these Terms will be without prejudice to its other remedies under these Terms or otherwise\n\n\n16. Contact Information. If you have any questions about these Terms or the Site, please contact EvoGalaxy at privacy@evogalaxy.com",
      TextKeys.footerPrivacyMenu: "Privacy",
      TextKeys.footerPrivacyTitle: "Privacy policy",
      TextKeys.footerPrivacyLastUpdated: "Last Updated:",
      TextKeys.footerPrivacy1:
          "This Privacy Policy is designed to help you understand how EvoGalaxy (called “EvoGalaxy”, “we,” “us,” and “our”) collects, uses, and shares your personal information and to help you understand and exercise your privacy rights\n\n\nSCOPE\n\nThis Privacy Policy applies to personal information processed by us, including on our website located at evogalaxy.com (the “Site”). To make this Privacy Policy easier to read, our Site and the content and functionalities accessible via the Site are collectively referred to as the “Site.” For the avoidance of doubt, this Privacy Policy does not apply to the decentralized digital ecosystem developed by EvoGalaxy (the “Protocol”) and EvoGalaxy cannot control activity and data on the Protocol, the validation of transactions on the Protocol, or use of the Protocol. The Protocol is an open-source protocol that is maintained and processed by validators across the globe\n\n\nCHANGES TO OUR PRIVACY POLICY\n\nWe may revise this Privacy Policy from time to time at our sole discretion. If there are any material changes to this Privacy Policy, we will notify you as required by applicable law. You understand and agree that you will be deemed to have accepted the updated Privacy Policy if you continue to use our Site after the new Privacy Policy takes effect\n\n\nPERSONAL INFORMATION WE COLLECT\n\nThe categories of personal information we collect depend on how you interact with us, our Site, and the requirements of applicable law. We collect information that you provide to us, information we obtain automatically when you use our Site, and information from other sources such as third-party services and organizations, as described below\n\nA. INFORMATION YOU PROVIDE TO US DIRECTLY\n\nWe may collect the following personal information that you provide to us:\n\n- Account Creation. We may collect information if you create an account with us, such as your name, username, email address, or password\n\n- Wallet and Transaction Information. In order to engage in transactions on the Site, you may need to provide us or our third-party payment processors with access to or information about your digital wallet. We will never ask you or collect your private keys\n\n- Other Transactions. We may collect personal information and details associated with your activities on our Site, including token issuance. Any payments made via our Site are processed by third-party payment processors\n\n- Your Communications with Us. We may collect personal information, such as email address when you request information about our Site, register for our newsletter or marketing promotions, request customer or technical support, apply for a job or otherwise communicate with us\n\n- Interactive Features. We and others who use our Site may collect personal information that you submit or make available through our interactive features (e.g., via EvoGalaxy community, messaging and chat features, commenting functionalities, forums, blogs, and social media pages). Any personal information you provide on the public sections of these features will be considered “public” (the “User Content”) unless otherwise required by applicable law, and is not subject to the privacy protections referenced herein. Please exercise caution before revealing any information that may identify you in the real world to other users\n\n- Surveys. We may contact you to participate in surveys. If you decide to participate, you may be asked to provide certain information that may include personal information\n\n- Sweepstakes, Giveaways, or Contests. We may collect personal information you provide for any sweepstakes, giveaways, or contests that we offer. In some jurisdictions, we are required to publicly share information of sweepstakes and contest winners\n\n- Conferences, Trade Shows, and Other Events. We may collect personal information from individuals when we attend or host conferences, trade shows, and other events\n\n- Business Development and Strategic Partnerships. We may collect personal information from individuals and third parties to assess and pursue potential business opportunities\n\n- Job Applications. We may post job openings and opportunities on our Site. If you reply to one of these postings by submitting your application, CV, and/or cover letter to us, we will collect and use this information to assess your qualifications\n\n\nB. INFORMATION COLLECTED AUTOMATICALLY\n\nWe may collect personal information automatically when you use our Site:\n\n- Automatic Data Collection. We may collect certain information automatically when you use our Site, such as your Internet protocol (IP) address, user settings, MAC address, cookie identifiers, mobile carrier, mobile advertising and other unique identifiers, browser or device information, location information (including approximate location derived from IP address), Internet service provider, and metadata about the content you provide. We may also automatically collect information regarding your use of our Site, such as pages that you visit before, during, and after using our Site, information about the links you click, the types of content you interact with, the frequency and duration of your activities, and other information about how you use our Site\n\n- Cookie Policy for Cookies, Pixel Tags/Web Beacons, and Other Technologies. We, as well as third parties that provide content, advertising, or other functionality on our Site, may use cookies, pixel tags, local storage, and other technologies (“Technologies”) to automatically collect information through your use of our Site\n\n- Cookies. Cookies are small text files placed in device browsers that store preferences and facilitate and enhance your experience\n\n- Pixel Tags/Web Beacons and Other Technologies. A pixel tag (also known as a web beacon) is a piece of code embedded in our Site that collects information about engagement on our Site. The use of a pixel tag allows us to record, for example, that a user has visited a particular web page or clicked on a particular advertisement. We may also include web beacons in emails to understand whether messages have been opened, acted on, or forwarded\n\n- Our uses of these Technologies fall into the following general categories:\n\n- Operationally Necessary. This includes Technologies that allow you access to our Site, applications, and tools that are required to identify irregular website behavior, prevent fraudulent activity, improve security, or allow you to make use of our functionality\n\n- Performance-Related. We may use Technologies to assess the performance of our Site, including as part of our analytic practices to help us understand how individuals use our Site (see Analytics below)\n\n- Functionality-Related. We may use Technologies that allow us to offer you enhanced functionality when accessing or using our Site. This may include identifying you when you sign into our Site or keeping track of your specified preferences, interests, or past items viewed\n\n- Advertising- or Targeting-Related. We may use first-party or third-party Technologies to deliver content, including ads relevant to your interests, on our Site or on third-party websites\n\n\nSee “Your Privacy Choices and Rights” below to understand your choices regarding these Technologies\n\n- Analytics. We may use our Technologies and other third-party tools to process analytics information on our Site. These technologies allow us to process usage data to better understand how our website and web-related services are used, and to continually improve and personalize our Site. Some of our analytics partners include:\n\n- Google Analytics. For more information about how Google uses your data (including for its own purposes, e.g., for profiling or linking it to other data), please visit Google Analytics Privacy Policy. To learn more about how to opt-out of Google Analytics use of your information, please click here\n\n- Intercom. For more information about how Intercom uses your data for customer interaction purposes, please visit Intercom's Privacy Policy\n\n- Mixpanel. For more information about how Mixpanel uses your data for customer interaction purposes, please visit Mixpanel's Privacy Policy\n\n- Segment. For more information about how Segment uses your data for customer interaction purposes, please visit Segment's Privacy Policy\n\n- Social Media Platforms. Our Site may contain social media buttons, such as Discord, Snapchat, Twitter, and Telegram that might include widgets such as the “share this” button or other interactive mini programs). These features may collect your IP address and which page you are visiting on our Site, and may set a cookie to enable the feature to function properly. Your interactions with these platforms are governed by the privacy policy of the company providing it\n\n\nC. INFORMATION COLLECTED FROM OTHER SOURCES\n\n- Third-Party Sources. We may obtain information about you from other sources, including through third-party services and organizations. For example, if you access our Site through a third-party application, such as an app store, a third-party login service, or a social networking site, we may collect information about you from that third-party application that you have made available via your privacy settings\n\n- Referrals, Sharing, and Other Features. Our Site may offer various tools and functionalities that allow you to provide information about your friends through our referral service; third parties may also use these services to upload information about you. Our referral services may also allow you to forward or share certain content with a friend or colleague, such as an email inviting your friend to use our Site. Please only share with us contact information of people with whom you have a relationship (e.g., relative, friend, neighbor, or co-worker)",
      TextKeys.footerPrivacy2:
          "\n\n\nHOW WE USE YOUR INFORMATION\n\nWe use your information for a variety of business purposes, including to provide our Site, for administrative purposes, and to market our products and services, as described below\n\nA. PROVIDE OUR SITE\n\nWe use your information to fulfill our contract with you and provide you with our Site and perform our contract with you, such as:\n\n- Managing your information and accounts\n\n- Providing access to certain areas, functionalities, and features of our Site\n\n- Answering requests for customer or technical support\n\n- Communicating with you about your account, activities on our Site, and policy changes\n\n- Processing information about your wallet to facilitate transfers via the Site\n\n- Processing applications if you apply for a job we post on our Site and\n\n- Allowing you to register for events\n\n\nB. ADMINISTRATIVE PURPOSES\n\nWe use your information for our legitimate interest, such as:\n\n- Pursuing our legitimate interests such as direct marketing, research and development (including marketing research), network and information security, and fraud prevention\n\n- Detecting security incidents, protecting against malicious, deceptive, fraudulent, or illegal activity, and prosecuting those responsible for that activity\n\n- Measuring interest and engagement in our Site\n\n- Improving, upgrading, or enhancing our Site\n\n- Developing new products and Site\n\n- Ensuring internal quality control and safety\n\n- Authenticating and verifying individual identities\n\n- Debugging to identify and repair errors with our Site\n\n- Auditing relating to interactions, transfers, and other compliance activities\n\n- Sharing information with third parties as needed to provide the Site\n\n- Enforcing our agreements and policies and\n\n- Other uses as required to comply with our legal obligations\n\n\nC. MARKETING AND ADVERTISING OUR PRODUCTS AND SERVICES\n\nWe may use personal information to tailor and provide you with content and advertisements. We may provide you with these materials as permitted by applicable law.\n\nSome of the ways we may market to you include email campaigns, custom audiences advertising, and “interest-based” or “personalized advertising,” including through cross-device tracking\n\nIf you have any questions about our marketing practices or if you would like to opt out of the use of your personal information for marketing purposes, you may contact us at any time as set forth in “Contact Us” below\n\n\nD. WITH YOUR CONSENT\n\nWe may use personal information for other purposes that are clearly disclosed to you at the time you provide personal information or with your consent\n\n\nE. OTHER PURPOSES\n\nWe also use your information for other purposes as requested by you or as permitted by applicable law\n\n- Automated Decision-Making. We may engage in automated decision-making, including profiling. EvoGalaxy's processing of your personal information will not result in a decision based solely on automated processing that significantly affects you unless such a decision is necessary as part of a contract we have with you, we have your consent, or we are permitted by law to engage in such automated-decision making. If you have questions about our automated decision-making, you may contact us as set forth in “Contact Us” below\n\n- De-identified and Aggregated Information. We may use personal information and other information about you to create de-identified and/or aggregated information, such as de-identified demographic information, de-identified location information, information about the device from which you access our Site, or other analyses we create\n\n\nHOW WE DISCLOSE YOUR INFORMATION\n\nWe disclose your information to third parties for a variety of business purposes, including to provide our Site, to protect us or others, or in the event of a major business transaction such as a merger, sale, or asset transfer, as described below\n\nA. DISCLOSURES TO PROVIDE OUR SITE\n\nThe categories of third parties with whom we may share your information are described below\n\n- Notice Regarding Use of Blockchain. Transactions involving our token will be conducted via blockchain. Information about your transfers will be provided to the blockchain and may be accessible to third parties due to the public nature of the blockchain. Because entries to the blockchain are, by their nature, public, and because it may be possible for someone to identify you through your pseudonymous, public wallet address using external sources of information, any transaction you enter onto the blockchain could possibly be used to identify you or information about you\n\n- Other Users of the Site and Parties You Transact With. Some of your personal information may be visible to other users of the Site (e.g., information featured on generally accessible parts of your profile). In addition, to complete transfers via the Site, we will need to share some of your personal information with the party that you are transacting with\n\n- Third-Party Websites and Applications. You may choose to share personal information or interact with third-party websites and/or third-party applications, including, but not limited to, third-party electronic wallet extensions. Once your personal information has been shared with a third-party website or a third-party application, it will also be subject to such third-party’s privacy policy. We encourage you to closely read each third-party website or third-party application privacy policy before sharing your personal information or otherwise interacting with them. Please note that we do not control, and we are not responsible for the third-party website’s or the third-party application’s processing of your personal information\n\n- Service Providers. We may share your personal information with our third-party service providers who use that information to help us provide our Site. This includes service providers that provide us with IT support, hosting, customer service, and related services\n\n- Business Partners. We may share your personal information with business partners to provide you with a product or service you have requested. We may also share your personal information to business partners with whom we jointly offer products or services\n\n- Affiliates. We may share your personal information with members of our corporate family\n\n- Advertising Partners. We may share your personal information with third-party advertising partners. These third-party advertising partners may set Technologies and other tracking tools on our Site to collect information regarding your activities and your device (e.g., your IP address, cookie identifiers, page(s) visited, location, time of day). These advertising partners may use this information (and similar information collected from other services) for purposes of delivering personalized advertisements to you when you visit digital properties within their networks. This practice is commonly referred to as “interest-based advertising” or “personalized advertising”\n\n- APIs/SDKs. We may use third-party application program interfaces (“APIs”) and software development kits (“SDKs”) as part of the functionality of our Site. For more information about our use of APIs and SDKs, please contact us as set forth in “Contact Us” below\n\n\nB.DISCLOSURES TO PROTECT US OR OTHERS\n\nWe may access, preserve, and disclose any information we store associated with you to external parties if we, in good faith, believe doing so is required or appropriate to: comply with law enforcement or national security requests and legal process, such as a court order or subpoena; protect your, our, or others’ rights, property, or safety; enforce our policies or contracts; collect amounts owed to us; or assist with an investigation or prosecution of suspected or actual illegal activity\n\n\nC. DISCLOSURE IN THE EVENT OF MERGER, SALE, OR OTHER ASSET TRANSFERS\n\nIf we are involved in a merger, acquisition, financing due diligence, reorganization, bankruptcy, receivership, purchase or sale of assets, or transition of service to another provider, your information may be sold or transferred as part of such a transaction, as permitted by law and/or contract\n\n\nYOUR PRIVACY CHOICES AND RIGHTS\n\nYour Privacy Choices. The privacy choices you may have about your personal information are determined by applicable law and are described below\n\n- Email Communications. If you receive an unwanted email from us, you can use the unsubscribe link found at the bottom of the email to opt out of receiving future emails. Note that you will continue to receive transfer-related emails regarding services you have requested. We may also send you certain non-promotional communications regarding us and our Site, and you will not be able to opt out of those communications (e.g., communications regarding our Site or updates to our Terms of Service or this Privacy Policy)\n\n- Text Messages. You may opt out of receiving text messages from us by following the instructions in the text message you have received from us or by otherwise contacting us\n\n- Mobile Devices. We may send you push notifications through our mobile application. You may opt out from receiving these push notifications by changing the settings on your mobile device. With your consent, we may also collect precise location-based information via our mobile application. You may opt out of this collection by changing the settings on your mobile device\n\n- “Do Not Track.” Do Not Track (“DNT”) is a privacy preference that users can set in certain web browsers. Please note that we do not respond to or honor DNT signals or similar mechanisms transmitted by web browsers",
      TextKeys.footerPrivacy3:
          "\n\n- Cookies and Interest-Based Advertising. You may stop or restrict the placement of Technologies on your device or remove them by adjusting your preferences as your browser or device permits. However, if you adjust your preferences, our Site may not work properly. Please note that cookie-based opt-outs are not effective on mobile applications. However, you may opt-out of personalized advertisements on some mobile applications by following the instructions for Android, iOS, and others. Please note you must separately opt out in each browser and on each device\n\nThe online advertising industry also provides websites from which you may opt out of receiving targeted ads from data partners and other advertising partners that participate in self-regulatory programs. You can access these and learn more about targeted advertising and consumer choice and privacy by visiting the Network Advertising Initiative, the Digital Advertising Alliance, the European Digital Advertising Alliance, and the Digital Advertising Alliance of Canada\n\nYour Privacy Rights. In accordance with applicable law, you may have the right to:\n\n- Access Personal Information about you, including: (i) confirming whether we are processing your personal information; (ii) obtaining access to or a copy of your personal information; or (iii) receiving an electronic copy of personal information that you have provided to us, or asking us to send that information to another company (aka the right of data portability)\n\n- Request Correction of your personal information where it is inaccurate or incomplete. In some cases, we may provide self-service tools that enable you to update your personal information\n\n- Request Deletion of your personal information\n\n- Request Restriction of or Object to our processing of your personal information, including where the processing of your personal information is based on our legitimate interest or for direct marketing purposes and\n\n- Withdraw Your Consent to our processing of your personal information. Please note that your withdrawal will only take effect for future processing and will not affect the lawfulness of processing before the withdrawal\n\nIf you would like to exercise any of these rights, please contact us as set forth in “Contact Us” below. We will process such requests in accordance with applicable laws\n\n\nSECURITY OF YOUR INFORMATION\n\nWe take steps designed to ensure that your information is treated securely and in accordance with this Privacy Policy. Unfortunately, no system is 100% secure, and we cannot ensure or warrant the security of any information you provide to us. To the fullest extent permitted by applicable law, we do not accept liability for unauthorized disclosure\n\nBy using our Site or providing personal information to us, you agree that we may communicate with you electronically regarding security, privacy, and administrative issues relating to your use of our Site. If we learn of a security system’s breach, we may attempt to notify you electronically by posting a notice on our Site, by mail, or by sending an email to you\n\n\nINTERNATIONAL DATA TRANSFERS\n\nAll information processed by us may be transferred, processed, and stored anywhere in the world, including, but not limited to, the United States or other countries, which may have data protection laws that are different from the laws where you live. We endeavor to safeguard your information consistent with the requirements of applicable laws\n\n\nRETENTION OF PERSONAL INFORMATION\n\nWe store the personal information we collect as described in this Privacy Policy for as long as you use our Site or as necessary to fulfill the purpose(s) for which it was collected, provide our Site, resolve disputes, establish legal defenses, conduct audits, pursue legitimate business purposes, enforce our agreements, and comply with applicable laws\n\n\nSUPPLEMENTAL NOTICE FOR CALIFORNIA RESIDENTS\n\nThis Supplemental Notice for California Residents only applies to our processing of personal information that is subject to the California Consumer Privacy Act of 2018 (“CCPA”). EvoGalaxy does not believe it is subject to the CCPA. That said, EvoGalaxy provides this supplemental notice for purposes of transparency. The CCPA provides California residents with the right to know what categories of personal information EvoGalaxy has collected about them and whether EvoGalaxy disclosed that personal information for a business purpose (e.g., to a service provider) in the preceding twelve months. California residents can find this information below:\n\nCATEGORY OF PERSONAL INFORMATION COLLECTED BY EVOGALAXY\n\nIdentifiers\n\nA real name, postal address, unique personal identifier, online identifier, Internet Protocol address, email address, account name, or other similar identifiers\n\nPersonal information categories listed in Cal. Civ. Code § 1798.80(e)\n\nA name, signature, Social Security number, address, telephone number, passport number, driver's license or state identification card number, insurance policy number, education, employment, employment history, bank account number, credit card number, debit card number, or any other financial information. Personal information does not include publicly available information that is lawfully made available to the general public from federal, state, or local government records. Note: Some personal information included in this category may overlap with other categories\n\nProtected classification characteristics under California or federal law\n\nAge (40 years or older), race, color, ancestry, national origin, citizenship, religion or creed, marital status, medical condition, physical or mental disability, sex (including gender, gender identity, gender expression, pregnancy or childbirth and related medical conditions), sexual orientation, veteran or military status, genetic information (including familial genetic information)\n\nCommercial information\n\nRecords of personal property, products or services purchased, obtained, or considered, or other purchasing or consuming histories or tendencies\n\nInternet or other electronic network activity\n\nBrowsing history, search history, information on a consumer's interaction with an Internet website, application, or advertisement\n\nProfessional or employment-related information\n\nCurrent or past job history or performance evaluations\n\nInferences drawn from other personal information to create a profile about a consumer\n\nProfile reflecting a consumer's preferences, characteristics, psychological trends, predispositions, behavior, attitudes, intelligence, abilities, and aptitudes\n\n\nCATEGORIES OF THIRD PARTIES PERSONAL INFORMATION IS DISCLOSED TO FOR A BUSINESS PURPOSE\n\nService providers\n\nBlockchain networks\n\nOther users or third parties you interact with\n\nAdvertising partners\n\nThird-party websites or applications (e.g., wallet providers; third-party identity verification services)\n\nService providers (recruitment context)\n\n\nThe categories of sources from which we collect personal information and our business and commercial purposes for using personal information are set forth in “Personal Information We Collect” and “How We Use Your Information” above, respectively\n\n“Sales” of Personal Information under the CCPA. For purposes of the CCPA, EvoGalaxy does not “sell” personal information, nor do we have actual knowledge of any “sale” of personal information of minors under 16 years of age\n\n\nADDITIONAL PRIVACY RIGHTS FOR CALIFORNIA RESIDENTS\n\nNon-Discrimination. California residents have the right not to receive discriminatory treatment by us for the exercise of their rights conferred by the CCPA\n\nAuthorized Agent. Only you, or someone legally authorized to act on your behalf, may make a verifiable consumer request related to your personal information. To designate an authorized agent, please contact us as set forth in “Contact Us” below\n\nVerification. When you make a request, we will ask you to provide sufficient information that allows us to reasonably verify you are the person about whom we collected personal information or an authorized representative, which may include confirming the email address associated with any personal information we have about you. If you are a California resident and would like to exercise any of your rights under the CCPA, please contact us as set forth in “Contact Us” below. We will process such requests in accordance with applicable laws\n\nAccessibility. This Privacy Policy uses industry-standard technologies and was developed in line with the World Wide Web Consortium’s Web Content Accessibility Guidelines, version 2.1. If you wish to print this policy, please do so from your web browser or by saving the page as a PDF\n\nCalifornia Shine the Light. The California “Shine the Light” law permits users who are California residents to request and obtain from us once a year, free of charge, a list of the third parties to whom we have disclosed their personal information (if any) for their direct marketing purposes in the prior calendar year, as well as the type of personal information disclosed to those parties\n\n\nSUPPLEMENTAL NOTICE FOR NEVADA RESIDENTS\n\nIf you are a resident of Nevada, you have the right to opt-out of the sale of certain personal information to third parties who intend to license or sell that personal information. You can exercise this right by contacting us as set forth in “Contact Us” below with the subject line “Nevada Do Not Sell Request” and providing us with your name and the email address associated with your account. Please note that we do not currently sell your personal information as sales are defined in Nevada Revised Statutes Chapter 603A",
      TextKeys.footerPrivacy4:
          "\n\n\nCHILDREN’S INFORMATION\n\nThe Site is not directed to children under 13 (or other age as required by local law), and we do not knowingly collect personal information from children. If you learn that your child has provided us with personal information without your consent, you may contact us as set forth in “Contact Us” below. If we learn that we have collected a child’s personal information in violation of applicable law, we will promptly take steps to delete such information\n\n\nTHIRD-PARTY WEBSITES/APPLICATIONS\n\nThe Site may contain links to other websites/applications and other websites/applications may reference or link to our Site. These third-party services are not controlled by us. We encourage our users to read the privacy policies of each website and application with which they interact. We do not endorse, screen, or approve, and are not responsible for, the privacy practices or content of such other websites or applications. Providing personal information to third-party websites or applications is at your own risk\n\n\nSUPERVISORY AUTHORITY\n\nIf you are located in the European Economic Area, Switzerland, or the United Kingdom you have the right to lodge a complaint with a supervisory authority if you believe our processing of your personal information violates applicable law\n\n\nCONTACT US\n\nIf you have any questions about our privacy practices or this Privacy Policy, or to exercise your rights as detailed in this Privacy Policy, please contact EvoGalaxy at: privacy@evogalaxy.com",
      TextKeys.footerSmartContractAddress: "EvoGalaxy Smart Contract Address:",
      // =====================
      // ===== Copyright =====
      // =====================
      TextKeys.disclaimer1:
          "No Investment Advice. The information provided on this website does not constitute investment advice, financial advice, trading advice, or any other sort of advice and you should not treat any of the website's content as such",
      TextKeys.disclaimer2:
          "EvoGalaxy does not recommend that any cryptocurrency should be bought, sold, or held by you. Do conduct your own due diligence and consult your financial advisor before making any investment decisions",
      // ==========================
      // ===== Token utility ======
      // ==========================
      TextKeys.tokenUtilityTitle: "Token utility",
      TextKeys.tokenUtilityDescription:
          "The token is the currency of the entire ecosystem. It has multiple uses that make it very valuable and worth having in your wallet.",
      TextKeys.tokenUtility1: "Buy and sell blueprints for spaceship design",
      TextKeys.tokenUtility2:
          "Access to mine actions on the central space station",
      TextKeys.tokenUtility3: "Participate in battles with token rewards",
      TextKeys.tokenUtility4:
          "Buy sectors of the galaxy to build your own space stations",
      TextKeys.tokenUtility5: "Participate in exclusive battle tournaments",
      TextKeys.tokenUtilityMore:
          "And this is just the beginning... Our goal is to keep adding new functionalities, mechanics, content and utilities to the token. The metaverse has no limits!",
      // ====================
      // ===== App bar ======
      // ====================
      TextKeys.connect: "Connect",
      // Errors
      // ==================
      // ===== Errors =====
      // ==================
      TextKeys.unknownPage: "Error 404: Page does not exist",
      TextKeys.noInternetAccess: "Your device does not have internet access",

      // ======
    },
  };

  LanguageState() {
    load();
  }

  load() async {
    final sharPref = await SharedPreferences.getInstance();
    // Select saved language or ES as default
    languageSelected = LanguagesAvailables.values.firstWhere(
        (element) => element.name == sharPref.getString("lang"),
        orElse: () => _defaultLanguage);
  }

  changeLanguage(LanguagesAvailables lgSel) {
    languageSelected = lgSel;
    notifyListeners();
  }

  String getText(TextKeys key) {
    String? txtReturn = _texts[languageSelected]![key];
    return txtReturn ?? "";
  }

  String pareseTxt(String str) {
    TextKeys textKey = TextKeys.values.firstWhere(
        (element) => element.name == str,
        orElse: () => TextKeys.noTranslationAvailable);

    return getText(textKey);
  }

  String pareseErrorTxt(String errorStr) {
    TextKeys errorKey = TextKeys.values.firstWhere(
        (element) => element.name == errorStr,
        orElse: () => TextKeys.defaultError);

    return getText(errorKey);
  }
}
