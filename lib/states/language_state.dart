import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ===============================
/// Custom translation system
// ===============================
enum LanguagesAvailables { es, en }

enum TextKeys {
  noTranslationAvailable,
  empty,
  // MyMind == start
  // Buttons
  btnSignIn,
  btnSignUp,
  btnRemember,
  btnVerify,
  // ======
  // Texts
  txtNotHaveAccount,
  txtAlreadyHaveAccount,
  txtForgotPassword,
  txtSignIn,
  txtSignUp,
  txtSignUpDescription,
  txtEmail,
  txtConfirmEmail,
  txtPassword,
  txtConfirmPassword,
  txtAvailableSoonTitle,
  txtAvailableSoon,
  txtNotes,
  txtNewNote,
  txtNewList,
  txtNewGroup,
  txtSort,
  txtMove,
  txtReminders,
  txtBannerVerifyAccount,
  txtVerifyEmaildSend,
  txtHaveNotNotes,
  txtTitle,
  txtSave,
  txtBackText,
  txtAddTextElement,
  txtTextElementPlaceholder,
  txtSize,
  txtBold,
  txtItalic,
  txtUnderline,
  txtColor,
  txtAligment,
  txtLeft,
  txtCenter,
  txtRight,
  txtStyle,
  txtChangeTitle,
  txtEdit,
  txtApply,
  txtDelete,
  txtOptions,
  txtNew,
  txtHelp,
  txtConfirmDelete,
  txtConfirmDialogContinue,
  txtConfirmDialogBack,

  // ======
  // Errors
  defaultError,
  errFormFields,
  errRequiredField,
  errInvalidEmail,
  errEmailsDifferents,
  errorPassShort,
  errorPassDifferents,
  incompleteData,
  userAccountCreatedErrorVerificationEmail,
  errTitleLength,
  errIncompatibleScreenSize,
  // ======
  // ================= MyMind == end

  // ===== Errors
  unknownPage,
  noInternetAccess,
  errorEmailNull,
  errorEmailInvalid,
  errorPassNull,
  errorPassMatch,
  // ===================
  // ===================

  copy,
  signOutText,
  profileText,
  continueText,

  notificationsText,
  insertUsername,
  insertPass,
  searchText,

  saved,
  total,
  name,
  surname,
  dniCif,
  address,
  addressNotification,
  phone,

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

  // Home
  welcomeMorningMessage,
  welcomeAfternoonMessage,
  nextEventsMessage,
  noNextEventsMessage,

  usernameNull,
  passNull,
  shortPass,
  matchPass,
  errorComServer,
  mustBeNumber,

  // Must be the same name as the value of ERRORS_CODE in the server
  permissionDenied,
  sessionExpired,
  catchmentErrorSave,
  errorGettingCatchmentNotExist,
  errorGettingCatchments,
  flowErrorSave,
  errorGettingFlows,
  errorDeleting,
}

class LanguageState with ChangeNotifier {
  final LanguagesAvailables _defaultLanguage = LanguagesAvailables.es;
  static LanguagesAvailables languageSelected = LanguagesAvailables.es;

  final Map<LanguagesAvailables, Map<TextKeys, String>> _texts = {
    LanguagesAvailables.es: {
      TextKeys.noTranslationAvailable: "-> Sin traducción <-",
      TextKeys.empty: "",
      // MyMind == Start
      // Buttons
      TextKeys.btnSignIn: "Iniciar sesión",
      TextKeys.btnSignUp: "Crear cuenta",
      TextKeys.btnRemember: "Recordar",
      TextKeys.btnVerify: "Verificar",
      // ======
      // Texts
      TextKeys.txtNotHaveAccount: "¿No tienes cuenta?",
      TextKeys.txtAlreadyHaveAccount: "¿Ya tienes una cuenta?",
      TextKeys.txtForgotPassword: "¿Olvidaste la contraseña?",
      TextKeys.txtSignIn: "Inicia sesión en tu cuenta",
      TextKeys.txtSignUp: "Crea tu cuenta",
      TextKeys.txtSignUpDescription:
          "Con una cuenta podrás tener tus recordatorios\ny notas en varios dispositivos",
      TextKeys.txtEmail: "Correo electrónico",
      TextKeys.txtConfirmEmail: "Repetir correo electrónico",
      TextKeys.txtPassword: "Contraseña",
      TextKeys.txtConfirmPassword: "Repetir contraseña",
      TextKeys.txtAvailableSoonTitle: "No disponible",
      TextKeys.txtAvailableSoon:
          "Esta característica estará disponible en próximas actualizaciones",
      TextKeys.txtNotes: "Notas",
      TextKeys.txtNewNote: "Nota",
      TextKeys.txtNewList: "Lista",
      TextKeys.txtNewGroup: "Grupo",
      TextKeys.txtSort: "Ordenar",
      TextKeys.txtMove: "Mover",
      TextKeys.txtReminders: "Recordatorios",
      TextKeys.txtBannerVerifyAccount:
          "El correo electrónico no está verificado. La cuenta será eliminada el",
      TextKeys.txtVerifyEmaildSend:
          "Correo electrónico de verificación enviado",
      TextKeys.txtHaveNotNotes: "Aún no tienes notas",
      TextKeys.txtTitle: "Título",
      TextKeys.txtSave: "Guardar",
      TextKeys.txtBackText: "Volver",
      TextKeys.txtAddTextElement: "Texto",
      TextKeys.txtTextElementPlaceholder: "Elemento texto",
      TextKeys.txtBold: "Negrita",
      TextKeys.txtItalic: "Cursiva",
      TextKeys.txtUnderline: "Subrayar",
      TextKeys.txtColor: "Color",
      TextKeys.txtAligment: "Alinear",
      TextKeys.txtLeft: "Izquierda",
      TextKeys.txtCenter: "Centro",
      TextKeys.txtRight: "Derecha",
      TextKeys.txtStyle: "Estilo",
      TextKeys.txtChangeTitle: "Cambiar título",
      TextKeys.txtEdit: "Editar",
      TextKeys.txtApply: "Aplicar",
      TextKeys.txtDelete: "Eliminar",
      TextKeys.txtOptions: "Opciones",
      TextKeys.txtNew: "Nuevo",
      TextKeys.txtHelp: "Ayuda",
      TextKeys.txtSize: "Tamaño",
      TextKeys.txtConfirmDelete: "Esta acción NO se puede deshacer",
      TextKeys.txtConfirmDialogContinue: "Continuar",
      TextKeys.txtConfirmDialogBack: "Volver",
      // ======
      // Errors
      TextKeys.defaultError: "Error desconocido",
      TextKeys.errFormFields: "Hay campos con errores.\nPor favor, revísalos",
      TextKeys.errRequiredField: "Campo requerido",
      TextKeys.errInvalidEmail: "El correo electrónico no es correcto",
      TextKeys.errEmailsDifferents: "Los correos electrónicos no coinciden",
      TextKeys.errorPassShort: "La contraseña es demasiado corta",
      TextKeys.errorPassDifferents: "Las contraseñas no coinciden",
      TextKeys.incompleteData:
          "Por favor, completa los datos y vuelve a intentarlo",
      TextKeys.errTitleLength: "El título es demasiado largo",
      TextKeys.errIncompatibleScreenSize: "Tamaño de pantalla incompatible",
      // ======
      // ================= MyMind == end

      /*
      TODO: Clear before release
      */
      // ==========
      // ERRORS ===
      TextKeys.unknownPage: "Error 404: Esta página no existe",
      TextKeys.noInternetAccess: "Su dispositivo no tiene acceso a internet",

      TextKeys.errorEmailNull: "Introduce el e-mail",
      TextKeys.errorEmailInvalid: "El e-mail no es correcto",
      TextKeys.errorPassNull: "Introduce la contraseña",
      TextKeys.errorPassMatch: "Las contraseñas no coinciden",
      // ==========
      // ==========

      TextKeys.signOutText: "Cerrar sesión",
      TextKeys.profileText: "Perfil",
      TextKeys.continueText: "Continuar",
      TextKeys.notificationsText: "Notificaciones",

      TextKeys.insertUsername: "Usuario",
      TextKeys.insertPass: "Contraseña",

      TextKeys.searchText: "Buscar",

      TextKeys.saved: "Guardado",
      TextKeys.total: "Total",
      TextKeys.name: "Nombre",
      TextKeys.surname: "Apellidos",
      TextKeys.dniCif: "DNI/CIF",
      TextKeys.address: "Dirección",
      TextKeys.addressNotification: "Dirección de notificaciones",

      TextKeys.phone: "Teléfono",

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

      // Home
      TextKeys.welcomeMorningMessage: "Buenos días",
      TextKeys.welcomeAfternoonMessage: "Buenas tardes",
      TextKeys.nextEventsMessage: "Estos son tus próximos eventos",
      TextKeys.noNextEventsMessage: "No tienes próximos eventos",

      // Errors
      TextKeys.mustBeNumber: "El número introducido no es correcto",

      TextKeys.usernameNull: "Por favor, introduce tu usuario",
      TextKeys.passNull: "Por favor, introduce tu contraseña",
      TextKeys.shortPass: "La contraseña es muy corta",
      TextKeys.matchPass: "Las contraseñas no coinciden",
      TextKeys.errorComServer: "Error en la comunicación con los servidores",
      TextKeys.permissionDenied: "Permiso denegado",

      TextKeys.sessionExpired: "Su sesión ha expirado, vuelva a iniciarla",

      TextKeys.catchmentErrorSave: "Ha ocurrido un error al guardar",
      TextKeys.errorGettingCatchments:
          "No se ha podido obtener las captaciones",
      TextKeys.errorGettingCatchmentNotExist: "La captación no existe",
      TextKeys.flowErrorSave: "Ha ocurrido un error al guardar",
      TextKeys.errorGettingFlows: "No se ha podido obtener los caudales",
      TextKeys.errorDeleting: "No se ha podido eliminar",
    },
    LanguagesAvailables.en: {},
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

  /// Get a String translation with a TextKey
  String getText(TextKeys key) {
    String? txtReturn = _texts[languageSelected]![key];
    return txtReturn ?? "";
  }

  /// Get a String translation with a TextKey String if it exists,
  /// otherwise "No translation available"
  String pareseTxt(String str) {
    TextKeys textKey = TextKeys.values.firstWhere(
        (element) => element.name == str,
        orElse: () => TextKeys.noTranslationAvailable);

    return getText(textKey);
  }

  /// Get a String translation with a TextKey String if it exists,
  /// otherwise "default error"
  String pareseErrorTxt(String errorStr) {
    TextKeys errorKey = TextKeys.values.firstWhere(
        (element) => element.name == errorStr,
        orElse: () => TextKeys.defaultError);

    return getText(errorKey);
  }
}
