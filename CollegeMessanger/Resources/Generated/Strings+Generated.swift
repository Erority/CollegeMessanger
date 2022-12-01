// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum Strings {
  /// Добавить чат
  public static let addChat = Strings.tr("Localizable", "addChat", fallback: "Добавить чат")
  /// Авторизация
  public static let authorization = Strings.tr("Localizable", "authorization", fallback: "Авторизация")
  /// День рождения
  public static let birthday = Strings.tr("Localizable", "birthday", fallback: "День рождения")
  /// Localizable.strings
  ///   CollegeMessanger
  /// 
  ///   Created by Денис Большачков on 29.10.2022.
  public static let collegeOfCommunication = Strings.tr("Localizable", "collegeOfCommunication", fallback: "Колледж связи")
  /// E-mail
  public static let email = Strings.tr("Localizable", "email", fallback: "E-mail")
  /// Имя
  public static let firstName = Strings.tr("Localizable", "firstName", fallback: "Имя")
  /// Забыли пароль ?
  public static let forgotPassword = Strings.tr("Localizable", "forgotPassword", fallback: "Забыли пароль ?")
  /// Группа
  public static let group = Strings.tr("Localizable", "group", fallback: "Группа")
  /// Фамилия
  public static let lastName = Strings.tr("Localizable", "lastName", fallback: "Фамилия")
  /// Войти
  public static let login = Strings.tr("Localizable", "login", fallback: "Войти")
  /// Главная
  public static let main = Strings.tr("Localizable", "main", fallback: "Главная")
  /// Пароль
  public static let password = Strings.tr("Localizable", "password", fallback: "Пароль")
  /// Отчество
  public static let patronymic = Strings.tr("Localizable", "patronymic", fallback: "Отчество")
  /// Номер телефона
  public static let phone = Strings.tr("Localizable", "phone", fallback: "Номер телефона")
  /// Зарегестрироваться
  public static let register = Strings.tr("Localizable", "register", fallback: "Зарегестрироваться")
  /// Регистрация
  public static let registration = Strings.tr("Localizable", "registration", fallback: "Регистрация")
  /// Настройки
  public static let settings = Strings.tr("Localizable", "settings", fallback: "Настройки")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Strings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
